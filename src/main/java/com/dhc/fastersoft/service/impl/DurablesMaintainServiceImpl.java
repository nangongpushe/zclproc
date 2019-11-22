package com.dhc.fastersoft.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.common.page.PageList;
import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.dao.DurablesMaintainDao;
import com.dhc.fastersoft.entity.Durables;
import com.dhc.fastersoft.entity.DurablesMaintain;
import com.dhc.fastersoft.service.DurablesMaintainService;
import com.dhc.fastersoft.utils.LayPage;

@Service("DurablesMaintainService")
public class DurablesMaintainServiceImpl implements DurablesMaintainService{

		@Autowired
		DurablesMaintainDao  durablesMaintainDao;
		
		@Override
		public LayPage<DurablesMaintain> list(HttpServletRequest request) {
			// TODO Auto-generated method stub
			LayPage<DurablesMaintain> page=new LayPage<>();
	        HashMap<String,String> maps = QueryUtil.pageQuery(request);
	        maps.put("commodity", request.getParameter("commodity"));
			maps.put("type", request.getParameter("type"));
			maps.put("encode", request.getParameter("encode"));
			String timeStart = request.getParameter("timeStart");
		    String timeEnd = request.getParameter("timeEnd");
		    maps.put("timeStart", timeStart);
		    maps.put("timeEnd", timeEnd);
	       
			int count = durablesMaintainDao.getRecordCount(maps);  

	        if (count<=0) {
				return page;
			}
	        
	        List<DurablesMaintain> data= durablesMaintainDao.pageQuery(maps);
	        
	        page.setCount(count);
	        page.setData(data);
	        page.setCode(0);
	        page.setMsg("");
			return page;
			
		}
		
		@Override
		public List<DurablesMaintain> exportxls(HttpServletRequest request) {
			 HashMap<String,String> maps = QueryUtil.pageQuery(request);
		        maps.put("commodity", request.getParameter("commodity"));
				maps.put("type", request.getParameter("type"));
				maps.put("encode", request.getParameter("encode"));
				String timeStart = request.getParameter("timeStart");
			    String timeEnd = request.getParameter("timeEnd");
			    maps.put("timeStart", timeStart);
			    maps.put("timeEnd", timeEnd);
		     
		return durablesMaintainDao.exportxls(maps);
		}
		
		
		@Override
		public DurablesMaintain getDurablesMaintainById(String id) {
		// TODO Auto-generated method stub
		return durablesMaintainDao.getDurablesMaintainById(id);
		}
		
		@Override
		public int add(DurablesMaintain durablesMaintain) {
		// TODO Auto-generated method stub
		return durablesMaintainDao.add(durablesMaintain);
		}
		
		@Override
		public int update(DurablesMaintain durablesMaintain) {
		// TODO Auto-generated method stub
		return durablesMaintainDao.update(durablesMaintain);
		}
		
		@Override
		public int remove(String id) {
		// TODO Auto-generated method stub
		return durablesMaintainDao.remove(id);
		}
}
