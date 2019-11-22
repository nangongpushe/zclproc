package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dhc.fastersoft.entity.QualityTask;

public interface QualityTaskMapper {
    int insert(QualityTask record);

    int insertSelective(QualityTask record);

	int count(HashMap<String, String> map);

	List<QualityTask> list(HashMap<String, String> map);

	QualityTask getById(@Param("id")String id);

	int delete(@Param("id")String id);

	int add(QualityTask entity);

	int update(QualityTask entity);

	int check(HashMap<String, String> map);
}