package com.dhc.fastersoft.entity;

import java.math.BigDecimal;

public class StorageStoreHouse {
    private String id;

    private String warehouse;

    private String encode;

    private String type;

    private String status;

    private String enableDate;

    private String structure;

    private BigDecimal bulkHeight;

    private BigDecimal gateNum;

    private String cfa;

    private BigDecimal siloDiameter;

    private BigDecimal siloBore;

    private BigDecimal siloVolume;

    private BigDecimal gateHeight;

    private BigDecimal gateWidth;

    private BigDecimal eavesHeight;

    private BigDecimal designedCapacity;

    private BigDecimal authorizedCapacity;

    private String bulkArea;

    private BigDecimal ventNum;

    private String ductType;

    private String siloTightness;

    private BigDecimal axialNum;

    private String heatInsulation;

    private String creator;
	private String creatorId;


	private String warehouseId;
	private String message;

	private BigDecimal orderNo;

	public String getWarehouseId() {
		return warehouseId;
	}

	public void setWarehouseId(String warehouseId) {
		this.warehouseId = warehouseId;
	}
	public String getCreatorId() {
		return creatorId;
	}

	public void setCreatorId(String creatorId) {
		this.creatorId = creatorId;
	}

	private String createDate;

    private String warehouseCode;

    private String storeType;

    private String keeper;

    private String remark;

    private String buildingType;

    private BigDecimal length;

    private BigDecimal width;

    private BigDecimal height;

    private String longitude;

    private String latitude;
    
    private String storehouseName;

    private String address;

	private String isStop;

	public String getIsStop() {
		return isStop;
	}

	public void setIsStop(String isStop) {
		this.isStop = isStop;
	}


	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getStorehouseName() {
		return storehouseName;
	}

	public void setStorehouseName(String storehouseName) {
		this.storehouseName = storehouseName;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getWarehouse() {
		return warehouse;
	}

	public void setWarehouse(String warehouse) {
		this.warehouse = warehouse;
	}

	public String getEncode() {
		return encode;
	}

	public void setEncode(String encode) {
		this.encode = encode;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}


	public String getEnableDate() {
		return enableDate;
	}

	public void setEnableDate(String enableDate) {
		this.enableDate = enableDate;
	}

	public String getStructure() {
		return structure;
	}

	public void setStructure(String structure) {
		this.structure = structure;
	}

	public BigDecimal getBulkHeight() {
		return bulkHeight;
	}

	public void setBulkHeight(BigDecimal bulkHeight) {
		this.bulkHeight = bulkHeight;
	}

	public BigDecimal getGateNum() {
		return gateNum;
	}

	public void setGateNum(BigDecimal gateNum) {
		this.gateNum = gateNum;
	}

	
	public BigDecimal getSiloDiameter() {
		return siloDiameter;
	}

	public void setSiloDiameter(BigDecimal siloDiameter) {
		this.siloDiameter = siloDiameter;
	}

	public BigDecimal getSiloBore() {
		return siloBore;
	}

	public void setSiloBore(BigDecimal siloBore) {
		this.siloBore = siloBore;
	}

	public BigDecimal getSiloVolume() {
		return siloVolume;
	}

	public void setSiloVolume(BigDecimal siloVolume) {
		this.siloVolume = siloVolume;
	}

	public BigDecimal getGateHeight() {
		return gateHeight;
	}

	public void setGateHeight(BigDecimal gateHeight) {
		this.gateHeight = gateHeight;
	}

	public BigDecimal getGateWidth() {
		return gateWidth;
	}

	public void setGateWidth(BigDecimal gateWidth) {
		this.gateWidth = gateWidth;
	}

	public BigDecimal getEavesHeight() {
		return eavesHeight;
	}

	public void setEavesHeight(BigDecimal eavesHeight) {
		this.eavesHeight = eavesHeight;
	}

	public BigDecimal getDesignedCapacity() {
		return designedCapacity;
	}

	public void setDesignedCapacity(BigDecimal designedCapacity) {
		this.designedCapacity = designedCapacity;
	}

	public BigDecimal getAuthorizedCapacity() {
		return authorizedCapacity;
	}

	public void setAuthorizedCapacity(BigDecimal authorizedCapacity) {
		this.authorizedCapacity = authorizedCapacity;
	}

	

	public String getCfa() {
		return cfa;
	}

	public void setCfa(String cfa) {
		this.cfa = cfa;
	}

	public String getBulkArea() {
		return bulkArea;
	}

	public void setBulkArea(String bulkArea) {
		this.bulkArea = bulkArea;
	}

	public BigDecimal getVentNum() {
		return ventNum;
	}

	public void setVentNum(BigDecimal ventNum) {
		this.ventNum = ventNum;
	}

	public String getDuctType() {
		return ductType;
	}

	public void setDuctType(String ductType) {
		this.ductType = ductType;
	}

	public String getSiloTightness() {
		return siloTightness;
	}

	public void setSiloTightness(String siloTightness) {
		this.siloTightness = siloTightness;
	}

	public BigDecimal getAxialNum() {
		return axialNum;
	}

	public void setAxialNum(BigDecimal axialNum) {
		this.axialNum = axialNum;
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

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getWarehouseCode() {
		return warehouseCode;
	}

	public void setWarehouseCode(String warehouseCode) {
		this.warehouseCode = warehouseCode;
	}

	public String getStoreType() {
		return storeType;
	}

	public void setStoreType(String storeType) {
		this.storeType = storeType;
	}

	public String getKeeper() {
		return keeper;
	}

	public void setKeeper(String keeper) {
		this.keeper = keeper;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getBuildingType() {
		return buildingType;
	}

	public void setBuildingType(String buildingType) {
		this.buildingType = buildingType;
	}

	public BigDecimal getLength() {
		return length;
	}

	public void setLength(BigDecimal length) {
		this.length = length;
	}

	public BigDecimal getWidth() {
		return width;
	}

	public void setWidth(BigDecimal width) {
		this.width = width;
	}

	public BigDecimal getHeight() {
		return height;
	}

	public void setHeight(BigDecimal height) {
		this.height = height;
	}

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

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public BigDecimal getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(BigDecimal orderNo) {
		this.orderNo = orderNo;
	}
}