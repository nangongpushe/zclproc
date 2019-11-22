package com.dhc.fastersoft.service.store.Impl;


import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.apache.ws.commons.schema.utils.PrefixCollector;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.dao.store.StorageFumigateDao;
import com.dhc.fastersoft.dao.store.StorageMachineAirDao;
import com.dhc.fastersoft.entity.store.StorageFumigate;
import com.dhc.fastersoft.entity.store.StorageMachineAir;
import com.dhc.fastersoft.service.store.StorageFumigateService;
import com.dhc.fastersoft.service.store.StorageMachineAirService;


@Service("StorageFumigateService")
public class StorageFumigateServiceImpl implements StorageFumigateService{

	@Autowired
	private StorageFumigateDao fumigateDao;
	
	
	
	@Override
	public int save(StorageFumigate storageFumigate) {
		// TODO Auto-generated method stub
		storageFumigate.setId(UUID.randomUUID().toString().replaceAll("-", ""));
		Date date = Calendar.getInstance().getTime();
		storageFumigate.setReportTime(date);

		return fumigateDao.save(storageFumigate);
	}

	@Override
	public int update(StorageFumigate storageFumigate) {
		// TODO Auto-generated method stub
		return fumigateDao.update(storageFumigate);
	}

	@Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return fumigateDao.remove(id);
	}

	@Override
	public StorageFumigate getById(String id) {
		// TODO Auto-generated method stub
		return fumigateDao.getById(id);
	}

	@Override
	public int count(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return fumigateDao.count(map);
	}

	@Override
	public List<StorageFumigate> list(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return fumigateDao.list(map);
	}

	@Override
	public List<String> getSerials(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return fumigateDao.getSerials(map);
	}
	
}
