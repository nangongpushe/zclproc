package com.dhc.fastersoft.service.store.Impl;

import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.entity.store.StoreTemplateItem;
import com.dhc.fastersoft.service.store.StoreTemplateItemService;
import com.dhc.fastersoft.utils.LayPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;

@Service("StoreTemplateItemService")
public class StoreTemplateItemServiceImpl implements StoreTemplateItemService {
	@Autowired
    com.dhc.fastersoft.dao.store.StoreTemplateItemDao StoreTemplateItemDao;
	
	@Override
	public int add(StoreTemplateItem StoreTemplateItem) {
		// TODO Auto-generated method stub
		return StoreTemplateItemDao.add(StoreTemplateItem);
	}
	
	@Override
	public int update(StoreTemplateItem StoreTemplateItem) {
		// TODO Auto-generated method stub
		return StoreTemplateItemDao.update(StoreTemplateItem);
	}
	
	@Override
	public List<StoreTemplateItem> getItemListByTemplateId(String templateId) {
		// TODO Auto-generated method stub
		return StoreTemplateItemDao.getItemListByTemplateId(templateId);
	}
	
	
	@Override
	public LayPage<StoreTemplateItem> list(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<StoreTemplateItem> page=new LayPage<>();
        HashMap<String,String> maps = QueryUtil.pageQuery(request);

		int count = StoreTemplateItemDao.getRecordCount(maps);  

        if (count<=0) {
			return page;
		}
        
        List<StoreTemplateItem> data= StoreTemplateItemDao.pageQuery(maps);
        
        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
		return page;
	}
	
	
	@Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return StoreTemplateItemDao.remove(id);
	}
	
	@Override
	public List<StoreTemplateItem> getItemListByParentId(String parentId, String templateId) {
		// TODO Auto-generated method stub
		HashMap<String, Object> maps = new HashMap<String, Object>();
		maps.put("parentId", parentId);
		maps.put("templateId", templateId);
		return StoreTemplateItemDao.getItemListByParentId(maps);
	}
	
	@Override
	public List<StoreTemplateItem> getOneClassList(String templateId) {
		// TODO Auto-generated method stub
		return StoreTemplateItemDao.getOneClassList(templateId);
	}
	
	@Override
	public List<StoreTemplateItem> getTwoClassList(HashMap maps) {
		// TODO Auto-generated method stub
		return StoreTemplateItemDao.getTwoClassList(maps);
	}
}
