package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dhc.fastersoft.entity.StorageInspect;

public interface StorageInspectMapper {
    int insert(StorageInspect record);

    int insertSelective(StorageInspect record);

	List<StorageInspect> list(HashMap<String, String> map);

	int add(StorageInspect entity);

	int update(StorageInspect entity);

	StorageInspect getById(@Param("id")String id);

	int delete(@Param("id")String id);

	int count(HashMap<String, String> map);
}