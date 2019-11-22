package com.dhc.fastersoft.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;

public class ConstructionScheduleDetail {
	private String id;
	private String scheduleId;
	@Excel(name="序号")
	private int serial;
	@Excel(name="项目编号")
	private String projectSerial;
	@Excel(name="项目名称")
	private String projectName;
	@Excel(name="批准投资")
	private double approvedInvestment;
	@Excel(name="本月完成投资")
	private double currentInvestment;
	@Excel(name="累计完成投资")
	private double accumulateInvestment;
	@Excel(name="形象进度")
	private String progress;
	@Excel(name="备注")
	private String remark;
	
	private String projectId;
	
	public String getProjectId() {
		return projectId;
	}
	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getScheduleId() {
		return scheduleId;
	}
	public void setScheduleId(String scheduleId) {
		this.scheduleId = scheduleId;
	}
	public int getSerial() {
		return serial;
	}
	public void setSerial(int serial) {
		this.serial = serial;
	}
	public String getProjectSerial() {
		return projectSerial;
	}
	public void setProjectSerial(String projectSerial) {
		this.projectSerial = projectSerial;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public double getApprovedInvestment() {
		return approvedInvestment;
	}
	public void setApprovedInvestment(double approvedInvestment) {
		this.approvedInvestment = approvedInvestment;
	}
	public double getCurrentInvestment() {
		return currentInvestment;
	}
	public void setCurrentInvestment(double currentInvestment) {
		this.currentInvestment = currentInvestment;
	}
	public double getAccumulateInvestment() {
		return accumulateInvestment;
	}
	public void setAccumulateInvestment(double accumulateInvestment) {
		this.accumulateInvestment = accumulateInvestment;
	}
	public String getProgress() {
		return progress;
	}
	public void setProgress(String progress) {
		this.progress = progress;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
}
