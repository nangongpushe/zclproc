package com.dhc.fastersoft.service;



import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.dhc.fastersoft.entity.RotateBID;
import com.dhc.fastersoft.entity.RotateBIDPurchase;
import com.dhc.fastersoft.entity.RotateBIDSale;
import com.dhc.fastersoft.utils.LayPage;


@Component
public interface RotateBIDService {
	int save(RotateBID record);
	
	int update(RotateBID record);

	int remove(String id);
	
	int removeDetail(String id);
	
	RotateBID get(String id);
	
	List<RotateBID> list(HashMap<String, String> map);
	
	int count(HashMap<String, String> map);
	
	List<RotateBIDPurchase> listPurchase(String bidId);
	
	List<RotateBIDSale> listSale(String bidId);

	RotateBIDPurchase getSinglePurchase(HashMap<String, String> map);

	RotateBIDSale getSingleSale(HashMap<String, String> map);

	BigDecimal sumQuantityByBidId(Map<String,Object> map);


	BigDecimal sumSaleQuantityByBidId(Map<String,Object> map);
}
