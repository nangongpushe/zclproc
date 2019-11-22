package com.dhc.fastersoft.dao.store;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.store.StorageCooling;
import com.dhc.fastersoft.entity.store.StorageFumigate;
import com.dhc.fastersoft.entity.store.StorageMachineAir;


public interface StorageCoolingDao {
	
	int save(StorageCooling storageCooling);
	
	int update(StorageCooling storageCooling);

	int remove(String id);
		
	StorageCooling getById(String id);
		
	int count(HashMap<String, Object> map);

	List<StorageCooling> list(HashMap<String, Object> map);
	
}
