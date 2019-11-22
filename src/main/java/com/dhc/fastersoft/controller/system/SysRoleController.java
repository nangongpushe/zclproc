package com.dhc.fastersoft.controller.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.controller.BaseController;
import org.activiti.engine.IdentityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dhc.fastersoft.common.Constant;
import com.dhc.fastersoft.entity.system.SysRole;
import com.dhc.fastersoft.service.system.SysRoleService;
import com.dhc.fastersoft.utils.LayEntity;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.utils.StringUtils;

@RequestMapping(value="sysRole")
@Controller
public class SysRoleController extends BaseController{
	
	@Autowired	  
	IdentityService identityService;
	
	@Autowired
	private SysRoleService sysRoleService;
	
	/**
	 * 列表页面
	 * 
	 * @param request
	 * @return
	 */
	@SysLogAn("访问：系统管理-角色管理")
	@RequestMapping()
	public String index(){
		return "system/sysRole/sysRole_view";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public LayPage<SysRole> list(HttpServletRequest request){
			
		LayPage<SysRole> page = sysRoleService.pageList(request);
		return page;
	}
	
	@RequestMapping("/getRole")
	@ResponseBody
	public LayEntity getRole(HttpServletRequest request){
		LayEntity layEntity = new LayEntity();
		Map<String, Object> map = new HashMap<String, Object>();
		List<SysRole> Rolelist = sysRoleService.selectAll();
		Set<String> myRole = sysRoleService.findRoleNameByUserId(request.getParameter("userId"));
		map.put("Rolelist", Rolelist);
		map.put("myRole", myRole);
		layEntity.setData(map);
		return layEntity;
	}
	
	/** 
	* @Title: save 
	* @Description: save方法
	* @throws 
	*/ 
	
	@RequestMapping(value="/save")
	public String save(SysRole sysRole){
		if(StringUtils.isBlank(sysRole.getId())){
			String roleId = StringUtils.createUUID();
			sysRole.setId(roleId);
			sysRoleService.saveSysRole(sysRole);
			sysLogService.add(request, "系统管理-角色管理-新增");
		}else{
			sysRoleService.updateSysRole(sysRole);
			sysLogService.add(request, "系统管理-角色管理-修改");
		}
		
/*		Group group = identityService.newGroup(roleId);
		group.setType(sysRole.getType());
		group.setName(sysRole.getName());
		identityService.saveGroup(group);工作流组*/
		return "redirect:/sysRole.shtml";
	}
	
	/**
	 * 增加或修改
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/edit")
	public String addOrEdit(HttpServletRequest request) {
		String id = request.getParameter("id");
		SysRole sysRole = sysRoleService.selectByPrimaryKey(id);
		if(StringUtils.isBlank(sysRole)){
			request.setAttribute("type", "添加");
		}else {
			request.setAttribute("sysRole", sysRole);
			request.setAttribute("type", "编辑");
		}
		
		return "system/sysRole/sysRole_edit";
	}

	@SysLogAn("系统管理-角色管理-删除")
	@RequestMapping("/del")
	@ResponseBody
	public LayEntity del(@RequestParam("id")String id){
		sysRoleService.deleteById(id);
		LayEntity layEntity = new LayEntity(Constant.SUCCESS_CODE, Constant.SUCCESS, null);
		return layEntity;
	}
	
	/**
	 * 详情
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/detail")
	public String detail(HttpServletRequest request) {
		String id = request.getParameter("id");
		SysRole sysRole = sysRoleService.selectByPrimaryKey(id);
		request.setAttribute("sysRole", sysRole);
		request.setAttribute("type", "详情");	
		return "system/sysRole/sysRole_edit";
	}
	
}
