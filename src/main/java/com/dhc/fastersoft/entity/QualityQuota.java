package com.dhc.fastersoft.entity;

import java.util.List;

public class QualityQuota {
    private String id;

    private String quotaNo;

    private String quotaName;

    private String type;

    private String grade;

    private String creator;

    private String createDate;

    private String remark;
    
    private String company;
    public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	private List<QualityQuotaItem> quotaItems;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getQuotaNo() {
        return quotaNo;
    }

    public void setQuotaNo(String quotaNo) {
        this.quotaNo = quotaNo == null ? null : quotaNo.trim();
    }

    public String getQuotaName() {
        return quotaName;
    }

    public void setQuotaName(String quotaName) {
        this.quotaName = quotaName == null ? null : quotaName.trim();
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade == null ? null : grade.trim();
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator == null ? null : creator.trim();
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
        this.remark = remark == null ? null : remark.trim();
    }

	public List<QualityQuotaItem> getQuotaItems() {
		return quotaItems;
	}

	public void setQuotaItems(List<QualityQuotaItem> quotaItems) {
		this.quotaItems = quotaItems;
	}


    
}