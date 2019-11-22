package com.dhc.fastersoft.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.dhc.fastersoft.common.page.PageList;
import com.dhc.fastersoft.entity.Test;


@Component
public interface TestService {
	
	PageList pageQuery(HttpServletRequest request);

	public int add(Test test);

	public int update(Test test);

	int delete(String id);

	List<Test> query(HttpServletRequest request);

	Test getTestById(String id);

	void importExcel(List<Test> list);
}

