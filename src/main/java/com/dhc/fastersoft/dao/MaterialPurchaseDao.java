package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.MaterialPurchase;



public interface MaterialPurchaseDao {
	public List pageQuery(HashMap maps);
	public int add(MaterialPurchase materialPurchase);
	public int update(MaterialPurchase materialPurchase);
	public int getRecordCount(HashMap maps);	
	public MaterialPurchase getMaterialPurchaseById(String id);
	public int remove(String id);
}
