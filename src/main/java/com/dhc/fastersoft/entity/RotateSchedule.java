package com.dhc.fastersoft.entity;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

public class RotateSchedule {
	private String id;
	/**
	 * 经办人
	 */
	private String operator;
	/**
	 * 经办部门
	 */
	private String department;
	/**
	 * 填报时间
	 */
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date reportTime;
	/**
	 * 填报单位
	 */
	private String reportUnit;

	private String reportUnitId;
	/*
	 * 单位
	 */
	private String unit;
	
	private List<RotateScheduleDetail> detailList;
	
	private String reportTimeStr;
	
	private String noticeType;
	
	private String noticeSerial;
	
	private String noticeId;
	
	private String status;
	
	private String reporterId;



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

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public Date getReportTime() {
		return reportTime;
	}

	public void setReportTime(Date reportTime) {
		this.reportTime = reportTime;
	}

	public String getReportUnit() {
		return reportUnit;
	}

	public void setReportUnit(String reportUnit) {
		this.reportUnit = reportUnit;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public List<RotateScheduleDetail> getDetailList() {
		return detailList;
	}

	public void setDetailList(List<RotateScheduleDetail> detailList) {
		this.detailList = detailList;
	}

	public String getReportTimeStr() {
		return reportTimeStr;
	}

	public void setReportTimeStr(String reportTimeStr) {
		this.reportTimeStr = reportTimeStr;
	}

	public String getNoticeType() {
		return noticeType;
	}

	public void setNoticeType(String noticeType) {
		this.noticeType = noticeType;
	}

	public String getNoticeSerial() {
		return noticeSerial;
	}

	public void setNoticeSerial(String noticeSerial) {
		this.noticeSerial = noticeSerial;
	}

	public String getNoticeId() {
		return noticeId;
	}

	public void setNoticeId(String noticeId) {
		this.noticeId = noticeId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getReportUnitId() {
		return reportUnitId;
	}

	public void setReportUnitId(String reportUnitId) {
		this.reportUnitId = reportUnitId;
	}

	public RotateSchedule() {
	}

	public RotateSchedule(String id) {
		this.id = id;
	}
}
