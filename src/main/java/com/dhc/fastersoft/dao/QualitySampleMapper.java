package com.dhc.fastersoft.dao;

import com.dhc.fastersoft.entity.QualitySample;
import org.apache.ibatis.annotations.Param;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface QualitySampleMapper {
    int insert(QualitySample record);

	int getRecordCount(HashMap<String, String> map);

	List pageQuery(HashMap<String, String> map);

	int update(QualitySample qs);

	QualitySample getQSById(@Param("id")String id);

	int delete(@Param("id")String id);

	int count(HashMap<String, String> map);

	List<QualitySample> list(HashMap<String, String> map);

	List<QualitySample> getInSampleList(Map<String, Object> map);
	List<QualitySample> getMessage(HashMap<String, Object> map);

	List<QualitySample> query(HashMap<String, String> map);
	
	List<QualitySample> query(Map<String, Object> map);

	int countCheck(HashMap<String, String> map);
	
	void updateSampleStatus(Map<String,String> map);
	
	String getQualityInfo(Map<String,Object> param);

	QualitySample getSampleInfo(Map<String,Object> param);
}