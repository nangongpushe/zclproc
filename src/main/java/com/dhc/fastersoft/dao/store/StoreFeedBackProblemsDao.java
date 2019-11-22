package com.dhc.fastersoft.dao.store;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.store.StoreFeedBackProblems;


public interface StoreFeedBackProblemsDao {
	public List pageQuery(HashMap maps);
	public int add(StoreFeedBackProblems storeFeedBackProblems);
	public int update(StoreFeedBackProblems storeFeedBackProblems);
	public int getRecordCount(HashMap maps);	
	public List<StoreFeedBackProblems> getStoreFeedBackProblemsById(String serial);
	public int remove(String serial);
}
