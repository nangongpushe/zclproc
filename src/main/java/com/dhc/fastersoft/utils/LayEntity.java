package com.dhc.fastersoft.utils;

import java.util.Map;

/**
* @ClassName: LayEntity
* @Description: 回调实体
* @author zby
* @date 2017年10月9日 
* 
*/

public class LayEntity {
	
	private int code; 
	private String msg;
	private Map<String, Object> data;
	
	public LayEntity(){
		
	}

	public LayEntity(int code, String msg, Map<String, Object> data) {
		super();
		this.code = code;
		this.msg = msg;
		this.data = data;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Map<String, Object> getData() {
		return data;
	}
	public void setData(Map<String, Object> data) {
		this.data = data;
	}

}
