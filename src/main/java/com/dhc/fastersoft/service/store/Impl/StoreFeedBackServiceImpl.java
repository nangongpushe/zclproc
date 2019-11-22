package com.dhc.fastersoft.service.store.Impl;

import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.StorageWarehouseDao;
import com.dhc.fastersoft.dao.store.StoreFeedBackDao;
import com.dhc.fastersoft.dao.system.SysRoleDao;
import com.dhc.fastersoft.dao.system.SysUserDao;
import com.dhc.fastersoft.entity.store.StoreFeedBack;
import com.dhc.fastersoft.service.store.StoreFeedBackService;
import com.dhc.fastersoft.utils.LayPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;

@Service
public class StoreFeedBackServiceImpl implements StoreFeedBackService {
	
	@Autowired
    StoreFeedBackDao storeFeedBackDao;
	@Autowired
    SysUserDao sysUserDao;
	@Autowired
    SysRoleDao sysRoleDao;
	@Autowired
    StorageWarehouseDao storageWarehouseDao;

	
	@Override
	public LayPage<StoreFeedBack> list(HttpServletRequest request, String typeString) {
		// TODO Auto-generated method stub
		LayPage<StoreFeedBack> page=new LayPage<>();
        HashMap<String,String> maps = QueryUtil.pageQuery(request);
       maps.put("feedbackName", request.getParameter("feedbackName"));
       maps.put("feedbackSerial", request.getParameter("feedbackSerial"));
       maps.put("examineSerial", request.getParameter("examineSerial"));
       
       maps.put("storehouse", request.getParameter("storehouse"));
       maps.put("manager", request.getParameter("manager"));
       maps.put("inspectorType", request.getParameter("inspectorType"));
		String timeStart = request.getParameter("timeStart");
	    String timeEnd = request.getParameter("timeEnd");
	    maps.put("timeStart", timeStart);
	    maps.put("timeEnd", timeEnd);
	     maps.put("type", typeString);
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

			}
		}else{
		   	if(!TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")){
				maps.put("warehouseId",TokenManager.getToken().getWareHouseId());
		   		/*maps.put("storehouse", TokenManager.getToken().getShortName());*/
		   	}
	       }
		int count = storeFeedBackDao.getRecordCount(maps);  

        if (count<=0) {
			return page;
		}
        
        List<StoreFeedBack> data= storeFeedBackDao.pageQuery(maps);
        for (StoreFeedBack storeFeedBack : data) {
			if (storeFeedBack.getCreatorId().equals(TokenManager.getSysUserId())) {
				storeFeedBack.setIsMyself("1");
			}else {
				storeFeedBack.setIsMyself("0");
			}
		}
        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
		return page;
		
	}
	
	
	 
	 @Override
	public int add(StoreFeedBack StoreFeedBack) {
		// TODO Auto-generated method stub
		return storeFeedBackDao.add(StoreFeedBack);
	}
	 
	 @Override
	public int update(StoreFeedBack StoreFeedBack) {
		// TODO Auto-generated method stub
		return storeFeedBackDao.update(StoreFeedBack);
	}
	 
	 @Override
	public StoreFeedBack getStoreFeedBackByID(String id) {
		// TODO Auto-generated method stub
		 return storeFeedBackDao.getStoreFeedBackById(id);
	}

	
	 
	 @Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return storeFeedBackDao.remove(id);
	}
	 
}
