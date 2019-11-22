package com.dhc.fastersoft.service.impl;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.dao.ConstructionInfoDao;
import com.dhc.fastersoft.entity.ConstructionInfo;
import com.dhc.fastersoft.service.ConstructionInfoService;
import com.dhc.fastersoft.utils.PageUtil;

@Service("ConstructionInfoService")
public class ConstructionInfoServiceImpl implements ConstructionInfoService {

	@Autowired
	private ConstructionInfoDao constructionInfoDao;
	
	@Override
	public void AddConstructionInfo(ConstructionInfo constructionInfo) {
		constructionInfo.setId(UUID.randomUUID().toString().replace("-", ""));
		constructionInfoDao.AddConstructionInfo(constructionInfo);
	}

	@Override
	public List<ConstructionInfo> ListLimitChange(PageUtil pageUtil) {
		pageUtil.setTotalCount(constructionInfoDao.GetTotalCount(pageUtil));
		return constructionInfoDao.ListLimitChange(pageUtil);
	}

	@Override
	public ConstructionInfo GetConstructionInfo(String cid) {
		return constructionInfoDao.GetConstructionInfo(cid);
	}

	@Override
	public void UpdateConstructionInfo(ConstructionInfo constructionInfo) {
		constructionInfoDao.UpdateConstructionInfo(constructionInfo);
	}
}
