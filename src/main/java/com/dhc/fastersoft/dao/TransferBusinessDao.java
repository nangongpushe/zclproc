package com.dhc.fastersoft.dao;

import java.util.List;

import com.dhc.fastersoft.entity.TransferBusiness;
import com.dhc.fastersoft.utils.PageUtil;

public interface TransferBusinessDao {
	void SaveTransfer(TransferBusiness transferBusiness);
	List<TransferBusiness> ListTransfer(PageUtil<TransferBusiness> pageUtil);
	int GetTotcalCount(PageUtil<TransferBusiness> pageUtil);
	TransferBusiness GetTransfer(String tid);
	void UpdateTransfer(TransferBusiness transferBusiness);
	void DeleteTransfer(String id);
}
