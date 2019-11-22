package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.RotateFreight;
import com.dhc.fastersoft.entity.RotateFreightDetail;
import com.dhc.fastersoft.entity.RotateInvite;
import com.dhc.fastersoft.entity.RotateInviteDetail;


public interface RotateFreightDao {
	
	int saveFreight(RotateFreight record);
	
	int updateFreight(RotateFreight record);

	int remove(String id);
	
	int removeDetail(String id);
	
	RotateFreight getById(String id);
	
	int count(HashMap<String, Object> map);

	List<RotateFreight> list(HashMap<String, Object> map);
	
	List<RotateFreightDetail> listDetail(HashMap<String, Object> map);
	
	int updateClientNameAndPrice(List<RotateFreightDetail> freightDetails);
	
	int updateStatus(HashMap<String, Object> map);

}
