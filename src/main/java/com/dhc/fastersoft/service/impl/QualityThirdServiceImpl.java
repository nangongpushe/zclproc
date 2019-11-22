package com.dhc.fastersoft.service.impl;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.controller.RotatePlanController;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.system.SysUserService;
import org.apache.commons.logging.Log;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.QualityThirdMapper;
import com.dhc.fastersoft.entity.QualityResult;
import com.dhc.fastersoft.entity.QualityThird;
import com.dhc.fastersoft.service.QualityThirdService;
import com.dhc.fastersoft.service.system.SysRoleService;
import com.dhc.fastersoft.utils.LayPage;

@Service("QualityThirdService")
public class QualityThirdServiceImpl implements QualityThirdService{
	private static Logger log = Logger.getLogger(QualityThirdServiceImpl.class);
	@Autowired
	public QualityThirdMapper dao;
	@Autowired
	private SysRoleService sysRoleService;
	@Autowired
	private SysUserService sysUserService;
	@Override
	public LayPage<QualityThird> list(HttpServletRequest request) {
		LayPage<QualityThird> page=new LayPage<>();
        HashMap<String,String> map = QueryUtil.pageHashMap(request);
        String sampleNo=request.getParameter("sampleNo");
        String sampleName=request.getParameter("sampleName");
        String inspectedUnit=request.getParameter("inspectedUnit");
        String samplePlace=request.getParameter("samplePlace");
        map.put("sampleNo", sampleNo);
		map.put("genYear", request.getParameter("genYear"));
		log.info("回调" );
        map.put("sampleName", sampleName);
        if(!sysRoleService.findRoleNameByUserId(TokenManager.getToken().getId()).contains("中心化验室")) {
			if (!(TokenManager.getToken().getOriginCode() != null && TokenManager.getToken().getOriginCode().equals("CBL"))) {
				inspectedUnit = TokenManager.getToken().getShortName();
			}
		}
        map.put("inspectedUnit", inspectedUnit);
        map.put("samplePlace", samplePlace);
        int count=dao.count(map);
        if (count<=0) {
			return page;
		}
        List<QualityThird> data=dao.list(map);
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
	public QualityThird getByID(String id) {
		return dao.getById(id);
	}

	@Override
	public int remove(String id) {
		return dao.delete(id);
	}

	@Override
	public int update(QualityThird entity) {
		return dao.update(entity);
	}

	@Override
	public int add(QualityThird entity) {
		return dao.add(entity);
	}

	@Override
	public List query(HttpServletRequest request) {
		HashMap<String,String>  map = QueryUtil.pageHashMap(request);
		if(request.getParameter("isExport")!=null){
			map = new HashMap<>();
		}


			String sampleNo;
	        String sampleName;
	        String inspectedUnit;
			String samplePlace;
			String genYear;
			try {
				sampleNo =  new String(URLDecoder.decode(request.getParameter("sampleNo"),"utf-8"));
				sampleName =  new String(URLDecoder.decode(request.getParameter("sampleName"),"utf-8"));
				inspectedUnit =  new String(URLDecoder.decode(request.getParameter("inspectedUnit"),"utf-8"));
				samplePlace =  new String(URLDecoder.decode(request.getParameter("samplePlace"),"utf-8"));
				genYear =  new String(URLDecoder.decode(request.getParameter("genYear"),"utf-8"));

				map.put("sampleNo", sampleNo);
				map.put("sampleName", sampleName);
				map.put("inspectedUnit", inspectedUnit);
				map.put("samplePlace", samplePlace);
				map.put("genYear", genYear);
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		if(!sysRoleService.findRoleNameByUserId(TokenManager.getToken().getId()).contains("中心化验室")) {
			if (!(TokenManager.getToken().getOriginCode() != null && TokenManager.getToken().getOriginCode().equals("CBL"))) {
				inspectedUnit = TokenManager.getToken().getShortName();
				map.put("inspectedUnit", inspectedUnit);
			}
		}
		return dao.list(map);
	}

	@Override
	public int countSampleNo(String str) {
		HashMap<String,String> map = new HashMap<String, String>();
		 map.put("sampleNo", str);
		return dao.countSampleNo(map);
	}
	
	@Override
	public Map<String,QualityThird> queryBySampleNo(List<String> sampleNoList) {
		return dao.queryBySampleNo(sampleNoList);
	}

}
