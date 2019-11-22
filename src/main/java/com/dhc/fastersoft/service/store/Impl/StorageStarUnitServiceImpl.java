package com.dhc.fastersoft.service.store.Impl;

import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.StorageWarehouseDao;
import com.dhc.fastersoft.dao.store.StorageStarUnitDao;
import com.dhc.fastersoft.dao.system.SysRoleDao;
import com.dhc.fastersoft.dao.system.SysUserDao;
import com.dhc.fastersoft.entity.store.StorageStarUnit;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.store.StorageStarUnitService;
import com.dhc.fastersoft.utils.LayPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

@Service("StorageStarUnitService")
public class StorageStarUnitServiceImpl implements StorageStarUnitService {
	@Autowired
    StorageStarUnitDao storageStarUnitDao;
	@Autowired
    SysUserDao sysUserDao;
	@Autowired
    SysRoleDao sysRoleDao;
	@Autowired
    StorageWarehouseDao storageWarehouseDao;
	
	@Override
	public int add(StorageStarUnit storageStarUnit) {
		// TODO Auto-generated method stub
		return storageStarUnitDao.add(storageStarUnit);
	}
	
	@Override
	public int update(StorageStarUnit storageStarUnit) {
		// TODO Auto-generated method stub
		return storageStarUnitDao.update(storageStarUnit);
	}
	
	@Override
	public StorageStarUnit getStorageStarUnitByID(String id) {
		// TODO Auto-generated method stub
		return storageStarUnitDao.getStorageStarUnitById(id);
	}
	
	@Override
	public LayPage<StorageStarUnit> list(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<StorageStarUnit> page=new LayPage<>();
        HashMap<String,String> maps = QueryUtil.pageQuery(request);
        maps.put("warehouse", request.getParameter("warehouse"));
		maps.put("warehouseId", request.getParameter("warehouseId"));
		maps.put("postalAddress", request.getParameter("postalAddress"));
		maps.put("oldLevel", request.getParameter("oldLevel"));
		maps.put("type", request.getParameter("type"));
		
//	      SysUser sysUser = sysUserDao.selectByPrimaryKey(TokenManager.getSysUserId());
//			//现获取用户的权限
//			Set<String> types = sysRoleDao.findRoleByUserId(TokenManager.getSysUserId());
//			for (String type : types) {
//				if (type.equals("代储管理员")) {
//					maps.put("creatorId", TokenManager.getSysUserId());
//					maps.put("storehouse", "");
//					break;
//				}else if (type.equals("库点管理员")) {
//					//去分片监管查库看监管的企业  通过企业编号唯一去查找库的名称
//					maps.put("storehouse", sysUser.getCompany());
//					maps.put("creatorId", "");
//					break;
//				}
//			}
		 if(!TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")){
		   		maps.put("storehouse", TokenManager.getToken().getShortName());
//		   		HashMap<String,Object> map = new HashMap<String, Object>();			
//		  	   map.put("warehouseType", "备储库");
//		  	   map.put("storehouse",  TokenManager.getToken().getShortName());
//			       int i= storageWarehouseDao.check(map);
//			    
//			       if (i>0) {
//			    	   maps.put("storehouse", TokenManager.getToken().getShortName());
//			       }
		   	}
		int count = storageStarUnitDao.getRecordCount(maps);  

        if (count<=0) {
			return page;
		}
        
        List<StorageStarUnit> data= storageStarUnitDao.pageQuery(maps);
//        for (StorageStarUnit storageStarUnit : data) {
//			if (storageStarUnit.getCreatorId().equals(TokenManager.getSysUserId())) {
//				storageStarUnit.setIsMyself("1");
//			}else {
//				storageStarUnit.setIsMyself("0");
//			}
//		}
        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
		return page;
	}
	
	@Override
	public List<StorageStarUnit> exportxls(HttpServletRequest request) {
		// TODO Auto-generated method stub
		List<StorageStarUnit> page=new ArrayList();
        HashMap<String,String> maps = new HashMap<String, String>();
        maps.put("warehouse", request.getParameter("warehouse"));
		maps.put("warehouseId", request.getParameter("warehouseId"));
		maps.put("postalAddress", request.getParameter("postalAddress"));
		maps.put("oldLevel", request.getParameter("oldLevel"));
		maps.put("type", request.getParameter("type"));
		  SysUser sysUser = sysUserDao.selectByPrimaryKey(TokenManager.getSysUserId());
			//现获取用户的权限
			Set<String> types = sysRoleDao.findRoleByUserId(TokenManager.getSysUserId());
			for (String type : types) {
				if (type.equals("代储管理员")) {
					maps.put("creatorId", TokenManager.getSysUserId());
				}else if (type.equals("库点管理员")) {
					//去分片监管查库看监管的企业  通过企业编号唯一去查找库的名称
					maps.put("storehouse", sysUser.getCompany());
				}
			}
		return storageStarUnitDao.pageQuery(maps);
	}
	
	@Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return storageStarUnitDao.remove(id);
	}
	
}
