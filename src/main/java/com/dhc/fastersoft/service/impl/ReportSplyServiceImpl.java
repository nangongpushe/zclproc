package com.dhc.fastersoft.service.impl;

import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.report.ReportMonthDao;
import com.dhc.fastersoft.dao.report.ReportSplyDao;
import com.dhc.fastersoft.entity.enumdata.ReportNameEnum;
import com.dhc.fastersoft.entity.enumdata.ReportStatusEnum;
import com.dhc.fastersoft.entity.report.ReportMonth;
import com.dhc.fastersoft.entity.report.ReportSply;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.ReportSplyService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service("reportSplyService")
public class ReportSplyServiceImpl implements ReportSplyService {

	@Autowired
	public ReportSplyDao dao;
	@Autowired
	public ReportMonthDao monthDao;

	@Override
	public List<ReportSply> listSplyByMonthHouse(String month, String reportWarehouseId) {
		Map map = new HashMap();
		map.put("reportMonth", month);
		map.put("reportWarehouseId", reportWarehouseId);
		return dao.listSplyByMonthHouse(map);
	}

	@Override
	public List<ReportSply> listSplyByReportId(String reportId) {
		return dao.listSplyByReportId(reportId);
	}

	@Override
	public String addSply(String reportid, String reportMonth, List<ReportSply> splyList, String manager){
		SysUser user = TokenManager.getToken();
		String reportWarehouse = user.getShortName();
		if (StringUtils.isEmpty(reportid)){
			ReportMonth reportMain = new ReportMonth();
			reportid = UUID.randomUUID().toString().replace("-","");
			reportMain.setReportMonth(reportMonth);
			reportMain.setId(reportid);
			reportMain.setReportWarehouse(reportWarehouse);
			reportMain.setReportWarehouseId(user.getWareHouseId());
			reportMain.setReportName(ReportNameEnum.SPLY.getValue());
			reportMain.setReportStatus(ReportStatusEnum.CG.getValue());
			reportMain.setCreator(user.getAccount());
			reportMain.setManager(manager);
			monthDao.add(reportMain);
		}else{
			//先清空当月当库数据
			dao.deleteByReportId(reportid);
			//更新状态
			ReportMonth reportMain = new ReportMonth();
			reportMain.setId(reportid);
			reportMain.setReportStatus(ReportStatusEnum.CG.getValue());
			reportMain.setManager(manager);
			reportMain.setCreator(user.getAccount());
			monthDao.update(reportMain);
		}

		ReportSply reportSply = null;
		for (int i = 0; i < splyList.size(); i++) {
			reportSply = splyList.get(i);
			reportSply.setReportId(reportid);
			reportSply.setReportMonth(reportMonth);
			reportSply.setReportWarehouse(reportWarehouse);
			reportSply.setReportName(ReportNameEnum.SPLY.getValue());
			dao.add(reportSply);
		}

		return reportid;
	}

	@Override
	public List<ReportSply> listSumSply(String gatherId) {
		return dao.listSumSply(gatherId);
	}

	@Override
	public String addProxySply(String reportWarehouseId,String reportWarehouse, String reportid, String reportMonth, List<ReportSply> splyList, String manager){
		SysUser user = TokenManager.getToken();
		//String reportWarehouse = user.getShortName();
		if (StringUtils.isEmpty(reportid)){
			ReportMonth reportMain = new ReportMonth();
			reportid = UUID.randomUUID().toString().replace("-","");
			reportMain.setReportMonth(reportMonth);
			reportMain.setId(reportid);
			reportMain.setReportWarehouse(reportWarehouse);
			reportMain.setReportWarehouseId(reportWarehouseId);
			reportMain.setReportName(ReportNameEnum.SPLY.getValue());
			reportMain.setReportStatus(ReportStatusEnum.CG.getValue());
			reportMain.setCreator(user.getAccount());
			reportMain.setManager(manager);
			monthDao.add(reportMain);
		}else{
			//先清空当月当库数据
			dao.deleteByReportId(reportid);
			//更新状态
			ReportMonth reportMain = new ReportMonth();
			reportMain.setId(reportid);
			reportMain.setReportStatus(ReportStatusEnum.CG.getValue());
			reportMain.setManager(manager);
			reportMain.setCreator(user.getAccount());
			monthDao.update(reportMain);
		}

		ReportSply reportSply = null;
		for (int i = 0; i < splyList.size(); i++) {
			reportSply = splyList.get(i);
			reportSply.setReportId(reportid);
			reportSply.setReportMonth(reportMonth);
			reportSply.setReportWarehouse(reportWarehouse);
			reportSply.setReportName(ReportNameEnum.SPLY.getValue());
			dao.add(reportSply);
		}

		return reportid;
	}
}
