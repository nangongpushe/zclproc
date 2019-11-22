package com.dhc.fastersoft.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;
import com.dhc.fastersoft.entity.report.ReportSwtz;

import java.math.BigDecimal;
import java.util.HashMap;

public class RotatePlanDetail {
	private String id;
	@Excel(name="轮换类型",isImportField="true")
	private String rotateType;
	@Excel(name="库点名称",isImportField="true")
	private String libraryName;
	@Excel(name="仓房编号",isImportField="true")
	private String barnNumber;
	@Excel(name="粮食品种",isImportField="true")
	private String foodType;
	@Excel(name="生产年份",isImportField="true")
	private String yieldTime;
	@Excel(name="产地",isImportField="true")
	private String orign;
	@Excel(name="核定仓容(吨)",isImportField="true")
	private String approvalCapacity;
	@Excel(name="实际库存(吨)",isImportField="true")
	private String realCapacity;
	@Excel(name="轮换数量(吨)",isImportField="true")
	//private String rotateNumber;
	private BigDecimal rotateNumber;
	@Excel(name="已成交数量(吨)",isImportField="true")
	private BigDecimal dealDetailNumber;
	@Excel(name="未成交数量(吨)",isImportField="true")
	private BigDecimal unDealDetailNumber;
	@Excel(name="等级",isImportField="true")
	private String quality;
	private String planId;
	private String qualityId;
	private String swtzId;
	private String dealSerial;
	private String planmaindetailId;
	private HashMap<String, String> quotaItemMap;
	private ReportSwtz swtz;
	private String qualityDetail;
	private String warehouseid;	//
	private Integer isInput;

	private String enterpriseId;
	private String enterpriseName;
	private String storeType;
	private BigDecimal restNumber;
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
	public String getLibraryName() {
		return libraryName;
	}
	public void setLibraryName(String libraryName) {
		this.libraryName = libraryName;
	}
	public String getBarnNumber() {
		return barnNumber;
	}
	public void setBarnNumber(String barnNumber) {
		this.barnNumber = barnNumber;
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
	public String getApprovalCapacity() {
		return approvalCapacity;
	}
	public void setApprovalCapacity(String approvalCapacity) {
		this.approvalCapacity = approvalCapacity;
	}
	public String getRealCapacity() {
		return realCapacity;
	}
	public void setRealCapacity(String realCapacity) {
		this.realCapacity = realCapacity;
	}

	public String getQuality() {
		return quality;
	}
	public void setQuality(String quality) {
		this.quality = quality;
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
	public String getSwtzId() {
		return swtzId;
	}
	public void setSwtzId(String swtzId) {
		this.swtzId = swtzId;
	}

	public HashMap<String, String> getQuotaItemMap() {
		return quotaItemMap;
	}
	public void setQuotaItemMap(HashMap<String, String> quotaItemMap) {
		this.quotaItemMap = quotaItemMap;
	}
	public ReportSwtz getSwtz() {
		return swtz;
	}
	public void setSwtz(ReportSwtz swtz) {
		this.swtz = swtz;
	}
	public String getDealSerial() {
		return dealSerial;
	}
	public void setDealSerial(String dealSerial) {
		this.dealSerial = dealSerial;
	}
	public String getPlanmaindetailId() {
		return planmaindetailId;
	}
	public void setPlanmaindetailId(String planmaindetailId) {
		this.planmaindetailId = planmaindetailId;
	}

	public String getQualityDetail() {
		return qualityDetail;
	}

	public void setQualityDetail(String qualityDetail) {
		this.qualityDetail = qualityDetail;
	}

	public String getWarehouseid() {
		return warehouseid;
	}

	public void setWarehouseid(String warehouseid) {
		this.warehouseid = warehouseid;
	}

	public BigDecimal getRotateNumber() {
		return rotateNumber;
	}

	public void setRotateNumber(BigDecimal rotateNumber) {
		this.rotateNumber = rotateNumber;
	}

	public Integer getIsInput() {
		return isInput;
	}

	public void setIsInput(Integer isInput) {
		this.isInput = isInput;
	}

	public String getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(String enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	public String getEnterpriseName() {
		return enterpriseName;
	}

	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}

	public String getStoreType() {
		return storeType;
	}

	public void setStoreType(String storeType) {
		this.storeType = storeType;
	}

	public BigDecimal getDealDetailNumber() {
		return dealDetailNumber;
	}

	public void setDealDetailNumber(BigDecimal dealDetailNumber) {
		this.dealDetailNumber = dealDetailNumber;
	}

	public BigDecimal getUnDealDetailNumber() {
		return unDealDetailNumber;
	}

	public void setUnDealDetailNumber(BigDecimal unDealDetailNumber) {
		this.unDealDetailNumber = unDealDetailNumber;
	}

	public BigDecimal getRestNumber() {
		return restNumber;
	}

	public void setRestNumber(BigDecimal restNumber) {
		this.restNumber = restNumber;
	}

	@Override
	public String toString() {
		return "RotatePlanDetail{" +
				"id='" + id + '\'' +
				", rotateType='" + rotateType + '\'' +
				", libraryName='" + libraryName + '\'' +
				", barnNumber='" + barnNumber + '\'' +
				", foodType='" + foodType + '\'' +
				", yieldTime='" + yieldTime + '\'' +
				", orign='" + orign + '\'' +
				", approvalCapacity='" + approvalCapacity + '\'' +
				", realCapacity='" + realCapacity + '\'' +
				", rotateNumber=" + rotateNumber +
				", quality='" + quality + '\'' +
				", planId='" + planId + '\'' +
				", qualityId='" + qualityId + '\'' +
				", swtzId='" + swtzId + '\'' +
				", dealSerial='" + dealSerial + '\'' +
				", planmaindetailId='" + planmaindetailId + '\'' +
				", quotaItemMap=" + quotaItemMap +
				", swtz=" + swtz +
				", qualityDetail='" + qualityDetail + '\'' +
				", warehouseid='" + warehouseid + '\'' +
				'}';
	}
}
