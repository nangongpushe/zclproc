package com.dhc.fastersoft.webservice;

import java.io.Serializable;

import net.sf.json.JSONObject;

public class AppResult implements Serializable{
	
	private static final long serialVersionUID = 3672266867100643369L;
	
	private RstCode rstCode;  //状态码
	
	private String msg; //消息说明
	
	private Object result; //返回结果

	public String getMsg() {
		if (msg == null) {
			msg = rstCode.getNote();
		}
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	public void setMsg(Exception e) {
		this.msg = e.getCause() == null ? e.getMessage() : e.getCause().getMessage();
	}

	public String getRstCode() {
		return rstCode.getCode();
	}

	public void setRstCode(RstCode rstCode) {
		this.rstCode = rstCode;
	}

	public Object getResult() {
		return result;
	}

	public void setResult(Object result) {
		this.result = result;
	}

	@Override
	public String toString() {
		return JSONObject.fromObject(this).toString().replace(",\"result\":null", "");
	}
}
