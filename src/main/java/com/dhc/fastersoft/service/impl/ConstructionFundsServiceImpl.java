package com.dhc.fastersoft.service.impl;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.dao.ConstructionFundsDao;
import com.dhc.fastersoft.entity.ConstructionFunds;
import com.dhc.fastersoft.service.ConstructionFundsService;
import com.dhc.fastersoft.utils.PageUtil;

@Service("ConstructionFundsService")
public class ConstructionFundsServiceImpl implements ConstructionFundsService {
	
	@Autowired
	private ConstructionFundsDao constructionFundsDao;

	@Override
	public void AddConstructionFunds(ConstructionFunds constructionFunds) {
		constructionFunds.setId(UUID.randomUUID().toString().replace("-", ""));
		constructionFundsDao.AddConstructionFunds(constructionFunds);
	}

	@Override
	public List<ConstructionFunds> ListLimitFunds(PageUtil pageUtil) {
		pageUtil.setTotalCount(constructionFundsDao.GetTotalCount(pageUtil));
		return constructionFundsDao.ListLimitFunds(pageUtil);
	}

	@Override
	public ConstructionFunds GetConstructionFunds(String cid) {
		return constructionFundsDao.GetConstructionFunds(cid);
	}

	@Override
	public void UpdateConstructionFunds(ConstructionFunds constructionFunds) {
		constructionFundsDao.UpdateConstructionFunds(constructionFunds);
	}

	@Override
	public int GetTaotalCount(PageUtil pageUtil) {
		return constructionFundsDao.GetTotalCount(pageUtil);
	}

	@Override
	public List<ConstructionFunds> GetLastInvestment() {
		return constructionFundsDao.GetLastInvestment();
	}
}
