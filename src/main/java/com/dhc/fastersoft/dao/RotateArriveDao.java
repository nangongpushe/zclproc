package com.dhc.fastersoft.dao;

import com.dhc.fastersoft.entity.RotateArrive;
import com.dhc.fastersoft.entity.RotateArriveAudit;
import com.dhc.fastersoft.entity.RotateArriveDepartment;

import java.util.HashMap;
import java.util.List;


public interface RotateArriveDao {
	
	int save(RotateArrive record);
	
	int update(RotateArrive record);

	int remove(String id);
		
	RotateArrive get(String id);
	
	int count(HashMap<String, Object> map);

	List<RotateArrive> list(HashMap<String, Object> map);
	
	int updateStatus(HashMap<String, String> map);
	
	int updateClaimStatus(HashMap<String, String> map);
	
	int updateBalance(HashMap<String, Object> map);
	
	int saveAudit(RotateArriveAudit audit);
	
	int updateAudit(RotateArriveAudit audit);
	
	List<RotateArriveAudit> listAudit(HashMap<String, Object> map);
	
	int isExistAudit(HashMap<String, Object> map);
	
	int removeAudit(String arriveId);
	
	RotateArriveAudit getAudit(HashMap<String, Object> map);
	
	int saveDepartment(List<RotateArriveDepartment> arriveDepartment);
	
	int removeDepartment(String arriveId);
	
	List<RotateArriveDepartment> listDepartment(HashMap<String, Object> map);

//	void reUpdateStatus(RotateArrive rotateArrive);
}
