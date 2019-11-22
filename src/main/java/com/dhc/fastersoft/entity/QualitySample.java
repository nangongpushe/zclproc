package com.dhc.fastersoft.entity;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;


public class QualitySample {
    private String id;

    private String sampleNo;

    private String quantity;

    private String sampleSouce;

    private String executor;

    private String storageWay;

    private String storehouse;

    private String variety;

    private String harvestYear;

    private String origin;

    private String samplingDate;

    private String samplingPeople;

    private String testPeople;

    private String testDate;//检验开始时间

    private String testEndDate; //检验结束时间

    private String testStatus;

    private String remark;

    private String creator;

    private String createDate;
    
    private String company;
    
    private String varietyType;
    
    private String validType;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date storeTime;
    
    private String dealSerial;
    
    private String taskPriority;

    private String storeNature;
    
    private String storeType;
    
    private String inStoreYear;
	private String warehouseId;//库点id

	private Integer checkType;	// 1---内部质检、2---第三方质检

	private boolean foreign;//是否进口粮（true:是进口粮，false:不是进口粮）

	public String getWarehouseId() {
		return warehouseId;
	}

	public void setWarehouseId(String warehouseId) {
		this.warehouseId = warehouseId;
	}

	private QualityResult qualityResult;
    
    private QualityResult qualityThird;
	public String getTestEndDate() {
		return testEndDate;
	}

	public void setTestEndDate(String testEndDate) {
		this.testEndDate = testEndDate;
	}
    
    public String getDealSerial() {
		return dealSerial;
	}

	public void setDealSerial(String dealSerial) {
		this.dealSerial = dealSerial;
	}

	public String getValidType() {
		return validType;
	}

	public void setValidType(String validType) {
		this.validType = validType;
	}

	public Date getStoreTime() {
		return storeTime;
	}

	public void setStoreTime(Date storeTime) {
		this.storeTime = storeTime;
	}

	public String getVarietyType() {
		return varietyType;
	}

	public void setVarietyType(String varietyType) {
		this.varietyType = varietyType;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}


	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}



	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSampleNo() {
		return sampleNo;
	}

	public void setSampleNo(String sampleNo) {
		this.sampleNo = sampleNo;
	}

	public String getSampleSouce() {
		return sampleSouce;
	}

	public void setSampleSouce(String sampleSouce) {
		this.sampleSouce = sampleSouce;
	}

	public String getStorehouse() {
		return storehouse;
	}

	public void setStorehouse(String storehouse) {
		this.storehouse = storehouse;
	}

	public String getVariety() {
		return variety;
	}

	public void setVariety(String variety) {
		this.variety = variety;
	}

	public String getHarvestYear() {
		return harvestYear;
	}

	public void setHarvestYear(String harvestYear) {
		this.harvestYear = harvestYear;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public String getSamplingDate() {
		return samplingDate;
	}

	public void setSamplingDate(String samplingDate) {
		this.samplingDate = samplingDate;
	}

	public String getSamplingPeople() {
		return samplingPeople;
	}

	public void setSamplingPeople(String samplingPeople) {
		this.samplingPeople = samplingPeople;
	}

	public String getTestPeople() {
		return testPeople;
	}

	public void setTestPeople(String testPeople) {
		this.testPeople = testPeople;
	}

	public String getTestDate() {
		return testDate;
	}

	public void setTestDate(String testDate) {
		this.testDate = testDate;
	}

	public String getTestStatus() {
		return testStatus;
	}

	public void setTestStatus(String testStatus) {
		this.testStatus = testStatus;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	public String getExecutor() {
		return executor;
	}

	public void setExecutor(String executor) {
		this.executor = executor;
	}

	public String getStorageWay() {
		return storageWay;
	}

	public void setStorageWay(String storageWay) {
		this.storageWay = storageWay;
	}

	public String getTaskPriority() {
		return taskPriority;
	}

	public void setTaskPriority(String taskPriority) {
		this.taskPriority = taskPriority;
	}

	public QualityResult getQualityResult() {
		return qualityResult;
	}

	public void setQualityResult(QualityResult qualityResult) {
		this.qualityResult = qualityResult;
	}

	public QualityResult getQualityThird() {
		return qualityThird;
	}

	public void setQualityThird(QualityResult qualityThird) {
		this.qualityThird = qualityThird;
	}

	public String getStoreNature() {
		return storeNature;
	}

	public void setStoreNature(String storeNature) {
		this.storeNature = storeNature;
	}

	public String getStoreType() {
		return storeType;
	}

	public void setStoreType(String storeType) {
		this.storeType = storeType;
	}

	public String getInStoreYear() {
		return inStoreYear;
	}

	public void setInStoreYear(String inStoreYear) {
		this.inStoreYear = inStoreYear;
	}

	public Integer getCheckType() {
		return checkType;
	}

	public void setCheckType(Integer checkType) {
		this.checkType = checkType;
	}

	public boolean isForeign() {
		return foreign;
	}

	public void setForeign(boolean foreign) {
		this.foreign = foreign;
	}
}