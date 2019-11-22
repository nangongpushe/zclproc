package com.dhc.fastersoft.entity;

import java.util.Date;
import java.util.List;

import cn.afterturn.easypoi.excel.annotation.Excel;

public class StorageGaslog {
	private String id;
	@Excel(name="库点")
	private String warehouseName;

	private String warehouseId;
	@Excel(name="油罐编号")
	private String storagehouse;
	@Excel(name="检验时间")
	private String detectionTime;
	@Excel(name="检验方式")
	private String detectionOperation;
	//@Excel(name="磷化氢(ppm)")
	private String phosphine;
	//@Excel(name="含氧量(%)")
	private String oxygen;
	@Excel(name="检验人")
	private String detectionHumen;
	private String detectionHumenId;
	private Date createTime;

	private List<StorageGaslogTemp> storageGaslogTemp;
	private  String testingavg;

	public String getTestingavg() {
		return testingavg;
	}

	public void setTestingavg(String testingavg) {
		this.testingavg = testingavg;
	}

	public List<StorageGaslogTemp> getStorageGaslogTemp() {
		return storageGaslogTemp;
	}

	public void setStorageGaslogTemp(List<StorageGaslogTemp> storageGaslogTemp) {
		this.storageGaslogTemp = storageGaslogTemp;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getWarehouseName() {
		return warehouseName;
	}
	public void setWarehouseName(String warehouseName) {
		this.warehouseName = warehouseName;
	}
	public String getStoragehouse() {
		return storagehouse;
	}
	public void setStoragehouse(String storagehouse) {
		this.storagehouse = storagehouse;
	}
	public String getDetectionTime() {
		return detectionTime;
	}
	public void setDetectionTime(String detectionTime) {
		this.detectionTime = detectionTime;
	}
	public String getDetectionOperation() {
		return detectionOperation;
	}
	public void setDetectionOperation(String detectionOperation) {
		this.detectionOperation = detectionOperation;
	}
	public String getPhosphine() {
		return phosphine;
	}
	public void setPhosphine(String phosphine) {
		this.phosphine = phosphine;
	}
	public String getOxygen() {
		return oxygen;
	}
	public void setOxygen(String oxygen) {
		this.oxygen = oxygen;
	}
	public String getDetectionHumen() {
		return detectionHumen;
	}
	public void setDetectionHumen(String detectionHumen) {
		this.detectionHumen = detectionHumen;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getDetectionHumenId() {
		return detectionHumenId;
	}

	public void setDetectionHumenId(String detectionHumenId) {
		this.detectionHumenId = detectionHumenId;
	}

	public StorageGaslog(String id, String warehouseName, String detectionTime, String detectionOperation,
						 String phosphine, String oxygen, String detectionHumen, Date createTime) {
		this.id = id;
		this.warehouseName = warehouseName;
		this.detectionTime = detectionTime;
		this.detectionOperation = detectionOperation;
		this.phosphine = phosphine;
		this.oxygen = oxygen;
		this.detectionHumen = detectionHumen;
		this.createTime = createTime;
	}
	public StorageGaslog(String warehouseName,String detectionTime, String detectionHumen) {
		this.warehouseName = warehouseName;
		this.detectionTime = detectionTime;
		this.detectionHumen = detectionHumen;
	}
	public StorageGaslog() {
	}

	public String getWarehouseId() {
		return warehouseId;
	}

	public void setWarehouseId(String warehouseId) {
		this.warehouseId = warehouseId;
	}
}
