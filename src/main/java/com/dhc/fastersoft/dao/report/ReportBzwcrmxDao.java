package com.dhc.fastersoft.dao.report;

import com.dhc.fastersoft.entity.report.ReportBzwcrmx;
import com.dhc.fastersoft.entity.report.ReportSwtz;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface ReportBzwcrmxDao {
    List<ReportBzwcrmx> listBzwcrmxByReportId(String reportId);
    int add(ReportBzwcrmx record);
    int deleteByReportId(String reportId);
    List<ReportBzwcrmx> listSumBzwcrmx(String gatherId);
}
