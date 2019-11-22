package com.dhc.fastersoft.service.system;

import com.dhc.fastersoft.entity.system.SysProcessMapper;

import java.util.Map;

public interface SysProcessMapperService {
	void AddSysProcessMapper(SysProcessMapper mapper);
	SysProcessMapper GetSysProcessMapper(String processId);
	void delete(Map<String, Object> map);
}
