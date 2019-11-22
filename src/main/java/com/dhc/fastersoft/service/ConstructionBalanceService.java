package com.dhc.fastersoft.service;

import java.util.List;

import com.dhc.fastersoft.entity.ConstructionBalance;
import com.dhc.fastersoft.utils.PageUtil;

public interface ConstructionBalanceService {
	void AddConstructionBalance(ConstructionBalance constructionBalance);
	List<ConstructionBalance> ListLimitBalance(PageUtil pageUtil);
 	ConstructionBalance	GetConstructionBalance(String cid);
 	void UpdateConstructionBalance(ConstructionBalance constructionBalance);
}
