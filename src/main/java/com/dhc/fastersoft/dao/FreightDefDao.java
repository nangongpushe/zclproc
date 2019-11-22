package com.dhc.fastersoft.dao;

import com.dhc.fastersoft.entity.FreightDef;
import com.dhc.fastersoft.entity.system.SysDict;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


public interface FreightDefDao {
    int insert(FreightDef freightDef);
    int updateByPrimaryKey(FreightDef freightDef);
    int getRecordCount(HashMap<String, String> maps);
    List<FreightDef> pageQuery(HashMap<String, String> maps);
    FreightDef selectByPrimaryKey(Object id);
    List<FreightDef> selectByShipType(String shipType);
    List<FreightDef> selectByType(Map<String,String> map);
    int deleteByPrimaryKey(String id);
}
