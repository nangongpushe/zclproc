package com.dhc.fastersoft.controller.report;

import com.alibaba.fastjson.JSON;
import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.Constant;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.ReportMonthBzwDTO;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.enumdata.ReportNameEnum;
import com.dhc.fastersoft.entity.enumdata.ReportStatusEnum;
import com.dhc.fastersoft.entity.report.ReportBzw;
import com.dhc.fastersoft.entity.report.ReportMonth;
import com.dhc.fastersoft.entity.report.ReportSwtz;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.ReportBzwService;
import com.dhc.fastersoft.service.ReportMonthService;
import com.dhc.fastersoft.service.StorageWarehouseService;
import net.sf.json.JSONArray;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;

@RequestMapping("/reportBzw")
@Controller
public class ReportBzwController {

	@Autowired
	private ReportBzwService service;
	@Autowired
	private ReportMonthService monthService;
	@Autowired
	private StorageWarehouseService storageWarehouseService;

	/**
	 * 省外购进\销往省外月报表填报
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("fillBzw")
	public String fillBzw(ModelMap modelMap, String reportMonth) {
		String status = "未保存";
		SysUser user = TokenManager.getToken();
		//无法根据某个字段判断是否为代储用户 根据流程 代储用户需自行创建账户 即根据Note判断
		List<StorageWarehouse> list;
		if (user.getNote()!=null) {
			list = storageWarehouseService.listWareHouseByType(user.getCompany());
		} else {
			HashMap<String,Object> param = new HashMap();
			param.put("warehouseType", "代储");
			list = storageWarehouseService.listValidWarehouse(param);
			list.add(0, new StorageWarehouse(user.getWareHouseId(),user.getCompany(),user.getShortName()));
		}

		modelMap.put("extendsWarehouse", list);
		modelMap.put("extendsWarehouseJson",JSONArray.fromObject(list));

		String reportWarehouseId = user.getWareHouseId();
		if(StringUtils.isNotEmpty(reportMonth) && StringUtils.isNotEmpty(reportWarehouseId)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportName(ReportNameEnum.BZW.getValue());
			param.setReportWarehouseId(reportWarehouseId);
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				List<ReportBzw> bzwList = service.listBzwByReportId(report.getId());
				status = report.getReportStatus();
				String remark = report.getRemark();
				modelMap.put("remark", remark);
				modelMap.put("reportId", report.getId());
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("bzwList", bzwList);
				modelMap.put("manager", report.getManager());
			}
		}
		modelMap.put("status", status);
		modelMap.put("reportMonth", reportMonth);

		return "report/monthReport/fill_bzw";
	}

	/**
	 * 保存包装物库存月报表
	 *
	 * @param jsonlist
	 * @return
	 */
	@SysLogAn("报表台账-报表管理-填报-保存草稿")
	@RequestMapping("/saveBzw")
	@ResponseBody
	public ActionResultModel saveBzw(String reportId, String reportMonth, String jsonlist, String manager) {
		ActionResultModel actionResultModel = new ActionResultModel();
		SysUser user = TokenManager.getToken();
		String reportWarehouse = user.getShortName();
		if (StringUtils.isEmpty(user.getOriginCode()) || Constant.HOME_WAREHOUSE.equals(reportWarehouse)) {
			actionResultModel.setSuccess(false);
			actionResultModel.setMsg("您没有该权限！！");
		}else{
			List<ReportBzw> swtzlist = JSON.parseArray(jsonlist, ReportBzw.class);
			reportId = service.addBzw(reportId, reportMonth, swtzlist, manager);
			actionResultModel.setSuccess(true);
			actionResultModel.setMsg(reportId);
		}
		return actionResultModel;
	}

	@SysLogAn("报表台账-报表管理-导出")
	@RequestMapping("/exportBzw")
	public String exportBzw(HttpServletRequest request, HttpServletResponse response) {
		String reportId = request.getParameter("reportId");
		String reportName = ReportNameEnum.BZW.getValue();
		String fileName = reportName + ".xls";
		try {
			fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		ReportMonth monthReport = monthService.getReportMonthById(reportId);
		SysUser userInfo = monthService.getUserInfoByAccount(monthReport.getCreator());
		request.setAttribute("userInfo", userInfo);
		List<ReportBzw> list = service.listBzwByReportId(reportId);
		response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
		request.setAttribute("monthReport", monthReport);
		request.setAttribute("bzwList", list);
		return "report/monthReport/export_bzw";
	}

	/*@SysLogAn("报表台账-报表管理-导出")
	@RequestMapping("/exportBzwSum")
	public String exportBzwSum(HttpServletRequest request, HttpServletResponse response) {
		String reportId = request.getParameter("reportId");
		String reportName = ReportNameEnum.BZW.getValue();
		String fileName = reportName + ".xls";
		try {
			fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		ReportMonth monthReport = monthService.getReportMonthById(reportId);
		SysUser userInfo = monthService.getUserInfoByAccount(monthReport.getCreator());
		request.setAttribute("userInfo", userInfo);
		List bzwList = service.listSumBzw(monthReport);
		response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
		request.setAttribute("monthReport", monthReport);
		request.setAttribute("bzwList", bzwList);
		return "report/monthReport/export_bzw_sum";
	}*/
    @SysLogAn("报表台账-报表管理-导出")
    @RequestMapping("/exportBzwSum")
    public String exportBzwSum(HttpServletRequest request, HttpServletResponse response) {
        String reportId = request.getParameter("reportId");
        String reportName = ReportNameEnum.BZW.getValue();
        String fileName = reportName + ".xls";
        try {
            fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        ReportMonth monthReport = monthService.getReportMonthById(reportId);
        SysUser userInfo = monthService.getUserInfoByAccount(monthReport.getCreator());
        request.setAttribute("userInfo", userInfo);
        List bzwList = service.listSumBzw2(monthReport,request);
        response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
        request.setAttribute("monthReport", monthReport);
        request.setAttribute("bzwList", bzwList);
        return "report/monthReport/export_bzw_sum";
    }

	@SysLogAn("报表台账-报表管理-导出")
	@RequestMapping("/exportQueryBzw")
	public String exportQueryBzw(HttpServletRequest request, HttpServletResponse response, String bzwReportType) {
		String reportId = request.getParameter("reportId");
		String reportName = ReportNameEnum.BZW.getValue();
		String fileName = reportName + ".xls";
		try {
			fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		ReportMonth monthReport = monthService.getReportMonthById(reportId);
		SysUser userInfo = monthService.getUserInfoByAccount(monthReport.getCreator());
		request.setAttribute("userInfo", userInfo);
		response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
		request.setAttribute("monthReport", monthReport);
		if("sum".equals(bzwReportType)){
			ReportBzw[] bzwList = service.listSumBzwByReportId(reportId);
			request.setAttribute("bzwList", bzwList);
			return "report/monthReport/export_query_bzw";

		}else{
			List<ReportBzw> bzwList = service.listBzwByReportId(reportId);
			request.setAttribute("bzwList", bzwList);
			return "report/monthReport/export_bzw";
		}
	}

	/**
	 * 省外购进\销往省外月报表填报
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("appBzw")
	public String appBzw(ModelMap modelMap, String reportMonth) {
		String status = "";
		SysUser user = TokenManager.getToken();
		String reportWarehouse = user.getShortName();
		if(StringUtils.isNotEmpty(reportMonth) && StringUtils.isNotEmpty(reportWarehouse)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportStatus(ReportStatusEnum.DSH.getValue());
			param.setReportName(ReportNameEnum.BZW.getValue());
			param.setReportWarehouseId(user.getWareHouseId());
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				ReportBzw[] bzwList = service.listSumBzwByReportId(report.getId());
				status = report.getReportStatus();
				String remark = report.getRemark();
				modelMap.put("reportId", report.getId());
				modelMap.put("remark", remark);
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("bzwList", bzwList);
				List<ReportBzw> list = service.listBzwByReportId(report.getId());
				modelMap.put("list", list);
				modelMap.put("manager", report.getManager());
			}
		}
		modelMap.put("status", status);
		modelMap.put("reportMonth", reportMonth);
		return "report/monthReport/query_bzw";
	}

	/**
	 * 查询已审核
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("queryBzw")
	public String queryBzw(ModelMap modelMap, String reportMonth) {
		String status = "";
		SysUser user = TokenManager.getToken();
		String reportWarehouse = user.getShortName();
		if(StringUtils.isNotEmpty(reportMonth) && StringUtils.isNotEmpty(reportWarehouse)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportStatus("YS");//已审
			param.setReportName(ReportNameEnum.BZW.getValue());
			param.setReportWarehouseId(user.getWareHouseId());
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				ReportBzw[] bzwList = service.listSumBzwByReportId(report.getId());
				status = report.getReportStatus();
				String remark = report.getRemark();
				modelMap.put("reportId", report.getId());
				modelMap.put("remark", remark);
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("bzwList", bzwList);
				List<ReportBzw> list = service.listBzwByReportId(report.getId());
				modelMap.put("list", list);
				modelMap.put("manager", report.getManager());
			}
		}
		modelMap.put("status", status);
		return "report/monthReport/query_bzw";
	}

	/**
	 * 分库查询已审核
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("queryKuBzw")
	public String queryKuBzw(ModelMap modelMap, String reportMonth, String reportWarehouseId) {
		String status = "";
		if (StringUtils.isNotEmpty(reportMonth)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportStatus("YS");//已审
			param.setReportName(ReportNameEnum.BZW.getValue());
			param.setReportWarehouseId(reportWarehouseId);
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				ReportBzw[] bzwList = service.listSumBzwByReportId(report.getId());
				status = report.getReportStatus();
				String remark = report.getRemark();
				modelMap.put("reportId", report.getId());
				modelMap.put("remark", remark);
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("bzwList", bzwList);
				List<ReportBzw> list = service.listBzwByReportId(report.getId());
				modelMap.put("list", list);
				modelMap.put("manager", report.getManager());
			}
		}
		modelMap.put("status", status);
		modelMap.put("reportMonth", reportMonth);
		return "report/monthReport/query_bzw";
	}

	/**
	 * 分库审核
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("appKuBzw")
	public String appKuBzw(ModelMap modelMap, String reportMonth, String reportWarehouseId) {
		String status = "";
		if (StringUtils.isNotEmpty(reportMonth)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportStatus("DHZ");
			param.setReportName(ReportNameEnum.BZW.getValue());
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

				ReportBzw[] bzwList = service.listSumBzwByReportId(report.getId());
				List<ReportBzw> list = service.listBzwByReportId(report.getId());
				status = report.getReportStatus();
				String remark = report.getRemark();
				modelMap.put("reportId", report.getId());
				modelMap.put("remark", remark);
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("bzwList", bzwList);
				modelMap.put("list", list);
			}
		}
		modelMap.put("status", status);
		modelMap.put("reportMonth", reportMonth);
		return "report/monthReport/query_bzw";
	}

	/**
	 * 汇总查询
	 *
	 * @param
	 * @return
	 */
	/*@RequestMapping("querySumBzw")
	public String querySumBzw(ModelMap modelMap, String reportMonth) {
		String reportWarehouse = Constant.HOME_WAREHOUSE;
		String status = "";
		if (StringUtils.isNotEmpty(reportMonth)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportStatus(ReportStatusEnum.HZTG.getValue());//已审
			param.setReportName(ReportNameEnum.BZW.getValue());
			param.setReportWarehouse(reportWarehouse);
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				List bzwList = service.listSumBzw(report);
				status = report.getReportStatus();
				String remark = report.getRemark();
				modelMap.put("reportId", report.getId());
				modelMap.put("remark", remark);
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("bzwList", bzwList);
				modelMap.put("manager", report.getManager());
				modelMap.put("remark", report.getRemark());
			}
		}
		modelMap.put("status", status);
		return "report/monthReport/fill_bzw_sum";
	}*/
	@RequestMapping("querySumBzw")
	public String querySumBzw(ModelMap modelMap, String reportMonth) {
		String reportWarehouse = Constant.HOME_WAREHOUSE;
		String status = "";
		if (StringUtils.isNotEmpty(reportMonth)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportStatus(ReportStatusEnum.HZTG.getValue());//已审
			param.setReportName(ReportNameEnum.BZW.getValue());
			param.setReportWarehouse(reportWarehouse);
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				List bzwList = service.listSumBzw1(report,modelMap);
				status = report.getReportStatus();
				String remark = report.getRemark();
				modelMap.put("reportId", report.getId());
				modelMap.put("remark", remark);
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("bzwList", bzwList);
				modelMap.put("manager", report.getManager());
				modelMap.put("remark", report.getRemark());
			}
		}
		modelMap.put("status", status);
		return "report/monthReport/fill_bzw_sum";
	}
	/**
	 * 省外购进\销往省外月报表填报
	 *
	 * @param
	 * @return
	 */
	/*@RequestMapping("appSumBzw")
	public String appSumBzw(ModelMap modelMap, String reportMonth) {
		String status = "";
		if (StringUtils.isNotEmpty(reportMonth)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportStatus(ReportStatusEnum.HZDS.getValue());
			param.setReportName(ReportNameEnum.BZW.getValue());
			param.setReportWarehouse(Constant.HOME_WAREHOUSE);
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				List bzwList = service.listSumBzw(report);
				status = report.getReportStatus();
				String remark = report.getRemark();
				modelMap.put("reportId", report.getId());
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("bzwList", bzwList);
				modelMap.put("reportMain", report);
				modelMap.put("manager", report.getManager());
				modelMap.put("remark", report.getRemark());
			}
		}
		modelMap.put("status", status);
		return "report/monthReport/fill_bzw_sum";
	}*/


	@RequestMapping("appSumBzw")
	public String appSumBzw(ModelMap modelMap, String reportMonth) {
		String status = "";
		if (StringUtils.isNotEmpty(reportMonth)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportStatus(ReportStatusEnum.HZDS.getValue());
			param.setReportName(ReportNameEnum.BZW.getValue());
			param.setReportWarehouse(Constant.HOME_WAREHOUSE);
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				List bzwList = service.listSumBzw1(report,modelMap);
				status = report.getReportStatus();
				String remark = report.getRemark();
				modelMap.put("reportId", report.getId());
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("bzwList", bzwList);
				modelMap.put("reportMain", report);
				modelMap.put("manager", report.getManager());
				modelMap.put("remark", report.getRemark());
			}
		}
		modelMap.put("status", status);
		return "report/monthReport/fill_bzw_sum";
	}


/**
 * 代储点包装物报表填报
 *
 * @param
 * @return
 */
    @RequestMapping("fillProxyBzw")
    public String fillProxyBzw(ModelMap modelMap, String reportMonth, String reportWarehouse,String reportWarehouseId, String enterpriseName) {
        String status = "未保存";
        SysUser user = TokenManager.getToken();
        //无法根据某个字段判断是否为代储用户 根据流程 代储用户需自行创建账户 即根据Note判断
        List<StorageWarehouse> list = storageWarehouseService.listWareHouseByType(enterpriseName);
        modelMap.put("extendsWarehouse", list);
		modelMap.put("extendsWarehouseJson", JSONArray.fromObject(list));
        if(StringUtils.isNotEmpty(reportMonth) && StringUtils.isNotEmpty(reportWarehouseId)){
            ReportMonth param = new ReportMonth();
            param.setReportMonth(reportMonth);
            param.setReportName(ReportNameEnum.BZW.getValue());
            param.setReportWarehouseId(reportWarehouseId);
            ReportMonth report = monthService.getReport(param);
            if (report != null){
                List<ReportBzw> bzwList = service.listBzwByReportId(report.getId());
                status = report.getReportStatus();
                String remark = report.getRemark();
                modelMap.put("remark", remark);
                modelMap.put("reportId", report.getId());
                modelMap.put("fillTime", report.getCreateDate());
                modelMap.put("bzwList", bzwList);
                modelMap.put("manager", report.getManager());
            }
        }
		modelMap.put("reportWarehouseId", reportWarehouseId);
        modelMap.put("status", status);
        modelMap.put("reportMonth", reportMonth);
//		modelMap.put("reportWarehouse", reportWarehouse);
        return "report/monthReport/fill_bzw";
    }


    /**
     * 保存包装物库存月报表
     *
     * @param jsonlist
     * @return
     */
    @SysLogAn("报表台账-报表管理-[代储]报表填报-保存草稿")
    @RequestMapping("/saveProxyBzw")
    @ResponseBody
    public ActionResultModel saveProxyBzw(String reportWarehouseId, String reportWarehouse,String reportId, String reportMonth, String jsonlist, String manager) {
        //前台reportWarehouse的name重复，所以传到这里要拆分取第一个
        String [] reportWarehouses = reportWarehouse.split(",");
        ActionResultModel actionResultModel = new ActionResultModel();
        SysUser user = TokenManager.getToken();

        if (StringUtils.isEmpty(user.getOriginCode()) || Constant.HOME_WAREHOUSE.equals(reportWarehouse)) {
            actionResultModel.setSuccess(false);
            actionResultModel.setMsg("您没有该权限！！");
        }else{
            List<ReportBzw> swtzlist = JSON.parseArray(jsonlist, ReportBzw.class);
            reportId = service.addProxyBzw(reportWarehouseId,reportWarehouses[0],reportId, reportMonth, swtzlist, manager);
            actionResultModel.setSuccess(true);
            actionResultModel.setMsg(reportId);
        }
        return actionResultModel;
    }


    @ResponseBody
    @RequestMapping(value = "GetLastMonthData",method = RequestMethod.POST)
    public ReportMonthBzwDTO GetLastMonthData(@RequestParam(value = "reportDate") String reportDate,
								   @RequestParam(value = "reportWarehouseId",required = false) String reportWarehouseId){
		ReportMonthBzwDTO reportMonthBzwDTO = new ReportMonthBzwDTO();
		SysUser user = TokenManager.getToken();

		ReportMonth param = new ReportMonth();
		param.setReportMonth(reportDate);
		param.setReportName(ReportNameEnum.BZW.getValue());
		if(StringUtils.isEmpty(reportWarehouseId)){
			reportWarehouseId = user.getWareHouseId();
		}
		param.setReportWarehouseId(reportWarehouseId);
		ReportMonth reportMonth = monthService.getReport(param);
		if(reportMonth!=null){
			List<ReportBzw> list = service.listBzwByReportId(reportMonth.getId());

			reportMonthBzwDTO.setData(list);
			reportMonthBzwDTO.setManager(reportMonth.getManager());
			reportMonthBzwDTO.setMsg("");
			reportMonthBzwDTO.setReserveProperty(reportMonth.getReserveProperty());
			reportMonthBzwDTO.setSuccess(true);
		}
    	return reportMonthBzwDTO;
	}
}
