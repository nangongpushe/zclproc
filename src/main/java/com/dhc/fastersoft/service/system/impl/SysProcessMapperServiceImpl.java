package com.dhc.fastersoft.service.system.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.dao.system.SysProcessMapperDao;
import com.dhc.fastersoft.entity.system.SysProcessMapper;
import com.dhc.fastersoft.service.system.SysProcessMapperService;

import java.util.HashMap;
import java.util.Map;

@Service("SysProcessMapper")
public class SysProcessMapperServiceImpl implements SysProcessMapperService {

	@Autowired
	private SysProcessMapperDao sysProcessMapperDao;
	
	@Override
	public void AddSysProcessMapper(SysProcessMapper mapper) {
		sysProcessMapperDao.AddSysProcessMapper(mapper);
	}

	@Override
	public SysProcessMapper GetSysProcessMapper(String processId) {
		HashMap<String, Object> map = new HashMap();
		map.put("processId", processId);
		return sysProcessMapperDao.GetSysProcessMapper(map);
	}

	@Override
	public void delete(Map<String, Object> map) {
		sysProcessMapperDao.delete(map);
	}
}
