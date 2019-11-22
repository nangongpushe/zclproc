package com.dhc.fastersoft.service.impl;

import java.util.HashMap;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.dao.StorageOilcanRepairDao;
import com.dhc.fastersoft.entity.StorageOilcanRepair;
import com.dhc.fastersoft.service.StorageOilcanRepairService;
import com.dhc.fastersoft.utils.LayPage;
@Service("storageOilcanRepairService")
public class StorageOilcanRepairServiceImpl implements StorageOilcanRepairService {
	
	@Autowired
	StorageOilcanRepairDao dao;
	
	@Override
	public ActionResultModel save(StorageOilcanRepair repair) {
		// TODO Auto-generated method stub
		repair.setId(dao.getPrimId());
		ActionResultModel result = new ActionResultModel();
		if (dao.save(repair) == 1) {
			result.setMsg("新增成功");
			result.setSuccess(true);
		} else {
			result.setMsg("新增失败");
			result.setSuccess(false);
		}
		return result;
	}

	@Override
	public ActionResultModel update(StorageOilcanRepair repair) {
		// TODO Auto-generated method stub
		ActionResultModel result = new ActionResultModel();
		if (dao.update(repair) == 1) {
			result.setMsg("修改成功");
			result.setSuccess(true);
		} else {
			result.setMsg("修改失败");
			result.setSuccess(false);
		}
		return result;
	}

	@Override
	public LayPage<StorageOilcanRepair> list(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<StorageOilcanRepair> page = new LayPage<>();
        HashMap<String,String> map = QueryUtil.pageQuery(request);
        String oilcanId = request.getParameter("oilcanId");
        map.put("oilcanId", oilcanId);
        
		int count = dao.count(map);
		
		if (count <= 0) {
			return page;
		}
        
        List<StorageOilcanRepair> data = dao.list(map);
        
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
	public StorageOilcanRepair get(String id) {
		// TODO Auto-generated method stub
		return dao.get(id);
	}

}
