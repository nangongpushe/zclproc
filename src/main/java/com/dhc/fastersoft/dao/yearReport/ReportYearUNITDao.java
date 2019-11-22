package com.dhc.fastersoft.dao.yearReport;

import com.dhc.fastersoft.entity.yearReport.ReportYearUNIT;

public interface ReportYearUNITDao {
    int deleteByPrimaryKey(String reportId);

    int insert(ReportYearUNIT record);

    int insertSelective(ReportYearUNIT record);

    ReportYearUNIT selectByPrimaryKey(String reportId);

    int updateByPrimaryKeySelective(ReportYearUNIT record);

    int updateByPrimaryKey(ReportYearUNIT record);
}