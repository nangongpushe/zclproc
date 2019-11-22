package com.dhc.fastersoft.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.entity.EnterpriseWarehouse;
import com.dhc.fastersoft.entity.ManuReportData;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.utils.LayPage;

public interface StorageWarehouseService {
	
	//库点
	String WAREHOUSE = "浙江省储备粮管理有限公司";
	//代储点
	String STORAGE = null;

	int save(StorageWarehouse warehouse);

	int remove(String id);

	int update(StorageWarehouse warehouse);

	LayPage<StorageWarehouse> list(HttpServletRequest request);

	int getToatalCount(HashMap<String, String> map);

	StorageWarehouse get(String id);

	String getWarehouseName(String warehouseShort);

	List<String> listWarehouseName();

	List<StorageWarehouse> getAllWarehouse();

	List<StorageWarehouse> getAllWarehouseOrderBy();

	List<StorageWarehouse> listWareHouseByType(String type);
	
	List<StorageWarehouse> listWareHouseByCondition(String warehouseName,String enterpriseName);
	
	LayPage<StorageWarehouse> list(String warehouseName);

	List<com.dhc.fastersoft.entity.StorageWarehouse> getWarehouseCode(String warehouseName);
	
	StorageWarehouse getStorageWarehouse(String warehouseCode);

	int check(String value, String str);
	int check(HashMap<String, Object> map);
	List<StorageWarehouse> listValidWarehouse(HashMap<String, Object> map);
	
	int countValidWarehouse(HashMap<String, Object> map);

    LayPage<StorageWarehouse> limitPageList(HttpServletRequest request);

	LayPage<StorageWarehouse> listWarehouseByCompany(HttpServletRequest request);
    List<StorageWarehouse> limitList();

	List<StorageWarehouse> limitListCBL();

	List<StorageWarehouse> limitListNOTCBL();

    List<StorageWarehouse> listSuperviseOfWarehouse(String warehouseShort);

	List<StorageWarehouse> listWareHouseByEnterPriseName(Map<String, String> paramMap);


	List<StorageWarehouse> selectWareHouseByEnterPriseName(Map<String, String> paramMap);

	List<String> listKudianCode();
	List<String> listKudianId();
	List<String> listEntrepriseId();
	//获取当前所有主库点与直属库
	List<StorageWarehouse> listHostWareHouse();

	List<StorageWarehouse> HostWareHouses(String wareHouseCode);

    List<StorageWarehouse> listWarehouseByHost(HttpServletRequest request);

	List<StorageWarehouse> limitPageQuery(Map<String,String> map);

	StorageWarehouse findConnectorByShortName(String warehouseShort);

	/**
	 * 获取所有库点信息
	 * @return
	 */
	List<StorageWarehouse> getWarehouseList();

	/**
	 * 代储点实物台账样品来源列表
	 * @param warehouseId
	 * @return
	 */
	public List<String> getProxySwtzPointList(String warehouseId);

	String getWarehouseIdByShortname(String shortName);

	StorageWarehouse getWarehouseById(String id);

	List<StorageWarehouse> getStorageWarehouseByEnterpriseName(String enterpriseName);

	List<String> getWareHouseList();

	Integer is_exist(String id);

	Integer oilcanFlagIs_exist(String id);

	String getWareHouseIdByCode(String code);

	String getWarehouseShortById(String warehouseId);

	/**
	 * 获取类型为储备库的库点简称
	 * @return
	 */
	List<String> getWarehouseShortByTypeWithCBK();

	/**
	 * 只查询储备库的简称和对应代码,ID
	 * @return
	 */
	List<StorageWarehouse> getStoreWarehouseByTypeWithCBK();

	/**
	 * 根据公司ID查询是否有主库点
	 */
	int countHostWarehouse(Map<String,Object> param);

	LayPage<StorageWarehouse> selectWarehouseListByEnterprise(HttpServletRequest request);

    Set<String> getStorageWarehouseShortByEnterpriseId(String enterpriseId);

    void reportWarehouse(StorageWarehouse warehouse);

    List<ManuReportData> manReport(HttpServletRequest request);

	List<String> findWareHouseNumberByStorage(String wareHouseId);

    List<ManuReportData> findWareId(String enterpriseId);

    List<EnterpriseWarehouse> findAllWareHouseByEnterpriseId(String enterpriseId);

	List<String> findWareNumberByStorage(String id);

    List<ManuReportData> findStoreHouse(HttpServletRequest request);
}
