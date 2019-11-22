package com.dhc.fastersoft.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;

import java.math.BigDecimal;

public class TransferBusinessDetail {
	private String id;
	private String businessId;
	@Excel(name="货主名称")
	private String shipperName;
	@Excel(name="货物名称")
	private String goodsName;
	@Excel(name="到港日期")
	private String arrivalDate;
	@Excel(name="中转数量")
	private BigDecimal quantity;
	@Excel(name="中转去向")
	private String destination;
	@Excel(name="运输方式")
	private String shipType;
	@Excel(name="中转收入(万元)")
	private BigDecimal income;
	@Excel(name="中转支出(万元)")
	private BigDecimal expend;
	@Excel(name="中转利润(万元)")
	private BigDecimal profits;

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getBusinessId() {
		return businessId;
	}
	public void setBusinessId(String businessId) {
		this.businessId = businessId;
	}
	public String getShipperName() {
		return shipperName;
	}
	public void setShipperName(String shipperName) {
		this.shipperName = shipperName;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public String getArrivalDate() {
		return arrivalDate;
	}
	public void setArrivalDate(String arrivalDate) {
		this.arrivalDate = arrivalDate;
	}

	public BigDecimal getQuantity() {
		return quantity;
	}

	public void setQuantity(BigDecimal quantity) {
		this.quantity = quantity;
	}

	public String getDestination() {
		return destination;
	}

	public void setDestination(String destination) {
		this.destination = destination;
	}

	public String getShipType() {
		return shipType;
	}

	public void setShipType(String shipType) {
		this.shipType = shipType;
	}

	public BigDecimal getIncome() {
		return income;
	}

	public void setIncome(BigDecimal income) {
		this.income = income;
	}

	public BigDecimal getExpend() {
		return expend;
	}

	public void setExpend(BigDecimal expend) {
		this.expend = expend;
	}

	public BigDecimal getProfits() {
		return profits;
	}

	public void setProfits(BigDecimal profits) {
		this.profits = profits;
	}
}
