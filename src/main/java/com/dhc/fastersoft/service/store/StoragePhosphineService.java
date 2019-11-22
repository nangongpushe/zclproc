package com.dhc.fastersoft.service.store;


import com.dhc.fastersoft.entity.store.StoragePhosphine;
import com.dhc.fastersoft.entity.store.StoragePhosphinePoint;

import java.util.HashMap;
import java.util.List;


public interface StoragePhosphineService {
	
	int save(StoragePhosphine storagePhosphine);
	
	int update(StoragePhosphine storagePhosphine);

	int remove(String id);
		
	StoragePhosphine getById(String id);
	
	List<StoragePhosphinePoint> getPointsByPhosphineId(String id);
		
	int count(HashMap<String, Object> map);

	List<StoragePhosphine> list(HashMap<String, Object> map);
}
