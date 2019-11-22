package com.dhc.fastersoft.service;



import com.dhc.fastersoft.entity.RotateArrive;
import com.dhc.fastersoft.entity.RotateArriveAudit;
import com.dhc.fastersoft.entity.RotateArriveDepartment;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;


@Component
public interface RotateArriveService {
	
	int save(RotateArrive record);
	
	int update(RotateArrive record);

	int remove(String id);	
	
	RotateArrive get(String id);
	
	List<RotateArrive> list(HashMap<String, Object> map);
	
	int count(HashMap<String, Object> map);
	
	int updateStatus(String id,String status);
	
	int updateClaimStatus(String id,String claimStatus);
	
	int updateBalance(String id,double balance);
	
	int saveAudit(RotateArriveAudit audit);
	
	int updateAudit(RotateArriveAudit audit);
	
	List<RotateArriveAudit> listAudit(HashMap<String, Object> map);
	
	int isExistAudit(HashMap<String, Object> map);
	
	int removeAudit(String arriveId);
	
	RotateArriveAudit getAudit(HashMap<String, Object> map);
	
	int saveDepartment(List<RotateArriveDepartment> arriveDepartments);
	
	int removeDepartment(String arriveId);
	
	List<RotateArriveDepartment> listDepartment(HashMap<String, Object> map);

	void reUpdateStatus(RotateArrive rotateArrive);
}
