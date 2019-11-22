package com.dhc.fastersoft.service;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.report.ReportMonth;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.utils.LayPage;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;


@Component
public interface ReportMonthService {

    int updateStatus(String id, String status, String reportMonth, String reportName);

    int updateStatus( String status, String reportMonth, String reportName);

    ReportMonth getReportMonthById(String reportId);

    ReportMonth getReport(ReportMonth reportMonth);

    ActionResultModel checkSummary(ReportMonth report);

    ActionResultModel summary(ReportMonth report, String sumManager);

    int appSumBack(String reportMonth, String reportName);

    int sumOA(ReportMonth report);

    SysUser getUserInfoByAccount(String account);
    
    List<ReportMonth> fillTableQuery(Map<String,Object> param);
    List<ReportMonth> queryReportMonth(Map<String,Object> param);

    int fillTableQueryCount(Map<String,Object> param);

    int queryReportMonthCount(Map<String,Object> param);

    LayPage<StorageWarehouse> kudianPageQuery(HttpServletRequest request);

    void reportSwtz(String reportId);

    int changeStatus(Map<String,Object> ids);
}

