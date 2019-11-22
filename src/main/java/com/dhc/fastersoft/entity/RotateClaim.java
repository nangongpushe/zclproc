package com.dhc.fastersoft.entity;

import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;


public class RotateClaim {
	private String id;
	private String arriveId;
	private String claimMan;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date claimDate;
	private String dealSerial;
	private String claimType;
	private String claimAmount;
	private String userId;
	private String claimBound;
	private BigDecimal claimWeight;
	private String warehouseShort;
	private String encode;
	private String warehouseAndEncode;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getArriveId() {
		return arriveId;
	}
	public void setArriveId(String arriveId) {
		this.arriveId = arriveId;
	}
	public String getClaimMan() {
		return claimMan;
	}
	public void setClaimMan(String claimMan) {
		this.claimMan = claimMan;
	}
	public Date getClaimDate() {
		return claimDate;
	}
	public void setClaimDate(Date claimDate) {
		this.claimDate = claimDate;
	}

	public String getDealSerial() {
		return dealSerial;
	}
	public void setDealSerial(String dealSerial) {
		this.dealSerial = dealSerial;
	}
	public String getClaimType() {
		return claimType;
	}
	public void setClaimType(String claimType) {
		this.claimType = claimType;
	}
	public String getClaimAmount() {
		return claimAmount;
	}
	public void setClaimAmount(String claimAmount) {
		this.claimAmount = claimAmount;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getClaimBound() {
		return claimBound;
	}
	public void setClaimBound(String claimBound) {
		this.claimBound = claimBound;
	}

	public BigDecimal getClaimWeight() {
		return claimWeight;
	}

	public void setClaimWeight(BigDecimal claimWeight) {
		this.claimWeight = claimWeight;
	}

	public String getWarehouseShort() {
		return warehouseShort;
	}

	public void setWarehouseShort(String warehouseShort) {
		this.warehouseShort = warehouseShort;
	}

	public String getEncode() {
		return encode;
	}

	public void setEncode(String encode) {
		this.encode = encode;
	}

	public String getWarehouseAndEncode() {
		String a = warehouseShort !=null?warehouseShort:"";
		String b =encode != null?encode:"";
		return a+b;
	}

	public void setWarehouseAndEncode(String warehouseAndEncode) {
		this.warehouseAndEncode = warehouseShort !=null?warehouseShort:""+encode != null?encode:"";
	}
}
