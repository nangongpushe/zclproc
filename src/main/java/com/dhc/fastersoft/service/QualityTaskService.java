package com.dhc.fastersoft.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.dhc.fastersoft.entity.QualitySample;
import com.dhc.fastersoft.entity.QualityTask;
import com.dhc.fastersoft.utils.LayPage;
@Component
public interface QualityTaskService {

	LayPage<QualityTask> list(HttpServletRequest request);

	QualityTask getByID(String id);

	int remove(String id);

	int add(QualityTask entity);

	int update(QualityTask entity);

	List query(HttpServletRequest request);


	int check(HttpServletRequest request);
	
	boolean checkBySampleNo(String sampleNo);

}
