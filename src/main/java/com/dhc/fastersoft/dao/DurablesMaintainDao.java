package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.DurablesMaintain;



public interface DurablesMaintainDao {
	public List pageQuery(HashMap maps);
	public int add(DurablesMaintain durablesMaintain);
	public int update(DurablesMaintain durablesMaintain);
	public int getRecordCount(HashMap maps);	
	public DurablesMaintain  getDurablesMaintainById(String id);
	public int remove(String id);
	public List exportxls(HashMap maps) ;
}
