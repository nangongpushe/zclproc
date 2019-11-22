package com.dhc.fastersoft.dao.system;

import java.util.HashMap;
import java.util.List;
import java.util.Set;

import com.dhc.fastersoft.entity.system.SysRole;
import com.dhc.fastersoft.entity.system.SysUser;

public interface SysRoleDao {
    int deleteByPrimaryKey(String id);

    int insert(SysRole record);

    int insertSelective(SysRole record);

    SysRole selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(SysRole record);

    int updateByPrimaryKey(SysRole record);
    
    Set<String> findRoleByUserId(String id);
    
    void initData();
    
	//分页方法
	List<SysRole> pageQuery(HashMap<String, String> maps);
	int getRecordCount(HashMap<String, String> maps);

	List<SysRole> selectAll();

	Set<String> findRoleIdByUserId(String userId);

	Set<String> findRoleNameByUserId(String userId);
}