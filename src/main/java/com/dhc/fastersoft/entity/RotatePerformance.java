package com.dhc.fastersoft.entity;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class RotatePerformance {
	private String id;
	private String operator;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date handleTime;
	private String department;
	private String type;
	private String deliveryPlace;
	private String enterpriseId;
	private String warehouseName;
	private String warehouseId;
	private String unit;
	private String status;
	private String dealSerial;
	private String bidSerial="";
	private String storehouse;
	private String takeEnd;
	private String deliveryEnd;
	private String grainType;
	private String dealUnit;
	private String dealUnitId;
	private String quantity;
	private String inPlanQuantity;
	private String processDetail;
	private String annex;
	private String remark;

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public Date getHandleTime() {
		return handleTime;
	}
	public void setHandleTime(Date handleTime) {
		this.handleTime = handleTime;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDeliveryPlace() {
		return deliveryPlace;
	}
	public void setDeliveryPlace(String deliveryPlace) {
		this.deliveryPlace = deliveryPlace;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getDealSerial() {
		return dealSerial;
	}
	public void setDealSerial(String dealSerial) {
		this.dealSerial = dealSerial;
	}
	public String getBidSerial() {
		return bidSerial;
	}
	public void setBidSerial(String bidSerial) {
		this.bidSerial = bidSerial;
	}
	public String getStorehouse() {
		return storehouse;
	}
	public void setStorehouse(String storehouse) {
		this.storehouse = storehouse;
	}
	public String getTakeEnd() {
		return takeEnd;
	}
	public void setTakeEnd(String takeEnd) {
		this.takeEnd = takeEnd;
	}
	public String getDeliveryEnd() {
		return deliveryEnd;
	}
	public void setDeliveryEnd(String deliveryEnd) {
		this.deliveryEnd = deliveryEnd;
	}
	public String getGrainType() {
		return grainType;
	}
	public void setGrainType(String grainType) {
		this.grainType = grainType;
	}
	public String getDealUnit() {
		return dealUnit;
	}
	public void setDealUnit(String dealUnit) {
		this.dealUnit = dealUnit;
	}
	public String getQuantity() {
		return quantity;
	}
	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}
	public String getInPlanQuantity() {
		return inPlanQuantity;
	}
	public void setInPlanQuantity(String inPlanQuantity) {
		this.inPlanQuantity = inPlanQuantity;
	}
	public String getProcessDetail() {
		return processDetail;
	}
	public void setProcessDetail(String processDetail) {
		this.processDetail = processDetail;
	}
	public String getAnnex() {
		return annex;
	}
	public void setAnnex(String annex) {
		this.annex = annex;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public RotatePerformance() {
	}
	public RotatePerformance(Date handleTime) {
		this.handleTime = handleTime;
	}

	public String getWarehouseId() {
		return warehouseId;
	}

	public void setWarehouseId(String warehouseId) {
		this.warehouseId = warehouseId;
	}

	public String getDealUnitId() {
		return dealUnitId;
	}

	public void setDealUnitId(String dealUnitId) {
		this.dealUnitId = dealUnitId;
	}

	public String getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(String enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	public String getWarehouseName() {
		return warehouseName;
	}

	public void setWarehouseName(String warehouseName) {
		this.warehouseName = warehouseName;
	}
}
