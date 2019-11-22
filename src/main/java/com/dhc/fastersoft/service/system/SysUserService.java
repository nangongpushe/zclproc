package com.dhc.fastersoft.service.system;

import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.utils.LayPage;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public interface SysUserService {
	
	SysUser login(String account ,String password);
	
	int updateByPrimaryKeySelective(SysUser sysUser);
	
	int createSysUser(SysUser sysUser);
	
	LayPage<SysUser> pageList(HttpServletRequest request);

	void saveUserRole(String roleid, String userId);
	
	void deleteUserRole(String userId);

	void deleteById(String id);

	SysUser selectByAccount(String account);

	SysUser selectByCompany(String reportWarehouse);
	//权限范围（主要是库与代储企业之间的关系）
	String getUserPosition();
	SysUser selectByPrimaryKey(String id);

	List<SysUser> getList();

	SysUser selectById(String id);
	
	List<SysUser> getListByRoleName(String roleName); 

	List<SysUser> distinctList();
	List<SysUser> getListByStoreHouseAndType(HashMap<String, String> map);
	
	SysUser getUserByPosition(String position);
	List<SysUser> getUserIds(HashMap<String, String> map);

	List<SysUser> getUserByExample(Map<String,Object> param);

}
