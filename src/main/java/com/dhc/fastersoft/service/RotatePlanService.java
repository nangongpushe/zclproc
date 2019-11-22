package com.dhc.fastersoft.service;


import com.dhc.fastersoft.entity.RotatePlan;
import com.dhc.fastersoft.entity.RotatePlanDetail;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Component
public interface RotatePlanService {
	int save(RotatePlan rotatePlan);
	
	int update(RotatePlan rotatePlan);

	int remove(String id);
	
	int removeDetail(String id);
	
	RotatePlan getPlan(String id);
	List<RotatePlanDetail> listPlanDetailByMainId(String id);
	List<RotatePlan> list(HashMap<String, Object> map);
	
	int count(HashMap<String, Object> map);
	
	List<RotatePlan> listAll(RotatePlan plan);
	
	List<RotatePlanDetail> listDetail(String id);
	
	int updateState(String id,String state);
	
	List<RotatePlanDetail> listDetailByCondition(HashMap<String, String> map);
	
	boolean checkPrimary(String planName);
	
	RotatePlanDetail getPlanDetail(String id);

	List<RotatePlanDetail> getSumRotatenumberByPlanmaindetailId(String planId);

	List<RotatePlan> getPlanname();

	BigDecimal getSumDealDetailNumberByRotateType(Map<String,Object> conditionMap);
}
