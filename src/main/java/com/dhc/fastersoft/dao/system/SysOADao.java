package com.dhc.fastersoft.dao.system;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.system.SysFile;
import org.springframework.stereotype.Component;

@Component
public interface SysOADao {

	int updateStatus(HashMap<String, String> map);
}
