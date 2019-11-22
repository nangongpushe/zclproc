package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dhc.fastersoft.entity.QualityQuotaItem;
import com.dhc.fastersoft.entity.QualityResult;
import com.dhc.fastersoft.entity.QualityResultItem;

public interface QualityResultItemMapper {

	int delete(@Param("id")String id);

	int add(QualityResultItem qtiItem);

	List<QualityResultItem> getById(@Param("id")String id);

	List<QualityResultItem> listCon(HashMap<String, String> map);

	int count(HashMap<String, String> map);

	int update(QualityResultItem qtiItem);

	int countNum(@Param("id")String id);

	int countItemName(QualityResultItem qtiItem);
	
	List<QualityResultItem> queryByResultId(List<String> resultIds);
}