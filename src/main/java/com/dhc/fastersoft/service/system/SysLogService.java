package com.dhc.fastersoft.service.system;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.entity.system.SysLog;
import com.dhc.fastersoft.utils.LayPage;

public interface SysLogService {
	
	LayPage<SysLog> pageList(HttpServletRequest request);
	
	int add(SysLog sysLog);

    int add(HttpServletRequest request, String log);
}
