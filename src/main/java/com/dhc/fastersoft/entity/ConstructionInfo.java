package com.dhc.fastersoft.entity;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class ConstructionInfo {
	private String id;
	private String dataType;
	private String projectSerial;
	private String projectUnit;
	private String projectName;
	private String operator;
	private String department;
	private Date handleTime;
	private String changeSerial;
	private String imageGroupId;
	private String fileGroupId;
	private String meetGroupId;
	private String projectYear;
	private String warehouseId;
	private String projectId;
	public String getProjectId() {
		return projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}

	public String getWarehouseId() {
		return warehouseId;
	}

	public void setWarehouseId(String warehouseId) {
		this.warehouseId = warehouseId;
	}

	// 父工程
	private ConstructionProject parentProject;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date changeDate;	// 变更日期


	public Date getChangeDate() {
		return changeDate;
	}

	public void setChangeDate(Date changeDate) {
		this.changeDate = changeDate;
	}

	public String getProjectYear() {
		return projectYear;
	}
	public void setProjectYear(String projectYear) {
		this.projectYear = projectYear;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDataType() {
		return dataType;
	}
	public void setDataType(String dataType) {
		this.dataType = dataType;
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
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public Date getHandleTime() {
		return handleTime;
	}
	public void setHandleTime(Date handleTime) {
		this.handleTime = handleTime;
	}
	public String getChangeSerial() {
		return changeSerial;
	}
	public void setChangeSerial(String changeSerial) {
		this.changeSerial = changeSerial;
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
	public String getMeetGroupId() {
		return meetGroupId;
	}
	public void setMeetGroupId(String meetGroupId) {
		this.meetGroupId = meetGroupId;
	}

	public ConstructionProject getParentProject() {
		return parentProject;
	}

	public void setParentProject(ConstructionProject parentProject) {
		this.parentProject = parentProject;
	}
}
