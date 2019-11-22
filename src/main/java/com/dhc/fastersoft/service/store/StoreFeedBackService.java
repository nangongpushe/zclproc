package com.dhc.fastersoft.service.store;

import com.dhc.fastersoft.entity.store.StoreFeedBack;
import com.dhc.fastersoft.utils.LayPage;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;

@Component
public interface StoreFeedBackService {
	
	public int add(StoreFeedBack storeFeedBack);
//	public PageList pageQuery(HttpServletRequest request);
	public int update(StoreFeedBack storeFeedBack);
	public StoreFeedBack getStoreFeedBackByID(String id);
	LayPage<StoreFeedBack> list(HttpServletRequest request, String typeString);
	public int remove(String id);
	
}
