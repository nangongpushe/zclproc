package com.dhc.fastersoft.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.dhc.fastersoft.entity.ConstructionProject;
import com.dhc.fastersoft.utils.PageUtil;

public interface ConstructionProjectDao {
	void AddConstruction(ConstructionProject constructionProject);
	List<ConstructionProject> ListLimitConstruction(PageUtil<ConstructionProject> pageUtil);
	ConstructionProject GetConstructionDetail(String id);
	int GetTotalCount(PageUtil<ConstructionProject> pageUtil);
	void UpdateConstruction(ConstructionProject constructionProject);
	void DeleteData(Map tableMap);
	
	int checkIsAddSameName(@Param("projectName")String projectName,@Param("projectSerial")String projectSerial);

	List<ConstructionProject> parentProjectList(ConstructionProject constructionProject);

	Integer childProjectCount(String id);

	List<ConstructionProject> getConstructionProjectByUnitIdAndUnitName(@Param("unitId")String unitId,@Param("unitName") String unitName);
}
