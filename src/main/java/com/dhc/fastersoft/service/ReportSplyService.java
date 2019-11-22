package com.dhc.fastersoft.service;


import com.dhc.fastersoft.entity.report.ReportSply;

import java.util.List;

public interface ReportSplyService {
    List<ReportSply> listSplyByMonthHouse(String month, String reportWarehouse);

    List<ReportSply> listSplyByReportId(String reportId);

    String addSply(String reportid, String reportMonth, List<ReportSply> splyList, String manager);

    List<ReportSply> listSumSply(String reportMonth);

    String addProxySply(String reportWarehouseId,String reportWarehouse, String reportid, String reportMonth, List<ReportSply> splyList, String manager);
}
