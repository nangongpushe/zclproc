package com.dhc.fastersoft.service;

import java.util.List;

import com.dhc.fastersoft.entity.ConstructionFunds;
import com.dhc.fastersoft.utils.PageUtil;

public interface ConstructionFundsService {
	void AddConstructionFunds(ConstructionFunds constructionFunds);
	List<ConstructionFunds> ListLimitFunds(PageUtil pageUtil);
	int GetTaotalCount(PageUtil pageUtil);
 	ConstructionFunds GetConstructionFunds(String cid);
 	void UpdateConstructionFunds(ConstructionFunds constructionFunds);
 	List<ConstructionFunds> GetLastInvestment();
}
