package com.dhc.fastersoft.entity;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class StorageStoreHouseOption {
	private static SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
    private String id;

    private String storehouseId;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date repairDate;

    private String projectName;

    private String construction;

    private String remark;

    private String creator;
    
    private Date createDate;
    
    private String repairDateStr; 

    public String getRepairDateStr() {
		return repairDateStr;
	}

	public void setRepairDateStr(String repairDateStr) {
		this.repairDateStr = repairDateStr;
	}

	public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getStorehouseId() {
        return storehouseId;
    }

    public void setStorehouseId(String storehouseId) {
        this.storehouseId = storehouseId;
    }

    public Date getRepairDate() {
        return repairDate;
    }

    public void setRepairDate(Date repairDate) {
    	this.repairDateStr = DATE_FORMAT.format(repairDate);
        this.repairDate = repairDate;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getConstruction() {
        return construction;
    }

    public void setConstruction(String construction) {
        this.construction = construction;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

	@Override
	public String toString() {
		return "StorageStoreHouseOption [id=" + id + ", storehouseId=" + storehouseId + ", repairDate=" + repairDate
				+ ", projectName=" + projectName + ", construction=" + construction + ", remark=" + remark
				+ ", creator=" + creator + ", createDate=" + createDate + "]";
	}
	
}