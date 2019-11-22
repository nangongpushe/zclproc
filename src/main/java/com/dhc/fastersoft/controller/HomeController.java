package com.dhc.fastersoft.controller;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.common.SysLogAn;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.dhc.fastersoft.service.system.SysPermissionService;

/**
 * 测试类
 * 
 * @author Canbol
 * @date 2017年9月20日 上午10:25:23
 */
@RequestMapping("/Home")
@Controller
public class HomeController {
	
	@Autowired
	SysPermissionService sysPermissionService;

	private static Logger log = Logger.getLogger(HomeController.class);

	/**
	 * 主界面
	 * 
	 */
	@SysLogAn(" 访问：首页")
	@RequestMapping("/Index")
	public String index(HttpServletRequest request) {
		return "home/sys_main";
	}
	
	/**
	 * 主页欢迎页
	 * 
	 */
	@RequestMapping("/welcome")
	public String welcome(HttpServletRequest request) {

		return "home/homeIndex";
	}


}
