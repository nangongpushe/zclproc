package com.dhc.fastersoft.entity.system;

/**
 * 
 * @author 少凡
 * OA流程ID 业务主键映射表
 */
public class SysProcessMapper {
	private String processId;
	private String bussinessId;
	private String tableMapper;
	private String fieldName;
	private String fieldValue;
	
	public String getProcessId() {
		return processId;
	}
	public void setProcessId(String processId) {
		this.processId = processId;
	}
	public String getBussinessId() {
		return bussinessId;
	}
	public void setBussinessId(String bussinessId) {
		this.bussinessId = bussinessId;
	}
	public String getTableMapper() {
		return tableMapper;
	}
	public void setTableMapper(String tableMapper) {
		this.tableMapper = tableMapper;
	}
	public String getFieldName() {
		return fieldName;
	}
	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}
	public String getFieldValue() {
		return fieldValue;
	}
	public void setFieldValue(String fieldValue) {
		this.fieldValue = fieldValue;
	}
	public SysProcessMapper(String tableMapper, String fieldName,String fieldValue) {
		this.tableMapper = tableMapper;
		this.fieldName = fieldName;
		this.fieldValue = fieldValue;
	}

	public SysProcessMapper() {
	}
}
