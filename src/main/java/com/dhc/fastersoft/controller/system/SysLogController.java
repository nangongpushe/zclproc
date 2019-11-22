package com.dhc.fastersoft.controller.system;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.common.SysLogAn;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dhc.fastersoft.entity.system.SysLog;
import com.dhc.fastersoft.service.system.SysLogService;
import com.dhc.fastersoft.utils.LayPage;

@Controller
@RequestMapping(value="/sysLog")
public class SysLogController {
	
	@Autowired
	private SysLogService SysLogService;

	/**
	 * 列表页面
	 * 
	 * @param request
	 * @return
	 */
	@SysLogAn("访问：系统管理-系统日志")
	@RequestMapping()
	public String index() {
		return "system/sysLog/sysLog_view";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public LayPage<SysLog> list(HttpServletRequest request){
		
		LayPage<SysLog> page = SysLogService.pageList(request);
		return page;
	}
}
