package com.dhc.fastersoft.controller.system;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dhc.fastersoft.entity.system.SysMenu;
import com.dhc.fastersoft.service.system.SysMenuService;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.utils.StringUtils;

@Controller
@RequestMapping("/sysMenu")
public class sysMenuController {
	
	@Autowired
	private SysMenuService sysMenuService;
	
	/**
	 * 列表页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping()
	public String index(HttpServletRequest request){
		
		return "system/sysMenu/sysMenu_view";
	}
	
	/** 
	* @Title: save 
	* @Description: save方法
	* @throws 
	*/ 
	
	@RequestMapping(value="/save")
	public String save(SysMenu sysMenu){
		if(StringUtils.isNotBlank(sysMenu.getMenuId())){
			sysMenu.setUpdateTime(new Date(System.currentTimeMillis()));
			sysMenuService.updateSysMenu(sysMenu);
		}else {
			if(StringUtils.isBlank(sysMenu.getMenuLevel())){
				sysMenu.setMenuLevel(BigDecimal.valueOf(1));
			}
			sysMenu.setMenuId(StringUtils.createUUID());
			sysMenu.setCreateTime(new Date(System.currentTimeMillis()));
			sysMenuService.saveSysMenu(sysMenu);
		}
		return "redirect:/sysMenu.shtml";
	}
	
	@RequestMapping(value="/getTree")
	@ResponseBody
	public List<SysMenu> getTree(SysMenu sysMenu){
		List<SysMenu> list = sysMenuService.selectAll();
		return list;
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public LayPage<SysMenu> list(HttpServletRequest request){
		
		LayPage<SysMenu> page = sysMenuService.pageList(request);
		return page;
	}
	
	@RequestMapping("/del")
	public void list(@RequestParam("id")String id){
		
		sysMenuService.deleteById(id);
	}
	
	/**
	 * 增加
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/add")
	public String add(HttpServletRequest request) {
		List<SysMenu> list = sysMenuService.selectAll();
		request.setAttribute("list", list);
		return "system/sysMenu/sysMenu_add";
	}
	
	/**
	 * 增加
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/edit")
	public String edit(HttpServletRequest request) {
		List<SysMenu> list = sysMenuService.selectAll();
		request.setAttribute("list", list);
		String menuId = request.getParameter("menuId");
		SysMenu sysMenu = sysMenuService.selectById(menuId);
		request.setAttribute("sysMenu", sysMenu);
		return "system/sysMenu/sysMenu_add";
	}
}
