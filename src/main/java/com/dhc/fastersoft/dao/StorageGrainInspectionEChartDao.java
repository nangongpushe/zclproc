package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.StorageGrainInspection;

public interface StorageGrainInspectionEChartDao {
	
	List<StorageGrainInspection> list(HashMap<String, String> map);

}
