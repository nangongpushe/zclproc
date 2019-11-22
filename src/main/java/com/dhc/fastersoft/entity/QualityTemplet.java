package com.dhc.fastersoft.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class QualityTemplet {
    private String id;

    private String templetNo;

    private String templetName;

    private String type;

    private String checkType;

    private String creator;

    private String createDate;

    public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}



	private String remark;
    
    private String company;
    
    public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getCheckType() {
		return checkType;
	}

	public void setCheckType(String checkType) {
		this.checkType = checkType;
	}

	private String templetId;

    private String itemName;

    private String grade;

    private String standard;
    
    private String itemId;

    private String orderNo;
	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
    
    public String getTempletId() {
		return templetId;
	}

	public void setTempletId(String templetId) {
		this.templetId = templetId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getStandard() {
		return standard;
	}

	public void setStandard(String standard) {
		this.standard = standard;
	}

	
    
    private List<QualityTempletItem> qtItems;
    
    private String colletorDateStr;

    public String getColletorDateStr() {
		return colletorDateStr;
	}

	public void setColletorDateStr(String colletorDateStr) {
		this.colletorDateStr = colletorDateStr;
	}

	public List<QualityTempletItem> getQtItems() {
		return qtItems;
	}

	public void setQtItems(List<QualityTempletItem> qtItems) {
		this.qtItems = qtItems;
	}

	public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getTempletNo() {
        return templetNo;
    }

    public void setTempletNo(String templetNo) {
        this.templetNo = templetNo == null ? null : templetNo.trim();
    }

    public String getTempletName() {
        return templetName;
    }

    public void setTempletName(String templetName) {
        this.templetName = templetName == null ? null : templetName.trim();
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator == null ? null : creator.trim();
    }


    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

	
}