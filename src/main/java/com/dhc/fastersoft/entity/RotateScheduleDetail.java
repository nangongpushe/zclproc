package com.dhc.fastersoft.entity;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

public class RotateScheduleDetail {
	private String id;

	private String scheduleId;

	private String storehouse;

	private String grainType;

	private String deliveryUnit;

	private double quantity;
	
	private double priorPeriod;
	
	private double currentPeriod;
	
	private double total;
	
	private double compleRate;
	
	private String modifier;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date modifyTime;
	
	private String remark;
	
	private String dealSerial;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date reportTime;
	
	private String modifyTimeStr;
	
	private String schemeBatch;
	
	private String dealUnit;
	
	private String deliveryStart;
	
	private String deliveryEnd;
	
	private String dealDate;
	
	private String rotateType;
	
	private String bidSerial;


	private String reportUnit;



	public String getReportUnit() {
		return reportUnit;
	}

	public void setReportUnit(String reportUnit) {
		this.reportUnit = reportUnit;
	}

	public String getBidSerial() {
		return bidSerial;
	}

	public void setBidSerial(String bidSerial) {
		this.bidSerial = bidSerial;
	}



	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getScheduleId() {
		return scheduleId;
	}

	public void setScheduleId(String scheduleId) {
		this.scheduleId = scheduleId;
	}

	public String getStorehouse() {
		return storehouse;
	}

	public void setStorehouse(String storehouse) {
		this.storehouse = storehouse;
	}



	public String getGrainType() {
		return grainType;
	}

	public void setGrainType(String grainType) {
		this.grainType = grainType;
	}

	public String getDeliveryUnit() {
		return deliveryUnit;
	}

	public void setDeliveryUnit(String deliveryUnit) {
		this.deliveryUnit = deliveryUnit;
	}

	public double getQuantity() {
		return quantity;
	}

	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}

	public double getPriorPeriod() {
		return priorPeriod;
	}

	public void setPriorPeriod(double priorPeriod) {
		this.priorPeriod = priorPeriod;
	}

	public double getCurrentPeriod() {
		return currentPeriod;
	}

	public void setCurrentPeriod(double currentPeriod) {
		this.currentPeriod = currentPeriod;
	}

	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

	public double getCompleRate() {
		return compleRate;
	}

	public void setCompleRate(double compleRate) {
		this.compleRate = compleRate;
	}

	public String getModifier() {
		return modifier;
	}

	public void setModifier(String modifier) {
		this.modifier = modifier;
	}

	public Date getModifyTime() {
		return modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getModifyTimeStr() {
		return modifyTimeStr;
	}

	public void setModifyTimeStr(String modifyTimeStr) {
		this.modifyTimeStr = modifyTimeStr;
	}

	public Date getReportTime() {
		return reportTime;
	}

	public void setReportTime(Date reportTime) {
		this.reportTime = reportTime;
	}

	public String getDealSerial() {
		return dealSerial;
	}

	public void setDealSerial(String dealSerial) {
		this.dealSerial = dealSerial;
	}

	public String getSchemeBatch() {
		return schemeBatch;
	}

	public void setSchemeBatch(String schemeBatch) {
		this.schemeBatch = schemeBatch;
	}

	public String getDealUnit() {
		return dealUnit;
	}

	public void setDealUnit(String dealUnit) {
		this.dealUnit = dealUnit;
	}

	public String getDeliveryStart() {
		return deliveryStart;
	}

	public void setDeliveryStart(String deliveryStart) {
		this.deliveryStart = deliveryStart;
	}

	public String getDeliveryEnd() {
		return deliveryEnd;
	}

	public void setDeliveryEnd(String deliveryEnd) {
		this.deliveryEnd = deliveryEnd;
	}

	public String getDealDate() {
		return dealDate;
	}

	public void setDealDate(String dealDate) {
		this.dealDate = dealDate;
	}

	public String getRotateType() {
		return rotateType;
	}

	public void setRotateType(String rotateType) {
		this.rotateType = rotateType;
	}
	
}
