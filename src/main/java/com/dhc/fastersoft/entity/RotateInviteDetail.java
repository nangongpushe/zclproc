package com.dhc.fastersoft.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;

public class RotateInviteDetail {

	private String id;
	private String inviteID;
	@Excel(name="标段",isImportField="true_rid")
	private String bidSerial;
	@Excel(name="竞得单位",isImportField="true_rid")
	private String competitiveUnit;
	@Excel(name="数量（吨）",isImportField="true_rid")
	private String num;
	@Excel(name="起始价（元/吨）",isImportField="true_rid")
	private String startingPrice;
	@Excel(name="竞得价（元/吨）",isImportField="true_rid")
	private String competitivePrice;

	@Excel(name="标的物总价（元）",isImportField="true_rid")
	private String bidPrice;

	@Excel(name="占用保证金（元）",isImportField="true_rid")
	private String bail;
	private String loanPaymentEndDate;

	private String competitiveUnitId;

	public String getCompetitiveUnitId() {
		return competitiveUnitId;
	}

	public void setCompetitiveUnitId(String competitiveUnitId) {
		this.competitiveUnitId = competitiveUnitId;
	}

	public String getLoanPaymentEndDate() {
		return loanPaymentEndDate;
	}

	public void setLoanPaymentEndDate(String loanPaymentEndDate) {
		this.loanPaymentEndDate = loanPaymentEndDate;
	}

	public String getInviteID() {
		return inviteID;
	}
	public void setInviteID(String inviteID) {
		this.inviteID = inviteID;
	}
	public String getBidSerial() {
		return bidSerial;
	}
	public void setBidSerial(String bidSerial) {
		this.bidSerial = bidSerial;
	}
	public String getCompetitiveUnit() {
		return competitiveUnit;
	}
	public void setCompetitiveUnit(String competitiveUnit) {
		this.competitiveUnit = competitiveUnit;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getStartingPrice() {
		return startingPrice;
	}
	public void setStartingPrice(String startingPrice) {
		this.startingPrice = startingPrice;
	}
	public String getCompetitivePrice() {
		return competitivePrice;
	}
	public void setCompetitivePrice(String competitivePrice) {
		this.competitivePrice = competitivePrice;
	}

	public String getBidPrice() {
		return bidPrice;
	}
	public void setBidPrice(String bidPrice) {
		this.bidPrice = bidPrice;
	}

	public String getBail() {
		return bail;
	}
	public void setBail(String bail) {
		this.bail = bail;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
}
