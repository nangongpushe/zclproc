package com.dhc.fastersoft.entity;

import java.util.Date;
import java.util.List;

import org.omg.CosNaming.NamingContextExtPackage.StringNameHelper;
import org.springframework.format.annotation.DateTimeFormat;


public class RotatePayment {
	private String id;
	private String paySerial;
	private Date reportDate;
	private String clientName;
	private String depositBank;
	private String depositAccount;
	private String payType;
	private String proceedType;
	private String operator;
	private String status;
	private String groupId;
	private String reporterId;
	private List<RotatePaymentDetail> detailList;
	private String isAduit;
	private String clientId;

	public String getClientId() {
		return clientId;
	}

	public void setClientId(String clientId) {
		this.clientId = clientId;
	}

	public String getIsAduit() {
		return isAduit;
	}

	public void setIsAduit(String isAduit) {
		this.isAduit = isAduit;
	}

	public String getReporterId() {
		return reporterId;
	}
	public void setReporterId(String reporterId) {
		this.reporterId = reporterId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPaySerial() {
		return paySerial;
	}
	public void setPaySerial(String paySerial) {
		this.paySerial = paySerial;
	}
	public Date getReportDate() {
		return reportDate;
	}
	public void setReportDate(Date reportDate) {
		this.reportDate = reportDate;
	}
	public String getClientName() {
		return clientName;
	}
	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
	public String getDepositBank() {
		return depositBank;
	}
	public void setDepositBank(String depositBank) {
		this.depositBank = depositBank;
	}
	public String getDepositAccount() {
		return depositAccount;
	}
	public void setDepositAccount(String depositAccount) {
		this.depositAccount = depositAccount;
	}
	public String getPayType() {
		return payType;
	}
	public void setPayType(String payType) {
		this.payType = payType;
	}
	public String getProceedType() {
		return proceedType;
	}
	public void setProceedType(String proceedType) {
		this.proceedType = proceedType;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
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
	public List<RotatePaymentDetail> getDetailList() {
		return detailList;
	}
	public void setDetailList(List<RotatePaymentDetail> detailList) {
		this.detailList = detailList;
	}
	
}
