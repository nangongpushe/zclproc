package com.dhc.fastersoft.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.dhc.fastersoft.common.page.PageList;
import com.dhc.fastersoft.entity.Consumables;
import com.dhc.fastersoft.utils.LayPage;

@Component
public interface ConsumablesService {
	public int add(Consumables consumables) throws Exception;
	public PageList pageQuery(HttpServletRequest request);
	public int update(Consumables consumables);
	public Consumables getConsumablesByID(String id);
	LayPage<Consumables> list(HttpServletRequest request);
	public int remove(String id);
	public int updateApply(Consumables consumables);
}
