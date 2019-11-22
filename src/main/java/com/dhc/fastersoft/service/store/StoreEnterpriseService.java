package com.dhc.fastersoft.service.store;

import com.dhc.fastersoft.entity.store.StoreEnterprise;
import com.dhc.fastersoft.utils.LayPage;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public interface StoreEnterpriseService {
	public int add(StoreEnterprise storeEnterprise);
	public int update(StoreEnterprise storeEnterprise);
	public StoreEnterprise getStoreEnterpriseByID(String id);
	StoreEnterprise getStoreEnterpriseByEnterpriseName(String enterpriseName);
	public LayPage<StoreEnterprise> ThisList(HttpServletRequest request);
	public LayPage<StoreEnterprise> list(HttpServletRequest request);
	public LayPage<StoreEnterprise> listOrderByName(HttpServletRequest request);
	public List<StoreEnterprise> exportxls(HttpServletRequest request);

	public int remove(String id);
	public int existCount(String id);
	public int getenterpriseSerialCount(String enterpriseSerial);
	public List<StoreEnterprise> getStoreEnterpriseByUserId(String id);
	public List<StoreEnterprise> getStoreEnterpriseByWarehouseCode(HashMap maps);
	public List<StoreEnterprise> getAllEnterprise();
	public List<StoreEnterprise> getEnterpriseByIds(Map<String,Object> map);
	List<StoreEnterprise> getEnterpriseList();

	public LayPage<StoreEnterprise> enterpriseList(HttpServletRequest request);
	public StoreEnterprise findStroeEnterpriseByWarehouseCode(String warehouseCode);

}
