package com.dhc.fastersoft.service.store.Impl;


import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.apache.ws.commons.schema.utils.PrefixCollector;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.store.StorageCoolingDao;
import com.dhc.fastersoft.dao.store.StorageFumigateDao;
import com.dhc.fastersoft.dao.store.StorageMachineAirDao;
import com.dhc.fastersoft.entity.store.StorageCooling;
import com.dhc.fastersoft.entity.store.StorageFumigate;
import com.dhc.fastersoft.entity.store.StorageMachineAir;
import com.dhc.fastersoft.service.store.StorageCoolingService;
import com.dhc.fastersoft.service.store.StorageFumigateService;
import com.dhc.fastersoft.service.store.StorageMachineAirService;


@Service("StorageCoolingService")
public class StorageCoolingServiceImpl implements StorageCoolingService{
	
	@Autowired
	private StorageCoolingDao coolingDao;

	@Override
	public int save(StorageCooling storageCooling) {
		// TODO Auto-generated method stub
		storageCooling.setId(UUID.randomUUID().toString().replaceAll("-", ""));
		storageCooling.setCreator(TokenManager.getNickname());
		Date date = Calendar.getInstance().getTime();
		storageCooling.setCreateDate(date);
		storageCooling.setRecordDate(date);
		return coolingDao.save(storageCooling);
	}

	@Override
	public int update(StorageCooling storageCooling) {
		// TODO Auto-generated method stub
		return coolingDao.update(storageCooling);
	}

	@Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return coolingDao.remove(id);
	}

	@Override
	public StorageCooling getById(String id) {
		// TODO Auto-generated method stub
		return coolingDao.getById(id);
	}

	@Override
	public int count(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return coolingDao.count(map);
	}

	@Override
	public List<StorageCooling> list(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return coolingDao.list(map);
	}


}
