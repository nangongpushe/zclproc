package com.dhc.fastersoft.dao.store;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.store.StoreFeedBack;




public interface StoreFeedBackDao {
	public List pageQuery(HashMap maps);
	public int add(StoreFeedBack storeFeedBack);
	public int update(StoreFeedBack storeFeedBack);
	public int getRecordCount(HashMap maps);	
	public StoreFeedBack getStoreFeedBackById(String id);
	public int remove(String id);
}
