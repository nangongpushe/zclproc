package com.dhc.fastersoft.service.yearReport.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dhc.fastersoft.dao.yearReport.ReportYearDao;
import com.dhc.fastersoft.dao.yearReport.ReportYearGMKCDao;
import com.dhc.fastersoft.entity.yearReport.ReportYear;
import com.dhc.fastersoft.entity.yearReport.ReportYearGMKC;
import com.dhc.fastersoft.entity.yearReport.ReportYearLYKJ;
import com.dhc.fastersoft.service.yearReport.YearReportService;
import com.dhc.fastersoft.utils.StringUtils;

@Service("yearReportService")
public class YearReportServiceImpl implements YearReportService{
	
	@Resource
	private ReportYearGMKCDao reportYearGMKCDao;
	
	@Resource
	private ReportYearDao reportYearDao;

	@Override
	public int addReportGMKC(ReportYearGMKC reportYearGMKC) {
		return reportYearGMKCDao.insert(reportYearGMKC);		
	}

	@Override
	public List<ReportYearGMKC> getYearGMKCByYear(String year) {
		// TODO Auto-generated method stub
		return reportYearGMKCDao.selectByYear(year);
	}

	@Override
	public List<ReportYearLYKJ> getYearLYKJByYear() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void addReportYear(ReportYear reportYear) {
		reportYearDao.insert(reportYear);
	}

	@Override
	public ReportYear selectByProperty(ReportYear reportYear) {
		return reportYearDao.selectByProperty(reportYear);
	}

	@Override
	public void delete(ReportYear newReportYear) {
		// TODO Auto-generated method stub
		reportYearDao.deleteByPrimaryKey(newReportYear.getId());
	}

}
