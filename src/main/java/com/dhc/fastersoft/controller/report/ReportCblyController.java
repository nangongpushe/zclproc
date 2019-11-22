package com.dhc.fastersoft.controller.report;

import com.alibaba.fastjson.JSON;
import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.Constant;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.enumdata.ReportNameEnum;
import com.dhc.fastersoft.entity.enumdata.ReportStatusEnum;
import com.dhc.fastersoft.entity.report.ReportCbly;
import com.dhc.fastersoft.entity.report.ReportMonth;
import com.dhc.fastersoft.entity.report.ReportSply;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.ReportCblyService;
import com.dhc.fastersoft.service.ReportMonthService;
import com.dhc.fastersoft.service.ReportSplyService;
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
import java.util.*;

@RequestMapping("/reportCbly")
@Controller
public class ReportCblyController {

	@Autowired
	private ReportCblyService service;
	@Autowired
	private ReportMonthService monthService;
	@Autowired
	private ReportSplyService splyService;

	/**
	 * 储备粮油审核页面
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("appCbly")
	public String appCbly(ModelMap modelMap, ReportMonth report) {
		String status = "无数据";
		SysUser user = TokenManager.getToken();
		String reportWarehouse = user.getShortName();
		if(StringUtils.isNotEmpty(report.getReportMonth()) && StringUtils.isNotEmpty(reportWarehouse)){
			report.setReportWarehouse(reportWarehouse);
			report.setReportStatus(ReportStatusEnum.DSH.getValue());//待审核
			report.setReportName(ReportNameEnum.CBLY.getValue());
			ReportMonth reportMain = monthService.getReport(report);
			if (reportMain != null){
				List<ReportCbly> cblyList = service.listCblyByReportId(reportMain.getId());
				modelMap.put("cblyList", cblyList);
				status = reportMain.getReportStatus();
				modelMap.put("reportId", reportMain.getId());
				modelMap.put("fillTime", reportMain.getCreateDate());
				modelMap.put("manager", reportMain.getManager());
			}

		}
		modelMap.put("list", ReportMonthController.list);
		modelMap.put("status", status);
		return "report/monthReport/fill_cbly";
	}

	/**
	 * 储备粮油填报
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("fillCbly")
	public String fillCbly(ModelMap modelMap, String reportMonth) {
		String status = "未保存";
		SysUser user = TokenManager.getToken();
		String reportWarehouseId = user.getWareHouseId();;
		if(StringUtils.isNotEmpty(reportMonth) && StringUtils.isNotEmpty(reportWarehouseId)){
			Date monthDate = DateUtil.StringtoDate(reportMonth, DateUtil.MONTH_FORMAT);
			Date preMonthDate = DateUtil.nextMonth(monthDate, -1);
			String preMonth = DateUtil.DateToString(preMonthDate, DateUtil.MONTH_FORMAT); //上个月

			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportName(ReportNameEnum.CBLY.getValue());
			param.setReportWarehouseId(reportWarehouseId);
			ReportMonth report = monthService.getReport(param);
			param.setReportMonth(preMonth);
			ReportMonth preMonthReport = monthService.getReport(param);
			if (report != null){
				List<ReportCbly> cblyList = service.listCblyByReportId(report.getId());
				status = report.getReportStatus();
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("reportId", report.getId());
				modelMap.put("cblyList", cblyList);
				modelMap.put("manager", report.getManager());
			}
			if (preMonthReport != null){ //查询上月库存
				List<ReportCbly> preCblyList = service.listCblyByReportId(preMonthReport.getId());
				modelMap.put("preCblyList", preCblyList);
			}
		}

		modelMap.put("list", ReportMonthController.list);
		modelMap.put("status", status);
		return "report/monthReport/fill_cbly";
	}

	/**
	 * 保存储备粮油
	 *
	 * @param jsonlist
	 * @return
	 */
	@SysLogAn("报表台账-报表管理-填报-保存")
	@RequestMapping("/saveCbly")
	@ResponseBody
	public ActionResultModel saveCbly(String reportId, String reportMonth,String manager, String jsonlist) {
		ActionResultModel actionResultModel = new ActionResultModel();
		SysUser user = TokenManager.getToken();
		String reportWarehouse = user.getShortName();
		if (StringUtils.isEmpty(user.getOriginCode()) || Constant.HOME_WAREHOUSE.equals(reportWarehouse)) {
			actionResultModel.setSuccess(false);
			actionResultModel.setMsg("您没有该权限！！");
		}else{
			List<ReportCbly> cblyList = JSON.parseArray(jsonlist, ReportCbly.class);

			//验证数据是否正确start
			List<ReportSply> splyList = splyService.listSplyByMonthHouse(reportMonth, user.getOriginCode());
			StringBuffer reserveInSb = new StringBuffer();
			StringBuffer transferReserveOilSb = new StringBuffer();
			ReportCbly cbly = null;
			ReportSply sply = null;
			BigDecimal changeOutSubtotal = null; //转做商品粮油
			BigDecimal reserveIn = null; //商品粮油收支月报表的储备粮油转入
			BigDecimal changeInSubtotal = null; //商品粮油转入
			BigDecimal transferReserveOil = null; //商品粮油收支月报表的转作储备粮油
			for (int i = 0; i < cblyList.size(); i++) {
				cbly = cblyList.get(i);

				if(cbly.getCssClass().contains("false")){ //只需要判断手工填写的品种即可
					if(!splyList.isEmpty()){
						sply = splyList.get(i);
						reserveIn = sply.getReserveIn();
						changeOutSubtotal = cbly.getChangeOutSubtotal();
						if(changeOutSubtotal == null){
							changeOutSubtotal = new BigDecimal(0);
						}
						if(reserveIn == null){
							reserveIn = new BigDecimal(0);
						}
						if(changeOutSubtotal.compareTo(reserveIn) !=0){
//							reserveInSb.append("、").append(sply.getGrainType()).append("(").append(reserveIn).append(")");
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
//							transferReserveOilSb.append("、").append(sply.getGrainType()).append("(").append(transferReserveOil).append(")");
							transferReserveOilSb.append("、").append(sply.getGrainType());
						}
					}

				}
			}

			String error = "";
			if (reserveInSb.length()>0) {
				error = reserveInSb.toString().substring(1) + "的转做商品粮油小计与商品粮油收支月报表的储备粮油转入不等；";
			}
			if (transferReserveOilSb.length()>0) {
				error += transferReserveOilSb.toString().substring(1) + "的商品粮油转入小计与商品粮油收支月报表的转作储备粮油不等；";
			}
			//验证数据是否正确end

			if (StringUtils.isNotEmpty(error)){
				actionResultModel.setMsg(error);
				actionResultModel.setSuccess(false);
			}else {
				reportId = service.addCbly(reportId, reportMonth, cblyList, manager);
				actionResultModel.setSuccess(true);
				actionResultModel.setMsg(reportId);
			}
		}

		return actionResultModel;
	}

	@SysLogAn("报表台账-报表管理-导出")
	@RequestMapping("/exportCbly")
	public String exportCbly(HttpServletRequest request, HttpServletResponse response, String title, String flag) {
		String reportId = request.getParameter("reportId").toString();
		String fileName = ReportNameEnum.CBLY.getValue() + ".xls";
		if (StringUtils.isNotEmpty(title)){
			fileName = title + ".xls";
		}
		try {
			fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		List<ReportCbly> cblyList = null;
		if("sum".equals(flag)){
			cblyList = service.listSumCbly(reportId);
		}else {
			cblyList = service.listCblyByReportId(reportId);
		}
		ReportMonth reportMain = monthService.getReportMonthById(reportId);
		SysUser userInfo = monthService.getUserInfoByAccount(reportMain.getCreator());
		request.setAttribute("userInfo", userInfo);
		response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
		request.setAttribute("cblyList", cblyList);
		request.setAttribute("reportMonth", reportMain.getReportMonth());
		request.setAttribute("thisYear", DateUtil.getToYear());
		request.setAttribute("reportMain", reportMain);
		return "report/monthReport/export_cbly";
	}

	/**
	 * 查询已审核数据
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("queryCbly")
	public String queryCbly(ModelMap modelMap, String reportMonth) {
		String status = "";
		SysUser user = TokenManager.getToken();
		String reportWarehouse = user.getShortName();
		if(StringUtils.isNotEmpty(reportMonth) && StringUtils.isNotEmpty(reportWarehouse)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportStatus("YS");//已审
			param.setReportName(ReportNameEnum.CBLY.getValue());
			param.setReportWarehouseId(user.getWareHouseId());
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				List<ReportCbly> cblyList = service.listCblyByReportId(report.getId());
				status = report.getReportStatus();
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("reportId", report.getId());
				modelMap.put("cblyList", cblyList);
				modelMap.put("manager", report.getManager());
			}
		}
		modelMap.put("list", ReportMonthController.list);
		modelMap.put("status", status);
		return "report/monthReport/fill_cbly";
	}

	/**
	 * 分库查询已审核数据
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("queryKuCbly")
	public String queryKuCbly(ModelMap modelMap, String reportMonth, String reportWarehouseId) {
		String status = "";
		if (StringUtils.isNotEmpty(reportMonth)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportStatus("YS");//已审
			param.setReportName(ReportNameEnum.CBLY.getValue());
			param.setReportWarehouseId(reportWarehouseId);
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				List<ReportCbly> cblyList = service.listCblyByReportId(report.getId());
				status = report.getReportStatus();
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("reportId", report.getId());
				modelMap.put("cblyList", cblyList);
				modelMap.put("manager", report.getManager());
			}
		}
		modelMap.put("list", ReportMonthController.list);
		modelMap.put("status", status);
		return "report/monthReport/fill_cbly";
	}

	/**
	 * 储备粮油审核页面
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("appKuCbly")
	public String appKuCbly(ModelMap modelMap, String reportMonth, String reportWarehouseId) {
		String status = "无数据";
		if (StringUtils.isNotEmpty(reportMonth)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportWarehouseId(reportWarehouseId);
			param.setReportStatus("DHZ");//待汇总(上报待审、上报通过)
			param.setReportName(ReportNameEnum.CBLY.getValue());
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				//查询月报是否已汇总
				param.setReportWarehouse(Constant.HOME_WAREHOUSE);
				param.setReportWarehouseId("0");
				param.setReportStatus(null);
				ReportMonth reportMain = monthService.getReport(param);
				modelMap.put("reportMain", reportMain);
				modelMap.put("manager", report.getManager());

				List<ReportCbly> cblyList = service.listCblyByReportId(report.getId());
				modelMap.put("cblyList", cblyList);
				status = report.getReportStatus();
				modelMap.put("reportId", report.getId());
				modelMap.put("fillTime", report.getCreateDate());
			}

		}
		modelMap.put("list", ReportMonthController.list);
		modelMap.put("status", status);
		return "report/monthReport/fill_cbly";
	}

	/**
	 * 储备粮油审核页面
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("appSumCbly")
	public String appSumCbly(ModelMap modelMap, ReportMonth report) {
		String status = "无数据";
		if (StringUtils.isNotEmpty(report.getReportMonth())){
			String reportWarehouse = Constant.HOME_WAREHOUSE;
			report.setReportWarehouse(reportWarehouse);
			report.setReportStatus(ReportStatusEnum.HZDS.getValue());//待审核
			report.setReportName(ReportNameEnum.CBLY.getValue());
			ReportMonth reportMain = monthService.getReport(report);
			if (reportMain == null){
				report.setReportStatus(ReportStatusEnum.OASUM.getValue());//待审核
				reportMain = monthService.getReport(report);
			}
			if (reportMain != null){
				List<ReportCbly> cblyList = service.listSumCbly(reportMain.getId());
				modelMap.put("cblyList", cblyList);
				status = reportMain.getReportStatus();
				modelMap.put("reportId", reportMain.getId());
				modelMap.put("reportMain", reportMain);
				modelMap.put("manager", reportMain.getManager());
			}

		}
		modelMap.put("list", ReportMonthController.list);
		modelMap.put("status", status);
		return "report/monthReport/fill_cbly";
	}

	/**
	 * 汇总查询
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("querySumCbly")
	public String querySumCbly(ModelMap modelMap, String reportMonth) {
		String status = "";
		if (StringUtils.isNotEmpty(reportMonth)){
			String reportWarehouse = Constant.HOME_WAREHOUSE;
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportStatus(ReportStatusEnum.HZTG.getValue());//已审
			param.setReportName(ReportNameEnum.CBLY.getValue());
			param.setReportWarehouse(reportWarehouse);
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				List<ReportCbly> cblyList = service.listSumCbly(report.getId());
				status = report.getReportStatus();
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("reportId", report.getId());
				modelMap.put("cblyList", cblyList);
				modelMap.put("manager", report.getManager());
			}
		}
		modelMap.put("list", ReportMonthController.list);
		modelMap.put("status", status);
		return "report/monthReport/fill_cbly";
	}

	/**
	 * 保存代储点储备粮油
	 *
	 * @param jsonlist
	 * @return
	 */
	@RequestMapping("/saveProxyCbly")
	@ResponseBody
	public ActionResultModel saveProxyCbly(String reportWarehouseId,String reportWarehouse,String reportId, String reportMonth,String manager, String jsonlist) {
		ActionResultModel actionResultModel = new ActionResultModel();
		SysUser user = TokenManager.getToken();
		System.out.println(TokenManager.getSysUserId());
		System.out.println(user.getId());
		//String reportWarehouse = user.getShortName();
//		if (StringUtils.isEmpty(reportWarehouse) || !Constant.WAREHOUSE.contains(reportWarehouse)) {
		if (StringUtils.isEmpty(reportWarehouse) || Constant.HOME_WAREHOUSE.equals(reportWarehouse)) {
			actionResultModel.setSuccess(false);
			actionResultModel.setMsg("您没有该权限！！");
		}else{
			List<ReportCbly> cblyList = JSON.parseArray(jsonlist, ReportCbly.class);

			//验证数据是否正确start
			List<ReportSply> splyList = splyService.listSplyByMonthHouse(reportMonth, reportWarehouse);
			StringBuffer reserveInSb = new StringBuffer();
			StringBuffer transferReserveOilSb = new StringBuffer();
			ReportCbly cbly = null;
			ReportSply sply = null;
			BigDecimal changeOutSubtotal = null; //转做商品粮油
			BigDecimal reserveIn = null; //商品粮油收支月报表的储备粮油转入
			BigDecimal changeInSubtotal = null; //商品粮油转入
			BigDecimal transferReserveOil = null; //商品粮油收支月报表的转作储备粮油
			for (int i = 0; i < cblyList.size(); i++) {
				cbly = cblyList.get(i);

				if(cbly.getCssClass().contains("false")){ //只需要判断手工填写的品种即可
					if(!splyList.isEmpty()){
						sply = splyList.get(i);
						reserveIn = sply.getReserveIn();
						changeOutSubtotal = cbly.getChangeOutSubtotal();
						if(changeOutSubtotal == null){
							changeOutSubtotal = new BigDecimal(0);
						}
						if(reserveIn == null){
							reserveIn = new BigDecimal(0);
						}
						if(changeOutSubtotal.compareTo(reserveIn) !=0){
//							reserveInSb.append("、").append(sply.getGrainType()).append("(").append(reserveIn).append(")");
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
//							transferReserveOilSb.append("、").append(sply.getGrainType()).append("(").append(transferReserveOil).append(")");
							transferReserveOilSb.append("、").append(sply.getGrainType());
						}
					}

				}
			}

			String error = "";
			if (reserveInSb.length()>0) {
				error = reserveInSb.toString().substring(1) + "的转做商品粮油小计与商品粮油收支月报表的储备粮油转入不等；";
			}
			if (transferReserveOilSb.length()>0) {
				error += transferReserveOilSb.toString().substring(1) + "的商品粮油转入小计与商品粮油收支月报表的转作储备粮油不等；";
			}
			//验证数据是否正确end

			if (StringUtils.isNotEmpty(error)){
				actionResultModel.setMsg(error);
				actionResultModel.setSuccess(false);
			}else {
				reportId = service.addProxyCbly(reportWarehouseId,reportWarehouse, reportId, reportMonth, cblyList, manager);
				actionResultModel.setSuccess(true);
				actionResultModel.setMsg(reportId);
			}
		}

		return actionResultModel;
	}

	/**
	 * 储备粮油填报
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("fillProxyCbly")
	public String fillProxyCbly(ModelMap modelMap, String reportMonth, String reportWarehouse, String reportWarehouseId) {
		String status = "未保存";
		SysUser user = TokenManager.getToken();
		//String reportWarehouse = user.getShortName();
		if(StringUtils.isNotEmpty(reportMonth) && StringUtils.isNotEmpty(reportWarehouseId)){
			Date monthDate = DateUtil.StringtoDate(reportMonth, DateUtil.MONTH_FORMAT);
			Date preMonthDate = DateUtil.nextMonth(monthDate, -1);
			String preMonth = DateUtil.DateToString(preMonthDate, DateUtil.MONTH_FORMAT); //上个月

			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportName(ReportNameEnum.CBLY.getValue());
			param.setReportWarehouseId(reportWarehouseId);
			ReportMonth report = monthService.getReport(param);
			param.setReportMonth(preMonth);
			ReportMonth preMonthReport = monthService.getReport(param);
			if (report != null){
				List<ReportCbly> cblyList = service.listCblyByReportId(report.getId());
				status = report.getReportStatus();
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("reportId", report.getId());
				modelMap.put("cblyList", cblyList);
				modelMap.put("manager", report.getManager());
			}
			if (preMonthReport != null){ //查询上月库存
				List<ReportCbly> preCblyList = service.listCblyByReportId(preMonthReport.getId());
				modelMap.put("preCblyList", preCblyList);
			}
		}

		modelMap.put("list", ReportMonthController.list);
		modelMap.put("status", status);
		return "report/monthReport/fill_cbly";
	}
}
