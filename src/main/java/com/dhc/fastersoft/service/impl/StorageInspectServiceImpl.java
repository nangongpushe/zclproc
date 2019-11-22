package com.dhc.fastersoft.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.system.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.dao.StorageInspectMapper;
import com.dhc.fastersoft.entity.StorageInspect;
import com.dhc.fastersoft.service.StorageInspectService;
import com.dhc.fastersoft.utils.LayPage;

@Service("StorageInspectService")
public class StorageInspectServiceImpl implements StorageInspectService {
	@Autowired
	public StorageInspectMapper dao;
	@Autowired
	private SysUserService sysUserService;
	@Override
	public LayPage<StorageInspect> list(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<StorageInspect> page=new LayPage<>();
        HashMap<String,String> map = QueryUtil.pageHashMap(request);
        String reportUnit=request.getParameter("reportUnit");
        String inspector=request.getParameter("inspector");
        map.put("reportUnit", reportUnit);
        map.put("inspector", inspector);
        int count=dao.count(map);
        if (count<=0) {
			return page;
		}
        List<StorageInspect> data=dao.list(map);
		for (int i=0;i<data.size();i++){
			String creatorid=data.get(i).getInspector();
			SysUser boolUser = sysUserService.selectByPrimaryKey(creatorid);
			if (boolUser!=null){
				data.get(i).setInspector(boolUser.getName());
			}

		}
        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
		return page;
	}
	@Override
	public int add(StorageInspect entity) {
		// TODO Auto-generated method stub
		return dao.add(entity);
	}
	@Override
	public int update(StorageInspect entity) {
		// TODO Auto-generated method stub
		return dao.update(entity);
	}
	@Override
	public StorageInspect getById(String id) {
		// TODO Auto-generated method stub
		return dao.getById(id);
	}
	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return dao.delete(id);
	}

}
