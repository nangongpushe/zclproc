package com.dhc.fastersoft.service;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.entity.StoreSupervise;
import com.dhc.fastersoft.entity.StoreSuperviseItem;
import com.dhc.fastersoft.utils.LayPage;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface StoreSuperviseService {

	ActionResultModel save(StoreSupervise supervise);

	ActionResultModel update(StoreSupervise supervise);

	StoreSupervise get(String id);

	LayPage<StoreSupervise> list(HttpServletRequest request);

	ActionResultModel remove(String id);

	String getCurrSerial();
	
	List<StoreSuperviseItem> listStoreSuperviseItems(String warehouseName);

	int check(HttpServletRequest request);

	StoreSupervise getMaxSuperiviseYear();

}
