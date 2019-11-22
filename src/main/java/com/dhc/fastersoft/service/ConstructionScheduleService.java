package com.dhc.fastersoft.service;

import java.util.List;

import com.dhc.fastersoft.entity.ConstructionSchedule;
import com.dhc.fastersoft.utils.PageUtil;

public interface ConstructionScheduleService {
	void AddConstructionSchedule(ConstructionSchedule constructionSchedule);
	List<ConstructionSchedule> ListLimitSchedule(PageUtil pageUtil);
 	ConstructionSchedule GetConstructionSchedule(String cid);
 	void UpdateConstructionSchedule(ConstructionSchedule constructionSchedule);
 	List<ConstructionSchedule> ListScheduleByIdArray(List<String> ids);
 	List<ConstructionSchedule> ListGrouyByYearMonth(PageUtil pageUtil);
 	void UpdateScheduleByArray(List<ConstructionSchedule> list);
}
