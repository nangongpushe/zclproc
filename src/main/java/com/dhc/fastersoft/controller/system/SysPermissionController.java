package com.dhc.fastersoft.controller.system;

import com.dhc.fastersoft.common.Constant;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.controller.BaseController;
import com.dhc.fastersoft.entity.system.SysPermission;
import com.dhc.fastersoft.service.system.SysPermissionService;
import com.dhc.fastersoft.utils.LayEntity;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.utils.StringUtil;
import com.dhc.fastersoft.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/sysPermission")
public class SysPermissionController extends BaseController{
	
	@Autowired
	private SysPermissionService sysPermissionService;
	
	/**
	 * 列表页面
	 * 
	 * @param request
	 * @return
	 */
	@SysLogAn("访问：系统管理-权限菜单管理")
	@RequestMapping()
	public String index(HttpServletRequest request) {
		return "system/sysPermission/sysPermission_view";
	}
	
	/**
	 * 增加
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/add")
	public String add(HttpServletRequest request) {
		List<SysPermission> list = sysPermissionService.selectAll();
		request.setAttribute("list", list);
		request.setAttribute("type", "添加");
		return "system/sysPermission/sysPermission_add";
	}
	
	/** 
	* @Title: save 
	* @Description: save方法
	* @throws 
	*/ 
	
	@RequestMapping(value="/save")
	public String save(SysPermission sysPermission){
		if(StringUtils.isBlank(sysPermission.getId())){
			if(StringUtils.isBlank(sysPermission.getMenuLevel())){
				sysPermission.setMenuLevel(BigDecimal.valueOf(1));
			}
			sysPermission.setId(StringUtils.createUUID());
			sysPermissionService.saveSysPermission(sysPermission);
			sysLogService.add(request, "系统管理-权限菜单管理-新增");
		}else {
			sysPermissionService.updatePermissionById(sysPermission);
			sysLogService.add(request, "系统管理-权限菜单管理-修改");
		}
		return "redirect:/sysPermission.shtml";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public LayPage<SysPermission> list(HttpServletRequest request){
		
		LayPage<SysPermission> page = sysPermissionService.pageList(request);
		return page;
	}

	@SysLogAn("系统管理-权限菜单管理-删除")
	@RequestMapping("/del")
	public void list(@RequestParam("id")String id){
		
		sysPermissionService.deleteById(id);
	}

	@SysLogAn("分配权限")
	@RequestMapping("/savePermission")
	@ResponseBody
	public LayEntity savePermission(HttpServletRequest request){
		LayEntity layEntity = new LayEntity();
		String roleId = request.getParameter("roleId");
		String permissionId = request.getParameter("permissionId");
		String[] ids = StringUtil.split(permissionId,",");
		sysPermissionService.deleteRolePermission(roleId);
		for(String permissId:ids){
			sysPermissionService.saveRolePermission(roleId,permissId);
		}
		layEntity.setCode(Constant.SUCCESS_CODE);
		layEntity.setMsg(Constant.SUCCESS);
		return layEntity;
	}
	
	@RequestMapping("/getTree")
	@ResponseBody
	public Map getTree(HttpServletRequest request,@RequestParam("roleId") String roleId){
		Map<String, List> map = new HashMap<String, List>();
		List<SysPermission> sysPermissions = sysPermissionService.selectAll();
		map.put("sysPermissions", sysPermissions);
		List<SysPermission> roleSysPermissions = sysPermissionService.selectRolePermission(roleId);
		map.put("roleSysPermissions", roleSysPermissions);
		return map;
	}
	
	/**
	 * 修改
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/edit")
	public String edit(HttpServletRequest request) {
		List<SysPermission> list = sysPermissionService.selectAll();
		request.setAttribute("list", list);
		request.setAttribute("type", "编辑");
		String id = request.getParameter("id");
		SysPermission sysPermission  = sysPermissionService.selectById(id);
		request.setAttribute("sysPermission", sysPermission);
		return "system/sysPermission/sysPermission_add";
	}
	
	/**
	 * 详情
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/detail")
	public String detail(HttpServletRequest request) {
		List<SysPermission> list = sysPermissionService.selectAll();
		request.setAttribute("list", list);
		request.setAttribute("type", "详情");
		String id = request.getParameter("id");
		SysPermission sysPermission  = sysPermissionService.selectById(id);
		request.setAttribute("sysPermission", sysPermission);
		return "system/sysPermission/sysPermission_add";
	}

}
