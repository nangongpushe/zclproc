package com.dhc.fastersoft.dao.store;

import java.util.HashMap;
import java.util.List;


import com.dhc.fastersoft.entity.store.StoreExamine;


public interface StoreExamineDao {
	
	public List pageQuery(HashMap maps);
	public int add(StoreExamine StoreExamine);
	public int update(StoreExamine StoreExamine);
	public int getRecordCount(HashMap maps);	
	public StoreExamine getStoreExamineById(String id);
	public int remove(String id);
}
