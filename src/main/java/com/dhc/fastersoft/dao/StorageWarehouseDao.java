package com.dhc.fastersoft.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.dhc.fastersoft.entity.EnterpriseWarehouse;
import com.dhc.fastersoft.entity.ManuReportData;
import org.apache.ibatis.annotations.Param;

import com.dhc.fastersoft.entity.StorageWarehouse;
import org.springframework.stereotype.Component;

/**
 * 
 * @Title: StorageHouseDao.java 
 * @Description:
 * @author 何明
 * @date 2017年9月26日 下午5:09:07
 */
@Component
public interface StorageWarehouseDao {
	/**
	 * 
	 * @Title: save
	 * @Description: 新增单条库点信息
	 * @param storageHouse
	 * @return
	 * @return int
	 * @author 何明
	 * @date 2017年9月26日 下午5:12:11
	 */
	int save(StorageWarehouse storageHouse);
	/**
	 * 
	 * @Title: updateSingleStorageHouse 
	 * @Description: 更新单条库点信息
	 * @param storageHouse
	 * @return
	 * @return int
	 * @author 何明
	 * @date 2017年9月26日 下午5:15:36
	 */
	int update(StorageWarehouse storageHouse);
	/**
	 * 
	 * @Title: deleteSingleStorageHouseById 
	 * @Description: 通过id删除数据
	 * @param id
	 * @return
	 * @return int
	 * @author 何明
	 * @date 2017年9月26日 下午5:18:46
	 */
	int remove(String id);
	/**
	 * 
	 * @Title: getPrimKey 
	 * @Description:
	 * @return
	 * @return String
	 * @author 何明
	 * @date 2017年9月28日 下午2:51:57
	 */
	String getPrimKey();
	/**
	 * 
	 * @Title: count 
	 * @Description:
	 * @param map
	 * @return
	 * @return int
	 * @author 何明
	 * @date 2017年9月30日 下午4:26:07
	 */
	int count(HashMap<String, String> map);
	/**
	 * 
	 * @Title: list 
	 * @Description:
	 * @param map
	 * @return
	 * @return List<StorageWarehouse>
	 * @author 何明
	 * @date 2017年9月30日 下午4:26:55
	 */
	List<StorageWarehouse> list(HashMap<String, String> map);
	/**
	 * 
	 * @Title: get
	 * @Description:
	 * @param id
	 * @return
	 * @return StorageWarehouse
	 * @author 何明
	 * @date 2017年9月30日 下午4:26:55
	 */
	StorageWarehouse get(String id);

	/**
	 * 
	 * @param
	 * @return
	 */
	List<String> listWarehouseName();

	/**
	 * 
	 * @Title: getAllWarehouse 
	 * @Description:
	 * @param @return
	 * @return String[]
	 * @author HeMing
	 * @date 2017年10月26日 下午7:46:53
	 */
	List<StorageWarehouse> getAllWarehouse();
/*
* 	按顺序查出库点
* */
	List<StorageWarehouse> getAllWarehouseOrderBy();

	/**
	 * 通过类型获取到库点或代储点
	 *
	 * @param type 类型
	 * @return
	 */
	List<StorageWarehouse> listWareHouseByType(String type);
	/**
	 * 
	 * @param map
	 * @return
	 */
	List<StorageWarehouse> listWareHouseByCondition(HashMap<String, Object> map);
	List<StorageWarehouse> getWarehouseCode(@Param("warehouseName")String warehouseName);
	/**
	 * 验证 重复
	 * @param map
	 * @return
	 */
	int check(HashMap<String, Object> map);
	
	/** 
	* @Title: getStorageWarehouse 
	* @Description: 根据 库点编码 查询 库点管理
	*/ 
	
	StorageWarehouse getStorageWarehouse(String warehouseCode);

    int getLimitRecordCount(HashMap<String, String> maps);

	/**
	 * 获取监管范围内的库点包括直属库点
	 * @param maps
	 * @return
	 */
	List<StorageWarehouse> limitPageQuery(Map<String, String> maps);

    List<StorageWarehouse> limitList();

	/**
	 * 非代储点
	 * @return
	 */
	List<StorageWarehouse> limitListCBL();

	/**
	 * 代储点
	 * @return
	 */
	List<StorageWarehouse> limitListNOTCBL();
	/**
	 * 库点及有效的代储点
	 * @param map
	 * @return
	 */
	List<StorageWarehouse> listValidWarehouse(HashMap<String, Object> map);
	/**
	 * 库点及有效的代储点总条数
	 * @param map
	 * @return
	 */
	int countValidWarehouse(HashMap<String, Object> map);
	
	List<StorageWarehouse> listSuperviseOfWarehouse(String warehouseShort);

    List<String> listKudianCode();
	List<String> listKudianId();
	List<String> listEntrepriseId();
	/**
	 * 根据公司名称或库点代码获取库点信息
	 * @param paramMap
	 * @return
	 */
	List<StorageWarehouse> listWareHouseByEnterPriseName(Map<String, String> paramMap);


	List<StorageWarehouse> selectWareHouseByEnterPriseName(Map<String, String> paramMap);

	/**
	 * 主库点和直属
	 * @return
	 */
	List<StorageWarehouse> listHostWareHouse();

	/**
	 * 根据用户的主库点和直属
	 * @return
	 */
	List<StorageWarehouse> HostWareHouses(@Param("wareHouseCode") String wareHouseCode);

	List<StorageWarehouse> listWarehouseByHost(HashMap<String,String> map);

	/**
	 * 根据库点简称查全称
	 * @return
	 */
	String getWarehouseName(String warehouseShort);


	StorageWarehouse findConnectorByShortName(String warehouseShort);

	List<StorageWarehouse> getWarehouseList();

	String getWarehouseIdByShortname(String shortName);

	StorageWarehouse getWarehouseById(String id);

	List<StorageWarehouse> getWareHouseByEnterpriseName(String enterpriseName);

	List<String> selectWareHouseList();
	/**
	 * 根据库点查找仓房
	 * @return
	 */
	Integer selectWareHouse(String id);
	/**
	 * 根据库点查找油罐
	 * @return
	 */
	Integer selectOilcan(String id);
	/**
	 * 根据wareHouse_code获取ID
	 */
	String selectIdByCode(String code);

	/**
	 * 代储点实物台账样品来源列表
	 * @param warehouseId
	 * @return
	 */
    List<String> getProxySwtzPointList(String warehouseId);

    String getWarehouseShortById(String id);


    List<String> getWarehouseShortByTypeWithCBK();


	List<StorageWarehouse> getWarehouseByCondition(HashMap<String,Object> map);

	/**
	 * 只查询储备库的简称和对应代码,ID
	 * @return
	 */
	List<StorageWarehouse> getStoreWarehouseByTypeWithCBK();


	/**
	 * 根据企业ID 查询是否存在除输入库点之外的主库点
	 * @return
	 */
    int countHostWarehouse(Map<String,Object> param);


	List<StorageWarehouse> selectWarehouseListByEnterprise(HashMap<String,String> map);

	Set<String> getStorageWarehouseShortByEnterpriseId(String enterpriseId);

	List<StorageWarehouse> listWarehouseByCompany(Map<String,Object> map);

	int countWarehouseByCompany(Map<String, Object> maps);

    List<ManuReportData> manReport(HashMap<String, String> map);

	List<String> findWareHouseNumberByStorage(String wareHouseId);

    List<ManuReportData> findWareId(String enterpriseId);

    List<EnterpriseWarehouse> findAllWareHouseByEnterpriseId(String enterpriseId);

    List<String> findWareNumberByStorage(String id);

    List<ManuReportData> findStoreHouse(HashMap<String, String> map);
}
