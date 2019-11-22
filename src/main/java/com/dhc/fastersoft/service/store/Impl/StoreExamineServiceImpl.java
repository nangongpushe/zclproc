package com.dhc.fastersoft.service.store.Impl;

import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.StorageWarehouseDao;
import com.dhc.fastersoft.dao.system.SysRoleDao;
import com.dhc.fastersoft.dao.system.SysUserDao;
import com.dhc.fastersoft.entity.store.StoreExamine;
import com.dhc.fastersoft.service.store.StoreExamineService;
import com.dhc.fastersoft.utils.LayPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;

@Service("StoreExamineService")
public class StoreExamineServiceImpl implements StoreExamineService {
	@Autowired
    com.dhc.fastersoft.dao.store.StoreExamineDao StoreExamineDao;
	@Autowired
    SysUserDao sysUserDao;
	@Autowired
    SysRoleDao sysRoleDao;
	@Autowired
    StorageWarehouseDao storageWarehouseDao;


	
	@Override
	public int add(StoreExamine StoreExamine) {
		// TODO Auto-generated method stub
		return StoreExamineDao.add(StoreExamine);
	}
	
	@Override
	public int update(StoreExamine StoreExamine) {
		// TODO Auto-generated method stub
		return StoreExamineDao.update(StoreExamine);
	}
	
	@Override
	public StoreExamine getStoreExamineByID(String id) {
		// TODO Auto-generated method stub
		return StoreExamineDao.getStoreExamineById(id);
	}
	
	@Override
	public LayPage<StoreExamine> list(HttpServletRequest request, String typeString) {
		// TODO Auto-generated method stub
		LayPage<StoreExamine> page=new LayPage<>();
        HashMap<String,String> maps = QueryUtil.pageQuery(request);
     
       maps.put("examineType", request.getParameter("examineType"));
       maps.put("timeStart", request.getParameter("timeStart"));
       maps.put("timeEnd", request.getParameter("timeEnd"));
       maps.put("pointsStart", request.getParameter("pointsStart"));
       maps.put("pointsEnd", request.getParameter("pointsEnd"));
       maps.put("type", typeString);
		maps.put("storehouse", request.getParameter("storehouse"));
		maps.put("warehouseId", request.getParameter("warehouseId"));
       maps.put("examineTempletType", request.getParameter("examineTempletType"));
		//获取6个库点编码
		List kudianCodes = storageWarehouseDao.listKudianCode();
		boolean isKudian = kudianCodes.contains(TokenManager.getToken().getOriginCode());
       //代储
       if (typeString.equals("0")) {
    	   HashMap<String,Object> map = new HashMap<String, Object>();			
    	   map.put("warehouseType", "代储库");
		   if(!TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")){

		   	if(isKudian){
//		   		他监管的库点
				maps.put("shortName",  TokenManager.getToken().getShortName());
			}else {
		   		//代储库自己
				map.put("warehouseShort",  TokenManager.getToken().getShortName());
				int i= storageWarehouseDao.check(map);

				if (i>0) {
					maps.put("storehouse", TokenManager.getToken().getShortName());
				}
			}

		   }else{
			   maps.put("storehouse1", "storehouse1");
		   }
       }else{
	   	if(!TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")){
	   		maps.put("storehouse", TokenManager.getToken().getShortName());
	   	}
       }


		int count = StoreExamineDao.getRecordCount(maps);  

        if (count<=0) {
			return page;
		}
        
        List<StoreExamine> data= StoreExamineDao.pageQuery(maps);
        for (StoreExamine storeExamine : data) {
			if (storeExamine.getCreatorId().equals(TokenManager.getSysUserId())) {
				storeExamine.setIsMyself("1");
			}else {
				storeExamine.setIsMyself("0");
			}
		}
        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
		return page;
	}
	
	

	@Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return StoreExamineDao.remove(id);
	}
	
}
