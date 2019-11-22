package com.dhc.fastersoft.entity;

import java.util.Date;
import java.util.List;

import com.dhc.fastersoft.entity.system.SysUser;
import org.springframework.format.annotation.DateTimeFormat;

public class RotateProcess {
	private String id;
	private String recordName;
	private String operator;
	private String operatorId;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date handleTime;
	private String dealSerial;
	private String buyer;
	private String seller;
	private String tagId;
	private String status;
	private String modifier;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date modifyTime;
	private String remark;


	private String sellerId;
	private String buyerId;

	public String getSellerId() {
		return sellerId;
	}

	public String getTagId() {
		return tagId;
	}

	public void setTagId(String tagId) {
		this.tagId = tagId;
	}

	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}

	public String getBuyerId() {
		return buyerId;
	}

	public void setBuyerId(String buyerId) {
		this.buyerId = buyerId;
	}

	private List<RotateProcessDetail> processDetail;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRecordName() {
		return recordName;
	}
	public void setRecordName(String recordName) {
		this.recordName = recordName;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public Date getHandleTime() {
		return handleTime;
	}
	public void setHandleTime(Date handleTime) {
		this.handleTime = handleTime;
	}
	public String getDealSerial() {
		return dealSerial;
	}
	public void setDealSerial(String dealSerial) {
		this.dealSerial = dealSerial;
	}
	public String getBuyer() {
		return buyer;
	}
	public void setBuyer(String buyer) {
		this.buyer = buyer;
	}
	public String getSeller() {
		return seller;
	}
	public void setSeller(String seller) {
		this.seller = seller;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getModifier() {
		return modifier;
	}
	public void setModifier(String modifier) {
		this.modifier = modifier;
	}
	public Date getModifyTime() {
		return modifyTime;
	}
	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public List<RotateProcessDetail> getProcessDetail() {
		return processDetail;
	}
	public void setProcessDetail(List<RotateProcessDetail> processDetail) {
		this.processDetail = processDetail;
	}

	public String getOperatorId() {
		return operatorId;
	}

	public void setOperatorId(String operatorId) {
		this.operatorId = operatorId;
	}

	public RotateProcess(Date handleTime) {
		this.handleTime = handleTime;
	}
	
	public RotateProcess() {
	}
}
