package com.dhc.fastersoft.dao;

import java.util.List;

import com.dhc.fastersoft.entity.RotatePerformance;
import com.dhc.fastersoft.utils.PageUtil;

public interface RotatePerformanceDao {
	void AddRotatePerformance(RotatePerformance rotatePerformance);
	List<RotatePerformance> ListLimitPerformance(PageUtil pageUtil);
	int GetTotalCount(PageUtil pageUtil);
 	RotatePerformance GetRotatePerformance(String id);
 	void UpdateRotatePerformance(RotatePerformance rotatePerformance);
}
