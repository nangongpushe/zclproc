package com.dhc.fastersoft.service.impl;


import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.avalon.framework.parameters.ParameterException;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;


import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.RotatePaymentDao;

import com.dhc.fastersoft.entity.RotatePayment;
import com.dhc.fastersoft.entity.RotatePaymentDetail;

import com.dhc.fastersoft.service.RotatePaymentService;


@Service("rotatePaymentService")
public class RotatePaymentServiceImpl implements RotatePaymentService {
	
	@Autowired
	private RotatePaymentDao paymentDao;
	
	private static String PREFIX = "ZF";

	@Override
	public int savePayment(RotatePayment record) {
		// TODO Auto-generated method stub
		record.setId(UUID.randomUUID().toString().replaceAll("-", ""));
		Date date = Calendar.getInstance().getTime();
		record.setReportDate(date);
		int i =(int)(Math.random()*1000);
		String serial = String.format("%s%s%03d", PREFIX,date.getTime(),i);
		record.setPaySerial(serial);
//		record.setOperator(TokenManager.getNickname());
		List<RotatePaymentDetail> detailList = record.getDetailList();
		for(RotatePaymentDetail detail:detailList) {
			detail.setId(UUID.randomUUID().toString().replaceAll("-", ""));
			
		}
		return paymentDao.savePayment(record);
	}

	@Override
	public int updatePayment(RotatePayment record) {
		// TODO Auto-generated method stub
		List<RotatePaymentDetail> detailList = record.getDetailList();
		for(RotatePaymentDetail detail:detailList) {
			if(null==detail.getId()||"".equals(detail.getId()))
				detail.setId(UUID.randomUUID().toString().replaceAll("-", ""));	
		}
		return paymentDao.updatePayment(record);
	}

	@Override
	public int removePayment(String id) {
		// TODO Auto-generated method stub
		return paymentDao.removePayment(id);
	}

	@Override
	public int removeDetail(String id) {
		// TODO Auto-generated method stub
		return paymentDao.removeDetail(id);
	}

	@Override
	public RotatePayment getPayment(String id) {
		// TODO Auto-generated method stub
		RotatePayment payment = paymentDao.getPayment(id);
		HashMap<String, Object> map = new HashMap<>();
		map.put("paymentId", id);
		List<RotatePaymentDetail> details=paymentDao.listPaymentDetail(map);
		payment.setDetailList(details);
		return payment;
	}

	@Override
	public int count(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return paymentDao.count(map);
	}

	@Override
	public List<RotatePayment> list(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return paymentDao.list(map);
	}

	@Override
	public List<RotatePaymentDetail> listPaymentDetail(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return paymentDao.listPaymentDetail(map);
	}

	@Override
	public int updateStatus(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return paymentDao.updateStatus(map);
	}

}
