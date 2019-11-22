package com.dhc.fastersoft.entity;

import java.util.Date;

public class StorageOilcanRepair {
    @Override
	public String toString() {
		return "StorageOilcanRepair [id=" + id + ", oilcanId=" + oilcanId + ", repairDate=" + repairDate
				+ ", projectName=" + projectName + ", construction=" + construction + ", effect=" + effect + ", remark="
				+ remark + ", creator=" + creator + ", createDate=" + createDate + "]";
	}

	private String id;

    private String oilcanId;

    private String repairDate;

    private String projectName;

    private String construction;

    private String effect;

    private String remark;

    private String creator;

    private Date createDate;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOilcanId() {
        return oilcanId;
    }

    public void setOilcanId(String oilcanId) {
        this.oilcanId = oilcanId;
    }

    public String getRepairDate() {
        return repairDate;
    }

    public void setRepairDate(String repairDate) {
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

    public String getEffect() {
        return effect;
    }

    public void setEffect(String effect) {
        this.effect = effect;
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
}