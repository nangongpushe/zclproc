package com.dhc.fastersoft.service.store;

import com.dhc.fastersoft.entity.store.StoreExamineItem;
import org.springframework.stereotype.Component;

import java.util.List;


@Component
public interface StoreExamineItemService {
	public int add(StoreExamineItem StoreExamineItem);
	public int update(StoreExamineItem StoreExamineItem);
	public StoreExamineItem getStoreExamineItemByID(String id);
	public List<StoreExamineItem> getItemListByExamineId(String examineId);
	public int remove(String examineId);
	public List<StoreExamineItem> getItemListByParentId(String parentId, String examineId);
	
}
