package com.dhc.fastersoft.service.store;



import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.dhc.fastersoft.entity.RotateArrive;
import com.dhc.fastersoft.entity.RotateArriveAudit;
import com.dhc.fastersoft.entity.RotateArriveDepartment;
import com.dhc.fastersoft.entity.store.StorageCooling;
import com.dhc.fastersoft.entity.store.StorageFumigate;
import com.dhc.fastersoft.entity.store.StorageMachineAir;


@Component
public interface StorageCoolingService {
	
	int save(StorageCooling storageCooling);
	
	int update(StorageCooling storageCooling);

	int remove(String id);
		
	StorageCooling getById(String id);
		
	int count(HashMap<String, Object> map);

	List<StorageCooling> list(HashMap<String, Object> map);
}
