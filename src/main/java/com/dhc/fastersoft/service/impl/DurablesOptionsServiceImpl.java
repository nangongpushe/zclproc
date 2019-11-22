package com.dhc.fastersoft.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.dao.DurablesOptionsDao;
import com.dhc.fastersoft.entity.DurablesOptions;
import com.dhc.fastersoft.service.DurablesOptionsService;

@Service("DurablesOptionsService")
public class DurablesOptionsServiceImpl implements DurablesOptionsService{
	
	@Autowired
	DurablesOptionsDao durablesOptionsDao;
	
	@Override
	public int add(DurablesOptions durablesOptions) {
		// TODO Auto-generated method stub
		return durablesOptionsDao.add(durablesOptions);
	}
	
	@Override
	public int update(DurablesOptions durablesOptions) {
		// TODO Auto-generated method stub
		return durablesOptionsDao.update(durablesOptions);
	}
	
	@Override
	public List<DurablesOptions> getDurablesOptionsByID(String id) {
		// TODO Auto-generated method stub
		 	return durablesOptionsDao.getDurablesOptionsById(id);
	}
	
	@Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return durablesOptionsDao.remove(id);
	}
}
