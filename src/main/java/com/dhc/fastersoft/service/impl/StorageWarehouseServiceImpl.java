package com.dhc.fastersoft.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.dhc.fastersoft.common.constants.BusinessConstants;
import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.StorageWarehouseDao;
import com.dhc.fastersoft.dao.system.SysUserDao;
import com.dhc.fastersoft.entity.EnterpriseWarehouse;
import com.dhc.fastersoft.entity.ManuReportData;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.util.HttpUtil;
import com.dhc.fastersoft.utils.LayPage;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.*;
/**
 * 
 * @Title: StorageHouseServiceImpl.java 
 * @Description:
 * @author 何明
 * @date 2017年9月26日 下午5:29:59
 */
@Service("storageWareHouseService")
public class StorageWarehouseServiceImpl implements StorageWarehouseService{
	@Autowired
	public StorageWarehouseDao dao;
	@Autowired
	public SysUserDao sysUserDao;

	@Override
	public int save(StorageWarehouse wareHouse) {
//		wareHouse.setId(dao.getPrimKey());
//		wareHouse.setCreator(TokenManager.getNickname());
		//System.out.println(wareHouse.getWarehouseType());
		if (wareHouse.getEnterpriseName() == null) {
			wareHouse.setEnterpriseName(StorageWarehouseService.WAREHOUSE);
		}
		return dao.save(wareHouse);
	}

	@Override
	public int remove(String id) {
		String url = BusinessConstants.REMOTE_BASE_URL + "/api/receive/warehouse/del/";
		int count = dao.remove(id);
		HttpUtil.postJson(url + id + ".do", "");
		return count;
	}

	@Override
	public int update(StorageWarehouse wareHouse) {
		if (wareHouse.getEnterpriseName() == null) {
			wareHouse.setEnterpriseName(StorageWarehouseService.WAREHOUSE);
		}
		return dao.update(wareHouse);
	}

	@Override
	public LayPage<StorageWarehouse> list(HttpServletRequest request) {
		LayPage<StorageWarehouse> page = new LayPage<>();
		HashMap<String,String> map = QueryUtil.pageQuery(request);

		String province = request.getParameter("province");
		String city = request.getParameter("city");
		String area = request.getParameter("area");
		String name = request.getParameter("name");
		String type = request.getParameter("type");
		String isstop = request.getParameter("isstop");
		map.put("shortName", request.getParameter("shortName"));
		map.put("ishost",request.getParameter("ishost"));
		map.put("isstop",isstop);
		map.put("name", name);
		map.put("province", province);
		map.put("city", city);
		map.put("area", area);
		map.put("type", type);//代储还是仓储
		if("dc".equals(type)){

		}

		//1.如果是仓储 如果是cbl  查看6个库   如果是6个库 比如直属库  查看自己 warehouse_code
		//2.如果是代储dc  如果是cbl  查看所有代储库点  如果是其他  查看自己
		map.put("enterpriseName", StorageWarehouseService.WAREHOUSE);
		SysUser user = TokenManager.getToken();
		//获取6个库点编码
		List kudianCodes = dao.listKudianCode();
		boolean isKudian = kudianCodes.contains(user.getOriginCode());
		if ((user.getOriginCode() != null && user.getOriginCode().equals("CBL")) || //判断是否是公司用户，如果是，便可以看到所有的库点信息
				user.getAccount().equals("admin")) {
			//代储
			if("dc".equals(type)){
				map.put("warehouseCode", "");
				map.put("enterpriseName", "");
				map.put("enterpriseName", request.getParameter("enterpriseName"));
				map.put("enterpriseId", request.getParameter("enterpriseId"));
				map.put("warehouseType","代储库");
			}else{
//				map.put("warehouseCode", user.getOriginCode());
				map.put("enterpriseName", request.getParameter("enterpriseName"));

				map.put("warehouseType","储备库");
			}
		}else if(isKudian){//库点用户可以看所有代储库点
			if("dc".equals(type)){
				map.put("warehouseCode", "");
				map.put("enterpriseName", "");
				map.put("enterpriseName", request.getParameter("enterpriseName"));
				map.put("enterpriseId", request.getParameter("enterpriseId"));
				map.put("warehouseType","代储库");
			}else{
				map.put("warehouseCode", user.getOriginCode());
				map.put("warehouseType","储备库");
			}
		} else{ //代储
			map.put("enterpriseName", user.getCompany());
			map.put("enterpriseId", request.getParameter("enterpriseId"));
			if("dc".equals(type)){

				map.put("warehouseType","代储库");
			}else{

				map.put("warehouseType","储备库");
			}

		}

		int count = dao.count(map);

		if (count <= 0) {
			return page;
		}

		List<StorageWarehouse> data = dao.list(map);
		page.setCount(count);
		page.setData(data);
		page.setCode(0);
		page.setMsg("");
		return page;
	}

	@Override
	public int getToatalCount(HashMap<String, String> map) {
		return dao.count(map);
	}

	@Override
	public StorageWarehouse get(String id) {
		return dao.get(id);
	}

	@Override
	public String getWarehouseName(String warehouseShort) {
		return dao.getWarehouseName(warehouseShort);
	}


	@Override
	public List<String> listWarehouseName() {
		return dao.listWarehouseName();
	}


	@Override
	public List<StorageWarehouse> getAllWarehouse() {
		return dao.getWarehouseList();
	}
	@Override
	public List<StorageWarehouse> getAllWarehouseOrderBy() {
		return dao.getAllWarehouseOrderBy();
	}

	@Override
	public List<StorageWarehouse> listWareHouseByType(String type) {
		return dao.listWareHouseByType(type);
	}

	@Override
	public List<StorageWarehouse> getStorageWarehouseByEnterpriseName(String enterpriseName) {
		return dao.getWareHouseByEnterpriseName(enterpriseName);
	}

	@Override
	public List<StorageWarehouse> listWareHouseByCondition(String warehouseName, String enterpriseName) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("warehouseName", warehouseName);
		map.put("enterpriseName", enterpriseName);
		return dao.listWareHouseByCondition(map);
	}

	@Override
	public LayPage<StorageWarehouse> list(String warehouseName) {
		LayPage<StorageWarehouse> page = new LayPage<>();
        HashMap<String,String> map = new HashMap<>();
        map.put("name", warehouseName);
        map.put("creator", "");
		int count = dao.count(map);
		if (count <= 0) {
			return page;
		}
        
        List<StorageWarehouse> data = dao.list(map);
        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
		return page;
	}


	@Override
	public List<StorageWarehouse> getWarehouseCode(String warehouseName) {
		return dao.getWarehouseCode(warehouseName);
	}

	@Override
	public StorageWarehouse getWarehouseById(String id) {
		return dao.getWarehouseById(id);
	}

	@Override
	public int check(String value, String str) {
		HashMap<String,Object> map = new HashMap();
		try {
			str =  new String(URLDecoder.decode(str,"utf-8"));
			value =  new String(URLDecoder.decode(value,"utf-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		map.put(str, value);
		return dao.check(map);
	}

	@Override
	public LayPage<StorageWarehouse> limitPageList(HttpServletRequest request) {

		SysUser user=TokenManager.getToken();
		//来自远程监管系统
		String  userId=request.getParameter("userId");
		if(userId!=null&&!("").equals(userId)){

			user = sysUserDao.selectByPrimaryKey(userId);

		}
		LayPage<StorageWarehouse> page=new LayPage<>();
		HashMap<String,String> maps = QueryUtil.pageQuery(request);
		maps.put("warehouse_type", request.getParameter("warehouse_type"));
		maps.put("warehouseName", request.getParameter("warehouseName"));
		maps.put("warehouseShort", request.getParameter("warehouseShort"));
		maps.put("enterpriseName", request.getParameter("enterpriseName"));
		maps.put("enterpriseId",request.getParameter("enterpriseId"));
		/*if(!user.getOriginCode().toUpperCase().equals("CBL")) {
			//非公司人员只能看到自己的所属库
			maps.put("warehouseCode",user.getOriginCode());
		}*/
		if(user.getOriginCode() != null) {
			if (!"CBL".equals(user.getOriginCode().toUpperCase())) {
				//非公司人员只能看到自己的所属库
				maps.put("warehouseCode", user.getOriginCode());
			}
		}
		int count = dao.getLimitRecordCount(maps);

		if (count<=0) {
			return page;
		}

		List<StorageWarehouse> data= dao.limitPageQuery(maps);

		page.setCount(count);
		page.setData(data);
		page.setCode(0);
		page.setMsg("");
		return page;
	}

	@Override
	public LayPage<StorageWarehouse> listWarehouseByCompany(HttpServletRequest request) {
		SysUser user=TokenManager.getToken();
		//来自远程监管系统
		String  userId=request.getParameter("userId");
		if(userId!=null&&!("").equals(userId)){
			user = sysUserDao.selectByPrimaryKey(userId);
		}
		LayPage<StorageWarehouse> page=new LayPage<>();
		HashMap<String,String> map = QueryUtil.pageQuery(request);
		Map<String, Object> maps = new HashMap<String,Object>();
		maps.put("start",map.get("start"));
		maps.put("end",map.get("end"));
		maps.put("warehouse_type", request.getParameter("warehouse_type"));
		maps.put("warehouseName", request.getParameter("warehouseName"));
		maps.put("warehouseShort", request.getParameter("warehouseShort"));
		maps.put("enterpriseName", request.getParameter("enterpriseName"));
		maps.put("enterpriseId",request.getParameter("enterpriseId"));

		List kudianCodes = dao.listKudianCode();
		List kudianIds = dao.listKudianId();
		boolean isKudian = kudianCodes.contains(user.getOriginCode());
		/*方法作用: 公司人员选所有库点，6个直属库点选本身和所有代储库点，代储库点选本公司库点*/
		/*if(!user.getOriginCode().toUpperCase().equals("CBL")) {
			//非公司人员只能看到自己的所属库
			maps.put("warehouseCode",user.getOriginCode());
		}*/
		List<StorageWarehouse> storageWarehouses = null;
		if (isKudian) {
			//6个直属库点，不能看到其余5个直属库点的数据
			Iterator<String> it = kudianIds.iterator();
			while(it.hasNext()){
				String item = it.next();
				StorageWarehouse storageWarehouse = dao.getStorageWarehouse(user.getOriginCode());
				if(storageWarehouse.getId().equals(item)){
					it.remove();
				}
			}
			maps.put("excludeWarehouseId",kudianIds);
		}else if("CBL".equals(user.getOriginCode())){
			//公司人员
		}else{
			if(StringUtils.isNotEmpty(user.getOriginCode())) {
				//代储点人员
				//StorageWarehouse storageWarehouse = dao.get(user.getWareHouseId());
				StorageWarehouse storageWarehouse = dao.getStorageWarehouse(user.getOriginCode());
				if (storageWarehouse != null) {
					maps.put("enterpriseId", storageWarehouse.getEnterpriseId());
				}
			}else{
				//如果没有库点代码，按公司人员权限
			}
		}

		int count = dao.countWarehouseByCompany(maps);

		if (count<=0) {
			return page;
		}

		List<StorageWarehouse> data= dao.listWarehouseByCompany(maps);
		page.setCount(count);
		page.setData(data);
		page.setCode(0);
		page.setMsg("");
		return page;
	}
	@Override
	public List<StorageWarehouse> limitList() {
		return dao.limitList();
	}

	@Override
	public List<String> getProxySwtzPointList(String warehouseId){
		return dao.getProxySwtzPointList(warehouseId);
	}

	@Override
	public List<StorageWarehouse> limitListCBL() {
		return dao.limitListCBL();
	}

	@Override
	public List<StorageWarehouse> limitListNOTCBL() {
		return dao.limitListNOTCBL();
	}

	@Override
	public int check(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.check(map);
	}

	@Override
	public StorageWarehouse getStorageWarehouse(String warehouseCode) {
		return dao.getStorageWarehouse(warehouseCode);
	}

	@Override
	public List<StorageWarehouse> listValidWarehouse(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.listValidWarehouse(map);
	}

	@Override
	public int countValidWarehouse(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.countValidWarehouse(map);
	}

	@Override
	public List<StorageWarehouse> listSuperviseOfWarehouse(String warehouseShort) {
		// TODO Auto-generated method stub
		return dao.listSuperviseOfWarehouse(warehouseShort);
	}

	@Override
	public List<StorageWarehouse> listWareHouseByEnterPriseName(Map<String, String> paramMap) {
		 return dao.listWareHouseByEnterPriseName(paramMap);
	}


	@Override
	public List<StorageWarehouse> selectWareHouseByEnterPriseName(Map<String, String> paramMap) {
		return dao.selectWareHouseByEnterPriseName(paramMap);
	}

	@Override
	public List<String> listKudianCode() {
		return dao.listKudianCode();
	}
	@Override
	public List<String> listKudianId() {
		return dao.listKudianId();
	}

	@Override
	public List<String> listEntrepriseId() {
		return dao.listEntrepriseId();
	}
	@Override
	public List<StorageWarehouse> listHostWareHouse() {
		return dao.listHostWareHouse();
	}

	/**
	 * @Description:    根据用户查询库点名称
	 * @Author:         Jovan
	 * @CreateDate:     2018/10/9 22:20
	 * @UpdateUser:     Jovan
	 * @Param wareHouseCode 用户识别标志
	 * @return
	 **/
	@Override
	public List<StorageWarehouse> HostWareHouses(String wareHouseCode) {
		return dao.HostWareHouses(wareHouseCode);
	}

	@Override
	public List<StorageWarehouse> listWarehouseByHost(HttpServletRequest request) {
		HashMap<String,String> map = new HashMap<>();
		map.put("enterpriseId", request.getParameter("enterpriseId"));
		return dao.listWarehouseByHost(map);
	}

	@Override
	public List<StorageWarehouse> limitPageQuery(Map<String, String> map) {
		return dao.limitPageQuery(map);
	}
	@Override
	public StorageWarehouse findConnectorByShortName(String warehouseShort){
		StorageWarehouse storageWarehouse = dao.findConnectorByShortName(warehouseShort);
		return storageWarehouse;
	}

	@Override
	public List<StorageWarehouse> getWarehouseList() {
		return dao.getWarehouseList();
	}

	@Override
	public String getWarehouseIdByShortname(String shortName) {
		return dao.getWarehouseIdByShortname(shortName);
	}
	/**
	 * @Description:    查询库名列表
	 * @Author:         Jovan
	 * @CreateDate:     2018/10/9 14:32
	 * @Param
	 * @return				列表
	 **/
	@Override
	public List<String> getWareHouseList() {
		return dao.selectWareHouseList();
	}

	/**
	 * @Description:    根据库点ID查找仓房
	 * @Author:         Jovan
	 * @CreateDate:     2018/10/9 14:32
	 * @Param
	 * @return				整数
	 **/
	@Override
	public Integer is_exist(String id){
		return dao.selectWareHouse(id);
	}
	/**
	 * @Description:    根据库点ID查找油罐
	 * @Author:         Jovan
	 * @CreateDate:     2018/10/23 19:00
	 * @Param
	 * @return				整数
	 **/
	@Override
	public Integer oilcanFlagIs_exist(String id){
		return dao.selectOilcan(id);
	}
	/**
	 * @Description:    根据warehouse_code查询I
	 * @Author:         Jovan
	 * @CreateDate:     2018/10/12 16:29
	 * @Param
	 * @return      ID
	 **/
	@Override
	public String getWareHouseIdByCode(String code) {
		return dao.selectIdByCode(code);
	}

	@Override
	public String getWarehouseShortById(String warehouseId) {
		return dao.getWarehouseShortById(warehouseId);
	}

	@Override
	public List<String> getWarehouseShortByTypeWithCBK() {
		return dao.getWarehouseShortByTypeWithCBK();
	}

	@Override
	public List<StorageWarehouse> getStoreWarehouseByTypeWithCBK(){
		return dao.getStoreWarehouseByTypeWithCBK();
	}

	@Override
	public int countHostWarehouse(Map<String,Object> param) {
		return dao.countHostWarehouse(param);
	}

	@Override
	public LayPage<StorageWarehouse> selectWarehouseListByEnterprise(HttpServletRequest request) {

		SysUser user=TokenManager.getToken();

		LayPage<StorageWarehouse> page=new LayPage<>();
		HashMap<String,String> maps = QueryUtil.pageQuery(request);
		maps.put("name", request.getParameter("warehouseName"));
		maps.put("shortName", request.getParameter("warehouseShort"));
		if(!user.getOriginCode().toUpperCase().equals("CBL")) {
			//非公司人员只能看到自己的所属库
			StorageWarehouse storageWarehouse = dao.getStorageWarehouse(user.getOriginCode());
			maps.put("enterpriseId",storageWarehouse.getEnterpriseId());
		}else{
			//公司人员可以看到所有库点
		}

		int count = dao.count(maps);

		if (count<=0) {
			return page;
		}

		List<StorageWarehouse> data= dao.selectWarehouseListByEnterprise(maps);

		page.setCount(count);
		page.setData(data);
		page.setCode(0);
		page.setMsg("");
		return page;
	}


	@Override
	public Set<String> getStorageWarehouseShortByEnterpriseId (String enterpriseId){
		Set<String> warehouseShorts = dao.getStorageWarehouseShortByEnterpriseId(enterpriseId);
		return warehouseShorts;
	}


	@Override
	public void reportWarehouse(StorageWarehouse warehouse){
		String reportUrl = BusinessConstants.REMOTE_BASE_URL + "/api/receive/warehouse.do";
		Map<String, Object> dataMap = new HashMap<>();
		dataMap.put("bgrainWarehouseId", warehouse.getId());
		dataMap.put("code", warehouse.getWarehouseCode());
		dataMap.put("name", warehouse.getWarehouseName());
		dataMap.put("warehouseshort", warehouse.getWarehouseShort());
		dataMap.put("warehouseType", StringUtils.indexOfAny("代储", warehouse.getWarehouseType()) == -1 ? 0 : 1);
		dataMap.put("completionDate", warehouse.getCompletionDate());    // 建成日期
		dataMap.put("acreage", warehouse.getAcreage());
		dataMap.put("province", warehouse.getProvince());
		dataMap.put("city", warehouse.getCity());
		dataMap.put("area", warehouse.getArea());
		dataMap.put("address", warehouse.getAddress());
		dataMap.put("longitude", warehouse.getLongitude());
		dataMap.put("latitude", warehouse.getLatitude());
		dataMap.put("orderNo", warehouse.getOrderNo());
		dataMap.put("dredge", StringUtils.equals(warehouse.getIsStop(), "Y") ? 1 : 0);
		dataMap.put("enterpriseId", BusinessConstants.ENTERPRISE_ID );
		HttpUtil.postJson(reportUrl, JSONObject.toJSONString(dataMap));

	}

	@Override
	public List<ManuReportData> manReport(HttpServletRequest request) {
		HashMap<String,String> map = new HashMap<>();
		map.put("enterpriseId", request.getParameter("enterpriseId"));
		return dao.manReport(map);
	}

	@Override
	public List<String> findWareHouseNumberByStorage(String wareHouseId) {
		return dao.findWareHouseNumberByStorage(wareHouseId);
	}

	@Override
	public List<ManuReportData> findWareId(String enterpriseId) {
		return dao.findWareId(enterpriseId);
	}

	@Override
	public List<EnterpriseWarehouse> findAllWareHouseByEnterpriseId(String enterpriseId) {
		return dao.findAllWareHouseByEnterpriseId(enterpriseId);
	}

	@Override
	public List<String> findWareNumberByStorage(String id) {
		return dao.findWareNumberByStorage(id);
	}

    @Override
    public List<ManuReportData> findStoreHouse(HttpServletRequest request) {
        HashMap<String,String> map = new HashMap<>();
        map.put("manuBatNum", request.getParameter("manuBatNum"));
        return dao.findStoreHouse(map);
    }
}
