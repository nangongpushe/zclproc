package com.dhc.fastersoft.service.system;

import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.entity.system.SysPermission;
import com.dhc.fastersoft.entity.system.SysRole;
import com.dhc.fastersoft.utils.LayPage;

public interface SysRoleService {
	
	//初始化数据
	void initData();
	
	Set<String> findRoleTypeByUserId(String userId);
	
	Set<String> findRoleNameByUserId(String userId);
	
	Set<String> findRoleIdByUserId(String userId);
	
	LayPage<SysRole> pageList(HttpServletRequest request);
	
	int saveSysRole(SysRole sysRole);
	
	int updateSysRole(SysRole sysRole);
	
	int deleteById(String id);
	
	List<SysRole> selectAll();

	SysRole selectByPrimaryKey(String roleid);
}
