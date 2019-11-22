package com.dhc.fastersoft.dao.report;

import com.dhc.fastersoft.entity.report.ReportCbly;
import com.dhc.fastersoft.entity.report.ReportMonth;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component
public interface ReportCblyDao {
    int add(ReportCbly reportCbly);

    int deleteByMonthHouse(Map map);

    List<ReportCbly> listCblyByReportId(String reportId);

    List<ReportCbly> listCblyByMonthHouse(Map map);

    int summary(ReportMonth report);

    int deleteByReportId(String reportId);

    List<ReportCbly> listSumCbly(String gatherId);
}
