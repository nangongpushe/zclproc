package com.dhc.fastersoft.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.system.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.dao.QualityQuotaItemMapper;
import com.dhc.fastersoft.dao.QualityQuotaMapper;
import com.dhc.fastersoft.entity.QualityQuota;
import com.dhc.fastersoft.service.QualityQuotaService;
import com.dhc.fastersoft.utils.LayPage;

@Service("QualityQuotaService")
public class QualityQuotaServiceImpl implements QualityQuotaService {
	@Autowired
	public QualityQuotaMapper dao;
	@Autowired
	private QualityQuotaItemMapper quotaItemDao;
	@Autowired
	private SysUserService sysUserService;

	@Override
	public LayPage<QualityQuota> list(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<QualityQuota> page=new LayPage<>();
        HashMap<String,String> map = QueryUtil.pageHashMap(request);
        String quotaNo=request.getParameter("quotaNo");
        String quotaName=request.getParameter("quotaName");
        String type=request.getParameter("type");
        map.put("quotaNo", quotaNo);
        map.put("quotaName", quotaName);
        map.put("type", type);
        int count=dao.count(map);
        if (count<=0) {
			return page;
		}
        List<QualityQuota> data=dao.list(map);
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
	public QualityQuota getByID(String id) {
		// TODO Auto-generated method stub
		return dao.getById(id);
	}

	@Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return dao.delete(id);
	}

	@Override
	public int add(QualityQuota entity) {
		// TODO Auto-generated method stub
		return dao.add(entity);
	}

	@Override
	public int update(QualityQuota entity) {
		// TODO Auto-generated method stub
		return dao.update(entity);
	}

	@Override
	public List<QualityQuota> listQualityQuota() {
		// TODO Auto-generated method stub
		HashMap<String, String> map =new HashMap<>();
		List<QualityQuota> qualityQuotas = dao.listQualityQuota(map);
		for(QualityQuota qualityQuota:qualityQuotas) {
			qualityQuota.setQuotaItems(quotaItemDao.getById(qualityQuota.getId()));
		}
		return qualityQuotas;
	}

	@Override
	public QualityQuota getQualityQuotaByOther(String grainType, String grade) {
		// TODO Auto-generated method stub
		HashMap<String, String> map = new HashMap<>();
		map.put("grainType", grainType);
		map.put("grade", grade);
		return dao.getQualityQuota(map);
	}

	@Override
	public QualityQuota getQualityQuotaById(String id) {
		// TODO Auto-generated method stub
		HashMap<String, String> map = new HashMap<>();
		map.put("id", id);
		return dao.getQualityQuota(map);
	}
	
	

	@Override
	public int check(HttpServletRequest request, String str) {
		// TODO Auto-generated method stub
		HashMap<String,String> map = QueryUtil.pageHashMap(request);
		int count=0;
		if (str.equals("one")) {
			String quotaNo=request.getParameter("quotaNo");
			if (quotaNo!=""&&quotaNo!=null) {
				map.put("quotaNo", quotaNo);
				count = dao.countCheck(map);
			}
			
		} else if(str.equals("two")){
			String grade=request.getParameter("grade");
			String type=request.getParameter("type");
			String quotaNo=request.getParameter("quotaNo");
			String quotaName=request.getParameter("quotaName");
			if (type!=""&&type!=null&&grade!=""&&grade!=null&&quotaName!=""&&quotaName!=null&&quotaNo!=""&&quotaNo!=null) {
				map.put("type", type);
				map.put("grade", grade);
				map.put("quotaName", quotaName);
				map.put("quotaNo", quotaNo);
				count = dao.countCheck(map);
			}

		}

		return count;
	}
}
