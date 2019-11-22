package com.dhc.fastersoft.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Component;

import com.dhc.fastersoft.entity.MaterialPurchaseDeatil;

@Component
public interface MaterialPurchaseDeatilService {
	
	public int add(MaterialPurchaseDeatil materialPurchaseDeatil);
	public int update(MaterialPurchaseDeatil materialPurchaseDeatil);
	public List<MaterialPurchaseDeatil> getMaterialPurchaseDeatilByID(String purchaseId);
	public int remove(String purchaseId);
}
