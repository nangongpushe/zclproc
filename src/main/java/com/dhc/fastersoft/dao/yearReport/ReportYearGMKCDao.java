package com.dhc.fastersoft.dao.yearReport;

import java.util.List;

import com.dhc.fastersoft.entity.yearReport.ReportYearGMKC;

public interface ReportYearGMKCDao {
    int deleteByPrimaryKey(String reportId);

    int insert(ReportYearGMKC record);

    int insertSelective(ReportYearGMKC record);

    ReportYearGMKC selectByPrimaryKey(String reportId);

    int updateByPrimaryKeySelective(ReportYearGMKC record);

    int updateByPrimaryKey(ReportYearGMKC record);
    
    List<ReportYearGMKC> selectByYear(String year);
}