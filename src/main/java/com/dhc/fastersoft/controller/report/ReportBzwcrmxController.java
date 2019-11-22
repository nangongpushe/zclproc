package com.dhc.fastersoft.controller.report;
import com.alibaba.fastjson.JSON;
import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.Constant;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.enumdata.ReportNameEnum;
import com.dhc.fastersoft.entity.enumdata.ReportStatusEnum;
import com.dhc.fastersoft.entity.report.ReportBzwcrmx;
import com.dhc.fastersoft.entity.report.ReportMonth;
import com.dhc.fastersoft.entity.report.ReportSwtz;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.ReportBzwcrmxService;
import com.dhc.fastersoft.service.ReportMonthService;
import com.dhc.fastersoft.service.ReportSwtzService;
import net.sf.json.JSONArray;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;

@RequestMapping("/reportBzwcrmx")
@Controller
public class ReportBzwcrmxController {
    @Autowired
    private ReportBzwcrmxService service;
    @Autowired
    private ReportMonthService monthService;
    /**
     * 库存包装物出入库明细表填报
     *
     * @param
     * @return
     */
    @RequestMapping("fillBzwcrmx")
    public String fillBzwcrmx(ModelMap modelMap, String reportMonth) {
        SysUser user = TokenManager.getToken();
        String status = "未保存";
        String reportWarehouseId = user.getWareHouseId();
        if(StringUtils.isNotEmpty(reportMonth) && StringUtils.isNotEmpty(reportWarehouseId)){
            ReportMonth param = new ReportMonth();
            param.setReportMonth(reportMonth);
            param.setReportName(ReportNameEnum.BZWCRMX.getValue());
            param.setReportWarehouseId(reportWarehouseId);
            ReportMonth report = monthService.getReport(param);
            if (report != null){
                List<ReportBzwcrmx> bzwcrmxList = service.listBzwcrmxByReportId(report.getId());
                status = report.getReportStatus();
                modelMap.put("reportId", report.getId());
                modelMap.put("fillTime", report.getCreateDate());
                modelMap.put("bzwcrmxList", bzwcrmxList);
                modelMap.put("reportMain", report);
                modelMap.put("manager", report.getManager());
                modelMap.put("reportWarehouse", report.getReportWarehouse());

            }else{
                modelMap.put("reportWarehouse", user.getShortName());
            }
        }
        modelMap.put("status", status);
        //modelMap.addAttribute("currentPoint",TokenManager.getToken().getShortName());
        return "report/monthReport/fill_bzwcrmx";
    }

    /**
     * 库存包装物出入库明细表保存
     *
     * @param
     * @return
     */
    @SysLogAn("报表台账-报表管理-填报-保存")
    @RequestMapping("saveBzwcrmx")
    @ResponseBody
    public ActionResultModel saveSwtz(String reportId, String reportMonth, String jsonlist, String manager, String reserveProperty,String comments) {
        ActionResultModel actionResultModel = new ActionResultModel();
        SysUser user = TokenManager.getToken();
        String reportWarehouse = user.getShortName();
        if (StringUtils.isEmpty(user.getOriginCode()) || Constant.HOME_WAREHOUSE.equals(reportWarehouse)) {
            actionResultModel.setSuccess(false);
            actionResultModel.setMsg("您没有该权限！！");
        }else{
            List<ReportBzwcrmx> bzwcrmxlist = JSON.parseArray(jsonlist, ReportBzwcrmx.class);
            reportId = service.addBzwcrmx(reportId, reportMonth, bzwcrmxlist, manager, reserveProperty,comments);
            actionResultModel.setSuccess(true);
            actionResultModel.setMsg(reportId);
        }
        return actionResultModel;

    }

    @SysLogAn("报表台账-报表管理-导出")
    @RequestMapping("/exportBzwcrmx")
    public String exportBzwcrmx(HttpServletRequest request, HttpServletResponse response, String title) {
        String reportId = request.getParameter("reportId").toString();
        String fileName = ReportNameEnum.BZWCRMX.getValue() + ".xls";
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
        List<ReportBzwcrmx> bzwcrmxList = service.listBzwcrmxByReportId(reportId);
        response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
        request.setAttribute("bzwcrmxList", bzwcrmxList);
        request.setAttribute("reportMain", reportMain);
        return "report/monthReport/export_bzwcrmx";
    }

/**
 * 库存包装物出入库明细表填报
 *
 * @param
 * @return
 */
    @RequestMapping("fillProxyBzwcrmx")
    public String fillProxyBzwcrmx(ModelMap modelMap, String reportMonth, String reportWarehouse,String reportWarehouseId, String enterpriseName) {
        SysUser user = TokenManager.getToken();
        String status = "未保存";
        if(StringUtils.isNotEmpty(reportMonth) && StringUtils.isNotEmpty(reportWarehouseId)){
            ReportMonth param = new ReportMonth();
            param.setReportMonth(reportMonth);
            param.setReportName(ReportNameEnum.BZWCRMX.getValue());
            param.setReportWarehouseId(reportWarehouseId);
            ReportMonth report = monthService.getReport(param);
            if (report != null){
                List<ReportBzwcrmx> bzwcrmxList = service.listBzwcrmxByReportId(report.getId());
                status = report.getReportStatus();
                modelMap.put("reportId", report.getId());
                modelMap.put("fillTime", report.getCreateDate());
                modelMap.put("bzwcrmxList", bzwcrmxList);
                modelMap.put("reportMain", report);
                modelMap.put("manager", report.getManager());
            }
        }
        modelMap.put("reportWarehouse", reportWarehouse);
        modelMap.put("status", status);
        modelMap.addAttribute("currentPoint",TokenManager.getToken().getShortName());
        return "report/monthReport/fill_bzwcrmx";
    }


    /**
     * 库存包装物出入库明细表保存
     *
     * @param
     * @return
     */
    @SysLogAn("报表台账-报表管理-[代储]报表填报-保存")
    @RequestMapping("saveProxyBzwcrmx")
    @ResponseBody
    public ActionResultModel saveProxyBzwcrmx(String reportWarehouseId, String reportWarehouse,String reportId, String reportMonth, String jsonlist, String manager,String comments) {
        ActionResultModel actionResultModel = new ActionResultModel();
        SysUser user = TokenManager.getToken();
        //String reportWarehouse = user.getShortName();
        if (StringUtils.isEmpty(user.getOriginCode()) || Constant.HOME_WAREHOUSE.equals(reportWarehouseId)) {
            actionResultModel.setSuccess(false);
            actionResultModel.setMsg("您没有该权限！！");
        }else{
            List<ReportBzwcrmx> bzwcrmxlist = JSON.parseArray(jsonlist, ReportBzwcrmx.class);
            reportId = service.addProxyBzwcrmx(reportWarehouseId,reportWarehouse,reportId, reportMonth, bzwcrmxlist, manager,comments);
            actionResultModel.setSuccess(true);
            actionResultModel.setMsg(reportId);
        }
        return actionResultModel;

    }


    /**
     * 查询已审核
     *
     * @param
     * @return
     */
    @RequestMapping("queryBzwcrmx")
    public String queryBzwcrmx(ModelMap modelMap, String reportMonth) {
        SysUser user = TokenManager.getToken();
        String reportWarehouseId = user.getWareHouseId();
        String status = "";
        if(StringUtils.isNotEmpty(reportMonth) && StringUtils.isNotEmpty(reportWarehouseId)){
            ReportMonth param = new ReportMonth();
            param.setReportMonth(reportMonth);
            param.setReportStatus("YS");//已审
            param.setReportName(ReportNameEnum.BZWCRMX.getValue());
            param.setReportWarehouseId(user.getWareHouseId());
            ReportMonth report = monthService.getReport(param);
            if (report != null){
                List<ReportBzwcrmx> bzwcrmxList = service.listBzwcrmxByReportId(report.getId());
                status = report.getReportStatus();
                modelMap.put("reportId", report.getId());
                modelMap.put("fillTime", report.getCreateDate());
                modelMap.put("bzwcrmxList", bzwcrmxList);
                modelMap.put("reportMain", report);
                modelMap.put("manager", report.getManager());
            }
            modelMap.put("reportWarehouse", report.getReportWarehouse());
            modelMap.put("status", status);
        }
        return "report/monthReport/fill_bzwcrmx";
    }


/**
 * 包装物出入明细审核
 *
 * @param
 * @return
 */
    @RequestMapping("appKuBzwcrmx")
    public String appKuBzwcrmx(ModelMap modelMap, String reportMonth, String reportWarehouseId) {
        String status = "";
        if(StringUtils.isNotEmpty(reportMonth)){
            ReportMonth param = new ReportMonth();
            param.setReportMonth(reportMonth);
            param.setReportStatus("DHZ");
            param.setReportName(ReportNameEnum.BZWCRMX.getValue());
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
                modelMap.put("comments", report.getComments());
                modelMap.put("reserveProperty", report.getReserveProperty());

                List<ReportBzwcrmx> bzwcrmxList = service.listBzwcrmxByReportId(report.getId());
                status = report.getReportStatus();
                modelMap.put("reportId", report.getId());
                modelMap.put("bzwcrmxList", bzwcrmxList);
                modelMap.put("fillTime", report.getCreateDate());
                modelMap.put("reportWarehouse", report.getReportWarehouse());
            }
        }

        modelMap.put("status", status);
        return "report/monthReport/fill_bzwcrmx";
    }


    /**
     * 分库查询已审核
     *
     * @param
     * @return
     */
    @RequestMapping("queryKuBzwcrmx")
    public String queryKuBzwcrmx(ModelMap modelMap, String reportMonth, String reportWarehouseId, String reportWarehouse) {
        SysUser user = TokenManager.getToken();

        String status = "";
        if(StringUtils.isNotEmpty(reportMonth)){
            ReportMonth param = new ReportMonth();
            param.setReportMonth(reportMonth);
            param.setReportStatus("YS");//已审
            param.setReportName(ReportNameEnum.BZWCRMX.getValue());
            param.setReportWarehouseId(reportWarehouseId);
            ReportMonth report = monthService.getReport(param);
            if (report != null){
                List<ReportBzwcrmx> bzwcrmxList = service.listBzwcrmxByReportId(report.getId());
                status = report.getReportStatus();
                modelMap.put("reportId", report.getId());
                modelMap.put("bzwcrmxList", bzwcrmxList);
                modelMap.put("fillTime", report.getCreateDate());
                modelMap.put("reportMain", report);
                modelMap.put("manager", report.getManager());
                modelMap.put("comments", report.getComments());
                modelMap.put("reportWarehouse", report.getReportWarehouse());
            }
        }
        modelMap.put("status", status);
        modelMap.put("reportMonth", reportMonth);
        return "report/monthReport/fill_bzwcrmx";
    }


    /**
     * 实物台账审核
     *
     * @param
     * @return
     */
    @RequestMapping("appSumBzwcrmx")
    public String appSumBzwcrmx(ModelMap modelMap, String reportMonth) {
        String reportWarehouse = Constant.HOME_WAREHOUSE;
        String status = "";
        if(StringUtils.isNotEmpty(reportMonth)){
            ReportMonth param = new ReportMonth();
            param.setReportMonth(reportMonth);
            param.setReportStatus(ReportStatusEnum.HZDS.getValue());
            param.setReportName(ReportNameEnum.BZWCRMX.getValue());
            param.setReportWarehouse(reportWarehouse);
            ReportMonth report = monthService.getReport(param);
            if (report != null){
                List<ReportBzwcrmx> bzwcrmxList = service.listSumBzwcrmx(report.getId());
                status = report.getReportStatus();
                modelMap.put("reportId", report.getId());
                modelMap.put("bzwcrmxList", bzwcrmxList);
                modelMap.put("fillTime", report.getCreateDate());
                modelMap.put("reportMain", report);
            }
        }
        modelMap.put("reportWarehouse", reportWarehouse);
        modelMap.put("status", status);
        modelMap.put("reportMonth", reportMonth);
        return "report/monthReport/fill_bzwcrmx_sum";
    }


    @SysLogAn("报表台账-报表管理-导出")
    @RequestMapping("/exportBzwcrmxSum")
    public String exportBzwcrmxSum(HttpServletRequest request, HttpServletResponse response, String title) {
        String reportMonth = request.getParameter("reportMonth").toString();
        String reportId = request.getParameter("reportId").toString();
        String fileName = ReportNameEnum.BZWCRMX.getValue() + ".xls";
        if (StringUtils.isNotEmpty(title)){
            fileName = title + ".xls";
        }
        try {
            fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        List<ReportBzwcrmx> bzwcrmxList = service.listSumBzwcrmx(reportId);
        ReportMonth reportMain = monthService.getReportMonthById(reportId);
        SysUser userInfo = monthService.getUserInfoByAccount(reportMain.getCreator());

        request.setAttribute("userInfo", userInfo);
        response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
        request.setAttribute("bzwcrmxList", bzwcrmxList);
        request.setAttribute("reportMonth", reportMonth);
        request.setAttribute("reportMain", reportMain);
        return "report/monthReport/export_bzwcrmx_sum2";
    }


    /**
     * 查询已审核
     *
     * @param
     * @return
     */
    @RequestMapping("querySumBzwcrmx")
    public String querySumBzwcrmx(ModelMap modelMap, String reportMonth) {
        String reportWarehouse = Constant.HOME_WAREHOUSE;
        String status = "";
        if(StringUtils.isNotEmpty(reportMonth)){
            ReportMonth param = new ReportMonth();
            param.setReportMonth(reportMonth);
            param.setReportStatus(ReportStatusEnum.HZTG.getValue());//已审
            param.setReportName(ReportNameEnum.BZWCRMX.getValue());
            param.setReportWarehouse(reportWarehouse);
            ReportMonth report = monthService.getReport(param);
            if (report != null){
                List<ReportBzwcrmx> bzwcrmxList = service.listSumBzwcrmx(report.getId());
                status = report.getReportStatus();
                modelMap.put("reportId", report.getId());
                modelMap.put("bzwcrmxList", bzwcrmxList);
                modelMap.put("fillTime", report.getCreateDate());
                modelMap.put("reportMain", report);
            }
        }
        modelMap.put("reportWarehouse", reportWarehouse);
        modelMap.put("status", status);
        return "report/monthReport/fill_bzwcrmx_sum";
    }
}
