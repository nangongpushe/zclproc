package com.dhc.fastersoft.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;


public class RotateBID {
	private String id;
	private String bidName;
	private String bidType;
	private String tenderee;
	private String saler;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date saleDate;
	private String groupID;
	private BigDecimal total;
	private String creator;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date createDate;
	private String modifier;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date modifyDate;
	private String remark;
	private String foodType;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date dealDate;
	private List<RotateBIDPurchase> purchaseList;
	private List<RotateBIDSale> saleList;
	

	
	public RotateBID() {}

	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getBidName() {
		return bidName;
	}
	public void setBidName(String bidName) {
		this.bidName = bidName;
	}
	public String getBidType() {
		return bidType;
	}
	public void setBidType(String bidType) {
		this.bidType = bidType;
	}
	public String getTenderee() {
		return tenderee;
	}
	public void setTenderee(String tenderee) {
		this.tenderee = tenderee;
	}
	public String getSaler() {
		return saler;
	}
	public void setSaler(String saler) {
		this.saler = saler;
	}
	public Date getSaleDate() {
		return saleDate;
	}
	public void setSaleDate(Date saleDate) {
		this.saleDate = saleDate;
	}
	public String getGroupID() {
		return groupID;
	}
	public void setGroupID(String groupID) {
		this.groupID = groupID;
	}

	public BigDecimal getTotal() {
		return total;
	}

	public void setTotal(BigDecimal total) {
		this.total = total;
	}

	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getModifier() {
		return modifier;
	}
	public void setModifier(String modifier) {
		this.modifier = modifier;
	}
	public Date getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public String getFoodType() {
		return foodType;
	}
	public void setFoodType(String foodType) {
		this.foodType = foodType;
	}
	public List<RotateBIDPurchase> getPurchaseList() {
		return purchaseList;
	}
	public void setPurchaseList(List<RotateBIDPurchase> purchaseList) {
		this.purchaseList = purchaseList;
	}

	public List<RotateBIDSale> getSaleList() {
		return saleList;
	}

	public void setSaleList(List<RotateBIDSale> saleList) {
		this.saleList = saleList;
	}


	public Date getDealDate() {
		return dealDate;
	}


	public void setDealDate(Date dealDate) {
		this.dealDate = dealDate;
	}

	
}
