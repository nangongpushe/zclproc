package com.dhc.fastersoft.controller.report;

import com.alibaba.fastjson.JSON;
import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.Constant;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.enumdata.ReportNameEnum;
import com.dhc.fastersoft.entity.enumdata.ReportStatusEnum;
import com.dhc.fastersoft.entity.report.ReportMonth;
import com.dhc.fastersoft.entity.report.ReportSply;
import com.dhc.fastersoft.entity.report.ReportXwsw;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.ReportMonthService;
import com.dhc.fastersoft.service.ReportSplyService;
import com.dhc.fastersoft.service.ReportXwswService;
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
import java.util.List;

@RequestMapping("/reportXwsw")
@Controller
public class ReportXwswController {

	@Autowired
	private ReportXwswService service;
	@Autowired
	private ReportMonthService monthService;
	@Autowired
	private ReportSplyService splyService;

	/**
	 * 省外购进\销往省外月报表填报
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("fillXwsw")
	public String fillXwsw(String reportName, String reportMonth, ModelMap modelMap) {
		String fix = "销往";
		if (ReportNameEnum.SWGJ.getValue().equals(reportName)){
			fix = "购自";
		}
		String status = "未保存";
		SysUser user = TokenManager.getToken();
		String reportWarehouseId = user.getWareHouseId();
		if(StringUtils.isNotEmpty(reportMonth) && StringUtils.isNotEmpty(reportWarehouseId)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportName(reportName);
			param.setReportWarehouseId(reportWarehouseId);
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				List<ReportXwsw> xwswList = service.listXwswByReportId(report.getId());
				status = report.getReportStatus();
				modelMap.put("reportId", report.getId());
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("xwswList", xwswList);
				modelMap.put("manager", report.getManager());
			}
		}
		modelMap.put("list", ReportMonthController.list);
		modelMap.put("status", status);
		modelMap.put("fix", fix);
		modelMap.put("reportName", reportName);
		return "report/monthReport/fill_xwsw";
	}

	/**
	 * 保存省外购进\销往省外月报
	 *
	 * @param jsonlist
	 * @return
	 */
	@SysLogAn("报表台账-报表管理-填报-保存")
	@RequestMapping("/saveXwsw")
	@ResponseBody
	public ActionResultModel saveXwsw(String reportId, String reportMonth, String reportName, String jsonlist, String manager) {
		ActionResultModel actionResultModel = new ActionResultModel();
		SysUser user = TokenManager.getToken();
		String reportWarehouse = user.getShortName();
//		if (StringUtils.isEmpty(reportWarehouse) || !Constant.WAREHOUSE.contains(reportWarehouse)) {
		if (StringUtils.isEmpty(user.getOriginCode()) || Constant.HOME_WAREHOUSE.equals(reportWarehouse)) {
			actionResultModel.setSuccess(false);
			actionResultModel.setMsg("您没有该权限！！");
		}else{
			List<ReportXwsw> xwswList = JSON.parseArray(jsonlist, ReportXwsw.class);

			//验证数据是否正确start
			List<ReportSply> splyList = splyService.listSplyByMonthHouse(reportMonth, reportWarehouse);
			StringBuffer xwswSb = new StringBuffer();
			StringBuffer swgjSb = new StringBuffer();
			ReportSply sply = null;
			ReportXwsw xwsw = null;
			BigDecimal enterpriseInSw = null; //从企业购进 其中：省外
			BigDecimal subtotal = null; //省外购进表的小计
			BigDecimal saleSw = null; //销售 其中：省外

			if(!splyList.isEmpty()){
				for (int i = 0; i < xwswList.size(); i++) {
					xwsw = xwswList.get(i);
					subtotal = xwsw.getSubtotal();
					if(subtotal == null){
						subtotal = new BigDecimal(0);
					}

					if(xwsw.getCssClass().contains("false")){ //只需要判断手工填写的品种即可
						sply = splyList.get(i);
						if(ReportNameEnum.SWGJ.getValue().equals(reportName)){
							enterpriseInSw = sply.getEnterpriseInSw();
							if(enterpriseInSw == null){
								enterpriseInSw = new BigDecimal(0);
							}
							if(enterpriseInSw.compareTo(subtotal) !=0){
//								swgjSb.append("、").append(sply.getGrainType()).append("(").append(enterpriseInSw).append(")");
								swgjSb.append("、").append(sply.getGrainType());
							}
						} else if(ReportNameEnum.XWSW.getValue().equals(reportName)){
							saleSw = sply.getSaleSw();
							if(saleSw == null){
								saleSw = new BigDecimal(0);
							}
							if(saleSw.compareTo(subtotal) !=0){
//								xwswSb.append("、").append(sply.getGrainType()).append("(").append(saleSw).append(")");
								xwswSb.append("、").append(sply.getGrainType());
							}
						}
					}
				}
			}

			String error = "";
			if (swgjSb.length()>0) {
				error = swgjSb.toString().substring(1) + "与商品粮油收支月报表的从企业购进 其中：省外不等；";
			}
			if (xwswSb.length()>0) {
				error = xwswSb.toString().substring(1) + "与商品粮油收支月报表的销售 其中：省外不等；";
			}
			//验证数据是否正确end

			if (StringUtils.isNotEmpty(error)){
				actionResultModel.setMsg(error);
				actionResultModel.setSuccess(false);
			}else {
				reportId = service.addXwsw(reportId, reportMonth, reportName, xwswList, manager);
				actionResultModel.setSuccess(true);
				actionResultModel.setMsg(reportId);
			}
		}

		return actionResultModel;
	}

	@SysLogAn("报表台账-报表管理-导出")
	@RequestMapping("/exportXwsw")
	public String exportXwsw(HttpServletRequest request, HttpServletResponse response, String title, String flag) {
		String reportId = request.getParameter("reportId");
		List<ReportXwsw> xwswList = null;
		if("sum".equals(flag)){
			xwswList = service.listSumXwsw(reportId);
		} else {
			xwswList = service.listXwswByReportId(reportId);
		}
		String reportName = xwswList.get(0).getReportName();
		String fix = "销往";
		if (ReportNameEnum.SWGJ.getValue().equals(reportName)){
			fix = "购自";
		}
		String fileName = reportName + ".xls";
		if (StringUtils.isNotEmpty(title)){
			fileName = title + ".xls";
		}
		try {
			fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		ReportMonth reportMain = monthService.getReportMonthById(reportId);
		SysUser userInfo = monthService.getUserInfoByAccount(reportMain.getCreator());
		request.setAttribute("userInfo", userInfo);
		response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
		request.setAttribute("xwswList", xwswList);
		request.setAttribute("fix", fix);
		request.setAttribute("reportName", reportName);
		request.setAttribute("reportMain", reportMain);
		return "report/monthReport/export_xwsw";
	}

	/**
	 * 省外购进\销往省外月报表审核
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("appXwsw")
	public String appXwsw(String reportName, String reportMonth, ModelMap modelMap) {
		String fix = "销往";
		if (ReportNameEnum.SWGJ.getValue().equals(reportName)){
			fix = "购自";
		}
		String status = "";
		SysUser user = TokenManager.getToken();
		String reportWarehouse = user.getShortName();
		if(StringUtils.isNotEmpty(reportMonth) && StringUtils.isNotEmpty(reportWarehouse)){
			ReportMonth param = new ReportMonth();
			param.setReportStatus(ReportStatusEnum.DSH.getValue());
			param.setReportMonth(reportMonth);
			param.setReportName(reportName);
			param.setReportWarehouseId(user.getWareHouseId());
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				List<ReportXwsw> xwswList = service.listXwswByReportId(report.getId());
				status = report.getReportStatus();
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("reportId", report.getId());
				modelMap.put("xwswList", xwswList);
				modelMap.put("manager", report.getManager());
			}
		}
		modelMap.put("list", ReportMonthController.list);
		modelMap.put("status", status);
		modelMap.put("fix", fix);
		modelMap.put("reportName", reportName);
		return "report/monthReport/fill_xwsw";
	}

	/**
	 * 查询已审核
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("queryXwsw")
	public String queryXwsw(String reportName, String reportMonth, ModelMap modelMap) {
		String fix = "销往";
		if (ReportNameEnum.SWGJ.getValue().equals(reportName)){
			fix = "购自";
		}
		String status = "";
		SysUser user = TokenManager.getToken();
		String reportWarehouse = user.getShortName();
		if(StringUtils.isNotEmpty(reportMonth) && StringUtils.isNotEmpty(reportWarehouse)){
			ReportMonth param = new ReportMonth();
			param.setReportStatus("YS");//已审
			param.setReportMonth(reportMonth);
			param.setReportName(reportName);
			param.setReportWarehouseId(user.getWareHouseId());
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				List<ReportXwsw> xwswList = service.listXwswByReportId(report.getId());
				status = report.getReportStatus();
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("reportId", report.getId());
				modelMap.put("xwswList", xwswList);
				modelMap.put("manager", report.getManager());
			}
		}
		modelMap.put("list", ReportMonthController.list);
		modelMap.put("status", status);
		modelMap.put("fix", fix);
		modelMap.put("reportName", reportName);
		return "report/monthReport/fill_xwsw";
	}

	/**
	 * 分库查询已审核
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("queryKuXwsw")
	public String queryKuXwsw(String reportName, String reportMonth, String reportWarehouse, ModelMap modelMap) {
		String fix = "销往";
		if (ReportNameEnum.SWGJ.getValue().equals(reportName)){
			fix = "购自";
		}
		String status = "";
		if (StringUtils.isNotEmpty(reportMonth)){
			ReportMonth param = new ReportMonth();
			param.setReportStatus("YS");//已审
			param.setReportMonth(reportMonth);
			param.setReportName(reportName);
			param.setReportWarehouseId(reportWarehouse);
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				List<ReportXwsw> xwswList = service.listXwswByReportId(report.getId());
				status = report.getReportStatus();
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("reportId", report.getId());
				modelMap.put("xwswList", xwswList);
				modelMap.put("manager", report.getManager());
			}
		}
		modelMap.put("list", ReportMonthController.list);
		modelMap.put("status", status);
		modelMap.put("fix", fix);
		modelMap.put("reportName", reportName);
		return "report/monthReport/fill_xwsw";
	}

	/**
	 * 上报审核
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("appKuXwsw")
	public String appKuXwsw(String reportName, String reportMonth, ModelMap modelMap, String reportWarehouseId) {
		String fix = "销往";
		if (ReportNameEnum.SWGJ.getValue().equals(reportName)){
			fix = "购自";
		}
		String status = "";
		if (StringUtils.isNotEmpty(reportMonth)){
			ReportMonth param = new ReportMonth();
			param.setReportStatus("DHZ");
			param.setReportMonth(reportMonth);
			param.setReportName(reportName);
			param.setReportWarehouseId(reportWarehouseId);
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
					List<ReportXwsw> xwswList = service.listXwswByReportId(report.getId());
					status = report.getReportStatus();
					modelMap.put("fillTime", report.getCreateDate());
					modelMap.put("reportId", report.getId());
					modelMap.put("xwswList", xwswList);
//				}
			}
		}
		modelMap.put("list", ReportMonthController.list);
		modelMap.put("status", status);
		modelMap.put("fix", fix);
		modelMap.put("reportName", reportName);
		modelMap.put("reportMonth", reportMonth);
		return "report/monthReport/fill_xwsw";
	}

	/**
	 * 查询已审核
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("querySumXwsw")
	public String querySumXwsw(String reportName, String reportMonth, ModelMap modelMap) {
		String reportWarehouse = Constant.HOME_WAREHOUSE;
		String fix = "销往";
		if (ReportNameEnum.SWGJ.getValue().equals(reportName)){
			fix = "购自";
		}
		String status = "";
		if (StringUtils.isNotEmpty(reportMonth)){
			ReportMonth param = new ReportMonth();
			param.setReportStatus(ReportStatusEnum.HZTG.getValue());//已审
			param.setReportMonth(reportMonth);
			param.setReportName(reportName);
			param.setReportWarehouse(reportWarehouse);
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				List<ReportXwsw> xwswList = service.listSumXwsw(report.getId());
				status = report.getReportStatus();
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("reportId", report.getId());
				modelMap.put("xwswList", xwswList);
				modelMap.put("manager", report.getManager());
			}
		}
		modelMap.put("list", ReportMonthController.list);
		modelMap.put("status", status);
		modelMap.put("fix", fix);
		modelMap.put("reportName", reportName);
		return "report/monthReport/fill_xwsw";
	}

	/**
	 * 省外购进\销往省外月报表审核
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("appSumXwsw")
	public String appSumXwsw(String reportName, String reportMonth, ModelMap modelMap) {
		String fix = "销往";
		if (ReportNameEnum.SWGJ.getValue().equals(reportName)){
			fix = "购自";
		}
		String status = "";
		if (StringUtils.isNotEmpty(reportMonth)){
			ReportMonth param = new ReportMonth();
			param.setReportStatus(ReportStatusEnum.HZDS.getValue());
			param.setReportMonth(reportMonth);
			param.setReportName(reportName);
			param.setReportWarehouse(Constant.HOME_WAREHOUSE);
			ReportMonth report = monthService.getReport(param);
			if (report == null){
				param.setReportStatus(ReportStatusEnum.OASUM.getValue());//待审核
				report = monthService.getReport(param);
			}
			if (report != null){
				List<ReportXwsw> xwswList = service.listSumXwsw(report.getId());
				status = report.getReportStatus();
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("reportId", report.getId());
				modelMap.put("xwswList", xwswList);
				modelMap.put("reportMain", report);
				modelMap.put("manager", report.getManager());
			}
		}
		modelMap.put("list", ReportMonthController.list);
		modelMap.put("status", status);
		modelMap.put("fix", fix);
		modelMap.put("reportName", reportName);
		return "report/monthReport/fill_xwsw";
	}

	/**
	 * 保存省外购进\销往省外月报
	 *
	 * @param jsonlist
	 * @return
	 */
	@RequestMapping("/saveProxyXwsw")
	@ResponseBody
	public ActionResultModel saveProxyXwsw(String reportWarehouseId,String reportWarehouse, String reportId, String reportMonth, String reportName, String jsonlist, String manager) {
		ActionResultModel actionResultModel = new ActionResultModel();
		SysUser user = TokenManager.getToken();
		//String reportWarehouse = user.getShortName();
//		if (StringUtils.isEmpty(reportWarehouse) || !Constant.WAREHOUSE.contains(reportWarehouse)) {
		if (StringUtils.isEmpty(reportWarehouse) || Constant.HOME_WAREHOUSE.equals(reportWarehouse)) {
			actionResultModel.setSuccess(false);
			actionResultModel.setMsg("您没有该权限！！");
		}else{
			List<ReportXwsw> xwswList = JSON.parseArray(jsonlist, ReportXwsw.class);

			//验证数据是否正确start
			List<ReportSply> splyList = splyService.listSplyByMonthHouse(reportMonth, reportWarehouse);
			StringBuffer xwswSb = new StringBuffer();
			StringBuffer swgjSb = new StringBuffer();
			ReportSply sply = null;
			ReportXwsw xwsw = null;
			BigDecimal enterpriseInSw = null; //从企业购进 其中：省外
			BigDecimal subtotal = null; //省外购进表的小计
			BigDecimal saleSw = null; //销售 其中：省外

			if(!splyList.isEmpty()){
				for (int i = 0; i < xwswList.size(); i++) {
					xwsw = xwswList.get(i);
					subtotal = xwsw.getSubtotal();
					if(subtotal == null){
						subtotal = new BigDecimal(0);
					}

					if(xwsw.getCssClass().contains("false")){ //只需要判断手工填写的品种即可
						sply = splyList.get(i);
						if(ReportNameEnum.SWGJ.getValue().equals(reportName)){
							enterpriseInSw = sply.getEnterpriseInSw();
							if(enterpriseInSw == null){
								enterpriseInSw = new BigDecimal(0);
							}
							if(enterpriseInSw.compareTo(subtotal) !=0){
//								swgjSb.append("、").append(sply.getGrainType()).append("(").append(enterpriseInSw).append(")");
								swgjSb.append("、").append(sply.getGrainType());
							}
						} else if(ReportNameEnum.XWSW.getValue().equals(reportName)){
							saleSw = sply.getSaleSw();
							if(saleSw == null){
								saleSw = new BigDecimal(0);
							}
							if(saleSw.compareTo(subtotal) !=0){
//								xwswSb.append("、").append(sply.getGrainType()).append("(").append(saleSw).append(")");
								xwswSb.append("、").append(sply.getGrainType());
							}
						}
					}
				}
			}

			String error = "";
			if (swgjSb.length()>0) {
				error = swgjSb.toString().substring(1) + "与商品粮油收支月报表的从企业购进 其中：省外不等；";
			}
			if (xwswSb.length()>0) {
				error = xwswSb.toString().substring(1) + "与商品粮油收支月报表的销售 其中：省外不等；";
			}
			//验证数据是否正确end

			if (StringUtils.isNotEmpty(error)){
				actionResultModel.setMsg(error);
				actionResultModel.setSuccess(false);
			}else {
				reportId = service.addProxyXwsw(reportWarehouseId,reportWarehouse,reportId, reportMonth, reportName, xwswList, manager);
				actionResultModel.setSuccess(true);
				actionResultModel.setMsg(reportId);
			}
		}

		return actionResultModel;
	}

	/**
	 * 省外购进\销往省外月报表填报
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("fillProxyXwsw")
	public String fillProxyXwsw(String reportName, String reportMonth, ModelMap modelMap, String reportWarehouse, String reportWarehouseId) {
		String fix = "销往";
		if (ReportNameEnum.SWGJ.getValue().equals(reportName)){
			fix = "购自";
		}
		String status = "未保存";
		SysUser user = TokenManager.getToken();
		//String reportWarehouse = user.getShortName();
		if(StringUtils.isNotEmpty(reportMonth) && StringUtils.isNotEmpty(reportWarehouse)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportName(reportName);
			param.setReportWarehouseId(reportWarehouseId);
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				List<ReportXwsw> xwswList = service.listXwswByReportId(report.getId());
				status = report.getReportStatus();
				modelMap.put("reportId", report.getId());
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("xwswList", xwswList);
				modelMap.put("manager", report.getManager());
			}
		}
		modelMap.put("list", ReportMonthController.list);
		modelMap.put("status", status);
		modelMap.put("fix", fix);
		modelMap.put("reportName", reportName);
		return "report/monthReport/fill_xwsw";
	}

}
