package com.dhc.fastersoft.dao;

import com.dhc.fastersoft.entity.StoreSuperviseItem;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface StoreSuperviseItemDao {
    int save(StoreSuperviseItem item);
    public List pageQuery(HashMap maps);
	public int getRecordCount(HashMap maps);	
	String getPrimId();
	
	List<StoreSuperviseItem> listBySuperviseId(String id);
	
	List<StoreSuperviseItem> listStoreSuperviseItems(HashMap<String, Object> map);

	List<StoreSuperviseItem> getNewSuperiviseByWarehouseId(Map<String, Object> map);
	
}