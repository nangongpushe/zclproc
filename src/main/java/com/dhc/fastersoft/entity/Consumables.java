package com.dhc.fastersoft.entity;

import java.util.Date;

public class Consumables {
	private String id ;   //主键ID
	private String storehouse ;   //所入库房'
	private String warehouseId ;   //库房ID'
	private String commodity ;   //品名
	private String model ;   //规格型号
	private String unit ;   //制造单位:个、件、套
	private String custodian ;   //保管负责人
	private int incomingQuantity ;   //入库量(正整数)INCOMING_QUANTITY
	private int apply ;   //本次领用量(正整数)
	private int totalApply ;   //累计领用量(正整数)
	private int surplus ;   //剩余量(正整数)
	private double unitPrice ;   //单价
	private double amount ;   //金额'
	private String manufacturer ;   //生产厂家MANUFACTURER
	private String serialNumber ;   //出厂编号SERIAL_NUMBER
	private String supplier ;   //供应商SUPPLIER
	private String options ;   //随机资料OPTIONS
	private String groupId ;   //物资照片(附件分组ID)GROUP_ID
	private String storageDate ;   //入库时间(YYYY-MM-DD)STORAGE_DATE
	private String storagePlace ;   //存放地点STORAGE_PLACE
	private String remark ;  //备注
	private String creator ;  //创建者
	private String createDate;   //创建时间
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getStorehouse() {
		return storehouse;
	}
	public void setStorehouse(String storeHouse) {
		this.storehouse = storeHouse;
	}
	public String getCommodity() {
		return commodity;
	}
	public void setCommodity(String commodity) {
		this.commodity = commodity;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getCustodian() {
		return custodian;
	}
	public void setCustodian(String custodian) {
		this.custodian = custodian;
	}
	public int getIncomingQuantity() {
		return incomingQuantity;
	}
	public void setIncomingQuantity(int incomingQuantity) {
		this.incomingQuantity = incomingQuantity;
	}
	public int getApply() {
		return apply;
	}
	public void setApply(int apply) {
		this.apply = apply;
	}
	public int getTotalApply() {
		return totalApply;
	}
	public void setTotalApply(int totalApply) {
		this.totalApply = totalApply;
	}
	public int getSurplus() {
		return surplus;
	}
	public void setSurplus(int surplus) {
		this.surplus = surplus;
	}
	public double getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(double unitPrice) {
		this.unitPrice = unitPrice;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public String getManufacturer() {
		return manufacturer;
	}
	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}
	public String getSerialNumber() {
		return serialNumber;
	}
	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}
	public String getSupplier() {
		return supplier;
	}
	public void setSupplier(String supplier) {
		this.supplier = supplier;
	}
	public String getOptions() {
		return options;
	}
	public void setOptions(String options) {
		this.options = options;
	}
	public String getGroupId() {
		return groupId;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	public String getStorageDate() {
		return storageDate;
	}
	public void setStorageDate(String storageDate) {
		this.storageDate = storageDate;
	}
	public String getStoragePlace() {
		return storagePlace;
	}
	public void setStoragePlace(String storagePlace) {
		this.storagePlace = storagePlace;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getWarehouseId() {
		return warehouseId;
	}

	public void setWarehouseId(String warehouseId) {
		this.warehouseId = warehouseId;
	}
}
