package com.dhc.fastersoft.service.system;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.entity.system.SysMenu;
import com.dhc.fastersoft.utils.LayPage;

public interface SysMenuService {
	
	LayPage<SysMenu> pageList(HttpServletRequest request);
	
	SysMenu selectById(String menuId);
	
	int saveSysMenu(SysMenu sysMenu);
	
	int updateSysMenu(SysMenu sysMenu);
	
	int deleteById(String id);
	
	List<SysMenu> selectAll();
}
