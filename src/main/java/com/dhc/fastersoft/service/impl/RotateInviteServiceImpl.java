package com.dhc.fastersoft.service.impl;



import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.dao.RotateInviteDao;
import com.dhc.fastersoft.entity.RotateInvite;
import com.dhc.fastersoft.entity.RotateInviteDetail;
import com.dhc.fastersoft.service.RotateInviteService;
import com.dhc.fastersoft.utils.DateUtil;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.utils.PageUtil;
@Service("rotateInviteService")
public class RotateInviteServiceImpl implements RotateInviteService {
	
	@Autowired
	private RotateInviteDao inviteDao;
	
	private static String SERIAL_PREFIX = "ZBJG";
	
	@Override
	public String save(RotateInvite rotateInvite) {

		String id = UUID.randomUUID().toString().replaceAll("-", "");
		rotateInvite.setId(id);
		String date = DateUtil.DateToString(new Date(), DateUtil.LONG_DATE_FORMAT);
		String serialCount = String.format("%02d", inviteDao.getSerialCount(date)+1);
		String serial = String.format("%s%s%s", SERIAL_PREFIX,date.replaceAll("-", ""),serialCount);
		rotateInvite.setInviteSerial(serial);
		inviteDao.save(rotateInvite);
		return id;
	}

	@Override
	public int update(RotateInvite record) {
		// TODO Auto-generated method stub
		return inviteDao.update(record);
	}

	@Override
	public int remove(String id) {
		// TODO Auto-generated method stub
		return inviteDao.remove(id);
	}

	@Override
	public int removeDetail(String id) {
		// TODO Auto-generated method stub
		return inviteDao.removeDetail(id);
	}

	@Override
	public RotateInvite get(String id) {
		// TODO Auto-generated method stub
		RotateInvite rotateInvite=inviteDao.get(id);
		List<RotateInviteDetail> inviteDetails=inviteDao.listDetail(id);
		rotateInvite.setInviteDetails(inviteDetails);
		return rotateInvite;
	}

	@Override
	public List<RotateInvite> list(int pageIndex,int pageSize,String inviteName
			,String inviteType,String handleTime) {
		// TODO Auto-generated method stub
        HashMap<String,String> map = new HashMap<>();
        map.put("inviteName", inviteName);
        map.put("inviteType", inviteType);
        map.put("handleTime", handleTime);
        map.put("pageIndex", String.valueOf(pageIndex));
        map.put("pageSize", String.valueOf(pageSize));

        
        List<RotateInvite> data= inviteDao.list(map);

		return data;
	}

	@Override
	public List<RotateInviteDetail> listDetail(String id) {
		// TODO Auto-generated method stub
		return inviteDao.listDetail(id);
	}

	@Override
	public int count(int pageIndex, int pageSize, String inviteName, String inviteType, String handleTime,String bidId) {
		// TODO Auto-generated method stub
        HashMap<String,String> map = new HashMap<>();
        map.put("inviteName", inviteName);
        map.put("inviteType", inviteType);
        map.put("handleTime", handleTime);
        map.put("pageIndex", String.valueOf(pageIndex));
        map.put("pageSize", String.valueOf(pageSize));
        map.put("bidId",bidId);
		return inviteDao.count(map);
	}

	@Override
	public int updateIsGather(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return inviteDao.updateIsGather(map);
	}



}
