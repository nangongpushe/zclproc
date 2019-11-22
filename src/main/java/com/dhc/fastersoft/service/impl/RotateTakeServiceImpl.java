package com.dhc.fastersoft.service.impl;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.dao.RotateTakeDao;
import com.dhc.fastersoft.entity.RotateTake;
import com.dhc.fastersoft.service.RotateTakeService;
import com.dhc.fastersoft.utils.PageUtil;

@Service("RotateTakeService")
public class RotateTakeServiceImpl implements RotateTakeService{

	@Autowired
	private RotateTakeDao rotateTakeDao;
	
	@Override
	public void AddRotateTake(RotateTake rotateTake) {
		rotateTake.setId(UUID.randomUUID().toString().replace("-", ""));
		rotateTakeDao.AddRotateTake(rotateTake);
	}

	@Override
	public List<RotateTake> ListLimitTake(PageUtil pageUtil) {
		pageUtil.setTotalCount(rotateTakeDao.GetTotalCount(pageUtil));
		return rotateTakeDao.ListLimitTake(pageUtil);
	}

	@Override
	public RotateTake GetRotateTake(String id) {
		return rotateTakeDao.GetRotateTake(id);
	}

	@Override
	public List<RotateTake> getByMainId(String mainId){
		return rotateTakeDao.getByMainId(mainId);
	}

	@Override
	public void UpdateRotateTake(RotateTake rotateTake) {
		rotateTakeDao.UpdateRotateTake(rotateTake);
	}

	@Override
	public int deleteByMainId(String mainId){
		return rotateTakeDao.deleteByMainId(mainId);
	}

	@Override
	public BigDecimal selectTakeCountByDealSerial(String id) {
		return rotateTakeDao.selectTakeCountByDealSerial(id);
	}

}
