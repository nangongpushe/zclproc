package com.dhc.fastersoft.dao.system;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.system.SysMenu;


public interface SysMenuDao {
    int deleteByPrimaryKey(String menuId);

    int insert(SysMenu record);

    int insertSelective(SysMenu record);

    SysMenu selectByPrimaryKey(String menuId);

    int updateByPrimaryKeySelective(SysMenu record);

    int updateByPrimaryKey(SysMenu record);

	int getRecordCount(HashMap<String, String> map);

	List<SysMenu> pageQuery(HashMap<String, String> map);

	List<SysMenu> selectAll();
}