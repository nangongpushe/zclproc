package com.dhc.fastersoft.service.store;

import com.dhc.fastersoft.entity.store.StoreTemplateItem;
import com.dhc.fastersoft.utils.LayPage;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;

@Component
public interface StoreTemplateItemService {
	public int add(StoreTemplateItem storeTemplateItem);
	public int update(StoreTemplateItem storeTemplateItem);
	public List<StoreTemplateItem> getItemListByTemplateId(String templateId);
	public LayPage<StoreTemplateItem> list(HttpServletRequest request);
	public List<StoreTemplateItem> getOneClassList(String templateId);
	public List<StoreTemplateItem> getTwoClassList(HashMap maps);
	public List<StoreTemplateItem> getItemListByParentId(String parentId, String templateId);

	public int remove(String id);
	
}
