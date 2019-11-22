package com.dhc.fastersoft.webservice;

import javax.jws.WebService;

@WebService(endpointInterface = "com.dhc.fastersoft.webservice.IUserInfo", serviceName = "UserInfo")
public class UserInfoImpl implements IUserInfo {
	public Object[] getUsers(String userName, String token) {
		Object[] o = new Object[2];
		return o;
	}
}