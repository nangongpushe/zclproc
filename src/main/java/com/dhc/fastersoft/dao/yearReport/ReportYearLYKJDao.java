package com.dhc.fastersoft.dao.yearReport;

import com.dhc.fastersoft.entity.yearReport.ReportYearLYKJ;

public interface ReportYearLYKJDao {
    int deleteByPrimaryKey(String reportId);

    int insert(ReportYearLYKJ record);

    int insertSelective(ReportYearLYKJ record);

    ReportYearLYKJ selectByPrimaryKey(String reportId);

    int updateByPrimaryKeySelective(ReportYearLYKJ record);

    int updateByPrimaryKey(ReportYearLYKJ record);
}