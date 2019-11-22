package com.dhc.fastersoft.service.system.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import aj.org.objectweb.asm.Label;

import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.SysDictDao;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.utils.LayPage;

@Service("sysDictService")
public class SysDictServiceImpl implements SysDictService{
	
	@Resource
	private SysDictDao sysDictDao;

	@Override
	public int save(SysDict sysDict) {
		sysDict.setCreateBy(TokenManager.getSysUserId());
		sysDict.setUpdateDate(new Date(System.currentTimeMillis()));
		// TODO Auto-generated method stub
		return sysDictDao.insert(sysDict);
	}

	@Override
	public LayPage<SysDict> pageList(HttpServletRequest request) {
		
		LayPage<SysDict> page = new LayPage<SysDict>();

        HashMap<String,String> map = QueryUtil.pageHashMap(request);
        
        String label = request.getParameter("label");
        map.put("label", label);
        map.put("type", request.getParameter("type"));

		int count = sysDictDao.getRecordCount(map);    //总记录数
		page.setCode(0);
		page.setCount(count);
        if (count<=0) {
        	page.setMsg("没有查询到数据");
			return page;
		}
        page.setData(sysDictDao.pageQuery(map));
        page.setMsg("succes");
		return page;
	}

	@Override
	public void deleteById(String id) {
		sysDictDao.deleteByPrimaryKey(id);	
	}

	@Override
	public List<SysDict> selectAll() {
		
		return sysDictDao.selectAll();
	}
	
	@Override
	public SysDict getSysDictByType(String type) {
		// TODO Auto-generated method stub
		return sysDictDao.getSysDictByType(type);
	}
	
	@Override
	public List<SysDict> getSysDictByparentId(String parentId) {
		// TODO Auto-generated method stub
		return sysDictDao.getSysDictByparentId(parentId);
	}

	@Override
	public List<SysDict> getSysDictListByType(String type) {
		// TODO Auto-generated method stub
		return sysDictDao.getSysDictListByType(type);
	}

	@Override
	public SysDict getSysDictByLabel(String label) {
		// TODO Auto-generated method stub
		return sysDictDao.getSysDictByLabel(label);
	}

	@Override
	public SysDict selectById(String id) {
		
		return sysDictDao.selectByPrimaryKey(id);
	}

	@Override
	public void updateById(SysDict record) {
		
		sysDictDao.updateByPrimaryKey(record);
	}

}
