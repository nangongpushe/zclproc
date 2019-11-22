package com.dhc.fastersoft.service.system.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.dhc.fastersoft.common.Constant;
import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.dao.system.SysPermissionDao;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysPermission;
import com.dhc.fastersoft.service.system.SysPermissionService;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.utils.StringUtils;

@Service("sysPermissionService")
public class SysPermissionServiceImpl implements SysPermissionService{
	
	@Resource
	private SysPermissionDao sysPermissionDao;

	@Override
	public Set<String> findPermissionByUserId(String userId) {
		return sysPermissionDao.findPermissionByUserId(userId);
	}

	@Override
	public LayPage<SysPermission> pageList(HttpServletRequest request) {
		LayPage<SysPermission> page = new LayPage<SysPermission>();

        HashMap<String,String> map = QueryUtil.pageHashMap(request);
        
        String name = request.getParameter("key[name]");
        map.put("name", name);
        map.put("type", request.getParameter("key[type]"));
        map.put("perId", request.getParameter("key[perId]"));
        
		int count = sysPermissionDao.getRecordCount(map);    //总记录数
		page.setCode(Constant.SUCCESS_CODE);
		page.setCount(count);
        if (count<=0) {
        	page.setCode(Constant.FAIL_CODE);
        	page.setMsg("没有查询到数据");
			return page;
		}
        page.setData(sysPermissionDao.pageQuery(map));
        page.setMsg(Constant.SUCCESS);
		return page;
	}

	@Override
	public int saveSysPermission(SysPermission sysPermission) {
		// TODO Auto-generated method stub
		return sysPermissionDao.insert(sysPermission);
	}

	@Override
	public int deleteById(String id) {
		// TODO Auto-generated method stub
		return sysPermissionDao.deleteByPrimaryKey(id);
	}

	@Override
	public List<SysPermission> selectAll() {
		// TODO Auto-generated method stub
		return sysPermissionDao.selectAll();
	}

	@Override
	public void saveRolePermission(String roleId, String permissionId) {
		HashMap<String,String> map = new HashMap<String, String>();
		map.put("roleId", roleId);
		map.put("permissionId", permissionId);
		map.put("id", StringUtils.createUUID());
		sysPermissionDao.saveRolePermission(map);
	}

	@Override
	public List<SysPermission> selectRolePermission(String roleId) {
		// TODO Auto-generated method stub
		return sysPermissionDao.selectRolePermission(roleId);
	}

	@Override
	public SysPermission selectById(String id) {
		// TODO Auto-generated method stub
		return sysPermissionDao.selectByPrimaryKey(id);
	}

	@Override
	public void updatePermissionById(SysPermission sysPermission) {
		// TODO Auto-generated method stub
		sysPermissionDao.updateByPrimaryKey(sysPermission);
	}

	@Override
	public void deleteRolePermission(String roleId) {
		// TODO Auto-generated method stub
		sysPermissionDao.deleteRolePermission(roleId);
	}

	@Override
	public SysPermission selectByUrl(String url) {
		// TODO Auto-generated method stub
		return sysPermissionDao.selectByUrl(url);
	}
	
	

}
