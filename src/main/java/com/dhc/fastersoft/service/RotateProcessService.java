package com.dhc.fastersoft.service;

import java.util.List;

import com.dhc.fastersoft.entity.RotateProcess;
import com.dhc.fastersoft.entity.RotateProcessDetail;
import com.dhc.fastersoft.utils.PageUtil;

public interface RotateProcessService {
	void AddRotateProcess(RotateProcess rotateProcess);
	List<RotateProcess> ListLimitProcess(PageUtil pageUtil);
    RotateProcess GetRotateProcess(String id);
    void UpdateRotateProcess(RotateProcess rotateProcess);
    void UpdateRotateProcessState(RotateProcess rotateProcess);
    void deleteRotateProcess(String id);
    List<RotateProcessDetail> GetRotateProcessDetailByDealSerial(String dealSerial);
}
