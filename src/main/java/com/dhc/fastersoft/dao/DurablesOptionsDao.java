package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.DurablesOptions;



public interface DurablesOptionsDao {
	public List pageQuery(HashMap maps);
	public int add(DurablesOptions durablesOptions);
	public int update(DurablesOptions durablesOptions);
	public int updateApply(DurablesOptions durablesOptions);
	public int getRecordCount(HashMap maps);	
	public List<DurablesOptions> getDurablesOptionsById(String id);
	public int remove(String id);
}
