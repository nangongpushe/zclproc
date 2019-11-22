package com.dhc.fastersoft.service;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;


import com.dhc.fastersoft.entity.DurablesMaintain;
import com.dhc.fastersoft.utils.LayPage;

@Component
public interface DurablesMaintainService {
	LayPage<DurablesMaintain> list(HttpServletRequest request);
	
	public int add(DurablesMaintain durablesMaintain);
	public int update(DurablesMaintain durablesMaintain);
	public DurablesMaintain  getDurablesMaintainById(String id);
	public int remove(String id);
	public List<DurablesMaintain> exportxls(HttpServletRequest request);
}
