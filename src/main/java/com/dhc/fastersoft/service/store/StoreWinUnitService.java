package com.dhc.fastersoft.service.store;

import com.dhc.fastersoft.entity.store.StoreWinUnit;
import com.dhc.fastersoft.utils.LayPage;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;


@Component
public interface StoreWinUnitService {
	public LayPage<StoreWinUnit> list(HttpServletRequest request);
	public int add(StoreWinUnit storeWinUnit);
	public int update(StoreWinUnit storeWinUnit);
	public StoreWinUnit getStoreWinUnitByID(String id);
	public int remove(String id);
	public int updateRecommend(String id);
}
