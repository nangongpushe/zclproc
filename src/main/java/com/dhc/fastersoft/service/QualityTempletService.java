package com.dhc.fastersoft.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.dhc.fastersoft.common.page.PageList;
import com.dhc.fastersoft.entity.QualityTemplet;
import com.dhc.fastersoft.utils.LayPage;

import java.util.List;
import java.util.Map;

@Component
public interface QualityTempletService {

	LayPage<QualityTemplet> list(HttpServletRequest request);

	LayPage<QualityTemplet> listChoice(HttpServletRequest request);

	int add(QualityTemplet entity);

	int update(QualityTemplet entity);


	QualityTemplet getByID(String id);

	int remove(String id);

	int check(HttpServletRequest request, String str);


	List<QualityTemplet> getTemplateByNo(Map<String,Object> templateMap);

	

}
