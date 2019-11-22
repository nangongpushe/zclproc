package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;


import com.dhc.fastersoft.entity.Durables;

public interface DurablesDao {
	public List pageQuery(HashMap maps);
	public int add(Durables durables);
	public int update(Durables durables);
	public int updateApply(Durables durables);
	public int getRecordCount(HashMap maps);	
	public int getEncodeCount(String encode);	
	
	public Durables getDurablesById(String id);
	public int remove(String id);
	public List<Durables> listDurables(HashMap<String,Object> map);
}
