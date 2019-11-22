package com.dhc.fastersoft.service.impl;


import com.dhc.fastersoft.dao.RotateRefundDao;
import com.dhc.fastersoft.dao.RotateRefundMainDao;
import com.dhc.fastersoft.entity.RotateRefund;
import com.dhc.fastersoft.entity.RotateRefundMain;
import com.dhc.fastersoft.service.RotateRefundService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
@Service("rotateRefundService")
public class RotateRefundServiceImpl implements RotateRefundService {
	
	@Autowired
	private RotateRefundDao refundDao;
	@Autowired
	private RotateRefundMainDao refundMainDao;


	@Override
	public int save(RotateRefund record) {
		//record.setId(UUID.randomUUID().toString().replaceAll("-", ""));
		return refundDao.save(record);
	}

	@Override
	public int update(RotateRefund record) {
		return refundDao.update(record);
	}

    @Override
    public int updateMain(RotateRefundMain rotateRefundMain) {
        return refundMainDao.update(rotateRefundMain);
    }

    @Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return refundDao.remove(id);
	}
	public int removeMain(String id) {
		// TODO Auto-generated method stub
		return refundMainDao.remove(id);
	}


	@Override
	public List<RotateRefund> get(String id) {
		return refundDao.get(id);
	}

	@Override
	public String getMaxGroupId(String id) {
		return refundDao.getMaxGroupId(id);
	}

	@Override
	public RotateRefund view(String id) {
		return refundDao.view(id);
	}

	@Override
	public List<RotateRefund> list(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return refundDao.list(map);
	}

	@Override
	public String getInviteName(RotateRefund rotateRefund) {
		return refundDao.getInviteName(rotateRefund);
	}

	@Override
	public int count(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return refundDao.count(map);
	}

}
