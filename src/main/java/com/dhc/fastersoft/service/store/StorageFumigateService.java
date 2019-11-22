package com.dhc.fastersoft.service.store;



import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.dhc.fastersoft.entity.RotateArrive;
import com.dhc.fastersoft.entity.RotateArriveAudit;
import com.dhc.fastersoft.entity.RotateArriveDepartment;
import com.dhc.fastersoft.entity.store.StorageFumigate;
import com.dhc.fastersoft.entity.store.StorageMachineAir;


public interface StorageFumigateService {
	
	int save(StorageFumigate storageFumigate);
	
	int update(StorageFumigate storageFumigate);

	int remove(String id);
		
	StorageFumigate getById(String id);
		
	int count(HashMap<String, Object> map);

	List<StorageFumigate> list(HashMap<String, Object> map);
	
	List<String> getSerials(HashMap<String, Object> map);
}
