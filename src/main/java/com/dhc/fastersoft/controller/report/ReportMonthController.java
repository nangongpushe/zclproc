package com.dhc.fastersoft.controller.report;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.Constant;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.controller.BaseController;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.enumdata.ReportNameEnum;
import com.dhc.fastersoft.entity.enumdata.ReportStatusEnum;
import com.dhc.fastersoft.entity.report.ReportMonth;
import com.dhc.fastersoft.entity.store.StoreEnterprise;
import com.dhc.fastersoft.service.ReportMonthService;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.service.store.StoreEnterpriseService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysUserService;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.utils.StringUtil;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.Collator;
import java.util.*;

/**
 * 月报表
 *
 * @author Canbol
 * @date 2017年10月7日 上午10:25:23
 */
@RequestMapping("/reportMonth")
@Controller
public class ReportMonthController extends BaseController {

    public static Logger log = Logger.getLogger(ReportMonthController.class);
    @Autowired
    StoreEnterpriseService storeEnterpriseService;
    @Autowired
    private ReportMonthService service;
    @Autowired
    private StorageWarehouseService storageWarehouseService;

    @Autowired
    private SysDictService sysDictService;

    @Autowired
    private SysUserService sysUserService;

    public static List<String> list = new ArrayList();
    public static List<String> reportNameList = new ArrayList();

    {
        list.add("折合原粮合计-list-true");
        list.add("贸易粮合计-list-true");
        list.add("谷物合计-thick-true");
        list.add("折合小麦-list_1-true");
        list.add("折合面粉-list_1-true");
        list.add("实际小麦-list_1-false");
        list.add("折合稻谷合计-list_1 thick-true");
        list.add("折合早籼稻-list_2-true");
        list.add("折合中晚籼稻-list_2-true");
        list.add("折合粳稻-list_2-true");
        list.add("折合大米合计-list_1 thick-true");
        list.add("折合早籼米-list_2-true");
        list.add("折合中晚籼米-list_2-true");
        list.add("折合粳米-list_2-true");
        list.add("实际稻谷合计-list_1 thick-true");
        list.add("实际早籼稻-list_2-false");
        list.add("实际中晚籼稻-list_2-false");
        list.add("实际粳稻-list_2-false");
        list.add("折合玉米-list_1 thick-true");
        list.add("实际玉米-list_2-false");
        list.add("实际玉米面和玉米渣-list_2-false");
        list.add("豆类合计-thick-true");
        list.add("折合大豆-list_1 thick-true");
        list.add("实际大豆-list_2-false");
        list.add("实际豆饼豆粕-list_2-false");
        list.add("成品粮合计-list-false");
        list.add("油及料折油合计-list-false");
        list.add("油脂合计-list-false");
        list.add("油料合计-list-false");
        list.add("折合菜籽油-list thick-true");
        list.add("实际菜籽油-list_1-false");
        list.add("实际油菜籽-list_1-false");
        list.add("实际大豆油-list-false");

        for (ReportNameEnum e : ReportNameEnum.values()) {
            reportNameList.add(e.getValue());
        }

    }

    /**
     * 提交审核
     *
     * @param reportId
     * @return
     */
    @SysLogAn("报表台账-报表管理-填报-提交审核")
    @RequestMapping("/submitReport")
    @ResponseBody
    public ActionResultModel submitReport(String reportId, String reportMonth, String reportName) {
        ActionResultModel actionResultModel = new ActionResultModel();
        service.updateStatus(reportId, ReportStatusEnum.DSH.getValue(), reportMonth, reportName);
        actionResultModel.setSuccess(true);
        return actionResultModel;
    }

    /**
     * 审核通过
     *
     * @param reportId
     * @return
     */
    @SysLogAn("报表台账-报表管理-审核-通过")
    @RequestMapping("/appPass")
    @ResponseBody
    public ActionResultModel appPass(String reportId) {
        ActionResultModel actionResultModel = new ActionResultModel();
        service.updateStatus(reportId, ReportStatusEnum.SHTG.getValue(), null, null);
        actionResultModel.setSuccess(true);
        return actionResultModel;
    }

    /**
     * 驳回
     *
     * @param reportId
     * @return
     */
    @SysLogAn("报表台账-报表管理-填报-驳回")
    @RequestMapping("/appBack")
    @ResponseBody
    public ActionResultModel appBack(String reportId) {
        ActionResultModel actionResultModel = new ActionResultModel();
        service.updateStatus(reportId, ReportStatusEnum.BH.getValue(), null, null);
        actionResultModel.setSuccess(true);
        return actionResultModel;
    }

    /**
     * 上报公司
     *
     * @param reportId
     * @return
     */
    @SysLogAn("报表台账-报表管理-填报-上报")
    @RequestMapping("/sendReport")
    @ResponseBody
    public ActionResultModel sendReport(String reportId) {
        ActionResultModel actionResultModel = new ActionResultModel();
        service.updateStatus(reportId, ReportStatusEnum.SBDS.getValue(), null, null);
        actionResultModel.setSuccess(true);
        return actionResultModel;
    }

    /**
     * 月报填报
     *
     * @param
     * @return
     */
    @SysLogAn("访问：报表台账-报表管理-填报")
    @RequestMapping("fillMain")
    public String fillMain(Model model, HttpServletResponse response) throws IOException {
        String reportWarehouse = TokenManager.getToken().getShortName();
        List<String> warehouses = storageWarehouseService.getWarehouseShortByTypeWithCBK();//Constant.WAREHOUSE.split("、");
        for (String warehouse : warehouses) {
            if (warehouse.equals(reportWarehouse)) {
                model.addAttribute("reportWarehouse", reportWarehouse);
                return "report/monthReport/fill_main";
            }
        }
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("<script>alert('对不起，您没有该权限！');</script>");
        return null;
    }

    /**
     * 月报审核
     *
     * @param
     * @return
     */
    @SysLogAn("访问：报表台账-报表管理-审核")
    @RequestMapping("appMain")
    public String appMain(Model model) {
        model.addAttribute("reportNameList", reportNameList);
        model.addAttribute("reportWarehouse", TokenManager.getToken().getShortName());
        return "report/monthReport/app_main";
    }

    /**
     * 本库查询(已审核)
     *
     * @param
     * @return
     */
    @SysLogAn("访问：报表台账-报表管理-查询")
    @RequestMapping("queryMain")
    public String queryMain(Model model) {
        model.addAttribute("reportNameList", reportNameList);
        model.addAttribute("reportWarehouse", TokenManager.getToken().getShortName());
        model.addAttribute("companyUser", TokenManager.getToken().getOriginCode().equals("CBL"));
        model.addAttribute("variety", sysDictService.getSysDictListByType("粮油品种"));
        return "report/monthReport/query_main";
    }

    /**
     * 分库查询(已审核)
     *
     * @param
     * @return
     */
    @SysLogAn("访问：报表台账-报表管理-分库查询")
    @RequestMapping("queryKuMain")
    public String queryKuMain(Model model) {

        List<String> baseWarehouses = storageWarehouseService.getWarehouseShortByTypeWithCBK();
        model.addAttribute("dictType", sysDictService.getSysDictListByType("粮油品种"));
        model.addAttribute("reportNameList", reportNameList);
        model.addAttribute("basepoint", baseWarehouses);
        model.addAttribute("judge", 2);//标记进去的是分库查询
        return "report/monthReport/query_ku_main";
    }

    /**
     * 分库审核(已审核)
     *
     * @param
     * @return
     */
    @SysLogAn("访问：报表台账-报表管理-分库审核")
    @RequestMapping("appKuMain")
    public String appKuKuMain(Model model) {
        model.addAttribute("reportNameList", reportNameList);
        model.addAttribute("judge", 1);//标记是进去的分库审核
        return "report/monthReport/app_ku_main";
    }

    @RequestMapping("/fillTableQuery")
    public String fillTableQuery(Model model) {
        model.addAttribute("reportNameList", reportNameList);
        return "report/monthReport/fill_table_query";
    }

    @RequestMapping(value = "/fillTableQuerylist", method = {RequestMethod.POST})
    @ResponseBody
    public LayPage<ReportMonth> fillTableQueryList(ReportMonth reportMonth,
                                                   @RequestParam("pageIndex") int pageIndex, @RequestParam("pageSize") int pageSize) {

        LayPage<ReportMonth> model = new LayPage();

        Map<String, Object> param = new HashMap();
        param.put("pageIndex", pageIndex);
        param.put("pageSize", pageSize);
        param.put("entity", reportMonth);
        param.put("isHost", "Y");

        //查询月报状态
        ReportMonth reportParam = new ReportMonth();
        reportParam.setReportWarehouse(Constant.HOME_WAREHOUSE);
        reportParam.setReportWarehouseId("0");
        reportParam.setReportName(reportMonth.getReportName());
        reportParam.setReportMonth(reportMonth.getReportMonth());
        ReportMonth reportMain = service.getReport(reportParam);
        String reportMonthStatus = reportMain == null ? "" : reportMain.getReportStatus();//月报状态

        int count = service.fillTableQueryCount(param);

        if (count > 0) {

            List<ReportMonth> data = service.fillTableQuery(param);

            for (ReportMonth item : data) {
                if (!"未做".equals(item.getReportStatus())) {
                    item.setReportMonthStatus(reportMonthStatus);
                }
            }

            model.setCount(count);
            model.setData(data);
        } else {
            model.setMsg("无数据");
            model.setCount(0);
        }

        return model;
    }

    /**
     * 上报通过
     *
     * @param reportId
     * @return
     */
    @RequestMapping("/sendPass")
    @ResponseBody
    @SysLogAn("报表台账-报表管理-分库审核-通过")
    public ActionResultModel sendPass(String reportId) {
        ActionResultModel actionResultModel = new ActionResultModel();
        service.updateStatus(reportId, ReportStatusEnum.SBTG.getValue(), null, null);
        service.reportSwtz(reportId);
        actionResultModel.setSuccess(true);
        return actionResultModel;
    }


    //    批量审批-通过
    @RequestMapping(value = "/sendPassMultiple")
    @ResponseBody
    public ActionResultModel sendPassMultiple(String[] ids) {
        ActionResultModel actionResultModel = new ActionResultModel();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("ids", ids);

        try {
            service.changeStatus(map);//改变报表状态
            actionResultModel.setSuccess(true);
        } catch (Exception e) {
            actionResultModel.setSuccess(false);
        }


        return actionResultModel;
    }


    /**
     * 上报驳回
     *
     * @param reportId
     * @return
     */
    @SysLogAn("报表台账-报表管理-分库审核-驳回")
    @RequestMapping("/sendBack")
    @ResponseBody
    public ActionResultModel sendBack(String reportId) {
        ActionResultModel actionResultModel = new ActionResultModel();
        service.updateStatus(reportId, ReportStatusEnum.SBBH.getValue(), null, null);
        actionResultModel.setSuccess(true);
        return actionResultModel;
    }

    /**
     * 汇总检查
     *
     * @param report
     * @return
     */
    @RequestMapping("/checkSummary")
    @ResponseBody
    public ActionResultModel checkSummary(ReportMonth report) {
        ActionResultModel actionResultModel = service.checkSummary(report);
        return actionResultModel;
    }

    /**
     * 汇总
     *
     * @param report
     * @return
     */
    @SysLogAn("报表台账-报表管理-分库审核-汇总")
    @RequestMapping("/summary")
    @ResponseBody
    public ActionResultModel summary(ReportMonth report, String sumManager) {
        ActionResultModel actionResultModel = service.summary(report, sumManager);
        return actionResultModel;
    }

    /**
     * 汇总查询(已审核)
     *
     * @param
     * @return
     */
    @SysLogAn("访问：报表台账-报表管理-汇总查询")
    @RequestMapping("querySumMain")
    public String querySumMain(Model model) {
        model.addAttribute("reportNameList", reportNameList);
        model.addAttribute("reportWarehouse", TokenManager.getToken().getShortName());
        return "report/monthReport/query_sum_main";
    }

    /**
     * 汇总审核
     *
     * @param
     * @return
     */
    @SysLogAn("访问：报表台账-报表管理-汇总审核")
    @RequestMapping("appSumMain")
    public String appSumMain(Model model) {
        model.addAttribute("reportNameList", reportNameList);
        model.addAttribute("reportWarehouse", TokenManager.getToken().getShortName());
        return "report/monthReport/app_sum_main";
    }

    /**
     * 汇总通过
     *
     * @param reportId
     * @return
     */
    @SysLogAn("报表台账-报表管理-汇总审核-通过")
    @RequestMapping("/appSumPass")
    @ResponseBody
    public ActionResultModel appSumPass(String reportId) {
        ActionResultModel actionResultModel = new ActionResultModel();
        service.updateStatus(reportId, ReportStatusEnum.HZTG.getValue(), null, null);
        actionResultModel.setSuccess(true);
        return actionResultModel;
    }

    /**
     * 汇总驳回
     *
     * @param reportMonth
     * @param reportName
     * @return
     */
    @SysLogAn("报表台账-报表管理-汇总审核-驳回")
    @RequestMapping("/appSumBack")
    @ResponseBody
    public ActionResultModel appSumBack(String reportMonth, String reportName) {
        ActionResultModel actionResultModel = new ActionResultModel();
        service.appSumBack(reportMonth, reportName);
        actionResultModel.setSuccess(true);
        return actionResultModel;
    }

    /**
     * 月报填报
     *
     * @param
     * @return
     */
    @RequestMapping("proxyFillMain")
    public String proxyFillMain(Model model, String type, HttpServletResponse response) throws IOException {
        String reportWarehouse = TokenManager.getToken().getShortName();
        List<String> baseWarehouses = storageWarehouseService.getWarehouseShortByTypeWithCBK();
        for (String warehouse : baseWarehouses) {
            if (warehouse.equals(reportWarehouse)) {
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("<script>alert('对不起，此功能只对代储库开放');</script>");
                return null;
            }
        }

        if (StringUtils.isEmpty(reportWarehouse)) {
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("<script>alert('对不起，您没有该权限！');</script>");
            return null;
        }

        String reportName = "";
        String title = "";
        if ("swtz".equals(type)) {
            reportName = ReportNameEnum.SWTZ.getValue();
            title = "库存实物台账";
        } else if ("cbly".equals(type)) {
            reportName = ReportNameEnum.CBLY.getValue();
            title = "省级储备粮油收支平衡月报表";
        } else if ("sply".equals(type)) {
            reportName = ReportNameEnum.SPLY.getValue();
            title = "企业商品粮油收支平衡月报表";
        } else if ("xwsw".equals(type)) {
            reportName = ReportNameEnum.XWSW.getValue();
            title = "粮食和食用油脂油料销往外省月报表";
        } else if ("swgj".equals(type)) {
            reportName = ReportNameEnum.SWGJ.getValue();
            title = "粮食和食用油脂油料外省购进月报表";
        }
        sysLogService.add(request, "访问：代储监管-报表台账-" + title);
        model.addAttribute("reportName", reportName);
        model.addAttribute("title", title);
        model.addAttribute("reportWarehouse", TokenManager.getToken().getCompany());
        return "report/monthReport/proxy_fill_main";
    }

    /**
     * OA汇总送审
     *
     * @param report
     * @return
     */
    @SysLogAn("报表台账-报表管理-汇总审核-OA汇总送审")
    @RequestMapping("/sumOA")
    @ResponseBody
    public ActionResultModel sumOA(ReportMonth report) {
        ActionResultModel actionResultModel = new ActionResultModel();
        service.sumOA(report);
        actionResultModel.setSuccess(true);
        return actionResultModel;
    }

    /**
     * @param model
     * @param response
     * @return
     */
    @RequestMapping("/proxyFillMainList")
    public String proxyFillMain(Model model, HttpServletResponse response) {

        return "report/monthReport/proxy_fill_main_list";
    }

    @RequestMapping(value = "/enterpriseList")
    @ResponseBody
    public LayPage<StoreEnterprise> list(HttpServletRequest request) {
        LayPage<StoreEnterprise> list = storeEnterpriseService.listOrderByName(request);
        return list;
    }

    @RequestMapping(value = "/reportMonthlist")
    @ResponseBody
    public LayPage<ReportMonth> reportMonthlist(ReportMonth reportMonth,
                                                @RequestParam("page") int pageIndex, @RequestParam("limit") int pageSize, HttpServletRequest request) {
        /*LayPage<StoreEnterprise> list=storeEnterpriseService.list(request);
		StoreEnterprise storeEnterprise=list.getData().get(0);*/
        LayPage<ReportMonth> model = new LayPage();

        List<ReportMonth> data = null;
        String reportmonth = reportMonth.getReportMonth();

        if (StringUtil.isBlank(reportmonth)) {
            Calendar c = Calendar.getInstance();//可以用set()对每个时间域单独修改
            int year = c.get(Calendar.YEAR);
            int month = c.get(Calendar.MONTH);
            reportmonth = year + ((month < 10) ? "-0" : "-") + month;
            reportMonth.setReportMonth(year + ((month < 10) ? "-0" : "-") + month);
        }
        Map<String, Object> param = new HashMap();
        param.put("pageIndex", pageIndex);
        param.put("pageSize", pageSize);
        param.put("entity", reportMonth);
        //所有代储点月报名字
        List<String> allReportNameList = new ArrayList<String>();
        allReportNameList.add("储备粮油收支月报表");
        allReportNameList.add("商品粮油收支月报表");
        allReportNameList.add("粮油库存实物台账月报表");
        allReportNameList.add("销往省外");
        allReportNameList.add("省外购进");
        allReportNameList.add("库存包装物出入库明细表");
        allReportNameList.add("包装物库存月报表");
        int c = 0;
        c = service.queryReportMonthCount(param);

        data = service.queryReportMonth(param);

        List<String> reportNameList = new ArrayList<String>();
        for (ReportMonth item : data) {
            if (item.getReportStatus() == null) {
                item.setReportStatus("未做");
            }
            reportNameList.add(item.getReportName());
        }
        for (String name : allReportNameList) {
            if (reportNameList.contains(name)) {

            } else {
                ReportMonth nullReportMonth = new ReportMonth();
                nullReportMonth.setReportMonth(reportmonth);
                nullReportMonth.setReportName(name);
                nullReportMonth.setReportStatus("未做");
                data.add(nullReportMonth);
                c++;
            }
        }
        //Collections.sort(jobCandidateList, JobCandidate.ageComparator);
        //按照报表名字排序
        Collections.sort(data, new Comparator<ReportMonth>() {
            public int compare(ReportMonth o1, ReportMonth o2) {
                //String hits0 = o1.getReportName();
                //String hits1 = o2.getReportName();
                Comparator<Object> com = Collator.getInstance(java.util.Locale.CHINA);
                return com.compare(o1.getReportName(), o2.getReportName());
            }

            ;
        });
        model.setCount(c);
        model.setData(data);

        return model;
    }

    /**
     * 代储点月报填报
     *
     * @param model
     * @param response
     * @return
     * @throws IOException
     */
    @RequestMapping("addReportMonthList")
    public String addReportMonthList(Model model, HttpServletResponse response, String enterpriseName, String reportMonth, String reportName) throws IOException {
        StorageWarehouse storageWarehouse = storageWarehouseService.get(enterpriseName);
        if (storageWarehouse != null) {
            String reportWarehouse = storageWarehouse.getWarehouseShort();
            String enterpriseName1 = storageWarehouse.getEnterpriseName();
            model.addAttribute("reportWarehouseId", enterpriseName);
            model.addAttribute("reportWarehouse", reportWarehouse);
            model.addAttribute("enterpriseName", enterpriseName1);
            model.addAttribute("reportMonth", reportMonth);
            model.addAttribute("reportName", reportName);
            return "report/monthReport/proxy_fill_main_add";
        }
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("<script>alert('对不起，无此库');</script>");
        return null;
    }

    /**
     * 代储-维护报表
     *
     * @param model
     * @param response
     * @param warehouseId
     * @param reportMonth
     * @param reportName
     * @return
     * @throws IOException
     */
    @RequestMapping("maintainReportMonth")
    public String maintainReportMonth(Model model, HttpServletResponse response, String warehouseId, String reportMonth, String reportName) {
        StorageWarehouse storageWarehouse = storageWarehouseService.get(warehouseId);
        if (storageWarehouse != null) {
            String reportWarehouse = storageWarehouse.getWarehouseShort();
            //根据公司id查询公司信息
            StoreEnterprise storeEnterprise = storeEnterpriseService.getStoreEnterpriseByID(storageWarehouse.getEnterpriseId());
            model.addAttribute("storeEnterprise", storeEnterprise);
            String enterpriseName = storageWarehouse.getEnterpriseName();
            model.addAttribute("reportWarehouseId", warehouseId);
            model.addAttribute("reportWarehouse", reportWarehouse);
            model.addAttribute("enterpriseName", enterpriseName);
            model.addAttribute("reportMonth", reportMonth);
            model.addAttribute("reportName", reportName);
            return "report/monthReport/proxy_fill_main_add";
        }

        try {
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("<script>alert('对不起，无此库');</script>");
        } catch (IOException e) {
        }

        return null;
    }

    /**
     * 分页查询填报库点
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/kudianPageQuery")
    @ResponseBody
    public LayPage<StorageWarehouse> kudianPageQuery(HttpServletRequest request) {

        LayPage<StorageWarehouse> list = service.kudianPageQuery(request);
        return list;
    }
}
