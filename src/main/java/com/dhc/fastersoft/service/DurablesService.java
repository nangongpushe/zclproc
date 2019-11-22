package com.dhc.fastersoft.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.dhc.fastersoft.common.page.PageList;
import com.dhc.fastersoft.entity.Durables;
import com.dhc.fastersoft.utils.LayPage;

@Component
public interface DurablesService {
	public int add(Durables durables);
	public PageList pageQuery(HttpServletRequest request);
	public int update(Durables durables);
	public Durables getDurablesByID(String id);
	LayPage<Durables> list(HttpServletRequest request);
	public int remove(String id);
	public int updateApply(Durables durables);
	public int getEncodeCount(String encode);
	public List<Durables> listDurables(HashMap<String,Object> map);
}
