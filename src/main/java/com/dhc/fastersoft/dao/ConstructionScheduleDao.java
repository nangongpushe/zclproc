package com.dhc.fastersoft.dao;

import java.util.List;

import com.dhc.fastersoft.entity.ConstructionSchedule;
import com.dhc.fastersoft.utils.PageUtil;

public interface ConstructionScheduleDao {
	void AddConstructionSchedule(ConstructionSchedule constructionSchedule);
	List<ConstructionSchedule> ListLimitSchedule(PageUtil pageUtil);
	int GetTotalCount(PageUtil pageUtil);
	ConstructionSchedule GetConstructionSchedule(String cid);
 	void UpdateConstructionSchedule(ConstructionSchedule constructionSchedule);
 	List<ConstructionSchedule> ListScheduleByIdArray(List<String> ids);
 	List<ConstructionSchedule> ListGrouyByYearMonth(PageUtil pageUtil);
 	int GetCountGroupByYearMonth(PageUtil pageUtil);
 	void UpdateScheduleByArray(List<ConstructionSchedule> list);
}
