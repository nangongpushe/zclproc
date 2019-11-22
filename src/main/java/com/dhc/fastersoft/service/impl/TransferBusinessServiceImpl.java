package com.dhc.fastersoft.service.impl;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.dao.TransferBusinessDao;
import com.dhc.fastersoft.entity.TransferBusiness;
import com.dhc.fastersoft.service.TransferBusinessService;
import com.dhc.fastersoft.utils.PageUtil;

@Service("TransferBusinessService")
public class TransferBusinessServiceImpl implements TransferBusinessService{

	@Autowired
	private TransferBusinessDao transferBusinessDao;
	
	@Override
	public void SaveTransfer(TransferBusiness transferBusiness) {
		transferBusiness.setId(UUID.randomUUID().toString().replace("-", ""));
		transferBusinessDao.SaveTransfer(transferBusiness);
	}

	@Override
	public List<TransferBusiness> ListTransfer(PageUtil<TransferBusiness> pageUtil) {
		pageUtil.setTotalCount(transferBusinessDao.GetTotcalCount(pageUtil));
		return transferBusinessDao.ListTransfer(pageUtil);
	}

	@Override
	public TransferBusiness GetTransfer(String tid) {
		return transferBusinessDao.GetTransfer(tid);
	}

	@Override
	public void UpdateTransfer(TransferBusiness transferBusiness) {
		transferBusinessDao.UpdateTransfer(transferBusiness);
	}

	@Override
	public void DeleteTransfer(String id) {
		transferBusinessDao.DeleteTransfer(id);
	}
}
