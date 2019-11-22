package com.dhc.fastersoft.service.impl;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.dao.RotatePerformanceDao;
import com.dhc.fastersoft.entity.RotatePerformance;
import com.dhc.fastersoft.service.RotatePerformanceService;
import com.dhc.fastersoft.utils.PageUtil;

@Service("RotatePerformanceService")
public class RotatePerformanceServiceImpl implements RotatePerformanceService {

	@Autowired
	private RotatePerformanceDao rotatePerformanceDao;
	
	@Override
	public void AddRotatePerformance(RotatePerformance rotatePerformance) {
		rotatePerformance.setId(UUID.randomUUID().toString().replace("-", ""));
		rotatePerformanceDao.AddRotatePerformance(rotatePerformance);
	}

	@Override
	public List<RotatePerformance> ListLimitPerformance(PageUtil pageUtil) {
		pageUtil.setTotalCount(rotatePerformanceDao.GetTotalCount(pageUtil));
		return rotatePerformanceDao.ListLimitPerformance(pageUtil);
	}

	@Override 
	public RotatePerformance GetRotatePerformance(String id) {
		return rotatePerformanceDao.GetRotatePerformance(id);
	}

	@Override
	public void UpdateRotatePerformance(RotatePerformance rotatePerformance) {
		rotatePerformanceDao.UpdateRotatePerformance(rotatePerformance);
	}

}
