package com.dhc.fastersoft.service.impl;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.service.system.SysUserService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.common.page.PageList;
import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.QualitySampleMapper;
import com.dhc.fastersoft.dao.StorageStoreHouseDao;
import com.dhc.fastersoft.dao.StorageWarehouseDao;
import com.dhc.fastersoft.dao.system.SysRoleDao;
import com.dhc.fastersoft.entity.CustomerInformation;
import com.dhc.fastersoft.entity.QualitySample;
import com.dhc.fastersoft.entity.StorageStoreHouse;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.QualitySampleService;
import com.dhc.fastersoft.service.system.SysRoleService;
import com.dhc.fastersoft.utils.LayPage;

@Service("QualitySampleService")
public class QualitySampleServiceImpl implements QualitySampleService{
	@Autowired
	public QualitySampleMapper dao;
	@Autowired
	public StorageStoreHouseDao sshDao;
	@Autowired
	SysRoleDao sysRoleDao;
	@Autowired
	public StorageWarehouseDao storageWarehouseDao;
	@Autowired
	private SysRoleService sysRoleService;
	@Autowired
	private SysUserService sysUserService;
	@Override
	public int add(QualitySample qs) {
		// TODO Auto-generated method stub
		return dao.insert(qs);
	}
	@Override
	public int update(QualitySample qs) {
		// TODO Auto-generated method stub
		return dao.update(qs);
	}
	@Override
	public QualitySample getQSById(String id) {
		// TODO Auto-generated method stub
		return dao.getQSById(id);
	}
	@Override
	public int importExcel(List<QualitySample> list) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return dao.delete(id);
	}
	@Override
	public LayPage<QualitySample> list(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<QualitySample> page=new LayPage<>();
        HashMap<String,String> map = QueryUtil.pageHashMap(request);
        String sampleNo=request.getParameter("sampleNo");
        String isHasImportation = request.getParameter("isHasImportation");
        String sampleSouce=request.getParameter("sampleSouce");
        String variety=request.getParameter("variety");
        String testStatus=request.getParameter("testStatus");
//        String samplingDate=request.getParameter("samplingDate");
        String dealSerial=request.getParameter("dealSerial");
        String storehouse=request.getParameter("storehouse");
        String harvestYear=request.getParameter("harvestYear");
//        if(harvestYear!=null&&!harvestYear.isEmpty())
//        	harvestYear += "-01-01";
        String validType=request.getParameter("validType");
        String origin=request.getParameter("origin");
        String fillReport=request.getParameter("fillReport");
        if("true".equals(fillReport)){//报表台账填报选择明细号时只显示自己库
			map.put("sampleSouce", sampleSouce);
		}else{
			map.put("sampleSouce", sampleSouce);
			if(!sysRoleService.findRoleNameByUserId(TokenManager.getToken().getId()).contains("中心化验室")) {
				if (!(TokenManager.getToken().getOriginCode() != null && TokenManager.getToken().getOriginCode().equals("CBL"))) {
					String company = TokenManager.getToken().getShortName();
					String warehosueCode = TokenManager.getToken().getOriginCode().toUpperCase();
//					map.put("company", company);
					map.put("warehouseCode",warehosueCode);
//					map.put("sampleSouce",company);
				}
			}
		}

        map.put("validType", validType);
        map.put("sampleNo", sampleNo);
        map.put("variety", variety);
        map.put("testStatus", testStatus);
//        map.put("samplingDate", samplingDate);
        map.put("dealSerial", dealSerial);
        map.put("storehouse", storehouse==null?storehouse:storehouse.toUpperCase());
        map.put("harvestYear", harvestYear); //数据库字段为精确到日期的匹配模式 需拼接为日期模式
        map.put("origin", origin);
        map.put("isHasImportation",isHasImportation);
        if(StringUtils.isNotEmpty(isHasImportation)){
        	SysUser user = TokenManager.getToken();
        	if(!StringUtils.equals(user.getOriginCode().toUpperCase(),"ZSK")){
				map.put("userIsNotZSK","true");
			}
		}
        String  flag=request.getParameter("flag");
        if(request.getParameter("flag")!=null){
			map.put("end",")");
		}
        int count=dao.count(map);
        if (count<=0) {
			return page;
		}
        List<QualitySample> data=dao.list(map);
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
	public List<QualitySample> query(HttpServletRequest request) {
		// TODO Auto-generated method stub
        HashMap<String,String> map = QueryUtil.pageHashMap(request);
        String sampleNo;
		String variety;
		String testStatus;
		String samplingDate;
		try {
			sampleNo = new String(URLDecoder.decode(request.getParameter("sampleNo"),"utf-8"));
			variety =new String(URLDecoder.decode(request.getParameter("variety"),"utf-8"));
			testStatus =new String(URLDecoder.decode(request.getParameter("testStatus"),"utf-8"));
			samplingDate =new String(URLDecoder.decode(request.getParameter("samplingDate"),"utf-8"));
			String company = TokenManager.getToken().getOriginCode();
	        String nickname = TokenManager.getNickname();
			 if (!company.equals("CBL")) {
				 map.put("creator", nickname);
			}
			map.put("sampleNo", sampleNo);
			map.put("variety", variety);
			map.put("testStatus", testStatus);
			map.put("samplingDate", samplingDate);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dao.query(map);
	}
	
	@Override
	public List<QualitySample> query(Map<String,Object> param) {
		// TODO Auto-generated method stub
		/*String company = TokenManager.getToken().getOriginCode();
		String nickname = TokenManager.getNickname();
		 if (!company.equals("CBL")) {
			 param.put("creator", nickname);
		}*/
		return dao.query(param);
	}
	@Override
	public List<StorageStoreHouse> getStoreEncode() {
		// TODO Auto-generated method stub
		return sshDao.getStoreEncode();
	}
	@Override
	public int check(HttpServletRequest request) {
		// TODO Auto-generated method stub
		 HashMap<String,String> map = QueryUtil.pageHashMap(request);
	        String sampleNo=request.getParameter("sampleNo");
	        map.put("sampleNo", sampleNo);
		return dao.countCheck(map);
	}
	@Override
	public List<QualitySample> getMessage(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		//对数据进行权限上的控制
        Set<String> types = sysRoleDao.findRoleByUserId(TokenManager.getSysUserId());
		List<String> wareHouseIds = new ArrayList<>();
		if(types!=null && types.contains("中心化验室")) {
			//可查看所有数据 所以不需要对数据做过滤操作

		}else if(types != null && (types.contains("库化验室") || !"cbl".equals(TokenManager.getToken().getOriginCode().toLowerCase()))) {
			SysUser user = TokenManager.getToken();
			String baseName = user.getShortName(); //获取到用户的库点信息
			String wareHouseId = user.getWareHouseId();

			wareHouseIds.add(wareHouseId);
			/*for(StorageWarehouse base : storageWarehouseDao.listSuperviseOfWarehouse(baseName))
				baseNames.add(base.getWarehouseShort());*/
			map.put("wareHouseIds", wareHouseIds);
			map.put("warehouseCode",user.getOriginCode().toUpperCase());
		}
		List<QualitySample> samples = dao.getMessage(map);
		return samples;
	}
	@Override
	public void updateSampleStatus(Map<String, String> map) {
		dao.updateSampleStatus(map);
	}
	
	@Override
	public String getQualityInfo(Map<String, Object> param) {
		return dao.getQualityInfo(param);
	}
	@Override

	public QualitySample getSampleInfo(Map<String, Object> param) {
		return dao.getSampleInfo(param);
	}
}
