package com.dhc.fastersoft.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.dhc.fastersoft.entity.QualityThird;
import com.dhc.fastersoft.entity.QualityThirdItem;

@Component
public interface QualityThirdItemService {

	List<QualityThirdItem> getByID(String id);

	int deleteItem(String id);

	int add(QualityThirdItem qtiItem);

	int count(String id);

	List<QualityThirdItem> queryByThirdId(List<String> thirdIds);
}
