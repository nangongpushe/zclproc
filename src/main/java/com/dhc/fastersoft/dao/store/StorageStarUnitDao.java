package com.dhc.fastersoft.dao.store;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.store.StorageStarUnit;


public interface StorageStarUnitDao {
	
	public List pageQuery(HashMap maps);
	public List exportxls(HashMap maps) ;
	public int add(StorageStarUnit storageStarUnit);
	public int update(StorageStarUnit storageStarUnit);
	public int getRecordCount(HashMap maps);	
	public StorageStarUnit getStorageStarUnitById(String id);
	public int remove(String id);
}
