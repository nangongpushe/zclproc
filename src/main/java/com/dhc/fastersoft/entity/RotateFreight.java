package com.dhc.fastersoft.entity;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import cn.afterturn.easypoi.excel.annotation.Excel;
import cn.afterturn.easypoi.excel.annotation.ExcelCollection;


public class RotateFreight {
	private String id;
	private String freightName;
	private String inviteUnit;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date inviteTime;
	private String groupId;
	private String status;
	private String operator;
	private Date operatorTime;
	private List<RotateFreightDetail> freightDetails;
	private String reporterId;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date inviteEndTime;

	public Date getInviteEndTime() {
		return inviteEndTime;
	}

	public void setInviteEndTime(Date inviteEndTime) {
		this.inviteEndTime = inviteEndTime;
	}

	public String getReporterId() {
		return reporterId;
	}
	public void setReporterId(String reporterId) {
		this.reporterId = reporterId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getFreightName() {
		return freightName;
	}
	public void setFreightName(String freightName) {
		this.freightName = freightName;
	}
	public String getInviteUnit() {
		return inviteUnit;
	}
	public void setInviteUnit(String inviteUnit) {
		this.inviteUnit = inviteUnit;
	}
	public Date getInviteTime() {
		return inviteTime;
	}
	public void setInviteTime(Date inviteTime) {
		this.inviteTime = inviteTime;
	}
	public String getGroupId() {
		return groupId;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public Date getOperatorTime() {
		return operatorTime;
	}
	public void setOperatorTime(Date operatorTime) {
		this.operatorTime = operatorTime;
	}
	public List<RotateFreightDetail> getFreightDetails() {
		return freightDetails;
	}
	public void setFreightDetails(List<RotateFreightDetail> freightDetails) {
		this.freightDetails = freightDetails;
	}
	
}
