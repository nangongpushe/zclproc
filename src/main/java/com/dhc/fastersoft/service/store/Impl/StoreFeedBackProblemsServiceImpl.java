package com.dhc.fastersoft.service.store.Impl;

import com.dhc.fastersoft.dao.store.StoreFeedBackProblemsDao;
import com.dhc.fastersoft.entity.store.StoreFeedBackProblems;
import com.dhc.fastersoft.service.store.StoreFeedBackProblemsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("StoreFeedBackProblemsService")
public class StoreFeedBackProblemsServiceImpl implements StoreFeedBackProblemsService {
	
	@Autowired
    StoreFeedBackProblemsDao storeFeedBackProblemsDao;
	
	@Override
	public int add(StoreFeedBackProblems storeFeedBackProblems) {
		// TODO Auto-generated method stub
		return storeFeedBackProblemsDao.add(storeFeedBackProblems);
	}
	
	@Override
	public int update(StoreFeedBackProblems storeFeedBackProblems) {
		// TODO Auto-generated method stub
		return storeFeedBackProblemsDao.update(storeFeedBackProblems);
	}
	
	@Override
	public int remove(String serial) {
		// TODO Auto-generated method stub
		return storeFeedBackProblemsDao.remove(serial);
	}
	
	@Override
	public List<StoreFeedBackProblems> getStoreFeedBackProblemsByID(String serial) {
		// TODO Auto-generated method stub
		return storeFeedBackProblemsDao.getStoreFeedBackProblemsById(serial);
	}
}
