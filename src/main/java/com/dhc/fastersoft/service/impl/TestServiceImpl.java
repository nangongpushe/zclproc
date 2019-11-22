package com.dhc.fastersoft.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.common.page.PageList;
import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.dao.TestDao;
import com.dhc.fastersoft.entity.Test;
import com.dhc.fastersoft.service.TestService;

@Service("testService")
public class TestServiceImpl implements TestService {

	@Autowired
	public TestDao dao;
	
	public PageList pageQuery(HttpServletRequest request) {
		PageList page = new PageList();

        HashMap<String,String> map = QueryUtil.pageQuery(request);

        String name = request.getParameter("name");
        map.put("name", name);

		int allRow = dao.getRecordCount(map);    //总记录数
        page.setCount(allRow);
        if (allRow<=0) {
			return page;
		}
        
		page.setRecords(dao.pageQuery(map));
		return page;
	}

	public int add(Test test) {
		return dao.add(test);
	}

	public int update(Test test) {
		return dao.update(test);
	}

	public int delete(String id) {
		return dao.delete(id);
	}

	public List<Test> query(HttpServletRequest request) {
        HashMap<String,String> map = new HashMap<String,String>();

		String name = request.getParameter("name");
        map.put("name", name);
		return dao.query(map);
	}

	public Test getTestById(String id) {
		return dao.getTestById(id);
	}

	public void importExcel(List<Test> list) {
		for (Test test : list) {
			dao.add(test);
		}
	}
	

}
