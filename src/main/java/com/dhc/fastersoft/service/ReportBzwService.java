package com.dhc.fastersoft.service;

import com.dhc.fastersoft.entity.report.ReportBzw;
import com.dhc.fastersoft.entity.report.ReportMonth;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface ReportBzwService {
    List<ReportBzw> listBzwByMonthHouse(String month, String reportWarehouse);

    String addBzw(String reportId, String reportMonth, List<ReportBzw> bzwList, String manager);

    String addProxyBzw(String reportWarehouseId, String reportWarehouse,String reportId, String reportMonth, List<ReportBzw> bzwList, String manager);
    List<ReportBzw> listBzwByReportId(String reportId);

    /**
     * 获取包装物汇总列表
     * @param report
     * @return
     */
    List listSumBzw(ReportMonth report);
    List listSumBzw1(ReportMonth report,ModelMap modelMap);
    List listSumBzw2(ReportMonth report,HttpServletRequest request);
    ReportBzw[] listSumBzwByReportId(String reportId);
}
