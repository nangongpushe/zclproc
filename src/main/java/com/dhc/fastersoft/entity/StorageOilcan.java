package com.dhc.fastersoft.entity;

import java.util.Date;

public class StorageOilcan {
    private String id;

    private String warehouse;

    private String warehouseId;

    private String oilcanSerial;

    private String oilcanType;

    private String oilcanStatus;

    private String deliverDate;

    private String oilcanBody;

    private String oilcanTop;

    private String oilcanFloor;

    private String designedCapacity;

    private String authorizedCapacity;

    private String oilcanHeigh;

    private String oilcanInnerDiameter;

    private String oilcanOuterDiameter;

    private String designedOilLine;

    private String authorizedOilLine;

    private String heatInsulation;

    private String creator;

    private String creatorId;

    private Date createDate;

    private String remark;
    
    private String longitude;

    private String orderNo;
    
    public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getOilcanName() {
		return oilcanName;
	}

	public void setOilcanName(String oilcanName) {
		this.oilcanName = oilcanName;
	}

	private String latitude;
    
    private String oilcanName;

    private String warehouseCode;


    private String isStop;

    public String getIsStop() {
        return isStop;
    }

    public void setIsStop(String isStop) {
        this.isStop = isStop;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(String warehouse) {
        this.warehouse = warehouse == null ? null : warehouse.trim();
    }

    public String getOilcanSerial() {
        return oilcanSerial;
    }

    public void setOilcanSerial(String oilcanSerial) {
        this.oilcanSerial = oilcanSerial == null ? null : oilcanSerial.trim();
    }

    public String getOilcanType() {
        return oilcanType;
    }

    public void setOilcanType(String oilcanType) {
        this.oilcanType = oilcanType == null ? null : oilcanType.trim();
    }

    public String getOilcanStatus() {
        return oilcanStatus;
    }

    public void setOilcanStatus(String oilcanStatus) {
        this.oilcanStatus = oilcanStatus == null ? null : oilcanStatus.trim();
    }

    public String getDeliverDate() {
        return deliverDate;
    }

    public void setDeliverDate(String deliverDate) {
        this.deliverDate = deliverDate == null ? null : deliverDate.trim();
    }

    public String getOilcanBody() {
        return oilcanBody;
    }

    public void setOilcanBody(String oilcanBody) {
        this.oilcanBody = oilcanBody == null ? null : oilcanBody.trim();
    }

    public String getOilcanTop() {
        return oilcanTop;
    }

    public void setOilcanTop(String oilcanTop) {
        this.oilcanTop = oilcanTop == null ? null : oilcanTop.trim();
    }

    public String getOilcanFloor() {
        return oilcanFloor;
    }

    public void setOilcanFloor(String oilcanFloor) {
        this.oilcanFloor = oilcanFloor == null ? null : oilcanFloor.trim();
    }

    public String getDesignedCapacity() {
        return designedCapacity;
    }

    public void setDesignedCapacity(String designedCapacity) {
        this.designedCapacity = designedCapacity == null ? null : designedCapacity.trim();
    }

    public String getAuthorizedCapacity() {
        return authorizedCapacity;
    }

    public void setAuthorizedCapacity(String authorizedCapacity) {
        this.authorizedCapacity = authorizedCapacity == null ? null : authorizedCapacity.trim();
    }

    public String getOilcanHeigh() {
        return oilcanHeigh;
    }

    public void setOilcanHeigh(String oilcanHeigh) {
        this.oilcanHeigh = oilcanHeigh == null ? null : oilcanHeigh.trim();
    }

    public String getOilcanInnerDiameter() {
        return oilcanInnerDiameter;
    }

    public void setOilcanInnerDiameter(String oilcanInnerDiameter) {
        this.oilcanInnerDiameter = oilcanInnerDiameter == null ? null : oilcanInnerDiameter.trim();
    }

    public String getOilcanOuterDiameter() {
        return oilcanOuterDiameter;
    }

    public void setOilcanOuterDiameter(String oilcanOuterDiameter) {
        this.oilcanOuterDiameter = oilcanOuterDiameter == null ? null : oilcanOuterDiameter.trim();
    }

    public String getDesignedOilLine() {
        return designedOilLine;
    }

    public void setDesignedOilLine(String designedOilLine) {
        this.designedOilLine = designedOilLine == null ? null : designedOilLine.trim();
    }

    public String getAuthorizedOilLine() {
        return authorizedOilLine;
    }

    public void setAuthorizedOilLine(String authorizedOilLine) {
        this.authorizedOilLine = authorizedOilLine == null ? null : authorizedOilLine.trim();
    }

    public String getHeatInsulation() {
        return heatInsulation;
    }

    public void setHeatInsulation(String heatInsulation) {
        this.heatInsulation = heatInsulation;
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

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getWarehouseCode() {
        return warehouseCode;
    }

    public void setWarehouseCode(String warehouseCode) {
        this.warehouseCode = warehouseCode;
    }

    public String getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(String creatorId) {
        this.creatorId = creatorId;
    }

    public String getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(String warehouseId) {
        this.warehouseId = warehouseId;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }
}