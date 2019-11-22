package com.dhc.fastersoft.service.store.Impl;

import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.StorageWarehouseDao;
import com.dhc.fastersoft.dao.store.StoreEnterpriseDao;
import com.dhc.fastersoft.dao.store.StoreWinUnitDao;
import com.dhc.fastersoft.dao.system.SysRoleDao;
import com.dhc.fastersoft.dao.system.SysUserDao;
import com.dhc.fastersoft.entity.store.StoreEnterprise;
import com.dhc.fastersoft.entity.store.StoreWinUnit;
import com.dhc.fastersoft.service.store.StoreWinUnitService;
import com.dhc.fastersoft.utils.LayPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;

@Service("StoreWinUnitService")
public class StoreWinUnitServiceImpl implements StoreWinUnitService {
	
	@Autowired
    StoreWinUnitDao storeWinUnitDao;
	@Autowired
    SysRoleDao sysRoleDao;
	@Autowired
    SysUserDao sysUserDao;
	@Autowired
    StorageWarehouseDao storageWarehouseDao;
	@Autowired
    StoreEnterpriseDao storeEnterpriseDao;

	
	@Override
	public int add(StoreWinUnit storeWinUnit) {
		// TODO Auto-generated method stub
		return storeWinUnitDao.add(storeWinUnit);
	}
	
	@Override
	public int update(StoreWinUnit storeWinUnit) {
		// TODO Auto-generated method stub
		return storeWinUnitDao.update(storeWinUnit);
	}
	
	@Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return storeWinUnitDao.remove(id);
	}
	
	@Override
	public StoreWinUnit getStoreWinUnitByID(String id) {
		// TODO Auto-generated method stub
		return storeWinUnitDao.getStoreWinUnitById(id);
	}
	
	@Override
	public LayPage<StoreWinUnit> list(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<StoreWinUnit> page=new LayPage<>();
        HashMap<String,String> maps = QueryUtil.pageQuery(request);
        maps.put("year", request.getParameter("year"));
        maps.put("declareUnit", request.getParameter("declareUnit"));        
        String timeStart = request.getParameter("timeStart");
	    String timeEnd = request.getParameter("timeEnd");
	    maps.put("timeStart", timeStart);
	    maps.put("timeEnd", timeEnd);
	    if(!TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")){
	   		maps.put("regulatoryUnit", TokenManager.getToken().getShortName());
	   	 HashMap<String,Object> map = new HashMap<String, Object>();			
	  	   map.put("warehouseType", "代储库");
	  	   map.put("warehouseShort",  TokenManager.getToken().getShortName());
		       int i= storageWarehouseDao.check(map);
		    
		       if (i>0) {
//		    	   maps.put("declareUnit", TokenManager.getToken().getShortName());
//		    	   maps.put("regulatoryUnit", "");
		    	   map.put("warehouseCode", TokenManager.getToken().getOriginCode());
		    	   map.put("year", "");
		    		List<StoreEnterprise> storeEnterprise = storeEnterpriseDao.getStoreEnterpriseByWarehouseCode(map);
		    		
		    		if (storeEnterprise.size()!=0) {
		    			maps.put("regulatoryUnit", "");
		    			maps.put("declareUnit", storeEnterprise.get(0).getEnterpriseName());
		    		}
		       }
	   	}
//	    SysUser sysUser = sysUserDao.selectByPrimaryKey(TokenManager.getSysUserId());
//		//现获取用户的权限
//		Set<String> types = sysRoleDao.findRoleByUserId(TokenManager.getSysUserId());
//		for (String type : types) {
//			if (type.equals("代储管理员")) {
//				maps.put("creatorId", TokenManager.getSysUserId());
//				
//			}else if (type.equals("库点管理员")) {
//				//去分片监管查库看监管的企业  通过企业编号唯一去查找库的名称
//				maps.put("regulatoryUnit", TokenManager.getToken().getShortName());
//			}
//		}
       
		int count = storeWinUnitDao.getRecordCount(maps);  

        if (count<=0) {
			return page;
		}
        
        List<StoreWinUnit> data= storeWinUnitDao.pageQuery(maps);
        for (StoreWinUnit storeWinUnit : data) {
			if (storeWinUnit.getDeclareUnit().equals(maps.get("declareUnit"))) {
				storeWinUnit.setIsMyself("1");
			}else {
				storeWinUnit.setIsMyself("0");
			}
		}
        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
		return page;
	}
	
	@Override
	public int updateRecommend(String id) {
		// TODO Auto-generated method stub
		return storeWinUnitDao.updateRecommend(id);
	}
}
