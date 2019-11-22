package com.dhc.fastersoft.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;

import java.math.BigDecimal;
import java.util.HashMap;

public class RotatePlanmainDetail {
	private String id;
	@Excel(name="轮换类型",isImportField="true")
	private String rotateType;
	@Excel(name="粮食品种",isImportField="true")
	private String foodType;
	@Excel(name="生产年份",isImportField="true")
	private String yieldTime;
	@Excel(name="产地",isImportField="true")
	private String orign;
	@Excel(name="轮换数量(吨)",isImportField="true")
	//private String rotateNumber;
	private BigDecimal rotateNumber;
	private String planId;
	private String qualityId;
	@Excel(name="已经轮换数量(吨)",isImportField="true")
	private String detailNumber;
	private HashMap<String, String> quotaItemMap;
	/*粮食等级*/
	private QualityQuota qualityQuota;
	private String grade;
	private BigDecimal dealDetailNumber;


	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRotateType() {
		return rotateType;
	}
	public void setRotateType(String rotateType) {
		this.rotateType = rotateType;
	}
	public String getFoodType() {
		return foodType;
	}
	public void setFoodType(String foodType) {
		this.foodType = foodType;
	}
	public String getYieldTime() {
		return yieldTime;
	}
	public void setYieldTime(String yieldTime) {
		this.yieldTime = yieldTime;
	}
	public String getOrign() {
		return orign;
	}
	public void setOrign(String orign) {
		this.orign = orign;
	}

	public BigDecimal getRotateNumber() {
		return rotateNumber;
	}

	public void setRotateNumber(BigDecimal rotateNumber) {
		this.rotateNumber = rotateNumber;
	}

	public String getPlanId() {
		return planId;
	}
	public void setPlanId(String planId) {
		this.planId = planId;
	}
	public String getQualityId() {
		return qualityId;
	}
	public void setQualityId(String qualityId) {
		this.qualityId = qualityId;
	}

	public HashMap<String, String> getQuotaItemMap() {
		return quotaItemMap;
	}
	public void setQuotaItemMap(HashMap<String, String> quotaItemMap) {
		this.quotaItemMap = quotaItemMap;
	}
	public String getDetailNumber() {
		return detailNumber;
	}
	public void setDetailNumber(String detailNumber) {
		this.detailNumber = detailNumber;
	}

	public QualityQuota getQualityQuota() {
		return qualityQuota;
	}
	public void setQualityQuota(QualityQuota qualityQuota) {
		this.qualityQuota = qualityQuota;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public BigDecimal getDealDetailNumber() {
		return dealDetailNumber;
	}

	public void setDealDetailNumber(BigDecimal dealDetailNumber) {
		this.dealDetailNumber = dealDetailNumber;
	}
}
