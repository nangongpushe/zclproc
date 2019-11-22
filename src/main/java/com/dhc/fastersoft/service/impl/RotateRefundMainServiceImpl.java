package com.dhc.fastersoft.service.impl;


import com.dhc.fastersoft.dao.RotateRefundMainDao;
import com.dhc.fastersoft.entity.RotateRefundMain;
import com.dhc.fastersoft.service.RotateRefundMainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("rotateRefundMainService")
public class RotateRefundMainServiceImpl implements RotateRefundMainService {
	
	@Autowired
	private RotateRefundMainDao refundMainDao;


	@Override
	public String getMaxSerial() {
		return refundMainDao.getMaxSerial();
	}

	@Override
	public RotateRefundMain getBySerial(String serial) {
		return refundMainDao.getBySerial(serial);
	}

	@Override
	public RotateRefundMain get(String id) {
		return refundMainDao.get(id);
	}

	@Override
	public void save(RotateRefundMain rotateRefundMain) {
		refundMainDao.save(rotateRefundMain);
	}
}
