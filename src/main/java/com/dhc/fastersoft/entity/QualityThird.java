package com.dhc.fastersoft.entity;

import java.math.BigDecimal;
import java.util.List;

public class QualityThird {
    private String id;

    private String acceptedUnit;

    private String sampleNo;

    private String sampleName;

    private String inspectedUnit;

    private String testDate;

    private String validity;

    private BigDecimal basicNumber;

    private String grade;

    private String storeType;

    private String genYear;

	private String samplePlace;

    private String origin;

    private String storeDate;

    private String templetNo;

    private String qualityDetermin;

    private String creator;

    private String createDate;
    
    private List<QualityThirdItem> qualityThirdItems;

    public String getGenYear() {
        return genYear;
    }

    public void setGenYear(String genYear) {
        this.genYear = genYear;
    }

    public String getCreateDate() {
    	return createDate;
    }
    public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	private String company;

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
        this.id = id == null ? null : id.trim();
    }

    public String getAcceptedUnit() {
        return acceptedUnit;
    }

    public void setAcceptedUnit(String acceptedUnit) {
        this.acceptedUnit = acceptedUnit == null ? null : acceptedUnit.trim();
    }

    public String getSampleNo() {
        return sampleNo;
    }

    public void setSampleNo(String sampleNo) {
        this.sampleNo = sampleNo == null ? null : sampleNo.trim();
    }

    public String getSampleName() {
        return sampleName;
    }

    public void setSampleName(String sampleName) {
        this.sampleName = sampleName == null ? null : sampleName.trim();
    }

    public String getInspectedUnit() {
        return inspectedUnit;
    }

    public void setInspectedUnit(String inspectedUnit) {
        this.inspectedUnit = inspectedUnit == null ? null : inspectedUnit.trim();
    }

    public String getTestDate() {
        return testDate;
    }

    public void setTestDate(String testDate) {
        this.testDate = testDate == null ? null : testDate.trim();
    }

    public String getValidity() {
        return validity;
    }

    public void setValidity(String validity) {
        this.validity = validity == null ? null : validity.trim();
    }

    public BigDecimal getBasicNumber() {
        return basicNumber;
    }

    public void setBasicNumber(BigDecimal basicNumber) {
        this.basicNumber = basicNumber;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade == null ? null : grade.trim();
    }

    public String getStoreType() {
        return storeType;
    }

    public void setStoreType(String storeType) {
        this.storeType = storeType == null ? null : storeType.trim();
    }

    public String getSamplePlace() {
        return samplePlace;
    }

    public void setSamplePlace(String samplePlace) {
        this.samplePlace = samplePlace == null ? null : samplePlace.trim();
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin == null ? null : origin.trim();
    }

    public String getStoreDate() {
        return storeDate;
    }

    public void setStoreDate(String storeDate) {
        this.storeDate = storeDate == null ? null : storeDate.trim();
    }

    public String getTempletNo() {
        return templetNo;
    }

    public void setTempletNo(String templetNo) {
        this.templetNo = templetNo == null ? null : templetNo.trim();
    }

    public String getQualityDetermin() {
        return qualityDetermin;
    }

    public void setQualityDetermin(String qualityDetermin) {
        this.qualityDetermin = qualityDetermin == null ? null : qualityDetermin.trim();
    }
	public List<QualityThirdItem> getQualityThirdItems() {
		return qualityThirdItems;
	}
	public void setQualityThirdItems(List<QualityThirdItem> qualityThirdItems) {
		this.qualityThirdItems = qualityThirdItems;
	}
}