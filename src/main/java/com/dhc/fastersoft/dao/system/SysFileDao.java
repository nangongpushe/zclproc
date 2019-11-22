package com.dhc.fastersoft.dao.system;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dhc.fastersoft.entity.system.SysFile;

public interface SysFileDao {
    int deleteByPrimaryKey(String id);

    int insert(SysFile record);

    int insertSelective(SysFile record);

    SysFile selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(SysFile record);

    int updateByPrimaryKey(SysFile record);
    

     int deleteByGroupId(String groupId);
    
	 List<SysFile> getFilesByGroupId(String groupId);

	 void deleteByGroupIds(List<String> idList);


	int delete(@Param("id")String id);


	
}
