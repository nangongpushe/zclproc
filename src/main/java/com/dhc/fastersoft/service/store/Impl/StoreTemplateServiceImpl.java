package com.dhc.fastersoft.service.store.Impl;

import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.dao.StoreSuperviseItemDao;
import com.dhc.fastersoft.entity.StoreSuperviseItem;
import com.dhc.fastersoft.entity.store.StoreTemplate;
import com.dhc.fastersoft.service.store.StoreTemplateService;
import com.dhc.fastersoft.utils.LayPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;

@Service("StoreTemplateService")
public class StoreTemplateServiceImpl implements StoreTemplateService {
	@Autowired
    com.dhc.fastersoft.dao.store.StoreTemplateDao StoreTemplateDao;
	@Autowired
    StoreSuperviseItemDao storeSuperviseItemDao;
	
	@Override
	public int add(StoreTemplate StoreTemplate) {
		// TODO Auto-generated method stub
		return StoreTemplateDao.add(StoreTemplate);
	}
	
	@Override
	public int update(StoreTemplate StoreTemplate) {
		// TODO Auto-generated method stub
		return StoreTemplateDao.update(StoreTemplate);
	}
	
	@Override
	public StoreTemplate getStoreTemplateByID(String id) {
		// TODO Auto-generated method stub
		return StoreTemplateDao.getStoreTemplateById(id);
	}
	
	@Override
	public LayPage<StoreTemplate> list(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<StoreTemplate> page=new LayPage<>();
        HashMap<String,String> maps = QueryUtil.pageQuery(request);
        maps.put("templetName", request.getParameter("templetName"));
        maps.put("type", request.getParameter("type"));
		
       
		int count = StoreTemplateDao.getRecordCount(maps);  

        if (count<=0) {
			return page;
		}
        
        List<StoreTemplate> data= StoreTemplateDao.pageQuery(maps);
        
        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
		return page;
	}
	
	@Override
	public LayPage<StoreSuperviseItem> getEnterpriseNamelist(HttpServletRequest request) {
		LayPage<StoreSuperviseItem> page=new LayPage<>();
        HashMap<String,String> maps = QueryUtil.pageQuery(request);
   
        try {
        	maps.put("warehouseName", URLDecoder.decode(request.getParameter("storehouse"), "UTF-8"));
		} catch (Exception e) {
			// TODO: handle exception
		}
       
		int count = storeSuperviseItemDao.getRecordCount(maps);  

        if (count<=0) {
			return page;
		}
        
        List<StoreSuperviseItem> data= storeSuperviseItemDao.pageQuery(maps);
        
        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
		return page;
	}
	
	@Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return StoreTemplateDao.remove(id);
	}
	
}
