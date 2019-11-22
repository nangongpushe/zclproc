package com.dhc.fastersoft.dao.store;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.store.StoreExamineItem;


public interface StoreExamineItemDao {

	public int add(StoreExamineItem StoreExamineItem);
	public int update(StoreExamineItem StoreExamineItem);
	public StoreExamineItem getStoreExamineById(String id);
	public List<StoreExamineItem> getItemListByExamineId(String examineId);
	public int remove(String examineId);
	public List<StoreExamineItem> getItemListByParentId(HashMap map);
	
}
