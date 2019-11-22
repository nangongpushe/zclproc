package com.dhc.fastersoft.dao;

import com.dhc.fastersoft.entity.RotatePlanmainDetail;

import java.util.List;

public interface RotatePlanmainDetailDao {

	RotatePlanmainDetail findById(String id);

	void updatedetailNumberByid(RotatePlanmainDetail rotatePlanmainDetail);
	void updateDealDetailNumberByid(RotatePlanmainDetail rotatePlanmainDetail);

	List<RotatePlanmainDetail> findSumDetailNumberByPlanId(String id);
	
}
