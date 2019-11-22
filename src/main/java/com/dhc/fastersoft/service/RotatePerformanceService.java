package com.dhc.fastersoft.service;

import java.util.List;

import com.dhc.fastersoft.entity.RotatePerformance;
import com.dhc.fastersoft.utils.PageUtil;

public interface RotatePerformanceService {
	void AddRotatePerformance(RotatePerformance rotatePerformance);
	List<RotatePerformance> ListLimitPerformance(PageUtil pageUtil);
 	RotatePerformance GetRotatePerformance(String id);
 	void UpdateRotatePerformance(RotatePerformance rotatePerformance);
}
