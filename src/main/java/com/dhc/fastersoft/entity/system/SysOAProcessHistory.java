package com.dhc.fastersoft.entity.system;

import java.util.Date;

public class SysOAProcessHistory {
	private Date startTime;
	private Date endTime;
	private String message;
	private String strackTrace;
	
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getStrackTrace() {
		return strackTrace;
	}
	public void setStrackTrace(String strackTrace) {
		this.strackTrace = strackTrace;
	}
	public SysOAProcessHistory(Date startTime, Date endTime, String message) {
		this.startTime = startTime;
		this.endTime = endTime;
		this.message = message;
	}
	
	public SysOAProcessHistory() {}
}
