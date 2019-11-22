package com.dhc.fastersoft.dao;

import java.util.List;

import com.dhc.fastersoft.entity.ConstructionFunds;
import com.dhc.fastersoft.utils.PageUtil;

public interface ConstructionFundsDao {
	void AddConstructionFunds(ConstructionFunds constructionFunds);
	List<ConstructionFunds> ListLimitFunds(PageUtil pageUtil);
	int GetTotalCount(PageUtil pageUtil);
 	ConstructionFunds	GetConstructionFunds(String cid);
 	void UpdateConstructionFunds(ConstructionFunds constructionFunds);
 	List<ConstructionFunds> GetLastInvestment();
}
