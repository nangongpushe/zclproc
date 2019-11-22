package com.dhc.fastersoft.dao.yearReport;

import com.dhc.fastersoft.entity.yearReport.ReportYearPEOPLE;

public interface ReportYearPEOPLEDao {
    int deleteByPrimaryKey(String reportId);

    int insert(ReportYearPEOPLE record);

    int insertSelective(ReportYearPEOPLE record);

    ReportYearPEOPLE selectByPrimaryKey(String reportId);

    int updateByPrimaryKeySelective(ReportYearPEOPLE record);

    int updateByPrimaryKey(ReportYearPEOPLE record);
}