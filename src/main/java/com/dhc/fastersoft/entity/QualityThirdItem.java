package com.dhc.fastersoft.entity;

import java.math.BigDecimal;

public class QualityThirdItem {
    private String id;

    private String thirdId;

    private String itemName;

    private String grade;

    private String standard;

    private String result;
    
    private String remark;

    private BigDecimal orderNo;

    public BigDecimal getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(BigDecimal orderNo) {
        this.orderNo = orderNo;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getThirdId() {
        return thirdId;
    }

    public void setThirdId(String thirdId) {
        this.thirdId = thirdId == null ? null : thirdId.trim();
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName == null ? null : itemName.trim();
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade == null ? null : grade.trim();
    }

    public String getStandard() {
        return standard;
    }

    public void setStandard(String standard) {
        this.standard = standard == null ? null : standard.trim();
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result == null ? null : result.trim();
    }

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public QualityThirdItem(String itemName) {
		this.itemName = itemName;
	}

	public QualityThirdItem() {
	}

	@Override
	public boolean equals(Object obj) {
		QualityThirdItem target = (QualityThirdItem)obj;
		return this.itemName.equals(target.getItemName());
	}
}