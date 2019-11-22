package com.dhc.fastersoft.dao.store;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.store.StorageMachineAir;


public interface StorageMachineAirDao {
	
	int save(StorageMachineAir storageMachineAir);
	
	int update(StorageMachineAir storageMachineAir);

	int remove(String id);
		
	StorageMachineAir getById(String id);
		
	int count(HashMap<String, Object> map);

	List<StorageMachineAir> list(HashMap<String, Object> map);

}
