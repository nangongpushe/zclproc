package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.utils.LayPage;

public interface SysDictDao {
	
	//分页方法
	List<SysDict> pageQuery(HashMap<String, String> maps);
	int getRecordCount(HashMap<String, String> maps);
	
    int deleteByPrimaryKey(String id);

    int insert(SysDict record);

    int insertSelective(SysDict record);

    SysDict selectByPrimaryKey(Object id);

    int updateByPrimaryKeySelective(SysDict record);

    int updateByPrimaryKey(SysDict record);
    
	List<SysDict> selectAll();
	
	 SysDict getSysDictByType(String type);
	 List<SysDict> getSysDictByparentId(String parentId);
	 
	List<SysDict> getSysDictListByType(String type);
	
	SysDict getSysDictByLabel(String label);
    
}