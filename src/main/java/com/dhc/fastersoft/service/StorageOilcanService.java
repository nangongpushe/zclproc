package com.dhc.fastersoft.service;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.entity.StorageOilcan;
import com.dhc.fastersoft.utils.LayPage;

public interface StorageOilcanService {
	
	ActionResultModel save(StorageOilcan oilcan);

	ActionResultModel update(StorageOilcan oilcan);

	LayPage<StorageOilcan> list(HttpServletRequest request);

	StorageOilcan get(String id);

	ActionResultModel remove(String id);
	
	LayPage<StorageOilcan> list(String warehouse);

	int getcountByWarehouseId(String warehouseId);

}
