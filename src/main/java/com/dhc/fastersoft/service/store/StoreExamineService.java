package com.dhc.fastersoft.service.store;

import com.dhc.fastersoft.entity.store.StoreExamine;
import com.dhc.fastersoft.utils.LayPage;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;

@Component
public interface StoreExamineService {
	public int add(StoreExamine StoreExamine);
	public int update(StoreExamine StoreExamine);
	public StoreExamine getStoreExamineByID(String id);
	public LayPage<StoreExamine> list(HttpServletRequest request, String type);
	

	public int remove(String id);
	
}
