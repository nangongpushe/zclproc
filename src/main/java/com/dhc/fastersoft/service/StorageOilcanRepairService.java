package com.dhc.fastersoft.service;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.entity.StorageOilcanRepair;
import com.dhc.fastersoft.utils.LayPage;

public interface StorageOilcanRepairService {

	ActionResultModel save(StorageOilcanRepair repair);

	ActionResultModel update(StorageOilcanRepair repair);

	LayPage<StorageOilcanRepair> list(HttpServletRequest request);

	ActionResultModel remove(String id);

	StorageOilcanRepair get(String id);

}
