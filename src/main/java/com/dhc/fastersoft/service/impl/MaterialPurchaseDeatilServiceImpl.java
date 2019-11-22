package com.dhc.fastersoft.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.dao.MaterialPurchaseDeatilDao;
import com.dhc.fastersoft.entity.MaterialPurchaseDeatil;
import com.dhc.fastersoft.service.MaterialPurchaseDeatilService;

@Service("MaterialPurchaseDeatilService")
public class MaterialPurchaseDeatilServiceImpl implements MaterialPurchaseDeatilService{
	
	@Autowired
	MaterialPurchaseDeatilDao materialPurchaseDeatilDao;
	
	@Override
	public int add(MaterialPurchaseDeatil materialPurchaseDeatil) {
		// TODO Auto-generated method stub
		return materialPurchaseDeatilDao.add(materialPurchaseDeatil);
	}
	
	@Override
	public int update(MaterialPurchaseDeatil materialPurchaseDeatil) {
		// TODO Auto-generated method stub
		return materialPurchaseDeatilDao.update(materialPurchaseDeatil);
	}
	
	@Override
	public int remove(String purchaseId) {
		// TODO Auto-generated method stub
		return materialPurchaseDeatilDao.remove(purchaseId);
	}
	
	@Override
	public List<MaterialPurchaseDeatil> getMaterialPurchaseDeatilByID(String purchaseId) {
		// TODO Auto-generated method stub
		return materialPurchaseDeatilDao.getMaterialPurchaseDeatilById(purchaseId);
	}
}
