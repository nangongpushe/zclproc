package com.dhc.fastersoft.entity.store;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

public class StoragePhosphine {
	private String id;
	private String warehouse;
	private String warehouseId;
	private String encode;
	private String fumigate;
	private String average;
	private String inspector;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date inspecteTime;
	private String remark;
	private List<StoragePhosphinePoint> pointList;
	private String inspectorId;
	private String inspectors;
	private String testDevice;

	public String getTestDevice() {
		return testDevice;
	}

	public void setTestDevice(String testDevice) {
		this.testDevice = testDevice;
	}

	public String getInspectors() {
		return inspectors;
	}

	public void setInspectors(String inspectors) {
		this.inspectors = inspectors;
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

	public String getFumigate() {
		return fumigate;
	}

	public void setFumigate(String fumigate) {
		this.fumigate = fumigate;
	}

	public String getAverage() {
		return average;
	}

	public void setAverage(String average) {
		this.average = average;
	}

	public String getInspector() {
		return inspector;
	}

	public void setInspector(String inspector) {
		this.inspector = inspector;
	}

	public Date getInspecteTime() {
		return inspecteTime;
	}

	public void setInspecteTime(Date inspecteTime) {
		this.inspecteTime = inspecteTime;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public List<StoragePhosphinePoint> getPointList() {
		return pointList;
	}

	public void setPointList(List<StoragePhosphinePoint> pointList) {
		this.pointList = pointList;
	}

	public String getInspectorId() {
		return inspectorId;
	}

	public void setInspectorId(String inspectorId) {
		this.inspectorId = inspectorId;
	}

	public String getWarehouseId() {
		return warehouseId;
	}

	public void setWarehouseId(String warehouseId) {
		this.warehouseId = warehouseId;
	}
}