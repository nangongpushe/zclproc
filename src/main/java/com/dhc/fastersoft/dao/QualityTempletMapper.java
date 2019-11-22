package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.dhc.fastersoft.entity.QualityTemplet;

public interface QualityTempletMapper {


	int getRecordCount(HashMap<String, String> map);

	List pageQuery(HashMap<String, String> map);

	int add(QualityTemplet entity);

	int update(QualityTemplet qt);

	int count(HashMap<String, String> map);

	List<QualityTemplet> list(HashMap<String, String> map);

	QualityTemplet getById(@Param("id")String id);

	int delete(@Param("id")String id);

	List<QualityTemplet> listChoice(HashMap<String, String> map);

	int countCheck(HashMap<String, String> map);


	List<QualityTemplet> getTemplateByNo(Map<String, Object> map);

}