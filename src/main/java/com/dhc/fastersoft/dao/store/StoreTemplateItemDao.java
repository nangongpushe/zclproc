package com.dhc.fastersoft.dao.store;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.store.StoreTemplateItem;


public interface StoreTemplateItemDao {
	public List pageQuery(HashMap maps);
	public int add(StoreTemplateItem storeTemplateItem);
	public int update(StoreTemplateItem storeTemplateItem);
	public int getRecordCount(HashMap maps);	
	public List<StoreTemplateItem> getItemListByTemplateId(String templateId);
	public List<StoreTemplateItem> getOneClassList(String templateId);
	public List<StoreTemplateItem> getTwoClassList(HashMap maps);
	public List<StoreTemplateItem> getItemListByParentId(HashMap maps);
	public int remove(String templetId);
}
