package com.dhc.fastersoft.service;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.entity.echarts.EchartsData;
import com.dhc.fastersoft.entity.report.ReportSwtz;
import com.dhc.fastersoft.entity.store.StoreEnterprise;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.vo.KCTJChartsVO;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ReportSwtzService {
    List<ReportSwtz> listSwtz(HttpServletRequest request, String reportWarehouse);

    List<ReportSwtz> listSwtzByReportId(String reportId);

    String addSwtz(String reportId, String reportMonth, List<ReportSwtz> swtzList, String manager, String reserveProperty);

    String addProxySwtz(String reportWarehouseId,String reportWarehouse,String reportId, String reportMonth, List<ReportSwtz> swtzList, String manager, String reserveProperty);
    LayPage<ReportSwtz> pageList(HttpServletRequest request);

    LayPage<ReportSwtz> pageList1(HttpServletRequest request,String plandetailid);

    Map<String,Object> getKCTJCharts(HttpServletRequest request);

    List<KCTJChartsVO> getKCTJChartsY(HttpServletRequest request);

    List<ReportSwtz> listSumSwtzByReportId(String id);
    
    ReportSwtz getReportSwtzByOther(String reportMonth,String reportWarehouse,String storehouse,String variety,String origin,String harvestYear);

    ReportSwtz getReportSwtzById(String reportId);
    
    ActionResultModel getCurrMonthQuantity(HttpServletRequest request);

    ActionResultModel getLastMonthQuantity(HttpServletRequest request);

    List<ReportSwtz> listSumSwtz(String reportMonth);
    
    List<ReportSwtz> listSwtzForWebApi(HashMap<String, Object> map);
    
    List<KCTJChartsVO> listKCTJCharts(HashMap<String, String> map);


    String listMaxKCTJMonth(HashMap<String, String> map);


    Double getLastestQuantity(HashMap<String, Object> map);

    EchartsData queryKCQSCharts(HttpServletRequest request);

    Map<String,Object> getKCTJPie(HttpServletRequest request);

    List<StoreEnterprise> getAllStoreEnterprise();

    StoreEnterprise getStoreEnterpriseById(String enterpriseId);

    Map<String,Object> getStoreAndOilMap();
}
