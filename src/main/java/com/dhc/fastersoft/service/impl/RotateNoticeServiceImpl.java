package com.dhc.fastersoft.service.impl;

import com.dhc.fastersoft.dao.RotateNoticeDao;
import com.dhc.fastersoft.entity.RotateNotice;
import com.dhc.fastersoft.service.RotateNoticeService;
import com.dhc.fastersoft.utils.PageUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Component("RotateNoticeService")
public class RotateNoticeServiceImpl implements RotateNoticeService{

	@Autowired
	private RotateNoticeDao rotateNoticeDao;

	public void setRotateNoticeDao(RotateNoticeDao rotateNoticeDao) {
		this.rotateNoticeDao = rotateNoticeDao;
	}

	@Override
	public void SaveNotic(RotateNotice notice) {
		notice.setId(UUID.randomUUID().toString().replace("-", ""));
		rotateNoticeDao.SaveNotice(notice);
	}

	@Override
	public List<RotateNotice> ListLimitNotice(PageUtil<RotateNotice> pageUtil) {
//		pageUtil.setTotalCount(rotateNoticeDao.GetTotalCount(pageUtil));
		return rotateNoticeDao.ListLimitNotice(pageUtil);
	}

	@Override
	public int GetTotalCount(PageUtil<RotateNotice> pageUtil) {
		return rotateNoticeDao.GetTotalCount(pageUtil);
	}

	@Override
	public RotateNotice GetNoticeDetail(String nId) {
		return rotateNoticeDao.GetNoticeDetail(nId);
	}

	@Override
	public void UpdateNotice(RotateNotice notice) {
		rotateNoticeDao.UpdateNotice(notice);
	}

	@Override
	public List<RotateNotice> GetNoticeDetailByids(List<String> ids) {
		return rotateNoticeDao.GetNoticeDetailByids(ids);
	}

	@Override
	public void SendDataOut(Map<String,Object> ids) {
		rotateNoticeDao.SendDataOut(ids);
	}

	@Override
	public int getRownum(Map<String, Object> data) {
		return rotateNoticeDao.getRownum(data);
	}

	@Override
	public RotateNotice GetNoticeByDealSerial(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return rotateNoticeDao.GetNoticeByDealSerial(map);
	}

	@Override
	public boolean rotateNotifIsExistence(Map<String,Object> map) throws Exception {
		if(StringUtils.equals((String)map.get("type"),"out")){
			map.put("type","出库");
		}else if(StringUtils.equals((String)map.get("type"),"in")){
			map.put("type","入库");
		}else if(StringUtils.equals((String)map.get("type"),"move")){
			map.put("type","移库");
		}
		int count = rotateNoticeDao.getRotateNoticeCount(map);
		if(count==0){
			return true;
		}else{
			return false;
		}
	}

	@Override
	public List<RotateNotice> listLimitNoticeByDate(PageUtil<RotateNotice> pageUtil) {
		return rotateNoticeDao.listLimitNoticeByDate(pageUtil);
	}

	@Override
	public List<String> findOutNoticeSerial() {
		return rotateNoticeDao.findOutNoticeSerial();
	}

	@Override
	public List<String> findInNoticeSerial() {
		return rotateNoticeDao.findInNoticeSerial();
	}

	@Override
	public List<String> findMoveNoticeSerial() {
		return rotateNoticeDao.findMoveNoticeSerial();
	}
}
