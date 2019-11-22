package com.dhc.fastersoft.webservice;

/**
 * 接口返回码
 * @author Administrator
 *
 */
public enum RstCode {
	
	ERROR("-1", "系统异常"), SUCCESS("0", "成功"), AUTH_FAIL("1", "认证失败"), PARAM_ERROR("2", "非法参数");

	private String code;
	private String note;

	private RstCode(String code, String result) {
		this.code = code;
		this.note = result;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Override
	public String toString() {
		return this.code;
	}
}