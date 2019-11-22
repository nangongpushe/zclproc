package com.dhc.fastersoft.service;

import java.math.BigDecimal;
import java.util.List;

import com.dhc.fastersoft.entity.RotateTake;
import com.dhc.fastersoft.utils.PageUtil;

public interface RotateTakeService {
	void AddRotateTake(RotateTake rotateTake);
	List<RotateTake> ListLimitTake(PageUtil pageUtil);
	RotateTake GetRotateTake(String id);

    List<RotateTake> getByMainId(String mainId);

    void UpdateRotateTake(RotateTake rotateTake);

    int deleteByMainId(String mainId);

    BigDecimal selectTakeCountByDealSerial(String id);
}
