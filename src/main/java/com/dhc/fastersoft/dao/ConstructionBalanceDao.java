package com.dhc.fastersoft.dao;

import java.util.List;

import com.dhc.fastersoft.entity.ConstructionBalance;
import com.dhc.fastersoft.utils.PageUtil;

public interface ConstructionBalanceDao {
	void AddConstructionBalance(ConstructionBalance constructionBalance);
	List<ConstructionBalance> ListLimitBalance(PageUtil pageUtil);
	int GetTotalCount(PageUtil pageUtil);
 	ConstructionBalance	GetConstructionBalance(String cid);
 	void UpdateConstructionBalance(ConstructionBalance constructionBalance);
}
