package com.dhc.fastersoft.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.entity.StorageStoreHouse;
import com.dhc.fastersoft.utils.LayPage;

public interface StorageStoreHouseService {
	
	ActionResultModel saveForSingle(StorageStoreHouse storageStoreHouse);

	ActionResultModel updateForSingle(StorageStoreHouse storageStoreHouse);

	LayPage<StorageStoreHouse> list(HttpServletRequest request);

	LayPage<StorageStoreHouse> proxyList(HttpServletRequest request);

	StorageStoreHouse getSingle(String id);

	ActionResultModel remove(String id);

	String[] getEncodeByWarehouse(String warehouse);

	String[] getEncodeByWarehouseId(String warehouseId);

	List<StorageStoreHouse> getByEncodeAndWarehouse(String encode, String warehouse);

	String[] getAllEncode();
	
	List<StorageStoreHouse> listStorehouseOfWarehouse(String warehouseName);
	
	LayPage<StorageStoreHouse> list(String warehouse);

	List<String> listKudianCode();

	LayPage<StorageStoreHouse> listStoreHouseByWarehouseCode(Map<String,Object> map);

	String[] listStoreHouseAndOilCanByWarehouse(String warehouseId,String warehouseCode);

	int getcountByWarehouseId(String warehouseId);

	List<StorageStoreHouse> findAllByWarehouseId(HttpServletRequest request,String warehouseId);

	public LayPage<StorageStoreHouse> storeHouseListByWarehouseName(HttpServletRequest request,String warehouseName);

	public String[] getEncodeAndOilByWarehouse(String warehouse,String isHasOil);

	int countStoreHouseByEncode(String encode, String warehouseId);

    void reportStorehouse(StorageStoreHouse storeHouse);
}
