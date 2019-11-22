package com.dhc.fastersoft.controller.system;

import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.controller.BaseController;
import org.activiti.engine.IdentityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dhc.fastersoft.common.Constant;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.store.StoreEnterpriseService;
import com.dhc.fastersoft.service.system.SysRoleService;
import com.dhc.fastersoft.service.system.SysUserService;
import com.dhc.fastersoft.utils.LayEntity;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.utils.StringUtils;

@Controller
@RequestMapping("/sysUser")
public class SysUserController extends BaseController{
	
	@Autowired
	private SysUserService sysUserService;
	
	@Autowired	  
	IdentityService identityService;
	
	@Autowired
	StoreEnterpriseService storeEnterpriseService;
	
	@Autowired	  
	private SysRoleService sysRoleService;
	
	/**
	 * 列表页面
	 * 
	 * @param
	 * @return
	 */
	@SysLogAn("访问：系统管理-用户管理")
	@RequestMapping()
	public String index(){
		return "system/sysUser/sysUser_view";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public LayPage<SysUser> list(HttpServletRequest request){
		
		LayPage<SysUser> page = sysUserService.pageList(request);

		return page;
	}
	
	/**
	 * 增加
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/add")
	public String add(Model model,HttpServletRequest request) {
		request.setAttribute("type", "添加");
		
		model.addAttribute("enterPrise", storeEnterpriseService.getAllEnterprise());
		
		return "system/sysUser/sysUser_add";
	}
	
	/** 
	* @Title: save 
	* @Description: save方法
	* @throws 
	*/ 
	
	@RequestMapping(value="/save")
	public String save(SysUser sysUser){
		LayEntity layEntity = new LayEntity();
		if(StringUtils.isNotBlank(sysUser.getId())){
			sysUserService.updateByPrimaryKeySelective(sysUser);
			sysLogService.add(request, "系统管理-用户管理-修改");
			return "redirect:/sysUser.shtml";
		}else {
			String userId = StringUtils.createUUID();
			sysUser.setId(userId);
			
			SysUser boolUser = sysUserService.selectByAccount(sysUser.getAccount());
			if(StringUtils.isNotBlank(boolUser)){
				layEntity.setCode(Constant.FAIL_CODE);
				layEntity.setMsg("账号已存在");
				return "common/user_fail";
			}
			sysUser.setCompany(sysUser.getCompany().trim());;
			sysUser.setNote("本系统创建");
			sysUser.setStatus(BigDecimal.valueOf(Constant.SUCCESS_CODE));
			sysUserService.createSysUser(sysUser);
			sysLogService.add(request, "系统管理-用户管理-新增");

			/*User user = identityService.newUser(userId);
			user.setFirstName(sysUser.getName());
			user.setPassword(sysUser.getPassword());*/
			//增加个人信息
			/*identityService.setUserInfo(user.getId(),"groupId", groupId);*/
			/*identityService.saveUser(user);*/
			
			return "redirect:/sysUser.shtml";
		}
		
	}
	
	@RequestMapping("/validateAccount")
	@ResponseBody
	public LayEntity validateAccount(HttpServletRequest request){
		LayEntity layEntity = new LayEntity();
		String account = request.getParameter("account");
		SysUser boolUser = sysUserService.selectByAccount(account);
		if(StringUtils.isNotBlank(boolUser)){
			layEntity.setCode(Constant.FAIL_CODE);
			layEntity.setMsg("账号已存在");
			return layEntity;
		}else {
			layEntity.setCode(Constant.SUCCESS_CODE);
			return layEntity;
		}
	}
	
	@RequestMapping(value="createUsers")
	public LayEntity add(HttpServletRequest request,SysUser sysUser){
		LayEntity layEntity = new LayEntity();
		
		SysUser boolUser = sysUserService.selectByAccount(sysUser.getAccount());
		
		if(StringUtils.isBlank(boolUser)){
			layEntity.setCode(Constant.FAIL_CODE);
			layEntity.setMsg("账号已存在");
			return layEntity;
		}
		String userId = StringUtils.createUUID();
		
		String groupId = request.getParameter("groupId");
		//系统数据库增加User
		sysUser.setId(userId);
		sysUserService.createSysUser(sysUser);
		//工作流中增加user
		//增加个人信息
		/*identityService.setUserInfo(user.getId(),"groupId", groupId);*/
/*		User user = identityService.newUser(userId);
		identityService.saveUser(user);
		identityService.createMembership(user.getId(),groupId);*/
		layEntity.setCode(Constant.SUCCESS_CODE);
		layEntity.setMsg(Constant.SUCCESS);
		return layEntity;
	}

	@SysLogAn("系统管理-用户管理-分配角色")
	@RequestMapping(value="saveUserRole")
	public String saveUserRole(HttpServletRequest request){
		String[] roleIds =  request.getParameterValues("roleId"); 
		String userId = request.getParameter("userId");
		/*Set<String> roles = sysRoleService.findRoleIdByUserId(userId);*/
		sysUserService.deleteUserRole(userId);
		for (String roleid : roleIds) {		
/*					try {
						identityService.deleteMembership(userId, roleid);
						identityService.createMembership(userId,roleid);
					} catch (Exception e) {					
						e.printStackTrace();
					} 工作流关联*/
				sysUserService.saveUserRole(roleid,userId);
		}
		
		
		return "redirect:/sysUser.shtml";
	}

	@SysLogAn("系统管理-用户管理-删除")
	@RequestMapping("/del")
	public void list(@RequestParam("id")String id){
		
		sysUserService.deleteById(id);
	}
	
	/**
	 * 修改
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/edit")
	public String edit(Model model,HttpServletRequest request) {
		request.setAttribute("type", "编辑");
		String id = request.getParameter("id");
		request.setAttribute("enterPrise", storeEnterpriseService.getAllEnterprise());
		SysUser sysUser  = sysUserService.selectById(id);
		request.setAttribute("sysUser", sysUser);
		if(sysUser.getEnterPriseId()==null){
			sysUser.setEnterPriseId("");
		}
		model.addAttribute("enterPrise", storeEnterpriseService.getAllEnterprise());
		return "system/sysUser/sysUser_add";
	}
	
	/**
	 * 详情
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/detail")
	public String detail(Model model,HttpServletRequest request) {
		request.setAttribute("type", "详情");
		String id = request.getParameter("id");
		SysUser sysUser  = sysUserService.selectById(id);
		request.setAttribute("sysUser", sysUser);
		model.addAttribute("enterPrise", storeEnterpriseService.getAllEnterprise());
		return "system/sysUser/sysUser_add";
	}
}
