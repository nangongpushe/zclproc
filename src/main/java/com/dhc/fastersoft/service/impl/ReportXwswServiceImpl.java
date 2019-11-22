package com.dhc.fastersoft.service.impl;

import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.report.ReportMonthDao;
import com.dhc.fastersoft.dao.report.ReportXwswDao;
import com.dhc.fastersoft.entity.enumdata.ReportStatusEnum;
import com.dhc.fastersoft.entity.report.ReportMonth;
import com.dhc.fastersoft.entity.report.ReportXwsw;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.ReportXwswService;
import com.dhc.fastersoft.vo.ReportXwswResultVO;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

@Service("reportXwswService")
public class ReportXwswServiceImpl implements ReportXwswService {

	@Autowired
	public ReportXwswDao dao;
	@Autowired
	public ReportMonthDao monthDao;

	@Override
	public List<ReportXwsw> listXwswByMonthHouse(String month, String reportWarehouseId, String reportName) {
		Map map = new HashMap();
		map.put("reportMonth", month);
		map.put("reportWarehouseId", reportWarehouseId);
		map.put("reportName", reportName);
		return dao.listXwswByMonthHouse(map);
	}

	@Override
	public String addXwsw(String reportId, String reportMonth, String reportName, List<ReportXwsw> xwswList, String manager) {
		SysUser user = TokenManager.getToken();
		String reportWarehouse = user.getShortName();
		if (StringUtils.isEmpty(reportId)){
			ReportMonth reportMain = new ReportMonth();
			reportId = UUID.randomUUID().toString().replace("-","");
			reportMain.setReportMonth(reportMonth);
			reportMain.setId(reportId);
			reportMain.setReportWarehouse(reportWarehouse);
			reportMain.setReportWarehouseId(user.getWareHouseId());
			reportMain.setReportStatus(ReportStatusEnum.CG.getValue());
			reportMain.setReportName(reportName);
			reportMain.setCreator(user.getAccount());
			reportMain.setManager(manager);
			monthDao.add(reportMain);
		} else {
			//先清空当月当库数据
			dao.deleteByReportId(reportId);
			//更新状态
			ReportMonth reportMain = new ReportMonth();
			reportMain.setId(reportId);
			reportMain.setReportStatus(ReportStatusEnum.CG.getValue());
			reportMain.setManager(manager);
			reportMain.setCreator(user.getAccount());
			monthDao.update(reportMain);
		}

		ReportXwsw reportXwsw = null;
		for (int i = 0; i < xwswList.size(); i++) {
			reportXwsw = xwswList.get(i);
			reportXwsw.setReportId(reportId);
			reportXwsw.setReportMonth(reportMonth);
			reportXwsw.setReportWarehouse(reportWarehouse);
			reportXwsw.setReportName(reportName);
			dao.add(reportXwsw);
		}

		return reportId;
	}

	@Override
	public List<ReportXwsw> listXwswByReportId(String reportId) {
		return dao.listXwswByReportId(reportId);
	}

	@Override
	public List<ReportXwswResultVO> getDataByProvince(HttpServletRequest request) {
		HashMap<String,String> map = new HashMap<String, String>();
		map.put("startTime", request.getParameter("startTime"));
		map.put("endTime", request.getParameter("endTime"));
		return dao.getDataByProvince(map);
	}

	@Override
	public List<ReportXwsw> listSumXwsw(String gatherId) {
		return dao.listSumXwsw(gatherId);
	}

	@Override
	public List<ReportXwsw> getDataByTime(HttpServletRequest request) {
		HashMap<String,String> map = new HashMap<String, String>();
		map.put("startTime", request.getParameter("startTime"));
		map.put("endTime", request.getParameter("endTime"));
		String type = request.getParameter("time");
		if("year".equals(type)){
			// 日期格式拼接
			map.put("startTime",map.get("startTime")+"-01");
			map.put("endTime",map.get("endTime")+"-12");
			return dao.getDataByYear(map);
		}else {
			return dao.getDataByMonth(map);
		}

	}

	@Override
	public String addProxyXwsw(String reportWarehouseId,String reportWarehouse,String reportId, String reportMonth, String reportName, List<ReportXwsw> xwswList, String manager) {
		SysUser user = TokenManager.getToken();
		//String reportWarehouse = user.getShortName();
		if (StringUtils.isEmpty(reportId)){
			ReportMonth reportMain = new ReportMonth();
			reportId = UUID.randomUUID().toString().replace("-","");
			reportMain.setReportMonth(reportMonth);
			reportMain.setId(reportId);
			reportMain.setReportWarehouse(reportWarehouse);
			reportMain.setReportWarehouseId(reportWarehouseId);
			reportMain.setReportStatus(ReportStatusEnum.CG.getValue());
			reportMain.setReportName(reportName);
			reportMain.setCreator(user.getAccount());
			reportMain.setManager(manager);
			monthDao.add(reportMain);
		} else {
			//先清空当月当库数据
			dao.deleteByReportId(reportId);
			//更新状态
			ReportMonth reportMain = new ReportMonth();
			reportMain.setId(reportId);
			reportMain.setReportStatus(ReportStatusEnum.CG.getValue());
			reportMain.setManager(manager);
			reportMain.setCreator(user.getAccount());
			monthDao.update(reportMain);
		}

		ReportXwsw reportXwsw = null;
		for (int i = 0; i < xwswList.size(); i++) {
			reportXwsw = xwswList.get(i);
			reportXwsw.setReportId(reportId);
			reportXwsw.setReportMonth(reportMonth);
			reportXwsw.setReportWarehouse(reportWarehouse);
			reportXwsw.setReportName(reportName);
			dao.add(reportXwsw);
		}

		return reportId;
	}
}
