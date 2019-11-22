package com.dhc.fastersoft.service;



import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.dhc.fastersoft.entity.RotatePayment;
import com.dhc.fastersoft.entity.RotatePaymentDetail;
import com.dhc.fastersoft.entity.RotatePlan;
import com.dhc.fastersoft.entity.RotatePlanDetail;
import com.dhc.fastersoft.utils.LayPage;


@Component
public interface RotatePaymentService {
	int savePayment(RotatePayment record);
	
	int updatePayment(RotatePayment record);

	int removePayment(String id);
	
	int removeDetail(String id);
	
	RotatePayment getPayment(String id);
	
	int count(HashMap<String, Object> map);

	List<RotatePayment> list(HashMap<String, Object> map);
	
	List<RotatePaymentDetail> listPaymentDetail(HashMap<String, Object> map);
	
	int updateStatus(HashMap<String, Object> map);
}
