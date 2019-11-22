package com.dhc.fastersoft.dao;

import java.util.List;

import com.dhc.fastersoft.entity.ConstructionPlan;
import com.dhc.fastersoft.utils.PageUtil;

public interface ConstructionPlanDao {
	void AddConstructionPlan(ConstructionPlan constructionPlan);
	List<ConstructionPlan> ListLimitPlan(PageUtil pageUtil);
	int GetTotalCount(PageUtil pageUtil);
	ConstructionPlan GetConstructionPlan(String cid);
	void UpdateConstructionPlan(ConstructionPlan constructionPlan);
	List<ConstructionPlan> listGroupByYear(PageUtil pageUtil);
	int GetCountGroupByYear(PageUtil pageUtil);
	List<ConstructionPlan> ListPlanByIdArray(List<String> ids);
}
