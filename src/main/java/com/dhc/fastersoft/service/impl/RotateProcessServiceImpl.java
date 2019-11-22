package com.dhc.fastersoft.service.impl;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.dao.RotateProcessDao;
import com.dhc.fastersoft.entity.RotateProcess;
import com.dhc.fastersoft.entity.RotateProcessDetail;
import com.dhc.fastersoft.service.RotateProcessService;
import com.dhc.fastersoft.utils.PageUtil;

@Service("RotateProcessService")
public class RotateProcessServiceImpl implements RotateProcessService{

	@Autowired
	private RotateProcessDao rotateProcessDao;
	
	@Override
	public void AddRotateProcess(RotateProcess rotateProcess) {
		rotateProcess.setId(UUID.randomUUID().toString().replace("-", ""));
		rotateProcessDao.AddRotateProcess(rotateProcess);
	}

	@Override
	public List<RotateProcess> ListLimitProcess(PageUtil pageUtil) {
		pageUtil.setTotalCount(rotateProcessDao.GetTotalCount(pageUtil));
		return rotateProcessDao.ListLimitProcess(pageUtil);
	}

	@Override
	public RotateProcess GetRotateProcess(String id) {
		return rotateProcessDao.GetRotateProcess(id);
	}

	@Override
	public void UpdateRotateProcess(RotateProcess rotateProcess) {
		rotateProcessDao.UpdateRotateProcess(rotateProcess);
	}

	@Override
	public void UpdateRotateProcessState(RotateProcess rotateProcess) {
		rotateProcessDao.UpdateRotateProcessState(rotateProcess);
	}

	@Override
	public void deleteRotateProcess(String id) {
		rotateProcessDao.deleteRotateProcess(id);
	}

	@Override
	public List<RotateProcessDetail> GetRotateProcessDetailByDealSerial(String dealSerial) {
		// TODO Auto-generated method stub
		return rotateProcessDao.GetRotateProcessDetailByDealSerial(dealSerial);
	}
}
