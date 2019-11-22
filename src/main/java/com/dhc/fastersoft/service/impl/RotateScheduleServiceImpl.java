package com.dhc.fastersoft.service.impl;



import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.mail.internet.HeaderTokenizer.Token;

import org.activiti.engine.impl.bpmn.data.Data;
import org.apache.shiro.crypto.hash.Hash;
import org.aspectj.weaver.ast.Var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.config.annotation.authentication.configurers.userdetails.DaoAuthenticationConfigurer;
import org.springframework.stereotype.Service;

import com.ctc.wstx.util.DataUtil;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.RotateConcluteDao;
import com.dhc.fastersoft.dao.RotateScheduleDao;
import com.dhc.fastersoft.dao.RotateSchemeDao;
import com.dhc.fastersoft.entity.RotateSchedule;
import com.dhc.fastersoft.entity.RotateScheduleDetail;
import com.dhc.fastersoft.entity.RotateScheme;
import com.dhc.fastersoft.entity.RotateSchemeDetail;
import com.dhc.fastersoft.service.RotateScheduleService;
import com.dhc.fastersoft.utils.DateUtil;

@Service("RotateScheduleService")
public class RotateScheduleServiceImpl implements RotateScheduleService {
	
	@Autowired
	private RotateScheduleDao scheduleDao;


	@Override
	public int save(RotateSchedule record) {
		// TODO Auto-generated method stub
		record.setId(UUID.randomUUID().toString().replaceAll("-", ""));
		record.setUnit("吨");
		List<RotateScheduleDetail> detailList=record.getDetailList();
		String modifier=TokenManager.getToken().getName();
		Date modifyTime=new Date();
		record.setReportTime(modifyTime);
		for(RotateScheduleDetail detail:detailList) {
			detail.setId(UUID.randomUUID().toString().replaceAll("-", ""));
			detail.setModifier(modifier);
			detail.setModifyTime(modifyTime);
			detail.setReportTime(modifyTime);
		}
		return scheduleDao.save(record);
	}

	@Override
	public int update(RotateSchedule record) {
		// TODO Auto-generated method stub
		String modifier=TokenManager.getToken().getName();
		Date modifyTime=new Date();
		record.setReportTime(modifyTime);
		List<RotateScheduleDetail> detailList=record.getDetailList();
		for(RotateScheduleDetail detail:detailList) {
			if(null==detail.getId()||"".equals(detail.getId()))
				detail.setId(UUID.randomUUID().toString().replaceAll("-", ""));
			detail.setModifier(modifier);
			detail.setModifyTime(modifyTime);
			detail.setReportTime(modifyTime);
		}
		return scheduleDao.update(record);
	}

	@Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return scheduleDao.remove(id);
	}

	@Override
	public RotateSchedule get(String id) {
		// TODO Auto-generated method stub
		return scheduleDao.get(id);
	}

	@Override
	public int count(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return scheduleDao.count(map);
	}

	@Override
	public List<RotateSchedule> list(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		List<RotateSchedule> rotateSchedules =scheduleDao.list(map);
		for(RotateSchedule rotateSchedule:rotateSchedules) {
			rotateSchedule.setReportTimeStr(DateUtil.DateToString(rotateSchedule.getReportTime()
					, DateUtil.LONG_DATE_FORMAT));
		}
		return rotateSchedules;
	}

	@Override
	public List<RotateScheduleDetail> listDetail(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return scheduleDao.listDetail(map);
	}

	@Override
	public double getPriorPeriod(String dealSerial) {
		// TODO Auto-generated method stub
		Double priorPeriod=scheduleDao.getPriorPeriod(dealSerial);
		if(null==priorPeriod)
			return 0;
		return priorPeriod;
	}

	@Override
	public List<RotateScheduleDetail> gatherScheduleDetail(HashMap<String, String> map) {
		List<RotateScheduleDetail> scheduleDetails = scheduleDao.gatherScheduleDetail(map);
		if(null!=scheduleDetails) {
			for(RotateScheduleDetail detail:scheduleDetails) {
				String modifyTimeStr = DateUtil.DateToString(detail.getModifyTime(), DateUtil.LONG_DATE_FORMAT);
				detail.setModifyTimeStr(modifyTimeStr);
			}
		}
		return scheduleDetails;
	}

	@Override
	public List<RotateScheduleDetail> viewGatherDetail(HashMap<String, String> map) {
		// TODO Auto-generated method stub

		return scheduleDao.viewGatherDetail(map);
	}

	@Override
	public int countGather(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return scheduleDao.countGather(map);
	}

	@Override
	public List<RotateScheduleDetail> listDetailHistory(String noticeSerial) {
		// TODO Auto-generated method stub
		HashMap<String, String> map = new HashMap<>();
		map.put("noticeSerial", noticeSerial);
		return scheduleDao.listDetailHistory(map);
	}

	@Override
	public List<RotateSchedule> listScheduleHistory(HashMap<String, Object> map) {
		// TODO Auto-generated method stub

		return scheduleDao.listScheduleHistory(map);
	}

	@Override
	public int countScheduleHistory(HashMap<String, Object> map) {
		// TODO Auto-generated method stub

		return scheduleDao.countScheduleHistory(map);
	}

	@Override
	public int updateStatus(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return scheduleDao.updateStatus(map);
	}

}
