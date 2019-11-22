package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.entity.StorageStoreHouseOption;

public interface StorageStoreHouseOptionDao {
	
	int save(StorageStoreHouseOption option);//
	
	List<StorageStoreHouseOption> list(HashMap<String,String> map);
	
	int count(HashMap<String,String> map);
	
	String getNextId();

	int remove(String id);

	StorageStoreHouseOption getSingle(String id);

	int update(StorageStoreHouseOption option);
	
}