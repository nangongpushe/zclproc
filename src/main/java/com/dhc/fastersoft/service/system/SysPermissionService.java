package com.dhc.fastersoft.service.system;

import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysPermission;
import com.dhc.fastersoft.utils.LayPage;


public interface SysPermissionService {
	
	Set<String> findPermissionByUserId(String userId);
	
	LayPage<SysPermission> pageList(HttpServletRequest request);
	
	int saveSysPermission(SysPermission sysPermission);
	
	int deleteById(String id);
	
	List<SysPermission> selectAll();

	void saveRolePermission(String roleId,String permissionId);

	List<SysPermission> selectRolePermission(String roleId);

	SysPermission selectById(String id);

	void updatePermissionById(SysPermission sysPermission);

	void deleteRolePermission(String roleId);

	SysPermission selectByUrl(String url);

}
