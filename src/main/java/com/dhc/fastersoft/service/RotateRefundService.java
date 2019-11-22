package com.dhc.fastersoft.service;



import com.dhc.fastersoft.entity.RotateRefund;
import com.dhc.fastersoft.entity.RotateRefundMain;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;


@Component
public interface RotateRefundService {
	
	int save(RotateRefund record);
	
	int update(RotateRefund record);

	int updateMain(RotateRefundMain rotateRefundMain);

	int remove(String id);
    int removeMain(String id);
		
	List<RotateRefund> get(String id);
	String getMaxGroupId(String id);

	RotateRefund view(String id);
	
	int count(HashMap<String, Object> map);

	List<RotateRefund> list(HashMap<String, Object> map);

	String getInviteName(RotateRefund rotateRefund);
}
