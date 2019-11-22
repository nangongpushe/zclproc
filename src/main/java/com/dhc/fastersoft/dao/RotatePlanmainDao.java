package com.dhc.fastersoft.dao;

import com.dhc.fastersoft.entity.RotatePlanmain;
import com.dhc.fastersoft.entity.RotatePlanmainDetail;

import java.util.HashMap;
import java.util.List;


public interface RotatePlanmainDao {
	
	int save(RotatePlanmain rotatePlan);
	
	int update(RotatePlanmain rotatePlan);

	RotatePlanmain getPlan(String id);
	
	int count(HashMap<String, Object> maps);

	List<RotatePlanmain> list(HashMap<String, Object> map);
	
	List<RotatePlanmainDetail> listPlanDetail(String id);
	
	int updateState(HashMap<String, Object> map);

	List<RotatePlanmainDetail> listDetailByCondition(HashMap<String, String> map);
	
	int checkPrimary(String planName);

	int detailcount(HashMap<String, String> maps);

	int remove(String id);

	int removeDetail(String id);

	int updateAttachment(RotatePlanmain rotatePlan);

	int tablecount(HashMap<String, Object> maps);

	List<RotatePlanmain> tablelist(HashMap<String, Object> map);
	List<RotatePlanmain> listAll(RotatePlanmain plan);
}
