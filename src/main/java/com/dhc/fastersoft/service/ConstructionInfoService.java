package com.dhc.fastersoft.service;

import java.util.List;

import com.dhc.fastersoft.entity.ConstructionInfo;
import com.dhc.fastersoft.utils.PageUtil;

public interface ConstructionInfoService {
	void AddConstructionInfo(ConstructionInfo constructionInfo);
	List<ConstructionInfo> ListLimitChange(PageUtil pageUtil);
	ConstructionInfo GetConstructionInfo(String cid);
	void UpdateConstructionInfo(ConstructionInfo constructionInfo);
}
