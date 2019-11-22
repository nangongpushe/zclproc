package com.dhc.fastersoft.dao.report;

import com.dhc.fastersoft.entity.report.ReportBzw;
import com.dhc.fastersoft.entity.report.ReportMonth;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component
public interface ReportBzwDao {

    void deleteByMonthHouse(Map map);

    void add(ReportBzw reportBzw);

    List<ReportBzw> listBzwByMonthHouse(Map map);

    List<ReportBzw> listBzwByReportId(String reportId);

    int deleteByReportId(String reportId);

    int summary(ReportMonth report);

    /**
     * 获取回总列表
     * @param map (reportIds,packageProperty)
     * @return
     */
    List<ReportBzw> listSumBzw(Map map);

    /**
     * 汇总报表信息(group by 包装物用途)
     * @param reportId
     * @return
     */
    List<ReportBzw> listSumBzwByReportId(String reportId);

    List<ReportBzw> listSumBzw1(Map map);
}