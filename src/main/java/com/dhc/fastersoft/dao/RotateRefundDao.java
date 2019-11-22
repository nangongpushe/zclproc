package com.dhc.fastersoft.dao;

import com.dhc.fastersoft.entity.RotateRefund;

import java.util.HashMap;
import java.util.List;


public interface RotateRefundDao {
	
	int save(RotateRefund record);
	
	int update(RotateRefund record);

	int remove(String id);
		
	List<RotateRefund> get(String id);
	String getMaxGroupId(String id);

	RotateRefund view(String id);
	
	int count(HashMap<String, Object> map);

	List<RotateRefund> list(HashMap<String, Object> map);

	String getInviteName(RotateRefund rotateRefund);
}
