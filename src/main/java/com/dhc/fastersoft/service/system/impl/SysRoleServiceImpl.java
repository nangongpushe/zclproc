package com.dhc.fastersoft.service.system.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.common.Constant;
import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.dao.system.SysRoleDao;
import com.dhc.fastersoft.entity.system.SysRole;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.system.SysRoleService;
import com.dhc.fastersoft.utils.LayPage;

@Service("sysRoleService")
public class SysRoleServiceImpl implements SysRoleService{
	
	@Autowired
	private SysRoleDao sysRoleDao;

	@Override
	public Set<String> findRoleTypeByUserId(String userId) {
		// TODO Auto-generated method stub
		return sysRoleDao.findRoleByUserId(userId);
	}

	@Override
	public void initData() {
		// TODO Auto-generated method stub
		sysRoleDao.initData();
	}

	@Override
	public LayPage<SysRole> pageList(HttpServletRequest request) {
		
		LayPage<SysRole> page = new LayPage<SysRole>();

        HashMap<String,String> map = QueryUtil.pageHashMap(request);
        
        String name = request.getParameter("key[name]");
        map.put("name", name);

		int count = sysRoleDao.getRecordCount(map);    //总记录数
		
		page.setCount(count);
        if (count<=0) {
        	page.setCode(Constant.FAIL_CODE);
        	page.setMsg("没有查询到数据");
			return page;
		}
        page.setCode(Constant.SUCCESS_CODE);
        page.setData(sysRoleDao.pageQuery(map));
        page.setMsg(Constant.SUCCESS);
		return page;
	}

	@Override
	public int saveSysRole(SysRole sysRole) {
		
		return sysRoleDao.insert(sysRole);
	}

	@Override
	public int deleteById(String id) {
		
		return sysRoleDao.deleteByPrimaryKey(id);
	}

	@Override
	public List<SysRole> selectAll() {
		// TODO Auto-generated method stub
		return sysRoleDao.selectAll();
	}

	@Override
	public SysRole selectByPrimaryKey(String roleid) {
		// TODO Auto-generated method stub
		return sysRoleDao.selectByPrimaryKey(roleid);
	}

	@Override
	public Set<String> findRoleIdByUserId(String userId) {
		// TODO Auto-generated method stub
		return sysRoleDao.findRoleIdByUserId(userId);
	}

	@Override
	public Set<String> findRoleNameByUserId(String userId) {
		// TODO Auto-generated method stub
		return sysRoleDao.findRoleNameByUserId(userId);
	}

	@Override
	public int updateSysRole(SysRole sysRole) {
		// TODO Auto-generated method stub
		return sysRoleDao.updateByPrimaryKey(sysRole);
	}

}
