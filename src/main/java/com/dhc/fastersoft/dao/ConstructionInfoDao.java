package com.dhc.fastersoft.dao;

import java.util.List;

import com.dhc.fastersoft.entity.ConstructionInfo;
import com.dhc.fastersoft.utils.PageUtil;

public interface ConstructionInfoDao {
	void AddConstructionInfo(ConstructionInfo constructionInfo);
	List<ConstructionInfo> ListLimitChange(PageUtil pageUtil);
	int GetTotalCount(PageUtil pageUtil);
	ConstructionInfo GetConstructionInfo(String cid);
	void UpdateConstructionInfo(ConstructionInfo constructionInfo);
}
