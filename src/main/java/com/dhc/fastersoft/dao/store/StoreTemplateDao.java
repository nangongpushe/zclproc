package com.dhc.fastersoft.dao.store;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.store.StoreTemplate;



public interface StoreTemplateDao {
	public List pageQuery(HashMap maps);
	public int add(StoreTemplate storeTemplate);
	public int update(StoreTemplate storeTemplate);
	public int getRecordCount(HashMap maps);	
	public StoreTemplate getStoreTemplateById(String templetNo);
	public int remove(String id);
	
}
