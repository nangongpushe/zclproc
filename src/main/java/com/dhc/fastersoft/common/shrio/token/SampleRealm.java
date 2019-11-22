package com.dhc.fastersoft.common.shrio.token;

import java.util.Date;
import java.util.Set;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.service.system.SysPermissionService;
import com.dhc.fastersoft.service.system.SysRoleService;
import com.dhc.fastersoft.service.system.SysUserService;


/**
 * 
 * shiro 认证 + 授权   重写
 * zby
 * 
 */
public class SampleRealm extends AuthorizingRealm {

	@Autowired
	SysUserService sysUserService;
	@Autowired
	SysPermissionService sysPermissionService;
	@Autowired
	SysRoleService sysRoleService;
	@Autowired
	StorageWarehouseService storageWarehouseService;
	
	public SampleRealm() {
		super();
	}
	/**
	 *  认证信息，主要针对用户登录， 
	 */
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken authcToken) throws AuthenticationException {
		
		ShiroToken token = (ShiroToken) authcToken;
		SysUser user = sysUserService.login(token.getUsername(),token.getPswd());
		if(user.getOriginCode()==null){
			user.setOriginCode("");
		}
		StorageWarehouse storageWarehouse = storageWarehouseService.getStorageWarehouse(user.getOriginCode());
		if(storageWarehouse!=null&&!"".equals(storageWarehouse)){
			if(storageWarehouse.getWarehouseShort()!=null&&!"".equals(storageWarehouse.getWarehouseShort())){
				user.setShortName(storageWarehouse.getWarehouseShort());
			}
			user.setWareHouseId(storageWarehouse.getId());
		}

		if(user.getShortName()==null){
			user.setShortName("");
		}

	
		if(SysUser._0.equals(user.getStatus())){
			throw new DisabledAccountException("帐号已经禁止登录！");
		}else{
			//更新登录时间 last login time
			//user.setLastLoginTime(new Date());
			//sysUserService.updateByPrimaryKeySelective(user);
		}
		return new SimpleAuthenticationInfo(user,user.getPassword(), getName());
    }

	 /** 
     * 授权 
     */  
    @Override  
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {  
    	
    	String userId = TokenManager.getSysUserId();
		SimpleAuthorizationInfo info =  new SimpleAuthorizationInfo();
		//根据用户ID查询角色（role），放入到Authorization里。
		Set<String> roles = sysRoleService.findRoleTypeByUserId(userId);
		info.setRoles(roles);
		//根据用户ID查询权限（permission），放入到Authorization里。
		Set<String> permissions = sysPermissionService.findPermissionByUserId(userId);
		info.setStringPermissions(permissions);
        return info;  
    }  
    /**
     * 清空当前用户权限信息
     */
	public  void clearCachedAuthorizationInfo() {
		PrincipalCollection principalCollection = SecurityUtils.getSubject().getPrincipals();
		SimplePrincipalCollection principals = new SimplePrincipalCollection(
				principalCollection, getName());
		super.clearCachedAuthorizationInfo(principals);
	}
	/**
	 * 指定principalCollection 清除
	 */
	public void clearCachedAuthorizationInfo(PrincipalCollection principalCollection) {
		SimplePrincipalCollection principals = new SimplePrincipalCollection(
				principalCollection, getName());
		super.clearCachedAuthorizationInfo(principals);
	}
	
	public static void main(String[] args) {
		
		SysUser user = TokenManager.getToken();
		System.out.println(TokenManager.getToken());
		System.out.println(user);
	}
}
