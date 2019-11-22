package com.dhc.fastersoft.service;

import java.util.List;

import org.springframework.stereotype.Component;

import com.dhc.fastersoft.entity.QualityTempletItem;
@Component
public interface QualityTempletItemService {


	int add(QualityTempletItem qtiItem);

	List<QualityTempletItem> getByID(String id);

	int deleteItem(String id);

	int count(String id);
	
	void addByList(List<QualityTempletItem> data);

}
