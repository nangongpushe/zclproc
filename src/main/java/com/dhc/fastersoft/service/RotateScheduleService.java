package com.dhc.fastersoft.service;



import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.dhc.fastersoft.entity.RotateBID;
import com.dhc.fastersoft.entity.RotateConclute;
import com.dhc.fastersoft.entity.RotateInvite;
import com.dhc.fastersoft.entity.RotateSchedule;
import com.dhc.fastersoft.entity.RotateScheduleDetail;
import com.dhc.fastersoft.entity.RotateScheme;
import com.dhc.fastersoft.entity.RotateSchemeDetail;
import com.dhc.fastersoft.utils.LayPage;


public interface RotateScheduleService {
	
	int save(RotateSchedule record);
	
	int update(RotateSchedule record);

	int remove(String id);
	
	RotateSchedule get(String id);
	
	int count(HashMap<String, Object> map);
	
	List<RotateSchedule> list(HashMap<String, Object> map);
	
	List<RotateScheduleDetail> listDetail(HashMap<String, String> map);
	
	double getPriorPeriod(String dealSerial);
	
	List<RotateScheduleDetail> gatherScheduleDetail(HashMap<String, String> map);
	
	int countGather(HashMap<String, String> map);
	
	List<RotateScheduleDetail> viewGatherDetail(HashMap<String, String> map);
	
	List<RotateSchedule> listScheduleHistory(HashMap<String, Object> map);

	int countScheduleHistory(HashMap<String, Object> map);
	
	List<RotateScheduleDetail> listDetailHistory(String noticeSerial);
	
	int updateStatus(HashMap<String, String> map);
	
}
