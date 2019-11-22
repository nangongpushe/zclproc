package com.dhc.fastersoft.service;

import java.util.List;

import org.springframework.stereotype.Component;

import com.dhc.fastersoft.entity.QualityQuotaItem;

@Component
public interface QualityQuotaItemService {

	List<QualityQuotaItem> getByID(String id);

	int deleteItem(String id);

	int add(QualityQuotaItem qtiItem);

	int count(String id);

}
