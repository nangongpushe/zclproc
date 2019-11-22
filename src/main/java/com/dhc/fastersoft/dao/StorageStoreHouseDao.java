package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.constraints.Pattern;

import com.dhc.fastersoft.utils.LayPage;
import org.apache.ibatis.annotations.Param;

import com.dhc.fastersoft.entity.StorageStoreHouse;

public interface StorageStoreHouseDao {
	
	int saveForSingle(StorageStoreHouse storageStoreHouse);

	String getNextId();

	int updateForSingle(StorageStoreHouse storageStoreHouse);

	int count(HashMap<String, String> map);
	int count1(HashMap<String, String> map);
	int countOil(HashMap<String, String> map);
	List<StorageStoreHouse> list(HashMap<String, String> map);

	StorageStoreHouse getSingle(@Param("id")String id);

	int remove(@Param("id")String id);

	List<StorageStoreHouse> getStoreEncode();

	String[] getEncodeByWarehouse(@Param("warehouse")String warehouse);

	String[] getEncodeByWarehouseId(@Param("warehouseId")String warehouseId);

	List<StorageStoreHouse> getByEncodeAndWarehouse(String encode, String warehouse);

	String[] getAllEncode();
	int selectMonthBzw(StorageStoreHouse storageStoreHouse);
	int selectMonthSwtz(StorageStoreHouse storageStoreHouse);
	int selectPlanDetall(StorageStoreHouse storageStoreHouse);
	int selectQualitySample(StorageStoreHouse storageStoreHouse);
	List<StorageStoreHouse> listStorehouseOfWarehouse(String warehouseName);

	int proxyCount(HashMap<String, Object> map);

	List<StorageStoreHouse> proxyList(HashMap<String, Object> map);

	List<StorageStoreHouse> listStoreHouseByWarehouseCode(Map<String,Object> map);

	int storeHouseCount(Map<String,Object> map);

	String[] listStoreHouseAndOilCanByWarehouse(@Param("warehouseId")String warehouseId,@Param("warehouseCode")String warehouseCode);

	int getcountByWarehouseId(HashMap<String, String> map);

	List<StorageStoreHouse> findAllByWarehouseId(HashMap<String, String> map);

	List<StorageStoreHouse> listStorehouseOfWarehouseName(Map<String,String> map);

	int countStorehouseOfWarehouseName(Map<String,String> map);

	String[] getEncodeAndOilByWarehouse(@Param("warehouse") String warehouse,@Param("isHasOil") String isHasOil);

	int countStoreHouseByEncode(@Param("encode") String encode,@Param("warehouseId") String warehosueId);
}
