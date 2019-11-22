package com.dhc.fastersoft.service.impl;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.common.page.PageList;
import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.dao.MaterialPurchaseDao;
import com.dhc.fastersoft.entity.MaterialPurchase;
import com.dhc.fastersoft.service.MaterialPurchaseService;
import com.dhc.fastersoft.utils.LayPage;

@Service
public class MaterialPurchaseServiceImpl implements MaterialPurchaseService{
	
	@Autowired
	MaterialPurchaseDao materialPurchaseDao;
	
	@Override
	public LayPage<MaterialPurchase> list(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<MaterialPurchase> page=new LayPage<>();
        HashMap<String,String> maps = QueryUtil.pageQuery(request);
        maps.put("purchaseDept", request.getParameter("purchaseDept"));
		String timeStart = request.getParameter("timeStart");
	    String timeEnd = request.getParameter("timeEnd");
	    maps.put("timeStart", timeStart);
	    maps.put("timeEnd", timeEnd);
		maps.put("originCode", TokenManager.getToken().getOriginCode());

		int count = materialPurchaseDao.getRecordCount(maps);  

        if (count<=0) {
			return page;
		}
        
        List<MaterialPurchase> data= materialPurchaseDao.pageQuery(maps);
        for (int i=0;i<data.size();i++){
			BigDecimal bd = new BigDecimal(data.get(i).getTotalAmount());
        	data.get(i).setTotalAmount2(""+bd.setScale(2, BigDecimal.ROUND_HALF_UP).toPlainString());
		}
        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
		return page;
		
	}
	
	
	 
	 @Override
	public int add(MaterialPurchase materialPurchase) {
		// TODO Auto-generated method stub
		return materialPurchaseDao.add(materialPurchase);
	}
	 
	 @Override
	public int update(MaterialPurchase materialPurchase) {
		// TODO Auto-generated method stub
		return materialPurchaseDao.update(materialPurchase);
	}
	 
	 @Override
	public MaterialPurchase getMaterialPurchaseByID(String id) {
		// TODO Auto-generated method stub
		 return materialPurchaseDao.getMaterialPurchaseById(id);
	}

	
	 
	 @Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return materialPurchaseDao.remove(id);
	}
	 
}
