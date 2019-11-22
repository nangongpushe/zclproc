package com.dhc.fastersoft.service.impl;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.dao.ConstructionScheduleDao;
import com.dhc.fastersoft.entity.ConstructionSchedule;
import com.dhc.fastersoft.service.ConstructionScheduleService;
import com.dhc.fastersoft.utils.PageUtil;

@Service("ConstructionScheduleService")
public class ConstructionScheduleServiceImpl implements ConstructionScheduleService{

	@Autowired
	private ConstructionScheduleDao constructionScheduleDao;
	
	@Override
	public void AddConstructionSchedule(ConstructionSchedule constructionSchedule) {
		constructionSchedule.setId(UUID.randomUUID().toString().replace("-", ""));
		constructionScheduleDao.AddConstructionSchedule(constructionSchedule);
	}

	@Override
	public List<ConstructionSchedule> ListLimitSchedule(PageUtil pageUtil) {
		pageUtil.setTotalCount(constructionScheduleDao.GetTotalCount(pageUtil));
		return constructionScheduleDao.ListLimitSchedule(pageUtil);
	}

	@Override
	public ConstructionSchedule GetConstructionSchedule(String cid) {
		return constructionScheduleDao.GetConstructionSchedule(cid);
	}

	@Override
	public void UpdateConstructionSchedule(ConstructionSchedule constructionSchedule) {
		constructionScheduleDao.UpdateConstructionSchedule(constructionSchedule);
	}

	@Override
	public List<ConstructionSchedule> ListScheduleByIdArray(List<String> ids) {
		return constructionScheduleDao.ListScheduleByIdArray(ids);
	}

	@Override
	public List<ConstructionSchedule> ListGrouyByYearMonth(PageUtil pageUtil) {
		pageUtil.setTotalCount(constructionScheduleDao.GetCountGroupByYearMonth(pageUtil));
		return constructionScheduleDao.ListGrouyByYearMonth(pageUtil);
	}

	@Override
	public void UpdateScheduleByArray(List<ConstructionSchedule> list) {
		constructionScheduleDao.UpdateScheduleByArray(list);
	}

}
