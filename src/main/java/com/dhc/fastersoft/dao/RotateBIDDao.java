package com.dhc.fastersoft.dao;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.dhc.fastersoft.entity.RotateBID;
import com.dhc.fastersoft.entity.RotateBIDPurchase;
import com.dhc.fastersoft.entity.RotateBIDSale;


public interface RotateBIDDao {
	
	int save(RotateBID record);
	
	int update(RotateBID record);

	int remove(String id);
	
	int removeDetail(String id);
	
	RotateBID get(String id);
	
	RotateBIDPurchase getSinglePurchase(HashMap<String, String> map);
	
	RotateBIDSale getSingleSale(HashMap<String, String> map);
	
	int count(HashMap<String, String> maps);

	List<RotateBID> list(HashMap<String, String> map);
	
	List<RotateBIDPurchase> listPurchase(String id);
	
	List<RotateBIDSale> listSale(String id);

	BigDecimal sumQuantityByBidId(Map<String,Object> map);

	BigDecimal sumSaleQuantityByBidId(Map<String,Object> map);
}
