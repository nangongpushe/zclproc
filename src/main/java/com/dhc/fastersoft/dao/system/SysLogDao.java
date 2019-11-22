package com.dhc.fastersoft.dao.system;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.system.SysLog;
import org.springframework.stereotype.Component;

@Component
public interface SysLogDao {
	
	//分页方法
	List<SysLog> pageQuery(HashMap<String, String> maps);
	int getRecordCount(HashMap<String, String> maps);
	
    int deleteByPrimaryKey(String logId);

    int insert(SysLog record);

    int insertSelective(SysLog record);

    SysLog selectByPrimaryKey(String logId);

    int updateByPrimaryKeySelective(SysLog record);

    int updateByPrimaryKey(SysLog record);
}