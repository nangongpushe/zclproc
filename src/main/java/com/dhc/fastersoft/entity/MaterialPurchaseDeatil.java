package com.dhc.fastersoft.entity;

public class MaterialPurchaseDeatil {
    private String id;  //主键ID

    private String purchaseId;  //采购ID

    private String materialName;  //物资名称';

    private String model;  //规格型号

    private String quantity; //采购数量

    private String unitPrice;//单价

    private String estimatedUnitPrice;  //预计单价

    private String remark;  //备注

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPurchaseId() {
		return purchaseId;
	}

	public void setPurchaseId(String purchaseId) {
		this.purchaseId = purchaseId;
	}

	public String getMaterialName() {
		return materialName;
	}

	public void setMaterialName(String materialName) {
		this.materialName = materialName;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	public String getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(String unitPrice) {
		this.unitPrice = unitPrice;
	}

	public String getEstimatedUnitPrice() {
		return estimatedUnitPrice;
	}

	public void setEstimatedUnitPrice(String estimatedUnitPrice) {
		this.estimatedUnitPrice = estimatedUnitPrice;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
    
    
}