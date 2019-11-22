package com.dhc.fastersoft.service.impl;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.system.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.QualitySampleMapper;
import com.dhc.fastersoft.dao.QualityTaskMapper;
import com.dhc.fastersoft.entity.QualitySample;
import com.dhc.fastersoft.entity.QualityTask;
import com.dhc.fastersoft.service.QualityTaskService;
import com.dhc.fastersoft.utils.LayPage;

@Service("QualityTaskService")
public class QualityTaskServiceImpl implements QualityTaskService {
	@Autowired
	public QualityTaskMapper dao;
	@Autowired
	public QualitySampleMapper qsDao;
	@Autowired
	private SysUserService sysUserService;
	@Override
	public LayPage<QualityTask> list(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<QualityTask> page=new LayPage<>();
        HashMap<String,String> map = QueryUtil.pageHashMap(request);
        String taskSerial=request.getParameter("taskSerial");
        String taskName=request.getParameter("taskName");
        String sampleNo=request.getParameter("sampleNo");
        String wearhouse=request.getParameter("wearhouse");
        String inspectionType=request.getParameter("inspectionType");
        String actualInspectionTime=request.getParameter("actualInspectionTime");
        String taskStatus=request.getParameter("taskStatus");
        String nickname = TokenManager.getNickname();
        if (!(TokenManager.getToken().getOriginCode() != null && TokenManager.getToken().getOriginCode().equals("CBL"))) {
			 map.put("creator", nickname);
		}
        map.put("taskSerial", taskSerial);
        map.put("taskName", taskName);
        map.put("sampleNo", sampleNo);
        map.put("wearhouse", wearhouse);
        map.put("inspectionType", inspectionType);
        map.put("actualInspectionTime", actualInspectionTime);
        map.put("taskStatus", taskStatus);
        int count=dao.count(map);
        if (count<=0) {
			return page;
		}
        List<QualityTask> data=dao.list(map);
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
	public QualityTask getByID(String id) {
		// TODO Auto-generated method stub
		return dao.getById(id);
	}

	@Override
	public int remove(String ids) {
		// TODO Auto-generated method stub
		String id[]=ids.split("-");
		int i;
		for ( i = 0; i < id.length; i++) {
			 dao.delete(id[i]);
		}
		return i;
	}

	@Override
	public int add(QualityTask entity) {
		// TODO Auto-generated method stub
		return dao.add(entity);
	}

	@Override
	public int update(QualityTask entity) {
		// TODO Auto-generated method stub
		return dao.update(entity);
	}

	@Override
	public List query(HttpServletRequest request) {
		// TODO Auto-generated method stub
		 HashMap<String,String> map = QueryUtil.pageHashMap(request);
	        String taskSerial;
			String taskName;
			String sampleNo;
			String wearhouse;
			String inspectionType;
			String actualInspectionTime;
			String taskStatus;
			try {
				taskName = new String(URLDecoder.decode(request.getParameter("taskName"),"utf-8"));
				sampleNo = new String(URLDecoder.decode(request.getParameter("sampleNo"),"utf-8"));
				wearhouse = new String(URLDecoder.decode(request.getParameter("wearhouse"),"utf-8"));
				inspectionType = new String(URLDecoder.decode(request.getParameter("inspectionType"),"utf-8"));
				actualInspectionTime = new String(URLDecoder.decode(request.getParameter("actualInspectionTime"),"utf-8"));
				taskStatus = new String(URLDecoder.decode(request.getParameter("taskStatus"),"utf-8"));
				taskSerial = new String(URLDecoder.decode(request.getParameter("taskSerial"),"utf-8"));
				String company = TokenManager.getToken().getOriginCode();
		        String nickname = TokenManager.getNickname();
				 if (!company.equals("CBL")) {
					 map.put("creator", nickname);
				}
				map.put("taskSerial", taskSerial);
				map.put("taskName", taskName);
				map.put("sampleNo", sampleNo);
				map.put("wearhouse", wearhouse);
				map.put("inspectionType", inspectionType);
				map.put("actualInspectionTime", actualInspectionTime);
				map.put("taskStatus", taskStatus);
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return dao.list(map);
	}


	@Override
	public int check(HttpServletRequest request) {
		// TODO Auto-generated method stub
		HashMap<String,String> map = QueryUtil.pageHashMap(request);
        String taskSerial=request.getParameter("taskSerial");
        map.put("taskSerial", taskSerial);
		return dao.check(map);
	}

	@Override
	public boolean checkBySampleNo(String sampleNo) {
		// TODO Auto-generated method stub
		HashMap<String, String> map = new HashMap<>();
		map.put("sampleNo", sampleNo);
		int count = dao.count(map);
		return count>0?true:false;
	}

}
