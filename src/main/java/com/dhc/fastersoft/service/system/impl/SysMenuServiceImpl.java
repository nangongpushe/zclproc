package com.dhc.fastersoft.service.system.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.dao.system.SysMenuDao;
import com.dhc.fastersoft.entity.system.SysMenu;
import com.dhc.fastersoft.service.system.SysMenuService;
import com.dhc.fastersoft.utils.LayPage;

@Service("sysMenu")
public class SysMenuServiceImpl implements SysMenuService{
	
	@Resource
	private SysMenuDao sysMenuDao;

	@Override
	public LayPage<SysMenu> pageList(HttpServletRequest request) {
		LayPage<SysMenu> page = new LayPage<SysMenu>();

        HashMap<String,String> map = QueryUtil.pageHashMap(request);
        
        String menuName = request.getParameter("key[menuName]");
        map.put("menuName", menuName);

		int count = sysMenuDao.getRecordCount(map);    //总记录数
		page.setCode(0);
		page.setCount(count);
        if (count<=0) {
        	page.setMsg("没有查询到数据");
			return page;
		}
        page.setData(sysMenuDao.pageQuery(map));
        page.setMsg("succes");
		return page;
	}

	@Override
	public int saveSysMenu(SysMenu sysMenu) {
		
		return sysMenuDao.insert(sysMenu);
	}

	@Override
	public int deleteById(String id) {
		
		return sysMenuDao.deleteByPrimaryKey(id);
	}

	@Override
	public List<SysMenu> selectAll() {
		
		return sysMenuDao.selectAll();
	}

	@Override
	public SysMenu selectById(String menuId) {
		
		return sysMenuDao.selectByPrimaryKey(menuId);
	}

	@Override
	public int updateSysMenu(SysMenu sysMenu) {
	
		return sysMenuDao.updateByPrimaryKey(sysMenu);
	}
	


}
