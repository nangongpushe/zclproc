package com.dhc.fastersoft.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.dhc.fastersoft.entity.ConstructionProject;
import com.dhc.fastersoft.utils.PageUtil;

public interface ConstructionProjectService {
	void AddConstruction(ConstructionProject constructionProject);
	List<ConstructionProject> ListLimitConstruction(PageUtil<ConstructionProject> pageUtil);
	int GetTotalCount(PageUtil<ConstructionProject> pageUtil);
	ConstructionProject GetConstructionDetail(String id);
	void UpdateConstruction(ConstructionProject constructionProject);
	void DeleteData(Map tableMap);
	int checkIsAddSameName(String projectName,String projectSerial);
	List<ConstructionProject> parentProjectList(ConstructionProject constructionProject);
	Boolean isHashChildProject(String id);

	List<ConstructionProject> getConstructionProjectByProjectUnit(String id,String unitName);
}
