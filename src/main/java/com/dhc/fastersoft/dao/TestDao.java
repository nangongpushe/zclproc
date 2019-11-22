package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.common.page.PageList;
import com.dhc.fastersoft.entity.Test;

public interface TestDao {

	int getRecordCount(HashMap<String, String> maps);

	List<PageList> pageQuery(HashMap<String, String> map);

	int add(Test test);

	int update(Test test);

	int delete(String id);

	List<Test> query(HashMap<String, String> map);

	Test getTestById(String id);
}
