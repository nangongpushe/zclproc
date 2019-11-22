package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.dhc.fastersoft.entity.StorageOilcan;

public interface StorageOilcanDao {
	
    int save(StorageOilcan oilcan);
    
    String getPrimId();

	int update(StorageOilcan oilcan);

	int count(Map<String, String> map);

	List<StorageOilcan> list(HashMap<String, String> map);

	StorageOilcan get(String id);

	int remove(String id);
	int selectMonthBzw(StorageOilcan oilcan);
	int selectMonthSwtz(StorageOilcan oilcan);
	int selectPlanDetall(StorageOilcan oilcan);
	int selectQualitySample(StorageOilcan oilcan);

	List<StorageOilcan> getBySerialAndWarehouse(String oilcanSerial, String warehouse);
    
}