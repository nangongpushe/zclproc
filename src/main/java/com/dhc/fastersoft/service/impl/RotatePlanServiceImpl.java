package com.dhc.fastersoft.service.impl;

import com.dhc.fastersoft.dao.RotatePlanDao;
import com.dhc.fastersoft.entity.RotatePlan;
import com.dhc.fastersoft.entity.RotatePlanDetail;
import com.dhc.fastersoft.service.RotatePlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;


@Service("rotatePlanService")
public class RotatePlanServiceImpl implements RotatePlanService {
	
	@Autowired
	private RotatePlanDao dao;

	@Override
	public int save(RotatePlan rotatePlan) {
		// TODO Auto-generated method stub

		
		rotatePlan.setId(UUID.randomUUID().toString().replaceAll("-", ""));
		rotatePlan.setColletorDate(Calendar.getInstance().getTime());
		BigDecimal stock_in=new BigDecimal(0);
		BigDecimal stock_out=new BigDecimal(0);
		List<RotatePlanDetail> rotatePlanDetail = rotatePlan.getPlanDetail();
		for(int i=0;i<rotatePlanDetail.size();i++) {
			RotatePlanDetail detail=rotatePlanDetail.get(i);
			detail.setId(UUID.randomUUID().toString().replaceAll("-", ""));
			String type=detail.getRotateType();
			if(type.equals("轮入"))
				//stock_in+=Double.valueOf(detail.getRotateNumber());
				stock_in = stock_in.add(detail.getRotateNumber());
			else if(type.equals("轮出"))
				//stock_out+=Double.valueOf(detail.getRotateNumber());
				stock_out = stock_out.add(detail.getRotateNumber());
		}
		rotatePlan.setStockIn(stock_in);
		rotatePlan.setStockOut(stock_out);
		dao.save(rotatePlan);
		return 1;
	}
	
	

	@Override
	public RotatePlan getPlan(String id) {
		RotatePlan rotatePlan=dao.getPlan(id);
		if(rotatePlan != null){
			List<RotatePlanDetail> rotatePlanDetails=dao.listPlanDetail(id);
			rotatePlan.setPlanDetail(rotatePlanDetails);
		}

		return rotatePlan;
	}

	@Override
	public List<RotatePlanDetail> listPlanDetailByMainId(String id) {
		List<RotatePlanDetail> rotatePlanDetails=dao.listPlanDetailByMainId(id);
		return rotatePlanDetails;
	}
	
	@Override
	public int update(RotatePlan rotatePlan) {
		// TODO Auto-generated method stub
		Date date = new Date();
		rotatePlan.setModifyDate(date);
		
		List<RotatePlanDetail> rotatePlanDetail=rotatePlan.getPlanDetail();
		BigDecimal stock_in=new BigDecimal(0);
		BigDecimal stock_out=new BigDecimal(0);
		for(int i=0;i<rotatePlanDetail.size();i++) {
			RotatePlanDetail detail=rotatePlanDetail.get(i);
			if(null==detail.getId()||"".equals(detail.getId()))
				detail.setId(UUID.randomUUID().toString().replaceAll("-", ""));
			String type=detail.getRotateType();
			if(type.equals("轮入"))
				//stock_in+=Double.valueOf(detail.getRotateNumber());
				stock_in = stock_in.add(detail.getRotateNumber());
			else if(type.equals("轮出"))
				//stock_out+=Double.valueOf(detail.getRotateNumber());
				stock_out = stock_out.add(detail.getRotateNumber());
		}
		rotatePlan.setStockIn(stock_in);
		rotatePlan.setStockOut(stock_out);
		return dao.update(rotatePlan);
	}

	
	@Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return  dao.remove(id);
	}
	
	@Override
	public int removeDetail(String id) {
		// TODO Auto-generated method stub
		return dao.removeDetail(id);
	}


	@Override
	public List<RotatePlan> listAll(RotatePlan plan) {
		// TODO Auto-generated method stub
		return dao.listAll(plan);
	}


	@Override
	public List<RotatePlanDetail> listDetail(String id) {
		// TODO Auto-generated method stub
		return dao.listPlanDetail(id);
	}



	@Override
	public List<RotatePlan> list(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.list(map);
	}



	@Override
	public int count(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.count(map);
	}



	@Override
	public int updateState(String id, String state) {
		// TODO Auto-generated method stub
		HashMap<String, Object> map=new HashMap<>();
		map.put("id", id);
		map.put("state", state);
		if("已分发".equals(state)) {
			map.put("completeDate", new Date());
		}
		return dao.updateState(map);
	}



	@Override
	public List<RotatePlanDetail> listDetailByCondition(HashMap<String, String> map) {
		return dao.listDetailByCondition(map);
	}



	@Override
	public boolean checkPrimary(String planName) {
		int count = dao.checkPrimary(planName);
		return count>0?false:true;
	}

	@Override
	public RotatePlanDetail getPlanDetail(String id) {
		return dao.getPlanDetail(id);
	}

	@Override
	public List<RotatePlanDetail> getSumRotatenumberByPlanmaindetailId(String planId) {
		return dao.getSumRotatenumberByPlanmaindetailId(planId);
	}

	@Override
	public List<RotatePlan> getPlanname() {
		return dao.getPlanname();
	}
	@Override
	public BigDecimal getSumDealDetailNumberByRotateType(Map<String,Object> conditionMap){
		BigDecimal sumDealDetailNumber = dao.getSumDealDetailNumberByRotateType(conditionMap);
		if(null == sumDealDetailNumber){
			sumDealDetailNumber = new BigDecimal(0);
		}
		return sumDealDetailNumber;
	}

}
