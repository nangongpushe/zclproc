package com.dhc.fastersoft.service;

import java.util.List;

import com.dhc.fastersoft.entity.TransferBusiness;
import com.dhc.fastersoft.utils.PageUtil;

public interface TransferBusinessService {
	void SaveTransfer(TransferBusiness transferBusiness);
	List<TransferBusiness> ListTransfer(PageUtil<TransferBusiness> pageUtil);
	TransferBusiness GetTransfer(String tid);
	void UpdateTransfer(TransferBusiness transferBusiness);
	void DeleteTransfer(String id);
}
