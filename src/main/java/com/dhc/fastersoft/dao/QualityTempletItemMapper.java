package com.dhc.fastersoft.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.dhc.fastersoft.entity.QualityTempletItem;

public interface QualityTempletItemMapper {
    int insert(QualityTempletItem record);

    int insertSelective(QualityTempletItem record);

	int add(QualityTempletItem entity);

	List<QualityTempletItem> getById(@Param("id")String id);

	int delete(@Param("id")String id);

	int count(@Param("id")String id);

	void addByList(List<QualityTempletItem> data);

}