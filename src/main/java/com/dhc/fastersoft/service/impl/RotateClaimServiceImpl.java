package com.dhc.fastersoft.service.impl;



import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.executor.SimpleExecutor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.RotateArriveDao;
import com.dhc.fastersoft.dao.RotateClaimDao;
import com.dhc.fastersoft.entity.RotateArrive;
import com.dhc.fastersoft.entity.RotateClaim;
import com.dhc.fastersoft.service.RotateArriveService;
import com.dhc.fastersoft.service.RotateClaimService;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.utils.PageUtil;
@Service("rotateClaimService")
public class RotateClaimServiceImpl implements RotateClaimService {
	
	@Autowired
	private RotateClaimDao claimDao;

	@Override
	public int save(RotateClaim record) {
		// TODO Auto-generated method stub
		record.setId(UUID.randomUUID().toString().replaceAll("-", ""));
		record.setUserId(TokenManager.getSysUserId());
		return claimDao.save(record);
	}
	
	@Override
	public int saveBatch(List<RotateClaim> list) {
		// TODO Auto-generated method stub
		for(RotateClaim rotateClaim:list) {
			rotateClaim.setId(UUID.randomUUID().toString().replaceAll("-", ""));
			rotateClaim.setUserId(TokenManager.getSysUserId());
		}
		return claimDao.saveBatch(list);
	}

	@Override
	public int update(RotateClaim record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return claimDao.remove(id);
	}

	@Override
	public RotateClaim get(String arriveId, String claimMan) {
		// TODO Auto-generated method stub
		HashMap<String, String> map=new HashMap<>();
		map.put("arriveId", arriveId);
		map.put("claimMan", claimMan);
		return claimDao.get(map);

	}

	@Override
	public List<RotateClaim> list(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return claimDao.list(map);
	}

	@Override
	public int count(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return claimDao.count(map);
	}

	@Override
	public Double getTotalAmount(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return claimDao.getTotalAmount(map);
	}


	
}
