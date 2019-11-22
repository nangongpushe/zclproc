package com.dhc.fastersoft.entity;

import java.util.Date;

public class ConstructionProject {
	private String id;
	private String referenceNo;
	private String projectSerial;
	private String projectUnit;
	private String projectName;
	private String projectYear;
	private String projectTime;
	private double plannedInvestment;
	private String constructionType;
	private Integer constructionArea;
	private String projectStatus;
	private String storageCapacity;
	private String plannedStartTime;
	private String plannedFinishTime;
	private String imageGroupId;
	private String fileGroupId;
	private double actualInvestment;
	private String actualStartTime;
	private String actualFinishTime;
	private String reconnaissance;
	private String designUnit;
	private String buildUnit;
	private String controlUnit;
	private String contactor;
	private String contactWay;
	private String dataGroupId;
	private String remark;
	private String otherFileGroupId;
	private Date createTime;
	private String capacity;
	private String warehouseId;
	private ConstructionProject parentProject;	// 父项目
	private Boolean hasChildProject;	// 是否有子项目
	
	
	
	public String getWarehouseId() {
		return warehouseId;
	}
	public void setWarehouseId(String warehouseId) {
		this.warehouseId = warehouseId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getReferenceNo() {
		return referenceNo;
	}
	public void setReferenceNo(String referenceNo) {
		this.referenceNo = referenceNo;
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
	public String getProjectYear() {
		return projectYear;
	}
	public void setProjectYear(String projectYear) {
		this.projectYear = projectYear;
	}
	public String getProjectTime() {
		return projectTime;
	}
	public void setProjectTime(String projectTime) {
		this.projectTime = projectTime;
	}
	public double getPlannedInvestment() {
		return plannedInvestment;
	}
	public void setPlannedInvestment(double plannedInvestment) {
		this.plannedInvestment = plannedInvestment;
	}
	public String getConstructionType() {
		return constructionType;
	}
	public void setConstructionType(String constructionType) {
		this.constructionType = constructionType;
	}
	public Integer getConstructionArea() {
		return constructionArea;
	}
	public void setConstructionArea(Integer constructionArea) {
		this.constructionArea = constructionArea;
	}
	public String getProjectStatus() {
		return projectStatus;
	}
	public void setProjectStatus(String projectStatus) {
		this.projectStatus = projectStatus;
	}
	public String getStorageCapacity() {
		return storageCapacity;
	}
	public void setStorageCapacity(String storageCapacity) {
		this.storageCapacity = storageCapacity;
	}
	public String getPlannedStartTime() {
		return plannedStartTime;
	}
	public void setPlannedStartTime(String plannedStartTime) {
		this.plannedStartTime = plannedStartTime;
	}
	public String getPlannedFinishTime() {
		return plannedFinishTime;
	}
	public void setPlannedFinishTime(String plannedFinishTime) {
		this.plannedFinishTime = plannedFinishTime;
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
	public double getActualInvestment() {
		return actualInvestment;
	}
	public void setActualInvestment(double actualInvestment) {
		this.actualInvestment = actualInvestment;
	}
	public String getActualStartTime() {
		return actualStartTime;
	}
	public void setActualStartTime(String actualStartTime) {
		this.actualStartTime = actualStartTime;
	}
	public String getActualFinishTime() {
		return actualFinishTime;
	}
	public void setActualFinishTime(String actualFinishTime) {
		this.actualFinishTime = actualFinishTime;
	}
	public String getReconnaissance() {
		return reconnaissance;
	}
	public void setReconnaissance(String reconnaissance) {
		this.reconnaissance = reconnaissance;
	}
	public String getDesignUnit() {
		return designUnit;
	}
	public void setDesignUnit(String designUnit) {
		this.designUnit = designUnit;
	}
	public String getBuildUnit() {
		return buildUnit;
	}
	public void setBuildUnit(String buildUnit) {
		this.buildUnit = buildUnit;
	}
	public String getControlUnit() {
		return controlUnit;
	}
	public void setControlUnit(String controlUnit) {
		this.controlUnit = controlUnit;
	}
	public String getContactor() {
		return contactor;
	}
	public void setContactor(String contactor) {
		this.contactor = contactor;
	}
	public String getContactWay() {
		return contactWay;
	}
	public void setContactWay(String contactWay) {
		this.contactWay = contactWay;
	}
	public String getDataGroupId() {
		return dataGroupId;
	}
	public void setDataGroupId(String dataGroupId) {
		this.dataGroupId = dataGroupId;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getOtherFileGroupId() {
		return otherFileGroupId;
	}
	public void setOtherFileGroupId(String otherFileGroupId) {
		this.otherFileGroupId = otherFileGroupId;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getCapacity() {
		return capacity;
	}
	public void setCapacity(String capacity) {
		this.capacity = capacity;
	}

	public ConstructionProject getParentProject() {
		return parentProject;
	}

	public void setParentProject(ConstructionProject parentProject) {
		this.parentProject = parentProject;
	}

	public Boolean getHasChildProject() {
		return hasChildProject;
	}

	public void setHasChildProject(Boolean hasChildProject) {
		this.hasChildProject = hasChildProject;
	}
}
