package com.dhc.fastersoft.service;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.entity.StorageStoreHouseOption;
import com.dhc.fastersoft.utils.LayPage;

public interface StorageStoreHouseOptionService {

	ActionResultModel save(StorageStoreHouseOption option);

	LayPage<StorageStoreHouseOption> list(HttpServletRequest request);

	ActionResultModel remove(String id);

	StorageStoreHouseOption getSingle(String id);

	ActionResultModel update(StorageStoreHouseOption option);
	
}
