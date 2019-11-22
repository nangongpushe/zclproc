package com.dhc.fastersoft.service.store.Impl;


import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.dao.store.StorageMachineAirDao;
import com.dhc.fastersoft.entity.store.StorageMachineAir;
import com.dhc.fastersoft.service.store.StorageMachineAirService;


@Service("StorageMachineAirService")
public class StorageMachineAirServiceImpl implements StorageMachineAirService{
	@Autowired
	private StorageMachineAirDao dao;

	@Override
	public int save(StorageMachineAir storageMachineAir) {
		// TODO Auto-generated method stub
		storageMachineAir.setId(UUID.randomUUID().toString().replaceAll("-", ""));
		return dao.save(storageMachineAir);
	}

	@Override
	public int update(StorageMachineAir storageMachineAir) {
		// TODO Auto-generated method stub
		return dao.update(storageMachineAir);
	}

	@Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return dao.remove(id);
	}

	@Override
	public StorageMachineAir getById(String id) {
		// TODO Auto-generated method stub
		return dao.getById(id);
	}

	@Override
	public int count(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.count(map);
	}

	@Override
	public List<StorageMachineAir> list(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.list(map);
	}

}
