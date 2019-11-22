package com.dhc.fastersoft.dao;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import com.dhc.fastersoft.entity.RotateTake;
import com.dhc.fastersoft.utils.PageUtil;

public interface RotateTakeDao {
	void AddRotateTake(RotateTake rotateTake);
	List<RotateTake> ListLimitTake(PageUtil pageUtil);
	int GetTotalCount(PageUtil pageUtil);
	RotateTake GetRotateTake(String id);
	void UpdateRotateTake(RotateTake rotateTake);

    int deleteByMainId(String mainId);

    List<RotateTake> getByMainId(String mainId);

    BigDecimal selectTakeCountByDealSerial(String id);
}
