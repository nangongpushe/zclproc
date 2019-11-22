package com.dhc.fastersoft.service.store.Impl;

import com.dhc.fastersoft.entity.store.StoreExamineItem;
import com.dhc.fastersoft.service.store.StoreExamineItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service("StoreExamineItemService")
public class StoreExamineItemServiceImpl implements StoreExamineItemService {
	@Autowired
    com.dhc.fastersoft.dao.store.StoreExamineItemDao StoreExamineItemDao;
	
	@Override
	public int add(StoreExamineItem StoreExamineItem) {
		// TODO Auto-generated method stub
		return StoreExamineItemDao.add(StoreExamineItem);
	}
	
	@Override
	public int update(StoreExamineItem StoreExamineItem) {
		// TODO Auto-generated method stub
		return StoreExamineItemDao.update(StoreExamineItem);
	}
	
	@Override
	public List<StoreExamineItem> getItemListByExamineId(String examineId) {
		// TODO Auto-generated method stub
		return StoreExamineItemDao.getItemListByExamineId(examineId);
	}
	
	@Override
	public StoreExamineItem getStoreExamineItemByID(String id) {
		// TODO Auto-generated method stub
		return StoreExamineItemDao.getStoreExamineById(id);
	}
	
	
	@Override
	public int remove(String examineId) {
		// TODO Auto-generated method stub
		return StoreExamineItemDao.remove(examineId);
	}
	
	@Override
	public List<StoreExamineItem> getItemListByParentId(String parentId, String examineId) {
		// TODO Auto-generated method stub
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("parentId", parentId);
		map.put("examineId", examineId);
		return StoreExamineItemDao.getItemListByParentId(map);
	}
	
}
