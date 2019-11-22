package com.dhc.fastersoft.dao;

import com.dhc.fastersoft.entity.RotatePlan;
import com.dhc.fastersoft.entity.RotatePlanDetail;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public interface RotatePlanDao {
	
	int save(RotatePlan rotatePlan);
	
	int update(RotatePlan rotatePlan);

	int remove(String id);
	
	int removeDetail(String id);
	
	RotatePlan getPlan(String id);
	
	List<RotatePlan> listAll(RotatePlan plan);
	
	int getID();
	
	int count(HashMap<String, Object> maps);

	List<RotatePlan> list(HashMap<String, Object> map);
	
	List<RotatePlanDetail> listPlanDetail(String id);

	List<RotatePlanDetail> listPlanDetailByMainId(String id);
	int updateState(HashMap<String, Object> map);

	List<RotatePlanDetail> listDetailByCondition(HashMap<String, String> map);
	
	int checkPrimary(String planName);

	RotatePlanDetail getPlanDetail(String id);

	List<RotatePlanDetail> getSumRotatenumberByPlanmaindetailId(String planId);

	List<RotatePlan> getPlanname();
	void updateDealDetailNumberByid(RotatePlanDetail rotatePlanDetail);
	BigDecimal getSumDealDetailNumberByRotateType(Map<String,Object> conditionMap);
}
