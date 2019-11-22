package com.dhc.fastersoft.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.dao.QualityThirdItemMapper;
import com.dhc.fastersoft.entity.QualityThird;
import com.dhc.fastersoft.entity.QualityThirdItem;
import com.dhc.fastersoft.service.QualityThirdItemService;

@Service("QualityThirdItemService")
public class QualityThirdItemServiceImpl implements QualityThirdItemService{
	@Autowired
	public QualityThirdItemMapper dao;
	@Override
	public List<QualityThirdItem> getByID(String id) {
		// TODO Auto-generated method stub
		return dao.getById(id);
	}

	@Override
	public int deleteItem(String id) {
		// TODO Auto-generated method stub
		return dao.delete(id);
	}

	
	@Override
	public int add(QualityThirdItem qtiItem) {
		// TODO Auto-generated method stub
		return dao.add(qtiItem);
	}

	@Override
	public int count(String id) {
		// TODO Auto-generated method stub
		return dao.count(id);
	}

	@Override
	public List<QualityThirdItem> queryByThirdId(List<String> thirdIds) {
		return dao.queryByThirdId(thirdIds);
	}

	

}
