package com.dhc.fastersoft.service.store.Impl;


import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.apache.batik.bridge.SVGPatternElementBridge.PatternGraphicsNode;
import org.apache.ws.commons.schema.utils.PrefixCollector;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.store.StorageFumigateDao;
import com.dhc.fastersoft.dao.store.StorageMachineAirDao;
import com.dhc.fastersoft.dao.store.StoragePhosphineDao;
import com.dhc.fastersoft.entity.store.StorageFumigate;
import com.dhc.fastersoft.entity.store.StorageMachineAir;
import com.dhc.fastersoft.entity.store.StoragePhosphine;
import com.dhc.fastersoft.entity.store.StoragePhosphinePoint;
import com.dhc.fastersoft.service.store.StorageFumigateService;
import com.dhc.fastersoft.service.store.StorageMachineAirService;
import com.dhc.fastersoft.service.store.StoragePhosphineService;


@Service("StoragePhosphineService")
public class StoragePhosphineServiceImpl implements StoragePhosphineService{
	@Autowired
	private StoragePhosphineDao phosphineDao;

	@Override
	public int save(StoragePhosphine storagePhosphine) {
		// TODO Auto-generated method stub
		String id = UUID.randomUUID().toString().replaceAll("-", "");
		storagePhosphine.setId(id);
		/*storagePhosphine.setInspecteTime(Calendar.getInstance().getTime());*/
		/*storagePhosphine.setInspector(TokenManager.getNickname());*/
		List<StoragePhosphinePoint> details = storagePhosphine.getPointList();
		for(StoragePhosphinePoint point:details) {
			point.setPhosphineId(id);
		}
		return phosphineDao.save(storagePhosphine);
	}

	@Override
	public int update(StoragePhosphine storagePhosphine) {
		// TODO Auto-generated method stub
		String id = storagePhosphine.getId();
		List<StoragePhosphinePoint> details = storagePhosphine.getPointList();
		for(StoragePhosphinePoint point:details) {
			if(null==point.getPhosphineId()||"".equals(point.getPhosphineId()))
				point.setPhosphineId(id);
		}
		return phosphineDao.update(storagePhosphine);
	}

	@Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return phosphineDao.remove(id);
	}

	@Override
	public StoragePhosphine getById(String id) {
		// TODO Auto-generated method stub
		StoragePhosphine phosphine = phosphineDao.getById(id);
		phosphine.setPointList(phosphineDao.getPointsByPhosphineId(id));
		return phosphine;
	}

	@Override
	public List<StoragePhosphinePoint> getPointsByPhosphineId(String id) {
		// TODO Auto-generated method stub
		return phosphineDao.getPointsByPhosphineId(id);
	}

	@Override
	public int count(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return phosphineDao.count(map);
	}

	@Override
	public List<StoragePhosphine> list(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return phosphineDao.list(map);
	}
	
	
	
}
