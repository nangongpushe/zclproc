package com.dhc.fastersoft.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.system.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.dao.QualityTempletMapper;
import com.dhc.fastersoft.entity.QualityTemplet;
import com.dhc.fastersoft.service.QualityTempletService;
import com.dhc.fastersoft.utils.LayPage;

@Service("QualityTempletService")
public class QualityTempletServiceImpl implements QualityTempletService{
	@Autowired
	public QualityTempletMapper dao;
	@Autowired
	private SysUserService sysUserService;


	@Override
	public int add(QualityTemplet entity) {
		// TODO Auto-generated method stub
		return dao.add(entity);
	}

	@Override
	public int update(QualityTemplet entity) {
		// TODO Auto-generated method stub
		return dao.update(entity);
	}


	@Override
	public LayPage<QualityTemplet> list(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<QualityTemplet> page=new LayPage<>();
        HashMap<String,String> map = QueryUtil.pageHashMap(request);
        String templetNo=request.getParameter("templetNo");
        String templetName=request.getParameter("templetName");
        map.put("templetNo", templetNo);
        map.put("templetName", templetName);
        int count=dao.count(map);
        if (count<=0) {
			return page;
		}
        List<QualityTemplet> data=dao.list(map);
		for (int i=0;i<data.size();i++){
			String creatorid=data.get(i).getCreator();
			SysUser boolUser = sysUserService.selectByPrimaryKey(creatorid);
			if (boolUser!=null){
				data.get(i).setCreator(boolUser.getName());
			}

		}
        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
		return page;
	}

	@Override
	public LayPage<QualityTemplet> listChoice(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<QualityTemplet> page=new LayPage<>();
        HashMap<String,String> map = QueryUtil.pageHashMap(request);
        String templetNo=request.getParameter("templetNo");
        String templetName=request.getParameter("templetName");
        String type = request.getParameter("type");
        map.put("templetNo", templetNo);
        map.put("templetName", templetName);
        map.put("type",type);
        List<QualityTemplet> data=dao.listChoice(map);
        int size = dao.count(map);
        page.setCount(size);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
		return page;
	}
	@Override
	public QualityTemplet getByID(String id) {
		// TODO Auto-generated method stub
		return dao.getById(id);
	}

	@Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return dao.delete(id);
	}

	@Override
	public int check(HttpServletRequest request, String str) {
		// TODO Auto-generated method stub
		HashMap<String,String> map = QueryUtil.pageHashMap(request);
		int count=0;
		if (str.equals("one")) {
			String templetNo=request.getParameter("templetNo");
			if (templetNo!=""&&templetNo!=null) {
				map.put("templetNo", templetNo);
				count = dao.countCheck(map);
			}
			
		} else if(str.equals("two")){
			String type=request.getParameter("type");
			String templetNo=request.getParameter("templetNo");
			String templetName=request.getParameter("templetName");
			if (type!=""&&type!=null&&templetName!=""&&templetName!=null&&templetNo!=""&&templetNo!=null) {
				map.put("type", type);
				map.put("templetName", templetName);
				map.put("templetNo", templetNo);
				count = dao.countCheck(map);
			}

		}
		return count;
	}
	@Override
	public List<QualityTemplet> getTemplateByNo(Map<String,Object> templateMap){
		List<QualityTemplet> qualityTemplets = dao.getTemplateByNo(templateMap);
		return qualityTemplets;
	}

}
