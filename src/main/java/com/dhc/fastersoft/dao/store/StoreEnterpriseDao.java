package com.dhc.fastersoft.dao.store;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.dhc.fastersoft.entity.store.StoreEnterprise;
import org.apache.ibatis.annotations.Param;

public interface StoreEnterpriseDao {
	
	public List thisPageQuery(HashMap maps);
	public List pageQuery(HashMap maps);
	public List exportxls(HashMap maps) ;
	public int add(StoreEnterprise storeEnterprise);
	public int update(StoreEnterprise storeEnterprise);
	public int getRecordCount(HashMap maps);
	public int thisGetRecordCount(HashMap maps);
	public int getRecordCount1(HashMap maps);//查询除去6个直属公司的个数
	public StoreEnterprise getStoreEnterpriseById(String id);
	public int remove(String id);
	StoreEnterprise getStoreEnterpriseByEnterpriseName(@Param("enterpriseName") String enterpriseName);
	StoreEnterprise findStroeEnterpriseByWarehouseCode(String warehouseCode);
	public int getenterpriseSerialCount(String enterpriseSerial);
	public List<StoreEnterprise> getStoreEnterpriseByUserId(String id);
	public List<StoreEnterprise> getStoreEnterpriseByWarehouseCode(HashMap maps);
	public List<StoreEnterprise> getAllEnterprise();

	public List<StoreEnterprise> getEnterpriseByIds(Map<String,Object> map);
	public List pageQueryOrderByName(HashMap maps);
	List<StoreEnterprise> getEnterpriseList();
	int getNameById(String id);
	// 获取油管列表 键为库点ID 值为逗号分隔的列表字符串
    List<Map<String,Object>> getStoreAndOilList();

}
