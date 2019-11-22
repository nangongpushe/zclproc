package com.dhc.fastersoft.service;



import java.util.HashMap;
import java.util.List;



import org.springframework.stereotype.Component;

import com.dhc.fastersoft.entity.RotateFreightAPRV;
import com.dhc.fastersoft.entity.RotateFreightAPRVDetail;
import com.dhc.fastersoft.entity.RotateFreightAPRVGather;



@Component
public interface RotateFreightAPRVService {
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
	
	int  saveGather(RotateFreightAPRVGather record);
	
	RotateFreightAPRVGather getGather(HashMap<String, Object> map);
	
	int updateGatherStatus(HashMap<String, Object> map);
	
	int countGather(HashMap<String, Object> map);

	List<RotateFreightAPRVGather> listGather(HashMap<String, Object> map);
	
	List<RotateFreightAPRVDetail> listDetailGather(HashMap<String, Object> map);
	
	int updateGatherId(HashMap<String, Object> map);
	
	int removeGather(String id);
}
