package com.dhc.fastersoft.service.impl;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.dao.ConstructionPlanDao;
import com.dhc.fastersoft.entity.ConstructionPlan;
import com.dhc.fastersoft.service.ConstructionPlanService;
import com.dhc.fastersoft.utils.PageUtil;

@Service("ConstructionPlanService")
public class ConstructionPlanServiceImpl implements ConstructionPlanService {

	@Autowired
	private ConstructionPlanDao constructionPlanDao;
	
	@Override
	public void AddConstructionPlan(ConstructionPlan constructionPlan) {
		constructionPlan.setId(UUID.randomUUID().toString().replace("-", ""));
		constructionPlanDao.AddConstructionPlan(constructionPlan);
	}

	@Override
	public List<ConstructionPlan> ListLimitPlan(PageUtil pageUtil) {
		pageUtil.setTotalCount(constructionPlanDao.GetTotalCount(pageUtil));
		return constructionPlanDao.ListLimitPlan(pageUtil);
	}

	@Override
	public ConstructionPlan GetConstructionPlan(String cid) {
		return constructionPlanDao.GetConstructionPlan(cid);
	}

	@Override
	public void UpdateConstructionPlan(ConstructionPlan constructionPlan) {
		constructionPlanDao.UpdateConstructionPlan(constructionPlan);
	}

	@Override
	public List<ConstructionPlan> listGroupByYear(PageUtil pageUtil) {
		pageUtil.setTotalCount(constructionPlanDao.GetCountGroupByYear(pageUtil));
		return constructionPlanDao.listGroupByYear(pageUtil);
	}

	@Override
	public List<ConstructionPlan> ListPlanByIdArray(List<String> ids) {
		return constructionPlanDao.ListPlanByIdArray(ids);
	}
}
