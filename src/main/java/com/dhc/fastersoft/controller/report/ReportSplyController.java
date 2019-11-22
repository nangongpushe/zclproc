package com.dhc.fastersoft.controller.report;

import com.alibaba.fastjson.JSON;
import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.Constant;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.enumdata.ReportNameEnum;
import com.dhc.fastersoft.entity.enumdata.ReportStatusEnum;
import com.dhc.fastersoft.entity.report.*;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.ReportCblyService;
import com.dhc.fastersoft.service.ReportMonthService;
import com.dhc.fastersoft.service.ReportSplyService;
import com.dhc.fastersoft.service.ReportXwswService;
import com.dhc.fastersoft.utils.DateUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@RequestMapping("/reportSply")
@Controller
public class ReportSplyController {

	@Autowired
	private ReportSplyService service;
	@Autowired
	private ReportCblyService cblyService;
	@Autowired
	private ReportMonthService monthService;
	@Autowired
	private ReportXwswService xwswService;

	/**
	 * 商品粮油填报
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("fillSply")
	public String fillSply(ModelMap modelMap, String reportMonth) {
		String status = "未保存";
		SysUser user = TokenManager.getToken();
		String reportWarehouseId = user.getWareHouseId();;
		if(StringUtils.isNotEmpty(reportMonth) && StringUtils.isNotEmpty(reportWarehouseId)){
			Date monthDate = DateUtil.StringtoDate(reportMonth, DateUtil.MONTH_FORMAT);
			Date preMonthDate = DateUtil.nextMonth(monthDate, -1);
			String preMonth = DateUtil.DateToString(preMonthDate, DateUtil.MONTH_FORMAT); //上个月

			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportName(ReportNameEnum.SPLY.getValue());
			param.setReportWarehouseId(reportWarehouseId);
			ReportMonth report = monthService.getReport(param);
			param.setReportMonth(preMonth);
			ReportMonth preMonthReport = monthService.getReport(param);
			if (report != null){
				List<ReportSply> splyList = service.listSplyByReportId(report.getId());
				status = report.getReportStatus();
				modelMap.put("reportId", report.getId());
				modelMap.put("splyList", splyList);
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("manager", report.getManager());
			}
			if (preMonthReport != null){ //查询上月库存
				List<ReportSply> preSplyList = service.listSplyByReportId(preMonthReport.getId());
				modelMap.put("preSplyList", preSplyList);
			}
		}
		modelMap.put("list", ReportMonthController.list);
		modelMap.put("status", status);
		return "report/monthReport/fill_sply";
	}

	/**
	 * 保存商品粮油
	 *
	 * @param jsonlist
	 * @return
	 */
	@SysLogAn("报表台账-报表管理-填报-保存")
	@RequestMapping("/saveSply")
	@ResponseBody
	public ActionResultModel saveSply(String reportId, String reportMonth, String jsonlist, String manager) {
		ActionResultModel actionResultModel = new ActionResultModel();
		SysUser user = TokenManager.getToken();
		String reportWarehouse = user.getShortName();
//		if (StringUtils.isEmpty(reportWarehouse) || !Constant.WAREHOUSE.contains(reportWarehouse)) {
		if (StringUtils.isEmpty(user.getOriginCode()) || Constant.HOME_WAREHOUSE.equals(reportWarehouse)) {
			actionResultModel.setSuccess(false);
			actionResultModel.setMsg("您没有该权限！！");
		}else{
			List<ReportSply> splyList = JSON.parseArray(jsonlist, ReportSply.class);

			//验证数据是否正确start
			List<ReportCbly> cblyList = cblyService.listCblyByMonthHouse(reportMonth, user.getOriginCode());
			List<ReportXwsw> swgjList = xwswService.listXwswByMonthHouse(reportMonth, user.getOriginCode(), ReportNameEnum.SWGJ.getValue());
			List<ReportXwsw> xwswList = xwswService.listXwswByMonthHouse(reportMonth, user.getOriginCode(), ReportNameEnum.XWSW.getValue());
			StringBuffer reserveInSb = new StringBuffer();
			StringBuffer transferReserveOilSb = new StringBuffer();
			StringBuffer enterpriseInSwSb = new StringBuffer();
			StringBuffer saleSwSb = new StringBuffer();
			ReportCbly cbly = null;
			ReportSply sply = null;
			ReportXwsw swgj = null;
			ReportXwsw xwsw = null;
			BigDecimal reserveIn = null; //储备粮油转入
			BigDecimal changeOutSubtotal = null; //储备粮油收支月报表的转做商品粮油
			BigDecimal transferReserveOil = null; //转作储备粮油
			BigDecimal changeInSubtotal = null; //储备粮油收支月报表的商品粮油转入
			BigDecimal enterpriseInSw = null; //从企业购进 其中：省外
			BigDecimal subtotalSwgj = null; //省外购进表的小计
			BigDecimal saleSw = null; //销售 其中：省外
			BigDecimal subtotalXwsw = null; //销往省外表的小计
			for (int i = 0; i < splyList.size(); i++) {
				sply = splyList.get(i);

				if(sply.getCssClass().contains("false")){ //只需要判断手工填写的品种即可
					if(!cblyList.isEmpty()){
						cbly = cblyList.get(i);
						reserveIn = sply.getReserveIn();
						changeOutSubtotal = cbly.getChangeOutSubtotal();
						if(changeOutSubtotal == null){
							changeOutSubtotal = new BigDecimal(0);
						}
						if(reserveIn == null){
							reserveIn = new BigDecimal(0);
						}
						if(changeOutSubtotal.compareTo(reserveIn) !=0){
//							reserveInSb.append("、").append(sply.getGrainType()).append("(").append(changeOutSubtotal).append(")");
							reserveInSb.append("、").append(sply.getGrainType());
						}

						transferReserveOil = sply.getTransferReserveOil();
						changeInSubtotal = cbly.getChangeInSubtotal();
						if(transferReserveOil == null){
							transferReserveOil = new BigDecimal(0);
						}
						if(changeInSubtotal == null){
							changeInSubtotal = new BigDecimal(0);
						}
						if(transferReserveOil.compareTo(changeInSubtotal) !=0){
//							transferReserveOilSb.append("、").append(sply.getGrainType()).append("(").append(changeInSubtotal).append(")");
							transferReserveOilSb.append("、").append(sply.getGrainType());
						}
					}

					if(!swgjList.isEmpty()){
						swgj = swgjList.get(i);
						enterpriseInSw = sply.getEnterpriseInSw();
						subtotalSwgj = swgj.getSubtotal();
						if(enterpriseInSw == null){
							enterpriseInSw = new BigDecimal(0);
						}
						if(subtotalSwgj == null){
							subtotalSwgj = new BigDecimal(0);
						}
						if(enterpriseInSw.compareTo(subtotalSwgj) !=0){
//							enterpriseInSwSb.append("、").append(sply.getGrainType()).append("(").append(subtotalSwgj).append(")");
							enterpriseInSwSb.append("、").append(sply.getGrainType());
						}
					}

					if(!xwswList.isEmpty()){
						xwsw = xwswList.get(i);
						saleSw = sply.getSaleSw();
						subtotalXwsw = xwsw.getSubtotal();
						if(saleSw == null){
							saleSw = new BigDecimal(0);
						}
						if(subtotalXwsw == null){
							subtotalXwsw = new BigDecimal(0);
						}
						if(saleSw.compareTo(subtotalXwsw) !=0){
//							saleSwSb.append("、").append(sply.getGrainType()).append("(").append(subtotalXwsw).append(")");
							saleSwSb.append("、").append(sply.getGrainType());
						}
					}
				}
			}

			String error = "";
			if (reserveInSb.length()>0) {
				error = reserveInSb.toString().substring(1) + "的储备粮油转入与储备粮油收支月报表的转做商品粮油小计不等；";
			}
			if (transferReserveOilSb.length()>0) {
				error += transferReserveOilSb.toString().substring(1) + "的转作储备粮油与储备粮油收支月报表的商品粮油转入小计不等；";
			}
			if (enterpriseInSwSb.length()>0) {
				error += enterpriseInSwSb.toString().substring(1) + "的从企业购进 其中：省外与省外购进表的小计不等；";
			}
			if (saleSwSb.length()>0) {
				error += saleSwSb.toString().substring(1) + "的销售 其中：省外与销往省外表的小计不等；";
			}
			//验证数据是否正确end

			if (StringUtils.isNotEmpty(error)){
				actionResultModel.setMsg(error);
				actionResultModel.setSuccess(false);
			}else {
				reportId = service.addSply(reportId, reportMonth, splyList, manager);
				actionResultModel.setSuccess(true);
				actionResultModel.setMsg(reportId);
			}
		}

		return actionResultModel;
	}

	@SysLogAn("报表台账-报表管理-导出")
	@RequestMapping("/exportSply")
	public String exportSply(HttpServletRequest request, HttpServletResponse response, String title, String flag) {
		String reportId = request.getParameter("reportId").toString();
		String fileName = ReportNameEnum.SPLY.getValue() + ".xls";
		if(StringUtils.isNotEmpty(title)){
			fileName = title + ".xls";
		}
		try {
			fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		List<ReportSply> splyList = null;
		if("sum".equals(flag)){
			splyList = service.listSumSply(reportId);
		}else {
			splyList = service.listSplyByReportId(reportId);
		}
		ReportMonth reportMain = monthService.getReportMonthById(reportId);
		SysUser userInfo = monthService.getUserInfoByAccount(reportMain.getCreator());
		request.setAttribute("userInfo", userInfo);
		response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
		request.setAttribute("splyList", splyList);
		request.setAttribute("reportMonth", reportMain.getReportMonth());
		request.setAttribute("reportMain", reportMain);
		return "report/monthReport/export_sply";
	}

	/**
	 * 储备粮油审核页面
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("appSply")
	public String appSply(ModelMap modelMap, String reportMonth) {
		String status = "无数据";
		SysUser user = TokenManager.getToken();
		String reportWarehouse = user.getShortName();
		if(StringUtils.isNotEmpty(reportMonth) && StringUtils.isNotEmpty(reportWarehouse)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportName(ReportNameEnum.SPLY.getValue());
			param.setReportWarehouseId(user.getWareHouseId());
			param.setReportStatus(ReportStatusEnum.DSH.getValue());
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				List<ReportSply> splyList = service.listSplyByReportId(report.getId());
				status = report.getReportStatus();
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("reportId", report.getId());
				modelMap.put("splyList", splyList);
				modelMap.put("manager", report.getManager());
			}
		}
		modelMap.put("list", ReportMonthController.list);
		modelMap.put("status", status);
		return "report/monthReport/fill_sply";
	}

	/**
	 * 查询已审核
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("querySply")
	public String querySply(ModelMap modelMap, String reportMonth) {
		String status = "无数据";
		SysUser user = TokenManager.getToken();
		String reportWarehouse = user.getShortName();
		if(StringUtils.isNotEmpty(reportMonth) && StringUtils.isNotEmpty(reportWarehouse)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportName(ReportNameEnum.SPLY.getValue());
			param.setReportWarehouseId(user.getWareHouseId());
			param.setReportStatus("YS");//已审
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				List<ReportSply> splyList = service.listSplyByReportId(report.getId());
				status = report.getReportStatus();
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("reportId", report.getId());
				modelMap.put("splyList", splyList);
				modelMap.put("manager", report.getManager());
			}
		}
		modelMap.put("list", ReportMonthController.list);
		modelMap.put("status", status);
		return "report/monthReport/fill_sply";
	}

	/**
	 * 分库查询已审核
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("queryKuSply")
	public String queryKuSply(ModelMap modelMap, String reportMonth, String reportWarehouse, String reportWarehouseId) {
		String status = "无数据";
		if (StringUtils.isNotEmpty(reportMonth)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportName(ReportNameEnum.SPLY.getValue());
			param.setReportWarehouseId(reportWarehouseId);
			param.setReportStatus("YS");//已审
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				List<ReportSply> splyList = service.listSplyByReportId(report.getId());
				status = report.getReportStatus();
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("reportId", report.getId());
				modelMap.put("splyList", splyList);
				modelMap.put("manager", report.getManager());
			}
		}
		modelMap.put("list", ReportMonthController.list);
		modelMap.put("status", status);
		return "report/monthReport/fill_sply";
	}

	/**
	 * 储备粮油上报审核
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("appKuSply")
	public String appKuSply(ModelMap modelMap, String reportMonth, String reportWarehouseId) {
		String status = "无数据";
		if (StringUtils.isNotEmpty(reportMonth)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportName(ReportNameEnum.SPLY.getValue());
			param.setReportWarehouseId(reportWarehouseId);
			param.setReportStatus("DHZ");
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				//查询月报是否已汇总
				param.setReportWarehouse(Constant.HOME_WAREHOUSE);
				param.setReportWarehouseId("0");
				param.setReportStatus(null);
				ReportMonth reportMain = monthService.getReport(param);
				modelMap.put("reportMain", reportMain);
				modelMap.put("manager", report.getManager());

//				if(reportMain == null || ReportStatusEnum.HZBH.getValue().equals(reportMain.getReportStatus())) { //未汇总则显示待汇总数据
					List<ReportSply> splyList = service.listSplyByReportId(report.getId());
					status = report.getReportStatus();
					modelMap.put("fillTime", report.getCreateDate());
					modelMap.put("reportId", report.getId());
					modelMap.put("splyList", splyList);
//				}
			}
		}
		modelMap.put("list", ReportMonthController.list);
		modelMap.put("status", status);
		return "report/monthReport/fill_sply";
	}

	/**
	 * 查询查询
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("querySumSply")
	public String querySumSply(ModelMap modelMap, String reportMonth) {
		String status = "无数据";
		if (StringUtils.isNotEmpty(reportMonth)){
			String reportWarehouse = Constant.HOME_WAREHOUSE;
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportName(ReportNameEnum.SPLY.getValue());
			param.setReportWarehouse(reportWarehouse);
			param.setReportStatus(ReportStatusEnum.HZTG.getValue());//已审
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				List<ReportSply> splyList = service.listSumSply(report.getId());
				status = report.getReportStatus();
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("reportId", report.getId());
				modelMap.put("splyList", splyList);
				modelMap.put("manager", report.getManager());
			}
		}
		modelMap.put("list", ReportMonthController.list);
		modelMap.put("status", status);
		return "report/monthReport/fill_sply";
	}

	/**
	 * 储备粮油汇总审核
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("appSumSply")
	public String appSumSply(ModelMap modelMap, String reportMonth) {
		String status = "无数据";
		if (StringUtils.isNotEmpty(reportMonth)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportName(ReportNameEnum.SPLY.getValue());
			param.setReportWarehouse(Constant.HOME_WAREHOUSE);
			param.setReportStatus(ReportStatusEnum.HZDS.getValue());
			ReportMonth report = monthService.getReport(param);
			if (report == null){
				param.setReportStatus(ReportStatusEnum.OASUM.getValue());//待审核
				report = monthService.getReport(param);
			}
			if (report != null){
				List<ReportSply> splyList = service.listSumSply(report.getId());
				status = report.getReportStatus();
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("reportId", report.getId());
				modelMap.put("splyList", splyList);
				modelMap.put("reportMain", report);
				modelMap.put("manager", report.getManager());
			}
		}
		modelMap.put("list", ReportMonthController.list);
		modelMap.put("status", status);
		return "report/monthReport/fill_sply";
	}
	/**
	 * 保存代储点商品粮油
	 *
	 * @param jsonlist
	 * @return
	 */
	@RequestMapping("/saveProxySply")
	@ResponseBody
	public ActionResultModel saveProxySply(String reportWarehouseId,String reportWarehouse, String reportId, String reportMonth, String jsonlist, String manager) {
		ActionResultModel actionResultModel = new ActionResultModel();
		SysUser user = TokenManager.getToken();
		//String reportWarehouse = user.getShortName();
//		if (StringUtils.isEmpty(reportWarehouse) || !Constant.WAREHOUSE.contains(reportWarehouse)) {
		if (StringUtils.isEmpty(reportWarehouse) || Constant.HOME_WAREHOUSE.equals(reportWarehouse)) {
			actionResultModel.setSuccess(false);
			actionResultModel.setMsg("您没有该权限！！");
		}else{
			List<ReportSply> splyList = JSON.parseArray(jsonlist, ReportSply.class);

			//验证数据是否正确start
			List<ReportCbly> cblyList = cblyService.listCblyByMonthHouse(reportMonth, reportWarehouse);
			List<ReportXwsw> swgjList = xwswService.listXwswByMonthHouse(reportMonth, reportWarehouse, ReportNameEnum.SWGJ.getValue());
			List<ReportXwsw> xwswList = xwswService.listXwswByMonthHouse(reportMonth, reportWarehouse, ReportNameEnum.XWSW.getValue());
			StringBuffer reserveInSb = new StringBuffer();
			StringBuffer transferReserveOilSb = new StringBuffer();
			StringBuffer enterpriseInSwSb = new StringBuffer();
			StringBuffer saleSwSb = new StringBuffer();
			ReportCbly cbly = null;
			ReportSply sply = null;
			ReportXwsw swgj = null;
			ReportXwsw xwsw = null;
			BigDecimal reserveIn = null; //储备粮油转入
			BigDecimal changeOutSubtotal = null; //储备粮油收支月报表的转做商品粮油
			BigDecimal transferReserveOil = null; //转作储备粮油
			BigDecimal changeInSubtotal = null; //储备粮油收支月报表的商品粮油转入
			BigDecimal enterpriseInSw = null; //从企业购进 其中：省外
			BigDecimal subtotalSwgj = null; //省外购进表的小计
			BigDecimal saleSw = null; //销售 其中：省外
			BigDecimal subtotalXwsw = null; //销往省外表的小计
			for (int i = 0; i < splyList.size(); i++) {
				sply = splyList.get(i);

				if(sply.getCssClass().contains("false")){ //只需要判断手工填写的品种即可
					if(!cblyList.isEmpty()){
						cbly = cblyList.get(i);
						reserveIn = sply.getReserveIn();
						changeOutSubtotal = cbly.getChangeOutSubtotal();
						if(changeOutSubtotal == null){
							changeOutSubtotal = new BigDecimal(0);
						}
						if(reserveIn == null){
							reserveIn = new BigDecimal(0);
						}
						if(changeOutSubtotal.compareTo(reserveIn) !=0){
//							reserveInSb.append("、").append(sply.getGrainType()).append("(").append(changeOutSubtotal).append(")");
							reserveInSb.append("、").append(sply.getGrainType());
						}

						transferReserveOil = sply.getTransferReserveOil();
						changeInSubtotal = cbly.getChangeInSubtotal();
						if(transferReserveOil == null){
							transferReserveOil = new BigDecimal(0);
						}
						if(changeInSubtotal == null){
							changeInSubtotal = new BigDecimal(0);
						}
						if(transferReserveOil.compareTo(changeInSubtotal) !=0){
//							transferReserveOilSb.append("、").append(sply.getGrainType()).append("(").append(changeInSubtotal).append(")");
							transferReserveOilSb.append("、").append(sply.getGrainType());
						}
					}

					if(!swgjList.isEmpty()){
						swgj = swgjList.get(i);
						enterpriseInSw = sply.getEnterpriseInSw();
						subtotalSwgj = swgj.getSubtotal();
						if(enterpriseInSw == null){
							enterpriseInSw = new BigDecimal(0);
						}
						if(subtotalSwgj == null){
							subtotalSwgj = new BigDecimal(0);
						}
						if(enterpriseInSw.compareTo(subtotalSwgj) !=0){
//							enterpriseInSwSb.append("、").append(sply.getGrainType()).append("(").append(subtotalSwgj).append(")");
							enterpriseInSwSb.append("、").append(sply.getGrainType());
						}
					}

					if(!xwswList.isEmpty()){
						xwsw = xwswList.get(i);
						saleSw = sply.getSaleSw();
						subtotalXwsw = xwsw.getSubtotal();
						if(saleSw == null){
							saleSw = new BigDecimal(0);
						}
						if(subtotalXwsw == null){
							subtotalXwsw = new BigDecimal(0);
						}
						if(saleSw.compareTo(subtotalXwsw) !=0){
//							saleSwSb.append("、").append(sply.getGrainType()).append("(").append(subtotalXwsw).append(")");
							saleSwSb.append("、").append(sply.getGrainType());
						}
					}
				}
			}

			String error = "";
			if (reserveInSb.length()>0) {
				error = reserveInSb.toString().substring(1) + "的储备粮油转入与储备粮油收支月报表的转做商品粮油小计不等；";
			}
			if (transferReserveOilSb.length()>0) {
				error += transferReserveOilSb.toString().substring(1) + "的转作储备粮油与储备粮油收支月报表的商品粮油转入小计不等；";
			}
			if (enterpriseInSwSb.length()>0) {
				error += enterpriseInSwSb.toString().substring(1) + "的从企业购进 其中：省外与省外购进表的小计不等；";
			}
			if (saleSwSb.length()>0) {
				error += saleSwSb.toString().substring(1) + "的销售 其中：省外与销往省外表的小计不等；";
			}
			//验证数据是否正确end

			if (StringUtils.isNotEmpty(error)){
				actionResultModel.setMsg(error);
				actionResultModel.setSuccess(false);
			}else {
				reportId = service.addProxySply(reportWarehouseId,reportWarehouse,reportId, reportMonth, splyList, manager);
				actionResultModel.setSuccess(true);
				actionResultModel.setMsg(reportId);
			}
		}

		return actionResultModel;
	}

	/**
	 * 商品粮油填报
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("fillProxySply")
	public String fillProxySply(ModelMap modelMap, String reportMonth, String reportWarehouse, String reportWarehouseId) {
		String status = "未保存";
		SysUser user = TokenManager.getToken();
		//String reportWarehouse = user.getShortName();
		if(StringUtils.isNotEmpty(reportMonth) && StringUtils.isNotEmpty(reportWarehouseId)){
			Date monthDate = DateUtil.StringtoDate(reportMonth, DateUtil.MONTH_FORMAT);
			Date preMonthDate = DateUtil.nextMonth(monthDate, -1);
			String preMonth = DateUtil.DateToString(preMonthDate, DateUtil.MONTH_FORMAT); //上个月

			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportName(ReportNameEnum.SPLY.getValue());
			param.setReportWarehouseId(reportWarehouseId);
			ReportMonth report = monthService.getReport(param);
			param.setReportMonth(preMonth);
			ReportMonth preMonthReport = monthService.getReport(param);
			if (report != null){
				List<ReportSply> splyList = service.listSplyByReportId(report.getId());
				status = report.getReportStatus();
				modelMap.put("reportId", report.getId());
				modelMap.put("splyList", splyList);
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("manager", report.getManager());
			}
			if (preMonthReport != null){ //查询上月库存
				List<ReportSply> preSplyList = service.listSplyByReportId(preMonthReport.getId());
				modelMap.put("preSplyList", preSplyList);
			}
		}
		modelMap.put("list", ReportMonthController.list);
		modelMap.put("status", status);
		return "report/monthReport/fill_sply";
	}
}
