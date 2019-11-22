package com.dhc.fastersoft.dao.yearReport;

import com.dhc.fastersoft.entity.yearReport.ReportYear;

public interface ReportYearDao {
    int deleteByPrimaryKey(String id);

    int insert(ReportYear record);

    int insertSelective(ReportYear record);

    ReportYear selectByPrimaryKey(String id);
    
    ReportYear selectByProperty(ReportYear record);

    int updateByPrimaryKeySelective(ReportYear record);

    int updateByPrimaryKey(ReportYear record);
}