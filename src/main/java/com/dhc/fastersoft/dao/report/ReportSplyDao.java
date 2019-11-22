package com.dhc.fastersoft.dao.report;

import com.dhc.fastersoft.entity.report.ReportMonth;
import com.dhc.fastersoft.entity.report.ReportSply;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component
public interface ReportSplyDao {

    int add(ReportSply reportSply);

    int deleteByMonthHouse(Map map);

    List<ReportSply> listSplyByMonthHouse(Map map);

    List<ReportSply> listSplyByReportId(String reportId);

    int deleteByReportId(String reportId);

    int summary(ReportMonth report);

    List<ReportSply> listSumSply(String gatherId);
}