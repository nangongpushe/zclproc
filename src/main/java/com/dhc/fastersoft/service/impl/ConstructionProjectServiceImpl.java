package com.dhc.fastersoft.service.impl;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.dao.ConstructionProjectDao;
import com.dhc.fastersoft.entity.ConstructionProject;
import com.dhc.fastersoft.service.ConstructionProjectService;
import com.dhc.fastersoft.utils.PageUtil;

@Service("ConstructionProjectService")
public class ConstructionProjectServiceImpl implements ConstructionProjectService {

	@Autowired
	private ConstructionProjectDao constructionProjectDao;
	
	@Override
	public void AddConstruction(ConstructionProject constructionProject) {
		constructionProject.setId(UUID.randomUUID().toString().replace("-", ""));
		constructionProjectDao.AddConstruction(constructionProject);
	}

	@Override
	public List<ConstructionProject> ListLimitConstruction(PageUtil<ConstructionProject> pageUtil) {
		pageUtil.setTotalCount(constructionProjectDao.GetTotalCount(pageUtil));
		return constructionProjectDao.ListLimitConstruction(pageUtil);
	}

	@Override
	public ConstructionProject GetConstructionDetail(String id) {
		return constructionProjectDao.GetConstructionDetail(id);
	}

	@Override
	public void UpdateConstruction(ConstructionProject constructionProject) {
		constructionProjectDao.UpdateConstruction(constructionProject);
	}

	@Override
	public void DeleteData(Map tableMap) {
		constructionProjectDao.DeleteData(tableMap);
	}

	@Override
	public int GetTotalCount(PageUtil<ConstructionProject> pageUtil) {
		return constructionProjectDao.GetTotalCount(pageUtil);
	}
	
	@Override
	public int  checkIsAddSameName(String projectName,String projectSerial){
		return constructionProjectDao.checkIsAddSameName(projectName,projectSerial);
	}

	@Override
	public List<ConstructionProject> parentProjectList(ConstructionProject constructionProject) {
		return constructionProjectDao.parentProjectList(constructionProject);
	}

	@Override
	public Boolean isHashChildProject(String id) {
		int count = constructionProjectDao.childProjectCount(id);
		if(count==0){
			return false;
		}else{
			return true;
		}
	}

	@Override
	public List<ConstructionProject> getConstructionProjectByProjectUnit(String id, String unitName) {
		return constructionProjectDao.getConstructionProjectByUnitIdAndUnitName(id,unitName);
	}
}
