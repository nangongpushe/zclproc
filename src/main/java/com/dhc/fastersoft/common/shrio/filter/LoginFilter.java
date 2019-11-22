package com.dhc.fastersoft.common.shrio.filter;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.shiro.web.filter.AccessControlFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;

import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.system.SysLogService;
import com.dhc.fastersoft.service.system.SysPermissionService;
import com.dhc.fastersoft.utils.LoggerUtils;
/**
* @ClassName: LoginFilter
* @Description: 登录拦截器
* @author zby
* @date 2017年9月29日 
* 
*/

public class LoginFilter  extends AccessControlFilter {
	
	@Autowired
	private SysLogService sysLogService;
	@Autowired
	private SysPermissionService sysPermissionService;
	@Autowired
	private ApplicationContext applicationContext;
	
	final static Class<LoginFilter> CLASS = LoginFilter.class;
	@Override
	protected boolean isAccessAllowed(ServletRequest request,
			ServletResponse response, Object mappedValue) throws Exception {
		
		SysUser token = TokenManager.getToken();
		
		if(null != token || isLoginRequest(request, response)){// && isEnabled()
//			if(!ShiroFilterUtils.isAjax(request)) {
//			SysLog sysLog = new SysLog();
//			HttpServletRequest httpRequest = ((HttpServletRequest)request);
//			String url = httpRequest.getRequestURI();
//
//			if(url.contains("/Home/Index.shtml")){
//				sysLog.setUrl("登录首页");
//			}else {
//				url = url.replace("/zclproc/", "");	//去掉项目名  防止域名代理
//				SysPermission sysPermission = sysPermissionService.selectByUrl(url);
//				if(sysPermission!=null){
//					sysLog.setUrl("访问:"+sysPermission.getName());
//				}else {
//					sysLog.setUrl("访问:"+url);
//				}
//			}
//			sysLog.setUserId(TokenManager.getSysUserId());
//			sysLog.setClientIp(RequestUtil.getRemoteHost(httpRequest));
//			//获取请求参数
//			 Map<String, String[]> params = request.getParameterMap();
//		        String queryString = "";
//		        for (String key : params.keySet()) {
//		            String[] values = params.get(key);
//		            for (int i = 0; i < values.length; i++) {
//		                String value = values[i];
//		                queryString += key + "=" + value + "&";
//		            }
//		        }
///*		        // 去掉最后一个空格
//		        queryString = queryString.substring(0, queryString.length() - 1);*/
//			sysLog.setParameter("");
//			sysLog.setPermissions(mappedValue+"");
//			sysLogService.add(sysLog);
//			}
            return Boolean.TRUE;
        } 
		if (ShiroFilterUtils.isAjax(request)) {// ajax请求
			Map<String,String> resultMap = new HashMap<String, String>();
			LoggerUtils.debug(getClass(), "当前用户没有登录，并且是Ajax请求！");
			resultMap.put("login_status", "300");
			resultMap.put("message", "\u5F53\u524D\u7528\u6237\u6CA1\u6709\u767B\u5F55\uFF01");//当前用户没有登录！
			ShiroFilterUtils.out(response, resultMap);
		}
		return Boolean.FALSE ;
            
	}

	@Override
	protected boolean onAccessDenied(ServletRequest request, ServletResponse response)
			throws Exception {
		//保存Request和Response 到登录后的链接
		saveRequestAndRedirectToLogin(request, response);
		return Boolean.FALSE ;
	}
	

}
