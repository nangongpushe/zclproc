package com.dhc.fastersoft.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.dao.QualityTempletItemMapper;
import com.dhc.fastersoft.entity.QualityTempletItem;
import com.dhc.fastersoft.service.QualityTempletItemService;
@Service("QualityTempletItemService")
public class QualityTempletItemServiceImpl implements QualityTempletItemService {
	@Autowired
	public  QualityTempletItemMapper dao;
	@Override
	public int add(QualityTempletItem entity) {
		// TODO Auto-generated method stub
		return dao.add(entity);
	}
	@Override
	public List<QualityTempletItem> getByID(String id) {
		// TODO Auto-generated method stub
		return dao.getById(id);
	}
	@Override
	public int deleteItem(String id) {
		// TODO Auto-generated method stub
		return dao.delete(id);
	}
	@Override
	public int count(String id) {
		// TODO Auto-generated method stub
		return dao.count(id);
	}
	@Override
	public void addByList(List<QualityTempletItem> data) {
		dao.addByList(data);
	}

}
