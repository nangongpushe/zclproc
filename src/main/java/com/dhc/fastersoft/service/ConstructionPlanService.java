package com.dhc.fastersoft.service;

import java.util.List;

import com.dhc.fastersoft.entity.ConstructionPlan;
import com.dhc.fastersoft.utils.PageUtil;

public interface ConstructionPlanService {
	
	String PLAN_NAME = "年度基建项目投资计划表";
	
	void AddConstructionPlan(ConstructionPlan constructionPlan);
	List<ConstructionPlan> ListLimitPlan(PageUtil pageUtil);
	ConstructionPlan GetConstructionPlan(String cid);
	void UpdateConstructionPlan(ConstructionPlan constructionPlan);
	List<ConstructionPlan> listGroupByYear(PageUtil pageUtil);
	List<ConstructionPlan> ListPlanByIdArray(List<String> ids);
}
