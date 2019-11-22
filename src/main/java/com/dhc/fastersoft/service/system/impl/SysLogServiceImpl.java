package com.dhc.fastersoft.service.system.impl;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.utils.RequestUtil;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.dao.system.SysLogDao;
import com.dhc.fastersoft.entity.system.SysLog;
import com.dhc.fastersoft.service.system.SysLogService;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.utils.StringUtils;

@Service("sysLogService")
public class SysLogServiceImpl implements SysLogService{
	
	@Resource
	private SysLogDao sysLogDao;

	@Override
	public LayPage<SysLog> pageList(HttpServletRequest request) {
		LayPage<SysLog> page = new LayPage<SysLog>();

        HashMap<String,String> map = QueryUtil.pageHashMap(request);
        
        String clientIp = request.getParameter("key[clientIp]");
        map.put("clientIp", clientIp);
        map.put("userName", request.getParameter("key[userName]"));
        map.put("description", request.getParameter("key[description]"));
        map.put("startTime", request.getParameter("key[startTime]"));
        map.put("endTime", request.getParameter("key[endTime]"));

        int count = sysLogDao.getRecordCount(map);    //总记录数
		page.setCode(0);
		page.setCount(count);
        if (count<=0) {
        	page.setMsg("没有查询到数据");
			return page;
		}
        page.setData(sysLogDao.pageQuery(map));
        page.setMsg("succes");
		return page;
	}

	@Override
	public int add(SysLog sysLog) {
		sysLog.setLogId(StringUtils.createUUID());
		return sysLogDao.insert(sysLog);
	}

	@Override
	public int add(HttpServletRequest request, String log) {
		SysLog sysLog = new SysLog();
		sysLog.setDescription(log);
		sysLog.setUrl(request.getRequestURI());
		sysLog.setUserId(TokenManager.getSysUserId());
		sysLog.setClientIp(RequestUtil.getRemoteHost(request));
		//获取请求参数
		String queryString = ((HttpServletRequest) request).getQueryString();
		sysLog.setParameter(queryString);
		return add(sysLog);
	}

}
