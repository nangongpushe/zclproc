package com.dhc.fastersoft.service.store;

import com.dhc.fastersoft.entity.StoreSuperviseItem;
import com.dhc.fastersoft.entity.store.StoreTemplate;
import com.dhc.fastersoft.utils.LayPage;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;

@Component
public interface StoreTemplateService {
	public int add(StoreTemplate storeTemplate);
	public int update(StoreTemplate storeTemplate);
	public StoreTemplate getStoreTemplateByID(String id);
	public LayPage<StoreTemplate> list(HttpServletRequest request);
	public LayPage<StoreSuperviseItem> getEnterpriseNamelist(HttpServletRequest request) ;
	

	public int remove(String id);
	
}
