package com.dhc.fastersoft.service.impl;

import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.report.ReportCblyDao;
import com.dhc.fastersoft.dao.report.ReportMonthDao;
import com.dhc.fastersoft.entity.enumdata.ReportNameEnum;
import com.dhc.fastersoft.entity.enumdata.ReportStatusEnum;
import com.dhc.fastersoft.entity.report.ReportCbly;
import com.dhc.fastersoft.entity.report.ReportMonth;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.ReportCblyService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service("reportCblyService")
public class ReportCblyServiceImpl implements ReportCblyService {

	@Autowired
	public ReportCblyDao dao;
	@Autowired
	public ReportMonthDao monthDao;

	@Override
	public List<ReportCbly> listCblyByMonthHouse(String month, String reportWarehouseId) {
		Map map = new HashMap();
		map.put("reportMonth", month);
		map.put("reportWarehouseId", reportWarehouseId);
		return dao.listCblyByMonthHouse(map);
	}

	@Override
	public List<ReportCbly> listCblyByReportId(String reportId) {
		return dao.listCblyByReportId(reportId);
	}

	@Override
	public String addCbly(String reportId, String reportMonth, List<ReportCbly> cblyList, String manager) {
		SysUser user = TokenManager.getToken();
		String reportWarehouse = user.getShortName();
		if (StringUtils.isEmpty(reportId)){
			ReportMonth reportMain = new ReportMonth();
			reportId = UUID.randomUUID().toString().replace("-","");
			reportMain.setReportMonth(reportMonth);
			reportMain.setId(reportId);
			reportMain.setReportWarehouse(reportWarehouse);
			reportMain.setReportWarehouseId(user.getWareHouseId());
			reportMain.setReportName(ReportNameEnum.CBLY.getValue());
			reportMain.setReportStatus("草稿");
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

		ReportCbly reportCbly = null;
		for (int i = 0; i < cblyList.size(); i++) {
			reportCbly = cblyList.get(i);
			reportCbly.setReportMonth(reportMonth);
			reportCbly.setReportId(reportId);
			reportCbly.setReportWarehouse(reportWarehouse);
			reportCbly.setReportName(ReportNameEnum.CBLY.getValue());
			dao.add(reportCbly);
		}

		return reportId;
	}

	@Override
	public List<ReportCbly> listSumCbly(String gatherId) {
		return dao.listSumCbly(gatherId);
	}

	@Override
	public String addProxyCbly(String reportWarehouseId,String reportWarehouse,String reportId, String reportMonth, List<ReportCbly> cblyList, String manager) {
		SysUser user = TokenManager.getToken();
		//String reportWarehouse = user.getShortName();
		if (StringUtils.isEmpty(reportId)){
			ReportMonth reportMain = new ReportMonth();
			reportId = UUID.randomUUID().toString().replace("-","");
			reportMain.setReportMonth(reportMonth);
			reportMain.setId(reportId);
			reportMain.setReportWarehouse(reportWarehouse);
			reportMain.setReportWarehouseId(reportWarehouseId);
			reportMain.setReportName(ReportNameEnum.CBLY.getValue());
			reportMain.setReportStatus("草稿");
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

		ReportCbly reportCbly = null;
		for (int i = 0; i < cblyList.size(); i++) {
			reportCbly = cblyList.get(i);
			reportCbly.setReportMonth(reportMonth);
			reportCbly.setReportId(reportId);
			reportCbly.setReportWarehouse(reportWarehouse);
			reportCbly.setReportName(ReportNameEnum.CBLY.getValue());
			dao.add(reportCbly);
		}

		return reportId;
	}
}
