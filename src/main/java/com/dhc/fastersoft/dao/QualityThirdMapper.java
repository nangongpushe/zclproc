package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.MapKey;
import org.apache.ibatis.annotations.Param;

import com.dhc.fastersoft.entity.QualityThird;

public interface QualityThirdMapper {

	QualityThird getById(@Param("id")String id);

	int delete(@Param("id")String id);

	int add(QualityThird entity);

	int update(QualityThird entity);

	int count(HashMap<String, String> map);

	List<QualityThird> list(HashMap<String, String> map);

	int countSampleNo(HashMap<String, String> map);
	
	@MapKey("sampleNo")
	Map<String,QualityThird> queryBySampleNo(List<String> sampleNoList);
}