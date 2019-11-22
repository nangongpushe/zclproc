package com.dhc.fastersoft.service.yearReport;

import java.util.List;

import com.dhc.fastersoft.entity.yearReport.ReportYear;
import com.dhc.fastersoft.entity.yearReport.ReportYearGMKC;
import com.dhc.fastersoft.entity.yearReport.ReportYearLYKJ;

public interface YearReportService {
	
	int addReportGMKC(ReportYearGMKC reportYearGMKC);
	ReportYear selectByProperty(ReportYear reportYear);
	
	List<ReportYearGMKC> getYearGMKCByYear(String year);
	List<ReportYearLYKJ> getYearLYKJByYear();
	
	void addReportYear(ReportYear reportYear);
	void delete(ReportYear newReportYear);

}
