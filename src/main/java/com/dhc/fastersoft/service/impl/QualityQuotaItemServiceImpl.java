package com.dhc.fastersoft.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.dao.QualityQuotaItemMapper;
import com.dhc.fastersoft.entity.QualityQuotaItem;
import com.dhc.fastersoft.service.QualityQuotaItemService;

@Service("QualityQuotaItemService")
public class QualityQuotaItemServiceImpl implements QualityQuotaItemService{
	@Autowired
	public QualityQuotaItemMapper dao;
	@Override
	public List<QualityQuotaItem> getByID(String id) {
		// TODO Auto-generated method stub
		return dao.getById(id);
	}

	@Override
	public int deleteItem(String id) {
		// TODO Auto-generated method stub
		return dao.delete(id);
	}

	@Override
	public int add(QualityQuotaItem qtiItem) {
		// TODO Auto-generated method stub
		return dao.add(qtiItem);
	}

	@Override
	public int count(String id) {
		// TODO Auto-generated method stub
		return dao.count(id);
	}

}
