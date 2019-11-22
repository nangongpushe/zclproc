package com.dhc.fastersoft.service;



import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.dhc.fastersoft.entity.RotateInvite;
import com.dhc.fastersoft.entity.RotateInviteDetail;
import com.dhc.fastersoft.utils.LayPage;


@Component
public interface RotateInviteService {
	String save(RotateInvite record);
	
	int update(RotateInvite record);

	int remove(String id);
	
	int removeDetail(String id);
	
	RotateInvite get(String id);
	
	List<RotateInvite> list(int pageIndex,int pageSize,String inviteName
			,String inviteType,String handleTime);
	
	int count(int pageIndex,int pageSize,String inviteName
			,String inviteType,String handleTime,String bidId);
	
	List<RotateInviteDetail> listDetail(String id);
	
	int updateIsGather(HashMap<String, String> map);
	
}
