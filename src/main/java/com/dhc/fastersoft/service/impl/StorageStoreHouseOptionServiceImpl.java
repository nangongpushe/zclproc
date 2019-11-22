package com.dhc.fastersoft.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.dao.StorageStoreHouseOptionDao;
import com.dhc.fastersoft.entity.StorageStoreHouse;
import com.dhc.fastersoft.entity.StorageStoreHouseOption;
import com.dhc.fastersoft.service.StorageStoreHouseOptionService;
import com.dhc.fastersoft.utils.LayPage;

@Service("storageStoreHouseOptionService")
public class StorageStoreHouseOptionServiceImpl implements StorageStoreHouseOptionService {

	@Autowired
	StorageStoreHouseOptionDao dao;
	
	@Override
	public ActionResultModel save(StorageStoreHouseOption option) {
		// TODO Auto-generated method stub
		option.setId(dao.getNextId());
		ActionResultModel result = new ActionResultModel();
		if (dao.save(option) == 1) {
			result.setMsg("新增成功");
			result.setSuccess(true);
		} else {
			result.setMsg("新增失败");
			result.setSuccess(false);
		}
		return result;
	}

	@Override
	public LayPage<StorageStoreHouseOption> list(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<StorageStoreHouseOption> page = new LayPage<>();
        HashMap<String,String> map = QueryUtil.pageQuery(request);
        
        String storehouseId = request.getParameter("storehouseId");
        map.put("storehouseId", storehouseId);
		int count = dao.count(map);
		
		if (count <= 0) {
			return page;
		}
        
        List<StorageStoreHouseOption> data = dao.list(map);
        
        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
		return page;
	}

	@Override
	public ActionResultModel remove(String id) {
		// TODO Auto-generated method stub
		ActionResultModel result = new ActionResultModel();
		if (dao.remove(id) == 1) {
			result.setMsg("删除成功");
			result.setSuccess(true);
		} else {
			result.setMsg("删除失败");
			result.setSuccess(false);
		}
		return result;
	}

	@Override
	public StorageStoreHouseOption getSingle(String id) {
		// TODO Auto-generated method stub
		return dao.getSingle(id);
	}

	@Override
	public ActionResultModel update(StorageStoreHouseOption option) {
		// TODO Auto-generated method stub
		ActionResultModel result = new ActionResultModel();
		if (dao.update(option) == 1) {
			result.setMsg("修改成功");
			result.setSuccess(true);
		} else {
			result.setMsg("修改失败");
			result.setSuccess(false);
		}
		return result;
	}
}
