package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dhc.fastersoft.entity.QualityQuotaItem;
import org.springframework.stereotype.Component;

@Component
public interface QualityQuotaItemMapper {

	List<QualityQuotaItem> getById(@Param("id")String id);

	int delete(@Param("id")String id);

	int add(QualityQuotaItem qtiItem);

	List<QualityQuotaItem> listCon(HashMap<String, String> map);

	int count(@Param("id")String id);

}