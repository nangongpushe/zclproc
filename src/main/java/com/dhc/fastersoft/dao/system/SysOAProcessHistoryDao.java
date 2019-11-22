package com.dhc.fastersoft.dao.system;

import com.dhc.fastersoft.entity.system.SysOAProcessHistory;
import org.springframework.stereotype.Component;

@Component
public interface SysOAProcessHistoryDao {
	void AddLog(SysOAProcessHistory oaProcessHistory);
}
