package com.dhc.fastersoft.dao.store;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.store.StorageFumigate;
import com.dhc.fastersoft.entity.store.StorageMachineAir;


public interface StorageFumigateDao {
	
	int save(StorageFumigate storageFumigate);
	
	int update(StorageFumigate storageFumigate);

	int remove(String id);
		
	StorageFumigate getById(String id);
		
	int count(HashMap<String, Object> map);

	List<StorageFumigate> list(HashMap<String, Object> map);
	
	List<String> getSerials(HashMap<String, Object> map);

}
