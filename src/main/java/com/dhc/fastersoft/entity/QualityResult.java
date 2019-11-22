package com.dhc.fastersoft.entity;

import java.util.List;


public class QualityResult {

    private String id;

    private String reportSerial;

    private String reportUnit;

    private String reportType;

    private  String sampleNoId;

	public String getSampleNoId() {
		return sampleNoId;
	}

	public void setSampleNoId(String sampleNoId) {
		this.sampleNoId = sampleNoId;
	}

	private String sampleNo;

    private String sampleName;

    private String variety;

    private String oilcanSerial;

    private String storeNature;

    private String storeDate;

    private String entrustedEnterprise;

    private String storeEncode;

    private String origin;

    private String storeType;

    private String vehicleNumber;

    private String harvestYear;

    private String quantity;

    private String testDate;

	private String testEndDate;

    private String templetNo;

    private String status;

    private String groupId;

    private String creator;

    private String createDate;

    private String remark;  //结论（质量指标判定）

    private String company;
    
    private String varietyType;
    
    private String fileName;
    
    private String validType;
	private String warehouseId;//库点id(受检单位ID)

	private String acceptedUnit;
	private String acceptedUnitId;	//检验单位ID

	private String ProGrade;
	private String checkType;
	private String storeJudge;//储存指标判定
	private String hygieneJudge;	// 卫生指标判定

	public String getAcceptedUnit() {
		return acceptedUnit;
	}

	public void setAcceptedUnit(String acceptedUnit) {
		this.acceptedUnit = acceptedUnit;
	}

	public String getProGrade() {
		return ProGrade;
	}

	public void setProGrade(String proGrade) {
		ProGrade = proGrade;
	}

	public String getCheckType() {
		return checkType;
	}

	public void setCheckType(String checkType) {
		this.checkType = checkType;
	}

	public String getWarehouseId() {
		return warehouseId;
	}

	public void setWarehouseId(String warehouseId) {
		this.warehouseId = warehouseId;
	}
    
    private List<QualityResultItem> qualityResultItems;

	private String dealserial;

	private String mainTester;

	public String getValidType() {
		return validType;
	}

	public void setValidType(String validType) {
		this.validType = validType;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getVarietyType() {
		return varietyType;
	}

	public void setVarietyType(String varietyType) {
		this.varietyType = varietyType;
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

	public String getReportSerial() {
		return reportSerial;
	}

	public void setReportSerial(String reportSerial) {
		this.reportSerial = reportSerial;
	}

	public String getReportUnit() {
		return reportUnit;
	}

	public void setReportUnit(String reportUnit) {
		this.reportUnit = reportUnit;
	}

	public String getReportType() {
		return reportType;
	}

	public void setReportType(String reportType) {
		this.reportType = reportType;
	}

	public String getSampleNo() {
		return sampleNo;
	}

	public void setSampleNo(String sampleNo) {
		this.sampleNo = sampleNo;
	}

	public String getSampleName() {
		return sampleName;
	}

	public void setSampleName(String sampleName) {
		this.sampleName = sampleName;
	}

	public String getVariety() {
		return variety;
	}

	public void setVariety(String variety) {
		this.variety = variety;
	}

	public String getOilcanSerial() {
		return oilcanSerial;
	}

	public void setOilcanSerial(String oilcanSerial) {
		this.oilcanSerial = oilcanSerial;
	}

	public String getStoreNature() {
		return storeNature;
	}

	public void setStoreNature(String storeNature) {
		this.storeNature = storeNature;
	}

	public String getStoreDate() {
		return storeDate;
	}

	public void setStoreDate(String storeDate) {
		this.storeDate = storeDate;
	}

	public String getEntrustedEnterprise() {
		return entrustedEnterprise;
	}

	public void setEntrustedEnterprise(String entrustedEnterprise) {
		this.entrustedEnterprise = entrustedEnterprise;
	}

	public String getStoreEncode() {
		return storeEncode;
	}

	public void setStoreEncode(String storeEncode) {
		this.storeEncode = storeEncode;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public String getStoreType() {
		return storeType;
	}

	public void setStoreType(String storeType) {
		this.storeType = storeType;
	}

	public String getVehicleNumber() {
		return vehicleNumber;
	}

	public void setVehicleNumber(String vehicleNumber) {
		this.vehicleNumber = vehicleNumber;
	}

	public String getHarvestYear() {
		return harvestYear;
	}

	public void setHarvestYear(String harvestYear) {
		this.harvestYear = harvestYear;
	}

	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	public String getTestDate() {
		return testDate;
	}

	public void setTestDate(String testDate) {
		this.testDate = testDate;
	}

	public String getTempletNo() {
		return templetNo;
	}

	public void setTempletNo(String templetNo) {
		this.templetNo = templetNo;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

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

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public List<QualityResultItem> getQualityResultItems() {
		return qualityResultItems;
	}

	public void setQualityResultItems(List<QualityResultItem> qualityResultItems) {
		this.qualityResultItems = qualityResultItems;
	}

	public String getDealserial() {
		return dealserial;
	}

	public void setDealserial(String dealserial) {
		this.dealserial = dealserial;
	}

	public String getMainTester() {
		return mainTester;
	}

	public void setMainTester(String mainTester) {
		this.mainTester = mainTester;
	}
    public String getTestEndDate() {
        return testEndDate;
    }

    public void setTestEndDate(String testEndDate) {
        this.testEndDate = testEndDate;
    }

	public String getStoreJudge() {
		return storeJudge;
	}

	public void setStoreJudge(String storeJudge) {
		this.storeJudge = storeJudge;
	}

	public String getAcceptedUnitId() {
		return acceptedUnitId;
	}

	public void setAcceptedUnitId(String acceptedUnitId) {
		this.acceptedUnitId = acceptedUnitId;
	}

	public String getHygieneJudge() {
		return hygieneJudge;
	}

	public void setHygieneJudge(String hygieneJudge) {
		this.hygieneJudge = hygieneJudge;
	}
}