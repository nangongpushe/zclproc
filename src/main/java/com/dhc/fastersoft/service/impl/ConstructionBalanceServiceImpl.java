package com.dhc.fastersoft.service.impl;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.dao.ConstructionBalanceDao;
import com.dhc.fastersoft.entity.ConstructionBalance;
import com.dhc.fastersoft.service.ConstructionBalanceService;
import com.dhc.fastersoft.utils.PageUtil;

@Service("ConstructionBalanceService")
public class ConstructionBalanceServiceImpl implements ConstructionBalanceService {

	@Autowired
	private ConstructionBalanceDao constructionBalanceDao;
	
	@Override
	public void AddConstructionBalance(ConstructionBalance constructionBalance) {
		constructionBalance.setId(UUID.randomUUID().toString().replace("-", ""));
		constructionBalanceDao.AddConstructionBalance(constructionBalance);
	}

	@Override
	public List<ConstructionBalance> ListLimitBalance(PageUtil pageUtil) {
		pageUtil.setTotalCount(constructionBalanceDao.GetTotalCount(pageUtil));
		return constructionBalanceDao.ListLimitBalance(pageUtil);
	}

	@Override
	public ConstructionBalance GetConstructionBalance(String cid) {
		return constructionBalanceDao.GetConstructionBalance(cid);
	}

	@Override
	public void UpdateConstructionBalance(ConstructionBalance constructionBalance) {
		constructionBalanceDao.UpdateConstructionBalance(constructionBalance);
	}

}
