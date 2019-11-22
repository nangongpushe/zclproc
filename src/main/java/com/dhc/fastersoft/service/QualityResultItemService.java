package com.dhc.fastersoft.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.dhc.fastersoft.entity.QualityQuotaItem;
import com.dhc.fastersoft.entity.QualityResult;
import com.dhc.fastersoft.entity.QualityResultItem;
import com.dhc.fastersoft.utils.LayPage;

@Component
public interface QualityResultItemService {

	int deleteItem(@Param("id")String id);

	int add(QualityResultItem qtiItem);

	List<QualityResultItem> getByID(@Param("id")String id);

	LayPage<QualityResultItem> listCon(String ids);

	int update(QualityResultItem qtiItem);

	int count(String id);

	int countItemName(QualityResultItem qtiItem);
	
	List<QualityResultItem> queryByResultId(List<String> resultIds);
}
