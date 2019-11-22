package com.dhc.fastersoft.service;


import com.dhc.fastersoft.entity.RotateRefundMain;
import org.springframework.stereotype.Component;


@Component
public interface RotateRefundMainService {
	
	String getMaxSerial();
	RotateRefundMain getBySerial(String serial);
    RotateRefundMain get(String id);
	void save(RotateRefundMain rotateRefundMain);
}
