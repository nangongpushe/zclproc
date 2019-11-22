package com.dhc.fastersoft.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.MapKey;
import org.apache.ibatis.annotations.Param;

import com.dhc.fastersoft.entity.QualityThirdItem;

public interface QualityThirdItemMapper {

	List<QualityThirdItem> getById(@Param("id")String id);

	int delete(@Param("id")String id);

	int add(QualityThirdItem qtiItem);

	int count(@Param("id")String id);
	
	List<QualityThirdItem> queryByThirdId(List<String> thirdIds);
   
}