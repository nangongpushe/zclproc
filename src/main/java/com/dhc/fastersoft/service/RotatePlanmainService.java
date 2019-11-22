package com.dhc.fastersoft.service;


import com.dhc.fastersoft.entity.RotatePlanmain;
import com.dhc.fastersoft.entity.RotatePlanmainDetail;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;


@Component
public interface RotatePlanmainService {
	int save(RotatePlanmain rotatePlan);

	int update(RotatePlanmain rotatePlan);

	RotatePlanmain getPlan(String id);

	List<RotatePlanmain> list(HashMap<String, Object> map);

	int count(HashMap<String, Object> map);

	List<RotatePlanmainDetail> listDetail(String id);

	int updateState(String id, String state);
	
	List<RotatePlanmainDetail> listDetailByCondition(HashMap<String, String> map);
	
	boolean checkPrimary(String planName);

	int detailcount(HashMap<String, String> map);

	RotatePlanmainDetail findById(String id);

	void updatedetailNumberByid(RotatePlanmainDetail rotatePlanmainDetail);

	List<RotatePlanmainDetail> findSumDetailNumberByPlanId(String id);

	int remove(String id);

	int removeDetail(String id);

	int updateAttachment(RotatePlanmain rotatePlanmain);

	int tablecount(HashMap<String, Object> maps);

	List<RotatePlanmain> tablelist(HashMap<String, Object> map);

	List<RotatePlanmain> listAll(RotatePlanmain plan);
}
