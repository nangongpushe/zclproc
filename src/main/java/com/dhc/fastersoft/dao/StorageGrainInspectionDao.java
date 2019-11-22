package com.dhc.fastersoft.dao;

import com.dhc.fastersoft.entity.StorageGrainInspection;
import com.dhc.fastersoft.entity.StorageGrainInspectionTemp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface StorageGrainInspectionDao {
    int save(StorageGrainInspection record);

	String getPrimId();

	int update(StorageGrainInspection grainInspection);

	int count(HashMap<String, String> map);

	StorageGrainInspection get(String id);

	int remove(String id);

	List<StorageGrainInspection> list(HashMap<String, String> map);

	List<StorageGrainInspection> listByWarehouse(HashMap<String, String> map);

	String findMaxDateByWarehouse(HashMap<String, String> map);


	List<StorageGrainInspection> listForECahrt(HashMap<String, String> map);


	List<StorageGrainInspectionTemp> selectStorageGrainInspectionTempByPid(String p_id);

	int getTimeCount(HashMap<String,Object> map);

    List<Map<String,Object>> statistics(Map<String,Object> params);
}