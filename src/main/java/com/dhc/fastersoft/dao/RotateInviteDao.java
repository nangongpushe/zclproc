package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.RotateInvite;
import com.dhc.fastersoft.entity.RotateInviteDetail;


public interface RotateInviteDao {
	
	int save(RotateInvite record);
	
	int update(RotateInvite record);

	int remove(String id);
	
	int removeDetail(String id);
	
	RotateInvite get(String id);
	
	int count(HashMap<String, String> maps);

	List<RotateInvite> list(HashMap<String, String> map);
	
	List<RotateInviteDetail> listDetail(String id);

	int getSerialCount(String date);
	
	int updateIsGather(HashMap<String, String> map);
}
