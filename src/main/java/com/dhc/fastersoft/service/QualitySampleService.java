package com.dhc.fastersoft.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.dhc.fastersoft.entity.QualitySample;
import com.dhc.fastersoft.entity.StorageStoreHouse;
import com.dhc.fastersoft.utils.LayPage;

@Component
public interface QualitySampleService {


	int add(QualitySample qs);

	int update(QualitySample qs);

	QualitySample getQSById(String id);

	int importExcel(List<QualitySample> list);


	int delete(String id);

	LayPage<QualitySample> list(HttpServletRequest request);

	List<QualitySample> query(HttpServletRequest request);

	List<StorageStoreHouse> getStoreEncode();

	int check(HttpServletRequest request);

	List<QualitySample> getMessage(HashMap<String, Object> map);
	
	void updateSampleStatus(Map<String,String> map);
	
	String getQualityInfo(Map<String,Object> param);
	
	List<QualitySample> query(Map<String,Object> param);

    QualitySample getSampleInfo(Map<String,Object> param);
}
