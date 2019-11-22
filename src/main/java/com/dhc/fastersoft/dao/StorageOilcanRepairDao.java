package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.StorageOilcanRepair;

public interface StorageOilcanRepairDao {

	int countByOilcanId(String oilcanId);//

	int removeByOilcanId(String oilcanId);//
	
	int save(StorageOilcanRepair oilcanRepair);//

	String getPrimId();//

	int count(HashMap<String, String> map);//

	List<StorageOilcanRepair> list(HashMap<String, String> map);//

	int remove(String id);//

	StorageOilcanRepair get(String id);//
	
	int update(StorageOilcanRepair oilcanRepair);

}
