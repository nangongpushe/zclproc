package com.dhc.fastersoft.dao.store;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.store.StorageFumigate;
import com.dhc.fastersoft.entity.store.StorageMachineAir;
import com.dhc.fastersoft.entity.store.StoragePhosphine;
import com.dhc.fastersoft.entity.store.StoragePhosphinePoint;


public interface StoragePhosphineDao {
	
	int save(StoragePhosphine storagePhosphine);
	
	int update(StoragePhosphine storagePhosphine);

	int remove(String id);
		
	StoragePhosphine getById(String id);
	
	List<StoragePhosphinePoint> getPointsByPhosphineId(String id);
		
	int count(HashMap<String, Object> map);

	List<StoragePhosphine> list(HashMap<String, Object> map);

}
