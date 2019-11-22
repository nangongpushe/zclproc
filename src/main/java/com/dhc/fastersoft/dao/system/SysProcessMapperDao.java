package com.dhc.fastersoft.dao.system;

import com.dhc.fastersoft.entity.system.SysProcessMapper;
import org.springframework.stereotype.Component;

import java.util.Map;

@Component
public interface SysProcessMapperDao {
	void AddSysProcessMapper(SysProcessMapper mapper);
	SysProcessMapper GetSysProcessMapper(Map<String, Object> map);
	void delete(Map<String, Object> map);

}
