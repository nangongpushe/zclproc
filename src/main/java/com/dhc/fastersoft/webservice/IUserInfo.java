package com.dhc.fastersoft.webservice;

import javax.jws.WebParam;
import javax.jws.WebService;

@WebService
public interface IUserInfo {
	/**
	 * 获取用户
	 * @param userName 调用者账号
	 * @param token 令牌
	 * @return
	 */
	Object[] getUsers(@WebParam(name = "userName") String userName, @WebParam(name = "token") String token);
}