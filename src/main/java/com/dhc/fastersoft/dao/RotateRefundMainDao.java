package com.dhc.fastersoft.dao;

import com.dhc.fastersoft.entity.RotateRefundMain;

public interface RotateRefundMainDao {
	String getMaxSerial();
	RotateRefundMain getBySerial(String serial);
	RotateRefundMain get(String id);
	void save(RotateRefundMain rotateRefundMain);
	int remove(String id);
	int update(RotateRefundMain rotateRefundMain);
}
