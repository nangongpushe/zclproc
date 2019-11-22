package com.dhc.fastersoft.entity;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;


public class RotateArrive {
	private String id;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date reportDate;
	private String reportDept;
	private String reporter;
	private String payer;
	private String payUnit;
	private String payUnitId;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date arriveDate;
	private double arriveAmount;
	private double balance;
	private String status;
	private String groupId;
	private String modifier;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date modifyDate;
	private String claimStatus;
	private String remark;
	private String reporterId;
//	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	/**
	 * 审批通过时间
	 */
	private Date approvalDate;

	/**
	 * 认领时间
	 */
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date claimDate;

	private Date returnDate;

	/**
	 * 认领详情条数
	 */
	private Integer dealCount;

	public Date getReturnDate() {
		return returnDate;
	}

	public void setReturnDate(Date returnDate) {
		this.returnDate = returnDate;
	}

	public Date getClaimDate() {
		return claimDate;
	}

	public void setClaimDate(Date claimDate) {
		this.claimDate = claimDate;
	}

	public Date getApprovalDate() {
		return approvalDate;
	}

	public void setApprovalDate(Date approvalDate) {
		this.approvalDate = approvalDate;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Date getReportDate() {
		return reportDate;
	}
	public void setReportDate(Date reportDate) {
		this.reportDate = reportDate;
	}
	public String getReportDept() {
		return reportDept;
	}
	public void setReportDept(String reportDept) {
		this.reportDept = reportDept;
	}
	public String getReporter() {
		return reporter;
	}
	public void setReporter(String reporter) {
		this.reporter = reporter;
	}
	public String getPayer() {
		return payer;
	}
	public void setPayer(String payer) {
		this.payer = payer;
	}
	public String getPayUnit() {
		return payUnit;
	}
	public void setPayUnit(String payUnit) {
		this.payUnit = payUnit;
	}
	public Date getArriveDate() {
		return arriveDate;
	}


	public double getArriveAmount() {
		return arriveAmount;
	}
	public void setArriveAmount(double arriveAmount) {
		this.arriveAmount = arriveAmount;
	}
	public double getBalance() {
		return balance;
	}
	public void setBalance(double balance) {
		this.balance = balance;
	}
	public void setArriveDate(Date arriveDate) {
		this.arriveDate = arriveDate;
	}
	public void setBalance(int balance) {
		this.balance = balance;
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
	
	public String getClaimStatus() {
		return claimStatus;
	}
	public void setClaimStatus(String claimStatus) {
		this.claimStatus = claimStatus;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getReporterId() {
		return reporterId;
	}
	public void setReporterId(String reporterId) {
		this.reporterId = reporterId;
	}

	public String getPayUnitId() {
		return payUnitId;
	}

	public void setPayUnitId(String payUnitId) {
		this.payUnitId = payUnitId;
	}

	public Integer getDealCount() {
		return dealCount;
	}

	public void setDealCount(Integer dealCount) {
		this.dealCount = dealCount;
	}

	@Override
	public String toString() {
		return "RotateArrive{" +
				"id='" + id + '\'' +
				", reportDate=" + reportDate +
				", reportDept='" + reportDept + '\'' +
				", reporter='" + reporter + '\'' +
				", payer='" + payer + '\'' +
				", payUnit='" + payUnit + '\'' +
				", payUnitId='" + payUnitId + '\'' +
				", arriveDate=" + arriveDate +
				", arriveAmount=" + arriveAmount +
				", balance=" + balance +
				", status='" + status + '\'' +
				", groupId='" + groupId + '\'' +
				", modifier='" + modifier + '\'' +
				", modifyDate=" + modifyDate +
				", claimStatus='" + claimStatus + '\'' +
				", remark='" + remark + '\'' +
				", reporterId='" + reporterId + '\'' +
				'}';
	}
}
