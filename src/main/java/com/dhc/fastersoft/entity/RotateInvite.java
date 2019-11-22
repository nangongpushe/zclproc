package com.dhc.fastersoft.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;
import cn.afterturn.easypoi.excel.annotation.ExcelCollection;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;


public class RotateInvite {
	private String id;
	private String inviteName;
	private String inviteType;
	private String inviteSerial;
	@Excel(name="委托单位",isImportField="true_ri",needMerge=true)
	private String entrustCompany;
	@Excel(name="委托标的",isImportField="true_ri",needMerge=true)
	private String entrustBid;
	@Excel(name="委托数量(吨)",isImportField="true_ri",needMerge=true)
	private String entrustNum;
	@Excel(name="实施单位",isImportField="true_ri",needMerge=true)
	private String exploitingEntity;
	private String operator;
	private String department;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date handleTime;
	private String remark;
	private String bidId;
	private String bidName;
	private String bidType;
	@Excel(name="数量合计（吨）",isImportField="true_rid")
	private String totalNum;
	@Excel(name="竞得均价（元/吨）",isImportField="true_rid")
	private String totalCompetitivePrice;
	@Excel(name="标的物总价（元）",isImportField="true_rid")
	private String totalBidPrice;
	@Excel(name="占用保证金（元）",isImportField="true_rid")
	private String totalBail;
	@ExcelCollection(name = "招标结果明细")
	private List<RotateInviteDetail> inviteDetails;
	
	private String handleTimeStr;
	
	private String isGather;
	
	
	
	public String getIsGather() {
		return isGather;
	}
	public void setIsGather(String isGather) {
		this.isGather = isGather;
	}
	public String getHandleTimeStr() {
		return handleTimeStr;
	}
	public void setHandleTimeStr(String handleTimeStr) {
		this.handleTimeStr = handleTimeStr;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getInviteName() {
		return inviteName;
	}
	public void setInviteName(String inviteName) {
		this.inviteName = inviteName;
	}
	public String getInviteType() {
		return inviteType;
	}
	public void setInviteType(String inviteType) {
		this.inviteType = inviteType;
	}
	public String getEntrustCompany() {
		return entrustCompany;
	}
	public void setEntrustCompany(String entrustCompany) {
		this.entrustCompany = entrustCompany;
	}
	public String getEntrustBid() {
		return entrustBid;
	}
	public void setEntrustBid(String entrustBid) {
		this.entrustBid = entrustBid;
	}
	public String getEntrustNum() {
		return entrustNum;
	}
	public void setEntrustNum(String entrustNum) {
		this.entrustNum = entrustNum;
	}
	public String getExploitingEntity() {
		return exploitingEntity;
	}
	public void setExploitingEntity(String exploitingEntity) {
		this.exploitingEntity = exploitingEntity;
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
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public String getBidId() {
		return bidId;
	}
	public void setBidId(String bidId) {
		this.bidId = bidId;
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
	
	public String getTotalNum() {
		return totalNum;
	}
	public void setTotalNum(String totalNum) {
		this.totalNum = totalNum;
	}
	public String getTotalCompetitivePrice() {
		return totalCompetitivePrice;
	}
	public void setTotalCompetitivePrice(String totalCompetitivePrice) {
		this.totalCompetitivePrice = totalCompetitivePrice;
	}
	public String getTotalBidPrice() {
		return totalBidPrice;
	}
	public void setTotalBidPrice(String totalBidPrice) {
		this.totalBidPrice = totalBidPrice;
	}
	public String getTotalBail() {
		return totalBail;
	}
	public void setTotalBail(String totalBail) {
		this.totalBail = totalBail;
	}
	public List<RotateInviteDetail> getInviteDetails() {
		return inviteDetails;
	}
	public void setInviteDetails(List<RotateInviteDetail> inviteDetails) {
		this.inviteDetails = inviteDetails;
	}
	public String getInviteSerial() {
		return inviteSerial;
	}
	public void setInviteSerial(String inviteSerial) {
		this.inviteSerial = inviteSerial;
	}

	
	
}
