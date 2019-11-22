package com.dhc.fastersoft.service.impl;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.RotateFreightDao;
import com.dhc.fastersoft.entity.RotateFreight;
import com.dhc.fastersoft.entity.RotateFreightDetail;
import com.dhc.fastersoft.service.RotateFreightService;

@Service("rotateFreightService")
public class RotateFreightServiceImpl implements RotateFreightService {
	
	@Autowired
	private RotateFreightDao freightDao;

	@Override
	public String saveFreight(RotateFreight record) {
		// TODO Auto-generated method stub
		String id =UUID.randomUUID().toString().replaceAll("-", "");
		record.setId(id);
		record.setOperator(TokenManager.getNickname());
		record.setOperatorTime(Calendar.getInstance().getTime());
		List<RotateFreightDetail> freightDetails = record.getFreightDetails();
		for(RotateFreightDetail freightDetail:freightDetails) {
			if(null == freightDetail.getId()||"".equals(freightDetail.getId()))
				freightDetail.setId(UUID.randomUUID().toString().replaceAll("-", ""));
		}
		freightDao.saveFreight(record);
		return id;
	}

	@Override
	public int updateFreight(RotateFreight record) {
		// TODO Auto-generated method stub
		List<RotateFreightDetail> freightDetails = record.getFreightDetails();
		for(RotateFreightDetail freightDetail:freightDetails) {
			if(null == freightDetail.getId()||"".equals(freightDetail.getId()))
				freightDetail.setId(UUID.randomUUID().toString().replaceAll("-", ""));
		}
		return freightDao.updateFreight(record);
	}

	@Override
	public int removeFreightById(String id) {
		// TODO Auto-generated method stub
		return freightDao.remove(id);
	}

	@Override
	public RotateFreight getById(String id) {
		// TODO Auto-generated method stub
		RotateFreight rotateFreight = freightDao.getById(id);
		HashMap<String, Object> map = new HashMap<>();
		map.put("freightId", id);
		List<RotateFreightDetail> freightDetails = freightDao.listDetail(map);
		rotateFreight.setFreightDetails(freightDetails);
		return rotateFreight;
	}

	@Override
	public int countFreight(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return freightDao.count(map);
	}

	@Override
	public List<RotateFreight> listFreight(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return freightDao.list(map);
	}

	@Override
	public List<RotateFreightDetail> listFreightDetail(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return freightDao.listDetail(map);
	}

	@Override
	public int updateStatus(String id, String status) {
		// TODO Auto-generated method stub
		HashMap<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("status", status);
		return freightDao.updateStatus(map);
	}

	@Override
	public int updateClientNameAndPrice(List<RotateFreightDetail> freightDetails) {
		// TODO Auto-generated method stub
		//System.err.println(freightDetails);
		return freightDao.updateClientNameAndPrice(freightDetails);
	}
	
	
}
