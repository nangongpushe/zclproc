package com.dhc.fastersoft.service.impl;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.util.WebUtils;

import com.dhc.fastersoft.common.page.PageList;
import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.ConsumablesDao;
import com.dhc.fastersoft.entity.Consumables;
import com.dhc.fastersoft.service.ConsumablesService;
import com.dhc.fastersoft.utils.LayPage;

/**
* @ClassName: ConsumablesServiceImpl
* @Description: 
* @author 张乐
* @date 2017年9月28日 下午4:40:10
 */
@Service("ConsumablesService")
public class ConsumablesServiceImpl implements ConsumablesService{
	
	@Autowired
	ConsumablesDao consumablesDao;
	
	
	@Override
	public LayPage<Consumables> list(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<Consumables> page=new LayPage<>();
        HashMap<String,String> maps = QueryUtil.pageQuery(request);
        maps.put("commodity", request.getParameter("commodity"));
		maps.put("storehouse", request.getParameter("storehouse"));
		String timeStart = request.getParameter("timeStart");
	    String timeEnd = request.getParameter("timeEnd");
	    maps.put("timeStart", timeStart);
	    maps.put("timeEnd", timeEnd);
	    if (!(TokenManager.getToken().getOriginCode() != null && TokenManager.getToken().getOriginCode().equals("CBL"))) {
			/*String storehouse = TokenManager.getToken().getShortName();
			maps.put("storehouse", storehouse);*/
			maps.put("warehouseId",TokenManager.getToken().getWareHouseId());
		}
		int count = consumablesDao.getRecordCount(maps);  

        if (count<=0) {
			return page;
		}
        
        List<Consumables> data= consumablesDao.pageQuery(maps);
        
        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
		return page;
		
	}
	
	 @Override
	public PageList pageQuery(HttpServletRequest request) {
		// TODO Auto-generated method stub
		// User user=(User) WebUtils.getSessionAttribute(request, "user");
		 	PageList page = new PageList();
	        HashMap<String,String> maps = QueryUtil.pageQuery(request);
			maps.put("commodity", request.getParameter("commodity"));
			maps.put("model", request.getParameter("model"));
			String timeStart = request.getParameter("timeStart");
		    String timeEnd = request.getParameter("timeEnd");
		    maps.put("timeStart", timeStart);
		    maps.put("timeEnd", timeEnd);
	       
			int allRow = consumablesDao.getRecordCount(maps);   			//System.out.println("allRow:"+allRow);
	        page.setCount(allRow);
	        if (allRow<=0) {
				return page;
			}
			page.setRecords(consumablesDao.pageQuery(maps));
			
			return page;
	}
	 
	 @Override
	public int add(Consumables consumables) throws Exception {
		// TODO Auto-generated method stub
		return consumablesDao.add(consumables);
	}
	 
	 @Override
	public int update(Consumables consumables) {
		// TODO Auto-generated method stub
		return consumablesDao.update(consumables);
	}
	 
	 @Override
	public Consumables getConsumablesByID(String id) {
		// TODO Auto-generated method stub
		return consumablesDao.getConsumablesById(id);
	}
	 
	 @Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return consumablesDao.remove(id);
	}
	 
	 @Override
	public int updateApply(Consumables consumables) {
		// TODO Auto-generated method stub
		return consumablesDao.updateApply(consumables);
	}
}
