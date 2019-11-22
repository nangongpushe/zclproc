package com.dhc.fastersoft.service.impl;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.RotateBIDDao;
import com.dhc.fastersoft.entity.RotateBID;
import com.dhc.fastersoft.entity.RotateBIDPurchase;
import com.dhc.fastersoft.entity.RotateBIDSale;
import com.dhc.fastersoft.entity.RotatePlan;
import com.dhc.fastersoft.service.RotateBIDService;
import com.dhc.fastersoft.utils.DateUtil;
import com.dhc.fastersoft.utils.LayPage;
@Service("rotateBIDService")
public class RotateBIDServiceImpl implements RotateBIDService {
	@Autowired
	private RotateBIDDao dao;

	@Override
	public int save(RotateBID record) {
		// TODO Auto-generated method stub
		record.setId(UUID.randomUUID().toString().replaceAll("-", ""));
		BigDecimal total= new BigDecimal(0);
		if("招标采购".equals(record.getBidType())) {
			List<RotateBIDPurchase> purchaseList=record.getPurchaseList();
			for(RotateBIDPurchase purchase:purchaseList) {
				purchase.setId(UUID.randomUUID().toString().replaceAll("-", ""));
				total = total.add(purchase.getQuantity());
			}
		}else {
			List<RotateBIDSale> saleList=record.getSaleList();
			for(RotateBIDSale sale:saleList) {
				sale.setId(UUID.randomUUID().toString().replaceAll("-", ""));
				total= total.add(sale.getTotal());
			}
		}
		record.setTotal(total);
		record.setCreateDate(new Date());
//		record.setCreator(TokenManager.getToken().getName());
		return dao.save(record);
	}

	@Override
	public int update(RotateBID record) {
		// TODO Auto-generated method stub
		BigDecimal total = new BigDecimal(0);
		if("招标采购".equals(record.getBidType())) {
			List<RotateBIDPurchase> purchaseList=record.getPurchaseList();
			for(RotateBIDPurchase purchase:purchaseList) {
				if(null==purchase.getId()||"".equals(purchase.getId()))
					purchase.setId(UUID.randomUUID().toString().replaceAll("-", ""));
				total = total.add(purchase.getQuantity());
			}
		}else {
			List<RotateBIDSale> saleList=record.getSaleList();
			for(RotateBIDSale sale:saleList) {
				if(null==sale.getId()||"".equals(sale.getId()))
					sale.setId(UUID.randomUUID().toString().replaceAll("-", ""));
				total= total.add(sale.getTotal());
			}
		}
		record.setTotal(total);
		record.setModifyDate(new Date());
//		record.setModifier(TokenManager.getToken().getName());
		return dao.update(record);
	}

	@Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int removeDetail(String id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public RotateBID get(String id) {
		// TODO Auto-generated method stub
		RotateBID rotateBID=dao.get(id);
		
		if("招标采购".equals(rotateBID.getBidType())) {
			List<RotateBIDPurchase> purchaseList=dao.listPurchase(id);
			rotateBID.setPurchaseList(purchaseList);
		}else {
			List<RotateBIDSale> saleList=dao.listSale(id);
			rotateBID.setSaleList(saleList);
		}

		return rotateBID;
	}

	@Override
	public List<RotateBID> list(HashMap<String, String> map) {
		// TODO Auto-generated method stub
        
        List<RotateBID> data= dao.list(map);
		return data;
	}

	@Override
	public RotateBIDPurchase getSinglePurchase(HashMap<String, String> map) {
		return dao.getSinglePurchase(map);
	}

	@Override
	public RotateBIDSale getSingleSale(HashMap<String, String> map) {
		return dao.getSingleSale(map);
	}

	@Override
	public int count(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return dao.count(map);
	}

	@Override
	public List<RotateBIDPurchase> listPurchase(String bidId) {
		// TODO Auto-generated method stub
		return dao.listPurchase(bidId);
	}

	@Override
	public List<RotateBIDSale> listSale(String bidId) {
		// TODO Auto-generated method stub
		return dao.listSale(bidId);
	}
	@Override
	public BigDecimal sumQuantityByBidId(Map<String,Object> map){
		BigDecimal sumQuantity = dao.sumQuantityByBidId(map);
		return sumQuantity;
	}
	@Override
	public BigDecimal sumSaleQuantityByBidId(Map<String,Object> map){
		BigDecimal sumQuantity = dao.sumSaleQuantityByBidId(map);
		return sumQuantity;
	}
}
