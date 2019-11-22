package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.RotateFreight;
import com.dhc.fastersoft.entity.RotateFreightAPRV;
import com.dhc.fastersoft.entity.RotateFreightAPRVDetail;
import com.dhc.fastersoft.entity.RotateFreightAPRVGather;
import com.dhc.fastersoft.entity.RotateFreightDetail;
import com.dhc.fastersoft.entity.RotateInvite;
import com.dhc.fastersoft.entity.RotateInviteDetail;


public interface RotateFreightAPRVDao {
	
	int save(RotateFreightAPRV record);
	
	int update(RotateFreightAPRV record);

	int remove(String id);
	
	int removeDetail(String id);
	
	RotateFreightAPRV getById(String id);
	
	int count(HashMap<String, Object> map);

	List<RotateFreightAPRV> list(HashMap<String, Object> map);
	
	List<RotateFreightAPRVDetail> listDetail(HashMap<String, Object> map);
	
	
	int updateStatus(HashMap<String, Object> map);
	
	int updateIsGather(HashMap<String, Object> map);

	int updateIsReport(HashMap<String, Object> map);
	
	
	//------汇总-------
	int  saveGather(RotateFreightAPRVGather record);
	
	RotateFreightAPRVGather getGather(HashMap<String, Object> map);
	
	int updateGatherStatus(HashMap<String, Object> map);
	
	int countGather(HashMap<String, Object> map);

	List<RotateFreightAPRVGather> listGather(HashMap<String, Object> map);
	
	List<RotateFreightAPRVDetail> listDetailGather(HashMap<String, Object> map);
	
	int updateGatherId(HashMap<String, Object> map);

	int removeGather(String id);
}
