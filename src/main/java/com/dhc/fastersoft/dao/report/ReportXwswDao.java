package com.dhc.fastersoft.dao.report;

import com.dhc.fastersoft.entity.report.ReportMonth;
import com.dhc.fastersoft.entity.report.ReportXwsw;
import com.dhc.fastersoft.vo.ReportXwswResultVO;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public interface ReportXwswDao {
    int add(ReportXwsw record);

    List<ReportXwsw> listXwswByMonthHouse(Map map);

    void deleteByMonthHouse(Map map);

    List<ReportXwsw> listXwswByReportId(String reportId);

    int deleteByReportId(String reportId);

    int summary(ReportMonth report);

	List<ReportXwswResultVO> getDataByProvince(HashMap<String, String> map);

	List<ReportXwsw> getDataByYear(HashMap<String, String> map);

	List<ReportXwsw> getDataByMonth(HashMap<String, String> map);

    List<ReportXwsw> listSumXwsw(String gatherId);
}