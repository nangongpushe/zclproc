package com.dhc.fastersoft.common;

import java.lang.reflect.Method;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.system.SysLog;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.system.SysLogService;
import com.dhc.fastersoft.utils.RequestUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private SysLogService sysLogService;

	//不进行拦截的地址列表
	private List<String> uncheckUrls;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object obj) throws Exception {
		
		HttpServletRequest hreq = (HttpServletRequest) request;
		HttpServletResponse hres = (HttpServletResponse) response;
		
		String ip = request.getRemoteAddr();
		String requestUrl = request.getRequestURI();
		if(requestUrl.indexOf("/sign/login.shtml")>=0){
			return true;
		}

		if(uncheckUrls.contains(requestUrl)){
			return true;
		}else{
			String userId = request.getRemoteUser();
			userId = "admin"; //模拟登录
			SysUser token = TokenManager.getToken();
			if(token != null && StringUtils.isNotEmpty(token.getAccount())){
				HttpServletRequest httpRequest = ((HttpServletRequest)request);
				String logVal = getLogValue(obj, httpRequest);

				if(StringUtils.isNotEmpty(logVal)){
					sysLogService.add(request, logVal);
				}
			}
			if(userId!=null){
				return true;
			}
		}
		if (hreq.getHeader("x-requested-with") != null && hreq.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")){  
			hres.setStatus(911);//表示session timeout  
        }else{
        	//登录页面
        	String jumpUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/relogin.shtml";
        	response.sendRedirect(jumpUrl);
        }
        return false;
	}

	public List<String> getUncheckUrls() {
		return uncheckUrls;
	}

	public void setUncheckUrls(List<String> uncheckUrls) {
		this.uncheckUrls = uncheckUrls;
	}

	private String getLogValue(Object handler, HttpServletRequest request){
		if (handler instanceof HandlerMethod) {
			HandlerMethod hm = (HandlerMethod) handler;
			Class<?> clazz = hm.getBeanType();
			Method m = hm.getMethod();
			try {
				if (clazz != null && m != null) {
					boolean isClzAnnotation = clazz.isAnnotationPresent(SysLogAn.class);
					boolean isMethondAnnotation = m.isAnnotationPresent(SysLogAn.class);
					SysLogAn authority = null;
					// 如果方法和类声明中同时存在这个注解，那么方法中的会覆盖类中的设定。
					if (isMethondAnnotation) {
						authority = m.getAnnotation(SysLogAn.class);
					} else if (isClzAnnotation) {
						authority = clazz.getAnnotation(SysLogAn.class);
					}
					if (authority != null) {
						String value = authority.value();
						return value;
					}
				}
			} catch (Exception e) {
			}
		}
		return null;
	}

}
