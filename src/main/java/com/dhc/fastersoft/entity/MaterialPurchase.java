package com.dhc.fastersoft.entity;



public class MaterialPurchase {
    private String id;  //'主键ID

    private String purchaseSerial;//申购编号

    private String purchaseDept;//申购部门

    private String purchaseMan;//申购人

    private String purchaseDate;//申购日期

    private double totalAmount;//预计总金额

	private String totalAmount2;  //预计总金额列表显示用

	private String purchaseReason;//采购原因

    private String groupId;//附件

    private String status;//状态(备用字段)

	private String originCode;	//库点编码

	public String getTotalAmount2() {
		return totalAmount2;
	}

	public void setTotalAmount2(String totalAmount2) {
		this.totalAmount2 = totalAmount2;
	}

	public String getOriginCode() {
		return originCode;
	}

	public void setOriginCode(String originCode) {
		this.originCode = originCode;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPurchaseSerial() {
		return purchaseSerial;
	}

	public void setPurchaseSerial(String purchaseSerial) {
		this.purchaseSerial = purchaseSerial;
	}

	public String getPurchaseDept() {
		return purchaseDept;
	}

	public void setPurchaseDept(String purchaseDept) {
		this.purchaseDept = purchaseDept;
	}

	public String getPurchaseMan() {
		return purchaseMan;
	}

	public void setPurchaseMan(String purchaseMan) {
		this.purchaseMan = purchaseMan;
	}

	public String getPurchaseDate() {
		return purchaseDate;
	}

	public void setPurchaseDate(String purchaseDate) {
		this.purchaseDate = purchaseDate;
	}

	public double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getPurchaseReason() {
		return purchaseReason;
	}

	public void setPurchaseReason(String purchaseReason) {
		this.purchaseReason = purchaseReason;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
    
   
}