package com.dhc.fastersoft.service;

import com.dhc.fastersoft.entity.report.ReportCbly;
import com.dhc.fastersoft.entity.report.ReportMonth;
import org.springframework.stereotype.Component;

import java.util.List;


@Component
public interface ReportCblyService {
    List<ReportCbly> listCblyByMonthHouse(String month, String reportWarehouse);

    List<ReportCbly> listCblyByReportId(String reportId);

    /**
     * 保存储备粮油收支月报表
     * @param cblylist
     * @return
     */
    String addCbly(String reportId, String reportMonth, List<ReportCbly> cblylist, String manager);

    List<ReportCbly> listSumCbly(String reportMonth);

    String addProxyCbly(String reportWarehouseId,String reportWarehouse, String reportId, String reportMonth, List<ReportCbly> cblylist, String manager);
}

