package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.StoreSupervise;
import com.dhc.fastersoft.entity.StoreSuperviseItem;

public interface StoreSuperviseDao {
    int save(StoreSupervise supervise);

	String getPrimId();

	int update(StoreSupervise supervise);

	StoreSupervise get(String id);

	int count(HashMap<String, String> map);

	List<StoreSupervise> list(HashMap<String, String> map);

	int remove(String id);

	String getCurrSerial();

	int countCheck(HashMap<String, String> map);


	StoreSupervise getMaxSuperiviseYear();
}