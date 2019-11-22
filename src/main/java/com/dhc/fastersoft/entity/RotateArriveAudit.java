package com.dhc.fastersoft.entity;

import java.util.Date;


public class RotateArriveAudit {
	private String arriveId;
	private String auditorId;
	private String advice;
	private Date auditDate;
	private String reason;
	private String auditorName;
	private int auditStep;
	private Date auditCompleteDate;

	public Date getAuditCompleteDate() {
		return auditCompleteDate;
	}

	public void setAuditCompleteDate(Date auditCompleteDate) {
		this.auditCompleteDate = auditCompleteDate;
	}

	public String getArriveId() {
		return arriveId;
	}
	public void setArriveId(String arriveId) {
		this.arriveId = arriveId;
	}
	public String getAuditorId() {
		return auditorId;
	}
	public void setAuditorId(String auditorId) {
		this.auditorId = auditorId;
	}
	public String getAdvice() {
		return advice;
	}
	public void setAdvice(String advice) {
		this.advice = advice;
	}
	public Date getAuditDate() {
		return auditDate;
	}
	public void setAuditDate(Date auditDate) {
		this.auditDate = auditDate;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getAuditorName() {
		return auditorName;
	}
	public void setAuditorName(String auditorName) {
		this.auditorName = auditorName;
	}
	public int getAuditStep() {
		return auditStep;
	}
	public void setAuditStep(int auditStep) {
		this.auditStep = auditStep;
	}
	
	
}
