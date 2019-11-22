package com.dhc.fastersoft.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.dhc.fastersoft.common.page.PageList;
import com.dhc.fastersoft.entity.MaterialPurchase;
import com.dhc.fastersoft.utils.LayPage;

@Component
public interface MaterialPurchaseService {
	
	public int add(MaterialPurchase materialPurchase);
//	public PageList pageQuery(HttpServletRequest request);
	public int update(MaterialPurchase materialPurchase);
	public MaterialPurchase getMaterialPurchaseByID(String id);
	LayPage<MaterialPurchase> list(HttpServletRequest request);
	public int remove(String id);
	
}
