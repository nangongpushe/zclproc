package com.dhc.fastersoft.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;

import java.math.BigDecimal;
import java.util.List;

public class RotatePlanmainDetailForExcel {
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
	private String rotateNumber;
	@Excel(name="等级",isImportField="true")
	private String quality;

	public RotatePlanmainDetailForExcel() {}

	public RotatePlanmainDetailForExcel(RotatePlanmainDetail detail, List<QualityQuotaItem> quotaItems,String quality) {
		this.id=detail.getId();
		this.rotateType=detail.getRotateType();
		this.foodType=detail.getFoodType();
		this.yieldTime=detail.getYieldTime();
		this.orign=detail.getOrign();
		this.rotateNumber=detail.getRotateNumber().toString();
		this.quality=quality;
		
	}

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
	public String getRotateNumber() {
		return rotateNumber;
	}
	public void setRotateNumber(String rotateNumber) {
		this.rotateNumber = rotateNumber;
	}
	public String getQuality() {
		return quality;
	}
	public void setQuality(String quality) {
		this.quality = quality;
	}
}
