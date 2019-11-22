package com.dhc.fastersoft.service;

import com.dhc.fastersoft.entity.report.ReportXwsw;
import com.dhc.fastersoft.vo.ReportXwswResultVO;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface ReportXwswService {
    List<ReportXwsw> listXwswByMonthHouse(String month, String reportWarehouse, String reportName);

    String addXwsw(String reportId, String reportMonth, String reportName, List<ReportXwsw> xwswList, String manager);

    List<ReportXwsw> listXwswByReportId(String reportId);

	List<ReportXwswResultVO> getDataByProvince(HttpServletRequest request);

	List<ReportXwsw> getDataByTime(HttpServletRequest request);


    List<ReportXwsw> listSumXwsw(String gatherId);

    String addProxyXwsw(String reportWarehouseId,String reportWarehouse,String reportId, String reportMonth, String reportName, List<ReportXwsw> xwswList, String manager);
}
