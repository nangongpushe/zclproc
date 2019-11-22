package com.dhc.fastersoft.dao.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.dhc.fastersoft.entity.system.SysUser;
import org.springframework.stereotype.Component;

@Component
public interface SysUserDao {
    int deleteByPrimaryKey(String id);

    int insert(SysUser record);

    int insertSelective(SysUser record);

    SysUser selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(SysUser record);

    int updateByPrimaryKey(SysUser record);
    
    SysUser login(HashMap<String, Object> map);
    
	//分页方法
	List<SysUser> pageQuery(HashMap<String, String> maps);
	int getRecordCount(HashMap<String, String> maps);

	void saveUserRole(HashMap<String, String> map);

	SysUser selectByAccount(String account);

	SysUser selectByCompany(String selectByCompany);

	void deleteUserRole(String userId);

	List<SysUser> distinctList(HashMap<String, String> map);

	List<SysUser> getListByRoleName(String roleName);
	List<SysUser> getListByStoreHouseAndType(HashMap<String, String> map);
	
	SysUser getUserByPosition(String position);
	List<SysUser> getUserIds(HashMap<String, String> map);

	List<SysUser> getUserByExample(Map<String,Object> param);
}