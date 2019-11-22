package com.dhc.fastersoft.entity;

import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;


public class RotateRefund {
	private String id;
	private String operator;
	private String department;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date handleTime;
	private String bidSerial;
	private String company;
	private String companyId;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date dealDate;
	private String dealDates; //拼接的成交时间
	private String dealType;
	private String type;
	private String dealNumber;
	private String dealAmount;
	private String refundAmount;
	private String remark;
	private String modifier;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date modifyTime;
	private String concluteDetailId;
	private BigDecimal surplusBail;
    private String mainId;
	private String groupId;
    private String serial;
    private String inviteName;
    private String maxGroupId;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getMaxGroupId() {
		return maxGroupId;
	}

	public void setMaxGroupId(String maxGroupId) {
		this.maxGroupId = maxGroupId;
	}

	public String getInviteName() {
		return inviteName;
	}

	public void setInviteName(String inviteName) {
		this.inviteName = inviteName;
	}

	public String getDealDates() {
		return dealDates;
	}

	public void setDealDates(String dealDates) {
		this.dealDates = dealDates;
	}

	public String getSerial() {
		return serial;
	}

	public void setSerial(String serial) {
		this.serial = serial;
	}

	public String getMainId() {
		return mainId;
	}

	public void setMainId(String mainId) {
		this.mainId = mainId;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String group) {
		this.groupId = group;
	}

	public String getConcluteDetailId() {
		return concluteDetailId;
	}

	public void setConcluteDetailId(String concluteDetailId) {
		this.concluteDetailId = concluteDetailId;
	}

	public BigDecimal getSurplusBail() {
		return surplusBail;
	}

	public void setSurplusBail(BigDecimal surplusBail) {
		this.surplusBail = surplusBail;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public Date getHandleTime() {
		return handleTime;
	}
	public void setHandleTime(Date handleTime) {
		this.handleTime = handleTime;
	}
	public String getBidSerial() {
		return bidSerial;
	}
	public void setBidSerial(String bidSerial) {
		this.bidSerial = bidSerial;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public Date getDealDate() {
		return dealDate;
	}
	public void setDealDate(Date dealDate) {
		this.dealDate = dealDate;
	}
	public String getDealType() {
		return dealType;
	}
	public void setDealType(String dealType) {
		this.dealType = dealType;
	}
	public String getDealNumber() {
		return dealNumber;
	}
	public void setDealNumber(String dealNumber) {
		this.dealNumber = dealNumber;
	}
	public String getDealAmount() {
		return dealAmount;
	}
	public void setDealAmount(String dealAmount) {
		this.dealAmount = dealAmount;
	}
	public String getRefundAmount() {
		return refundAmount;
	}
	public void setRefundAmount(String refundAmount) {
		this.refundAmount = refundAmount;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
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

	public String getCompanyId() {
		return companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
}
