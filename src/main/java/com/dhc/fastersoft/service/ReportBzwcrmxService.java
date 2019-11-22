package com.dhc.fastersoft.service;

import com.dhc.fastersoft.entity.report.ReportBzwcrmx;
import com.dhc.fastersoft.entity.report.ReportSwtz;

import java.util.List;

public interface ReportBzwcrmxService {

    String addBzwcrmx(String reportId, String reportMonth, List<ReportBzwcrmx> bzwcrmxlist, String manager, String reserveProperty, String comments);
    List<ReportBzwcrmx> listBzwcrmxByReportId(String reportId);
    String addProxyBzwcrmx(String reportWarehouseId, String reportWarehouse,String reportId, String reportMonth, List<ReportBzwcrmx> bzwcrmxlist, String manager, String comments);
    List<ReportBzwcrmx> listSumBzwcrmx(String reportId);
}
