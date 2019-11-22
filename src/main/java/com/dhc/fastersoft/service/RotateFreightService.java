package com.dhc.fastersoft.service;



import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.dhc.fastersoft.entity.RotateFreight;
import com.dhc.fastersoft.entity.RotateFreightDetail;
import com.dhc.fastersoft.entity.RotateInvite;
import com.dhc.fastersoft.entity.RotateInviteDetail;
import com.dhc.fastersoft.utils.LayPage;


@Component
public interface RotateFreightService {
	String saveFreight(RotateFreight record);
	
	int updateFreight(RotateFreight record);

	int removeFreightById(String id);
		
	RotateFreight getById(String id);
	
	int countFreight(HashMap<String, Object> map);

	List<RotateFreight> listFreight(HashMap<String, Object> map);
	
	List<RotateFreightDetail> listFreightDetail(HashMap<String, Object> map);
	
	int updateStatus(String id,String status);
	
	int updateClientNameAndPrice(List<RotateFreightDetail> freightDetails);
}
