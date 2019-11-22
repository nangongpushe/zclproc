package com.dhc.fastersoft.service.store.Impl;

import com.dhc.fastersoft.common.Constant;
import com.dhc.fastersoft.common.constants.BusinessConstants;
import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.StorageWarehouseDao;
import com.dhc.fastersoft.dao.store.StoreEnterpriseDao;
import com.dhc.fastersoft.dao.system.SysRoleDao;
import com.dhc.fastersoft.dao.system.SysUserDao;
import com.dhc.fastersoft.entity.store.StoreEnterprise;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.store.StoreEnterpriseService;
import com.dhc.fastersoft.utils.LayPage;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Service("StoreEnterpriseService")
public class StoreEnterpriseServiceImpl implements StoreEnterpriseService {
	@Autowired
    StoreEnterpriseDao storeEnterpriseDao;
	@Autowired
    SysUserDao sysUserDao;
	@Autowired
    SysRoleDao sysRoleDao;
	@Autowired
	public StorageWarehouseDao warehouseDao;
	
	@Override
	public int add(StoreEnterprise storeEnterprise) {
		// TODO Auto-generated method stub
		return storeEnterpriseDao.add(storeEnterprise);
	}
	
	@Override
	public int update(StoreEnterprise storeEnterprise) {
		// TODO Auto-generated method stub
		return storeEnterpriseDao.update(storeEnterprise);
	}
	
	@Override
	public StoreEnterprise getStoreEnterpriseByID(String id) {
		// TODO Auto-generated method stub
		return storeEnterpriseDao.getStoreEnterpriseById(id);
	}

	@Override
	public StoreEnterprise getStoreEnterpriseByEnterpriseName(String enterpriseName) {
		return storeEnterpriseDao.getStoreEnterpriseByEnterpriseName(enterpriseName);
	}

	@Override
	public LayPage<StoreEnterprise> ThisList(HttpServletRequest request) {
		LayPage<StoreEnterprise> page=new LayPage<>();
		HashMap<String,String> maps = QueryUtil.pageQuery(request);
		SysUser user = TokenManager.getToken();
		List kudianCodes = warehouseDao.listKudianCode();
		boolean isKudian = kudianCodes.contains(user.getOriginCode());//是否库点用户
		if((user.getOriginCode() != null && user.getOriginCode().equals("CBL")) || //判断是否是公司用户，如果是，便可以看到所有的库点信息
				user.getAccount().equals("admin") || isKudian){
			maps.put("warehouseCode", "");
		}else{ //代储只能看自己
			maps.put("warehouseCode", user.getOriginCode());
		}
		maps.put("enterpriseName", request.getParameter("enterpriseName"));
		maps.put("seniority", request.getParameter("seniority"));
		maps.put("city", request.getParameter("city"));
		maps.put("registType", request.getParameter("registType"));
		maps.put("economicType", request.getParameter("economicType"));
		maps.put("province", request.getParameter("province"));
		maps.put("area", request.getParameter("area"));
		maps.put("enterpriseSerial", request.getParameter("enterpriseSerial"));
		maps.put("isStop", request.getParameter("isStop"));
		maps.put("socialCreditCode", request.getParameter("socialCreditCode"));
//		SysUser sysUser = sysUserDao.selectByPrimaryKey(TokenManager.getSysUserId());
//		//现获取用户的权限
//		Set<String> types = sysRoleDao.findRoleByUserId(TokenManager.getSysUserId());
//		for (String type : types) {
//			if (type.equals("代储管理员")) {
//				//公司
//				maps.put("enterpriseName", sysUser.getCompany());
//				maps.put("warehouseName", "");
//			}else if (type.equals("库点管理员")) {
//				//去分片监管查库看监管的企业  通过企业编号唯一去查找
//				maps.put("enterpriseName", "");
//				maps.put("warehouseName", TokenManager.getToken().getShortName());
//			}
//		}

		maps.put("isEnterpriseType", request.getParameter("isEnterpriseType"));

		int count = storeEnterpriseDao.thisGetRecordCount(maps);

		if (count<=0) {
			return page;
		}

		List<StoreEnterprise> data= storeEnterpriseDao.thisPageQuery(maps);

		page.setCount(count);
		page.setData(data);
		page.setCode(0);
		page.setMsg("");
		return page;
	}

	@Override
	public StoreEnterprise findStroeEnterpriseByWarehouseCode(String warehouseCode){
		return storeEnterpriseDao.findStroeEnterpriseByWarehouseCode(warehouseCode);
	}

	@Override
	public LayPage<StoreEnterprise> list(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<StoreEnterprise> page=new LayPage<>();
        HashMap<String,String> maps = QueryUtil.pageQuery(request);
		SysUser user = TokenManager.getToken();
		List kudianCodes = warehouseDao.listKudianCode();
		boolean isKudian = kudianCodes.contains(user.getOriginCode());//是否库点用户
		if((user.getOriginCode() != null && user.getOriginCode().equals("CBL")) || //判断是否是公司用户，如果是，便可以看到所有的库点信息
			user.getAccount().equals("admin") || isKudian){
			maps.put("warehouseCode", "");
		}else{ //代储只能看自己
			maps.put("warehouseCode", user.getOriginCode());
		}
        maps.put("enterpriseName", request.getParameter("enterpriseName"));
		maps.put("seniority", request.getParameter("seniority"));
		maps.put("city", request.getParameter("city"));
		maps.put("registType", request.getParameter("registType"));
		maps.put("economicType", request.getParameter("economicType"));
		maps.put("province", request.getParameter("province"));
		maps.put("area", request.getParameter("area"));
		maps.put("enterpriseSerial", request.getParameter("enterpriseSerial"));
		maps.put("isStop", request.getParameter("isStop"));
		maps.put("socialCreditCode", request.getParameter("socialCreditCode"));
//		SysUser sysUser = sysUserDao.selectByPrimaryKey(TokenManager.getSysUserId());
//		//现获取用户的权限
//		Set<String> types = sysRoleDao.findRoleByUserId(TokenManager.getSysUserId());
//		for (String type : types) {
//			if (type.equals("代储管理员")) {
//				//公司
//				maps.put("enterpriseName", sysUser.getCompany());
//				maps.put("warehouseName", "");
//			}else if (type.equals("库点管理员")) {
//				//去分片监管查库看监管的企业  通过企业编号唯一去查找
//				maps.put("enterpriseName", "");
//				maps.put("warehouseName", TokenManager.getToken().getShortName());
//			}
//		}

		maps.put("isEnterpriseType", request.getParameter("isEnterpriseType"));

		int count = storeEnterpriseDao.getRecordCount(maps);

        if (count<=0) {
			return page;
		}
        
        List<StoreEnterprise> data= storeEnterpriseDao.pageQuery(maps);
        
        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
		return page;
	}
	
	@Override
	public List<StoreEnterprise> exportxls(HttpServletRequest request) {
		// TODO Auto-generated method stub
		List<StoreEnterprise> page=new ArrayList();
        HashMap<String,String> maps = new HashMap<String, String>();
        maps.put("enterpriseName", request.getParameter("enterpriseName"));
		maps.put("seniority", request.getParameter("seniority"));
		maps.put("city", request.getParameter("city"));
		maps.put("registType", request.getParameter("registType"));
		maps.put("economicType", request.getParameter("economicType"));
		maps.put("province", request.getParameter("province"));
		maps.put("area", request.getParameter("area"));
		maps.put("isStop", request.getParameter("isStop"));
		//现获取用户的权限
		SysUser sysUser = sysUserDao.selectByPrimaryKey(TokenManager.getSysUserId());
		//现获取用户的权限
		Set<String> types = sysRoleDao.findRoleByUserId(TokenManager.getSysUserId());
		for (String type : types) {
			if (type.equals("代储管理员")) {
				//公司
				maps.put("enterpriseName", sysUser.getCompany());
				maps.put("warehouseName", "");
			}else if (type.equals("库点管理员")) {
				//去分片监管查库看监管的企业  通过企业编号唯一去查找
				maps.put("enterpriseName", "");
				maps.put("warehouseName", warehouseDao.getStorageWarehouse(TokenManager.getToken().getOriginCode()).getWarehouseShort());
			}
		}
	
		return storeEnterpriseDao.exportxls(maps);
	}
	
	@Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return storeEnterpriseDao.remove(id);
	}
	public int existCount(String id) {
		// TODO Auto-generated method stub
		return storeEnterpriseDao.getNameById(id);
	}

	@Override
	public int getenterpriseSerialCount(String enterpriseSerial) {
		// TODO Auto-generated method stub
		return storeEnterpriseDao.getenterpriseSerialCount(enterpriseSerial);
	}
	
	@Override
	public List<StoreEnterprise> getStoreEnterpriseByUserId(String id){
		// TODO Auto-generated method stub
		return storeEnterpriseDao.getStoreEnterpriseByUserId(id);
	}
	
	@Override
	public List<StoreEnterprise> getStoreEnterpriseByWarehouseCode(HashMap maps) {
		// TODO Auto-generated method stub
		return storeEnterpriseDao.getStoreEnterpriseByWarehouseCode(maps);
	}

	@Override
	public List<StoreEnterprise> getAllEnterprise() {
		// TODO Auto-generated method stub
		return storeEnterpriseDao.getAllEnterprise();
	}

	@Override
	public List<StoreEnterprise> getEnterpriseByIds(Map<String,Object> map) {
		// TODO Auto-generated method stub
		return storeEnterpriseDao.getEnterpriseByIds(map);
	}

	@Override
	public List<StoreEnterprise> getEnterpriseList() {
		return storeEnterpriseDao.getEnterpriseList();
	}

	List<StoreEnterprise> data2=new ArrayList<StoreEnterprise>();
	@Override
	public LayPage<StoreEnterprise> enterpriseList(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<StoreEnterprise> page=new LayPage<>();
		HashMap<String,String> maps = QueryUtil.pageQuery(request);
		SysUser user = TokenManager.getToken();
		List kudianCodes = warehouseDao.listKudianCode();
		boolean isKudian = kudianCodes.contains(user.getOriginCode());//是否库点用户
		if((user.getOriginCode() != null && user.getOriginCode().equals("CBL")) || //判断是否是公司用户，如果是，便可以看到所有的库点信息
				user.getAccount().equals("admin") || isKudian){
			maps.put("warehouseCode", "");
		}else{ //代储只能看自己
			maps.put("warehouseCode", user.getOriginCode());
		}
		String enterpriseName =  request.getParameter("enterpriseName");
		maps.put("enterpriseName",enterpriseName);
		maps.put("seniority", request.getParameter("seniority"));
		maps.put("city", request.getParameter("city"));
		maps.put("registType", request.getParameter("registType"));
		maps.put("economicType", request.getParameter("economicType"));
		maps.put("province", request.getParameter("province"));
		maps.put("area", request.getParameter("area"));
		maps.put("enterpriseSerial", request.getParameter("enterpriseSerial"));
		maps.put("isEnterpriseType", request.getParameter("isEnterpriseType"));


		int count = storeEnterpriseDao.getRecordCount(maps);
		int c=0;


		List<StoreEnterprise> data= storeEnterpriseDao.pageQuery(maps);

		if((user.getOriginCode() != null && user.getOriginCode().equals("CBL")) || //判断是否是公司用户，如果是，便可以看到所有的库点信息
				user.getAccount().equals("admin") || isKudian){
			c=count+1;
			if (data.size()<10||enterpriseName==Constant.HOME_WAREHOUSE){
				StoreEnterprise enterprise = new StoreEnterprise();
				enterprise.setEnterpriseName(Constant.HOME_WAREHOUSE);
				data.add(enterprise);
			}

//			count++;
		}else {
			c=count;
		}
		if (c<=0) {
			return page;
		}
		page.setCount(c);
		page.setData(data);
		page.setCode(0);
		page.setMsg("");
		return page;
	}

	@Override
	public LayPage<StoreEnterprise> listOrderByName(HttpServletRequest request) {
		// TODO Auto-generated method stub
		SysUser user = TokenManager.getToken();
		HashMap<String,String> maps = QueryUtil.pageQuery(request);

		LayPage<StoreEnterprise> page=new LayPage<>();

		//直属库：originCode
		List directlyWarehouseCodeList = warehouseDao.listKudianCode();
		boolean isDirectly = directlyWarehouseCodeList.contains(user.getOriginCode());//是否直属库点用户

		//判断是否是公司用户，如果是，便可以看到所有的库点信息
		if((user.getOriginCode() != null && BusinessConstants.CBL_CODE.equals(user.getOriginCode().toLowerCase()))
				|| user.getAccount().equals("admin")
				|| isDirectly){
			maps.put("warehouseCode", "");
		}else{ //代储只能看自己
			maps.put("warehouseCode", user.getOriginCode());
		}
		maps.put("enterpriseName", request.getParameter("enterpriseName"));
		maps.put("seniority", request.getParameter("seniority"));
		maps.put("city", request.getParameter("city"));
		maps.put("registType", request.getParameter("registType"));
		maps.put("economicType", request.getParameter("economicType"));
		maps.put("province", request.getParameter("province"));
		maps.put("area", request.getParameter("area"));
		maps.put("enterpriseSerial", request.getParameter("enterpriseSerial"));
//		SysUser sysUser = sysUserDao.selectByPrimaryKey(TokenManager.getSysUserId());
//		//现获取用户的权限
//		Set<String> types = sysRoleDao.findRoleByUserId(TokenManager.getSysUserId());
//		for (String type : types) {
//			if (type.equals("代储管理员")) {
//				//公司
//				maps.put("enterpriseName", sysUser.getCompany());
//				maps.put("warehouseName", "");
//			}else if (type.equals("库点管理员")) {
//				//去分片监管查库看监管的企业  通过企业编号唯一去查找
//				maps.put("enterpriseName", "");
//				maps.put("warehouseName", TokenManager.getToken().getShortName());
//			}
//		}


		int count = storeEnterpriseDao.getRecordCount1(maps);

		if (count<=0) {
			return page;
		}

		List<StoreEnterprise> data= storeEnterpriseDao.pageQueryOrderByName(maps);

		page.setCount(count);
		page.setData(data);
		page.setCode(0);
		page.setMsg("");
		return page;
	}
}
