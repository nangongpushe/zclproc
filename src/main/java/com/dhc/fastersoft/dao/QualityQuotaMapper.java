package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dhc.fastersoft.entity.QualityQuota;
import org.springframework.stereotype.Component;

@Component
public interface QualityQuotaMapper {

	int count(HashMap<String, String> map);

	List<QualityQuota> list(HashMap<String, String> map);

	QualityQuota getById(@Param("id")String id);

	int delete(@Param("id")String id);

	int add(QualityQuota entity);

	int update(QualityQuota entity);

	int countCheck(HashMap<String, String> map);
	
	List<QualityQuota> listQualityQuota(HashMap<String, String> map);
	
	QualityQuota getQualityQuota(HashMap<String, String> map);

}