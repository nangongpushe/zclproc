package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;

import com.dhc.fastersoft.entity.Consumables;


/**
* @ClassName: ConsumablesDao
* @Description: 易耗品
* @author 张乐
* @date 2017年9月28日 下午3:08:23
 */
public interface ConsumablesDao {
	public List pageQuery(HashMap maps);
	public int add(Consumables consumables);
	public int update(Consumables consumables);
	public int updateApply(Consumables consumables);
	public int getRecordCount(HashMap maps);	
	public Consumables getConsumablesById(String id);
	public int remove(String id);
}
