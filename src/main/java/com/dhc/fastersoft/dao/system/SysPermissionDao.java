package com.dhc.fastersoft.dao.system;

import java.util.HashMap;
import java.util.List;
import java.util.Set;

import com.dhc.fastersoft.entity.system.SysPermission;

public interface SysPermissionDao {
    int deleteByPrimaryKey(String id);

    int insert(SysPermission record);

    int insertSelective(SysPermission record);

    SysPermission selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(SysPermission record);

    int updateByPrimaryKey(SysPermission record);
    
    Set<String> findPermissionByUserId(String id);
    
	List<SysPermission> pageQuery(HashMap<String, String> map);
	int getRecordCount(HashMap<String, String> map);

	void saveRolePermission(HashMap<String, String> map);

	List<SysPermission> selectAll();

	List<SysPermission> selectRolePermission(String roleId);

	void deleteRolePermission(String roleId);

	SysPermission selectByUrl(String url);
}