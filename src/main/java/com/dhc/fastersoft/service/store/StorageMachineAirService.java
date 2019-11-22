package com.dhc.fastersoft.service.store;



import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.dhc.fastersoft.entity.RotateArrive;
import com.dhc.fastersoft.entity.RotateArriveAudit;
import com.dhc.fastersoft.entity.RotateArriveDepartment;
import com.dhc.fastersoft.entity.store.StorageMachineAir;


@Component
public interface StorageMachineAirService {
	
	int save(StorageMachineAir storageMachineAir);
	
	int update(StorageMachineAir storageMachineAir);

	int remove(String id);
		
	StorageMachineAir getById(String id);
		
	int count(HashMap<String, Object> map);

	List<StorageMachineAir> list(HashMap<String, Object> map);
}
