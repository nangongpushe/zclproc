package com.dhc.fastersoft.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;

public class ConstructionBalance {
	private String id;
	@Excel(name="项目编号")
	private String projectSerial;
	@Excel(name="项目单位")
	private String projectUnit;
	@Excel(name="项目名称")
	private String projectName;
	@Excel(name="经办人")
	private String operator;
	private String reportTime;
	private String reportUnit;
	private String reportDept;
	@Excel(name="承建单位")
	private String contractor;
	@Excel(name="承建单位上报数")
	private int contractorNum;
	@Excel(name="项目单位(监理)初审数")
	private int controlNum;
	@Excel(name="审计单位审定数")
	private double auditNum;
	@Excel(name="库现场管理人员初审意见")
	private String preliminaryOpinion;
	private String imageGroupId;
	private String fileGroupId;
	private String status;
	private String warehouseId;
	
	private String projectId;
	
	public String getWarehouseId() {
		return warehouseId;
	}
	public void setWarehouseId(String warehouseId) {
		this.warehouseId = warehouseId;
	}
	public String getProjectId() {
		return projectId;
	}
	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}



	private ConstructionProject parentProject;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getProjectSerial() {
		return projectSerial;
	}
	public void setProjectSerial(String projectSerial) {
		this.projectSerial = projectSerial;
	}
	public String getProjectUnit() {
		return projectUnit;
	}
	public void setProjectUnit(String projectUnit) {
		this.projectUnit = projectUnit;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getReportTime() {
		return reportTime;
	}
	public void setReportTime(String reportTime) {
		this.reportTime = reportTime;
	}
	public String getReportUnit() {
		return reportUnit;
	}
	public void setReportUnit(String reportUnit) {
		this.reportUnit = reportUnit;
	}
	public String getReportDept() {
		return reportDept;
	}
	public void setReportDept(String reportDept) {
		this.reportDept = reportDept;
	}
	public String getContractor() {
		return contractor;
	}
	public void setContractor(String contractor) {
		this.contractor = contractor;
	}
	public int getContractorNum() {
		return contractorNum;
	}
	public void setContractorNum(int contractorNum) {
		this.contractorNum = contractorNum;
	}
	public int getControlNum() {
		return controlNum;
	}
	public void setControlNum(int controlNum) {
		this.controlNum = controlNum;
	}
	public String getPreliminaryOpinion() {
		return preliminaryOpinion;
	}
	public void setPreliminaryOpinion(String preliminaryOpinion) {
		this.preliminaryOpinion = preliminaryOpinion;
	}
	public String getImageGroupId() {
		return imageGroupId;
	}
	public void setImageGroupId(String imageGroupId) {
		this.imageGroupId = imageGroupId;
	}
	public String getFileGroupId() {
		return fileGroupId;
	}
	public void setFileGroupId(String fileGroupId) {
		this.fileGroupId = fileGroupId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public double getAuditNum() {
		return auditNum;
	}
	public void setAuditNum(double auditNum) {
		this.auditNum = auditNum;
	}


	public ConstructionProject getParentProject() {
		return parentProject;
	}

	public void setParentProject(ConstructionProject parentProject) {
		this.parentProject = parentProject;
	}
}
