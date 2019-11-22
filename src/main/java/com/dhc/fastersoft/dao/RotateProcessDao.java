package com.dhc.fastersoft.dao;

import java.util.List;

import com.dhc.fastersoft.entity.RotateProcess;
import com.dhc.fastersoft.entity.RotateProcessDetail;
import com.dhc.fastersoft.utils.PageUtil;

public interface RotateProcessDao {
	void AddRotateProcess(RotateProcess rotateProcess);
	List<RotateProcess> ListLimitProcess(PageUtil pageUtil);
	int GetTotalCount(PageUtil pageUtil);
    RotateProcess GetRotateProcess(String id);
    void UpdateRotateProcess(RotateProcess rotateProcess);
    void UpdateRotateProcessState(RotateProcess rotateProcess);
    List<RotateProcessDetail> GetRotateProcessDetailByDealSerial(String dealSerial);
    public void deleteRotateProcess(String id);
}
