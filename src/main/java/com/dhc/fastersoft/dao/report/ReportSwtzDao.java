package com.dhc.fastersoft.dao.report;

import com.dhc.fastersoft.entity.StorageGrainInspection;
import com.dhc.fastersoft.entity.report.ReportMonth;
import com.dhc.fastersoft.entity.report.ReportSwtz;
import com.dhc.fastersoft.vo.KCTJChartsVO;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public interface ReportSwtzDao {
    int add(ReportSwtz record);

    List<ReportSwtz> listSwtz(Map map);

    int deleteByMonthHouse(Map map);

    List<ReportSwtz> listSwtzByReportId(String reportId);

    int deleteByReportId(String reportId);

    int summary(ReportMonth report);
    

	int getRecordCount(Map<String, Object> map);
	
	List<ReportSwtz> pageQuery(Map<String, Object> map);
	
	List<KCTJChartsVO> getCharts(HashMap<String, String> map);


    String listMaxKCTJMonth(HashMap<String, String> map);


    List<ReportSwtz> listSumSwtzByReportId(String reportId);
    
    ReportSwtz getReportSwtz(HashMap<String, String> map);
    
    String getCurrMonthQuantity(HashMap<String, String> map);

    StorageGrainInspection getLastMonthQuantity(HashMap<String, String> map);

    List<ReportSwtz> listSumSwtz(String gatherId);
    
    List<ReportSwtz> listSwtzForWebApi(HashMap<String, Object> map);
    
    Double getLastestQuantity(HashMap<String, Object> map);

    List<ReportSwtz> querySumByMonth(Map<String, String> map);

    String getSumQuantity(HashMap<String, String> map);

    List<KCTJChartsVO> getSumQuantityByReportwarehouse(HashMap<String, String> map);

    String getSumQuantityByVariety(HashMap<String, String> map);

    List<KCTJChartsVO> getDistinctVariety(HashMap<String, String> map);

    List<ReportSwtz> getDistinctHarvestYear(HashMap<String, String> map);

    String getSumQuantityByHarvestYear(HashMap<String, String> map);

    KCTJChartsVO getSumQuantityPinzhi(HashMap<String, String> map);

    int getRecordCount1(HashMap<String, Object> map);

    List<ReportSwtz> pageQuery1(HashMap<String, Object> map);

    List<KCTJChartsVO> getSumQuantityByEnterpriseid(HashMap<String, String> map);

    String getSumByEnterpriseidVariety(HashMap<String, String> map);

    String getSumByYearEnterpriseid(HashMap<String, String> map);

    String geMaxQuantityByEnterpriseid(HashMap<String, String> map);

    String getMaxQuantityByReportwarehouse(HashMap<String, String> map);
}