package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.MaterialPurchaseDeatil;

public interface MaterialPurchaseDeatilDao {
	public List pageQuery(HashMap maps);
	public int add(MaterialPurchaseDeatil materialPurchaseDeatil);
	public int update(MaterialPurchaseDeatil materialPurchaseDeatil);
	public int getRecordCount(HashMap maps);	
	public List<MaterialPurchaseDeatil> getMaterialPurchaseDeatilById(String purchaseId);
	public int remove(String purchaseId);
}
