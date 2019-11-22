package com.dhc.fastersoft.dao.store;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.store.StoreWinUnit;



public interface StoreWinUnitDao {
	public List pageQuery(HashMap maps);
	public int add(StoreWinUnit storeWinUnit);
	public int update(StoreWinUnit storeWinUnit);
	public int getRecordCount(HashMap maps);	
	public StoreWinUnit getStoreWinUnitById(String id);
	public int remove(String id);
	public int updateRecommend(String id);
	
}
