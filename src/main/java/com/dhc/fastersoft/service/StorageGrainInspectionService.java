package com.dhc.fastersoft.service;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.entity.StorageGrainInspection;
import com.dhc.fastersoft.entity.StorageGrainInspectionEChart;
import com.dhc.fastersoft.entity.StorageGrainInspectionTemp;
import com.dhc.fastersoft.utils.LayPage;
import org.apache.poi.ss.usermodel.Workbook;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface StorageGrainInspectionService {

	ActionResultModel save(StorageGrainInspection grainInspection);

	ActionResultModel update(StorageGrainInspection grainInspection);

	ActionResultModel remove(String id);

	StorageGrainInspection get(String id);

	LayPage<StorageGrainInspection> list(HttpServletRequest request);

	StorageGrainInspectionEChart getEChartData(HttpServletRequest request);
	
	//查询小表
	List<StorageGrainInspectionTemp> selectStorageGrainInspectionTempByPid(String p_id);

	List<StorageGrainInspection> listByWarehouse(HashMap<String, String> map);

	String findMaxDateByWarehouse(HashMap<String, String> map);
	int getTimeCount(HashMap<String,Object> map);

	LayPage statistics(Integer pageNum,Integer pageSize,Map<String,Object> params);

	Workbook excel(Map<String, Object> params);

    void reportGrainSituation(StorageGrainInspection storageGrainInspection) throws Exception;

	void reportGrainInspection(StorageGrainInspection storageGrainInspection);
}
