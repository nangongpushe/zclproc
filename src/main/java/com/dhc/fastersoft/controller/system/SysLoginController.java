package com.dhc.fastersoft.controller.system;

import com.dhc.fastersoft.common.shrio.controller.BaseController;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.system.SysUserService;
import com.dhc.fastersoft.util.PropertiesUtil;
import com.dhc.fastersoft.utils.LoggerUtils;
import com.dhc.fastersoft.utils.StringUtils;
import org.apache.http.client.ClientProtocolException;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.web.util.SavedRequest;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.Principal;
import java.util.Map;

//import org.apache.http.HttpEntity;
//import org.apache.http.ParseException;
//import org.apache.http.client.methods.CloseableHttpResponse;
//import org.apache.http.client.methods.HttpGet;
//import org.apache.http.impl.client.CloseableHttpClient;
//import org.apache.http.impl.client.HttpClients;
//import org.apache.http.util.EntityUtils;

@RequestMapping("sign")
@Controller
public class SysLoginController extends BaseController {

    @Resource
    SysUserService sysUserService;

    /**
     * 本系统登录跳转
     *
     * @return
     */
    @RequestMapping(value = "login")
    public ModelAndView login(HttpServletRequest request) {
/*		Principal principal = request.getUserPrincipal();
		if(StringUtils.isBlank(principal)){
			return new ModelAndView("system/login");
		}else {
			 SysUser sysUser =sysUserService.selectByAccount(principal.toString());
			 TokenManager.login(sysUser,false);
			 return new ModelAndView("redirect:/Home/Index.shtml");
		}*/
        return new ModelAndView("system/login");
    }

    /**
     * 本系统欢迎页面跳转
     *
     * @return
     */
    @RequestMapping(value = "welcome", method = RequestMethod.GET)
    public ModelAndView welcome() {

        return new ModelAndView("system/welcome");
    }

    /**
     * cas登录
     *
     * @return
     * @throws IOException
     * @throws ClientProtocolException
     */
    @RequestMapping(value = "caslogin")
    public String caslogin(HttpServletRequest request) {
        SysUser sysUser = new SysUser();
        Principal principal = request.getUserPrincipal();
        if (principal.getName().contains("com.dhc.fastersoft.entity.system.SysUser")) {
            sysUser = (SysUser) SecurityUtils.getSubject().getPrincipal();
        } else {
            sysUser = sysUserService.selectByAccount(principal.getName());
        }
        TokenManager.login(sysUser, false);

        return "redirect:/Home/Index.shtml";
    }

    @RequestMapping(value = "casSubmit")
    public String casSubmit(HttpServletRequest request) {
        Principal principal = request.getUserPrincipal();
		/*AttributePrincipal principal2 = (AttributePrincipal)request.getUserPrincipal();
		System.out.println(principal2);*/
        SysUser sysUser = new SysUser();
        if (principal.getName().contains("com.dhc.fastersoft.entity.system.SysUser")) {
            sysUser = (SysUser) SecurityUtils.getSubject().getPrincipal();
        } else {
            sysUser = sysUserService.selectByAccount(principal.getName());
        }
        TokenManager.login(sysUser, false);

        return "redirect:/Home/Index.shtml";
    }

    /**
     * 登录提交
     *
     * @param entity     登录的sysUser
     * @param rememberMe 是否记住
     * @param request    request，用来取登录之前Url地址，用来登录后跳转到没有登录之前的页面。
     * @return
     */
    @RequestMapping("submitLogin")
    @ResponseBody
    public Map<String, Object> submitLogin(SysUser entity, HttpServletRequest request) {
        String url = null;
        String rememberMe = request.getParameter("rememberMe");
        boolean flag = true;
        if (rememberMe == null || "false".equals(rememberMe)) {
            flag = false;
        }
        try {
            entity = TokenManager.login(entity, flag);
            request.getSession().setAttribute("user", entity);
            resultMap.put("status", 200);
            resultMap.put("message", "登录成功");
            /**
             * shiro 获取登录之前的地址
             */
            SavedRequest savedRequest = WebUtils.getSavedRequest(request);

            if (null != savedRequest) {
                url = savedRequest.getRequestUrl();
            }
            /**
             * 我们平常用的获取上一个请求的方式，在Session不一致的情况下是获取不到的
             * String url = (String) request.getAttribute(WebUtils.FORWARD_REQUEST_URI_ATTRIBUTE);
             */
            LoggerUtils.fmtDebug(getClass(), "获取登录之前的URL:[%s]", url);
            //如果登录之前没有地址，那么就跳转到首页。
            if (StringUtils.isBlank(url)) {
                url = request.getContextPath() + "/Home/Index.shtml";
            }
            //跳转地址
            resultMap.put("back_url", url);
            /**
             * 这里其实可以直接catch Exception，然后抛出 message即可，但是最好还是各种明细catch 好点。。
             */
        } catch (DisabledAccountException e) {
            resultMap.put("status", 500);
            resultMap.put("message", "帐号已经禁用。");
        } catch (Exception e) {
            resultMap.put("status", 500);
            resultMap.put("message", "帐号或密码错误");
        }

        return resultMap;
    }

    /**
     * 退出
     *
     * @return
     */
    @RequestMapping(value = "logout")
    public String logout(HttpServletRequest request, HttpSession session) {
        TokenManager.logout();
/*		System.out.println(request.getRemoteUser());
		System.out.println(request.getUserPrincipal());
		System.out.println(SecurityUtils.getSubject().getPrincipal());*/
        if (SecurityUtils.getSubject().getPrincipal() != null || request.getUserPrincipal() == null) {

            try {
                resultMap.put("status", 200);
            } catch (Exception e) {
                resultMap.put("status", 500);
                logger.error("errorMessage:" + e.getMessage());
                LoggerUtils.fmtError(getClass(), e, "退出出现错误，%s。", e.getMessage());
            }

            return "redirect:/sign/login.shtml";
        } else {
            SysUser sysUser = sysUserService.selectByAccount(request.getRemoteUser());
            TokenManager.login(sysUser, false);
            TokenManager.logout();

            String portalUrl = PropertiesUtil.getProperty("portal.url");

            return "redirect:" + portalUrl + "/cas/logout?service=" + portalUrl + "/portal/pageFront/";
        }

    }

    @RequestMapping(value = "unauthorized", method = RequestMethod.GET)
    public String unauthorized() {
        return "common/unauthorized";
    }

}
