package com.dhc.fastersoft.entity;

import java.math.BigDecimal;
import java.util.Date;

import cn.afterturn.easypoi.excel.annotation.Excel;

public class RotateFreightAPRVDetail {
	private String id;
	
	@Excel(name="调出单位",width=30)
	private String outUnit;
	@Excel(name="调出库点起运地",width=30)
	private String outStartPlace;
	@Excel(name="调入单位",width=30)
	private String reportUnit;
	@Excel(name="调入库点到达地",width=30)
	private String inAimPlace;
	@Excel(name="品种")
	private String grainType;
	@Excel(name="运距(公里)")
	private String distance;
	@Excel(name="运输方式")
	private String shipType;
	@Excel(name="数量(吨)")
	private String quantity;
	@Excel(name="散运(吨)")
	private String bulk;
	@Excel(name="包装(吨)")
	private String packageNum;
	/*@Excel(name="运费单价(元/吨)")*/
	private String freightUnit;
	@Excel(name="运费(元)")
	private String freight;
	@Excel(name="其他费用(元)")
	private String otherFee;
	@Excel(name="板前费(元)")
	private String boardFee;
	@Excel(name="入库费(元)")
	private String warehouseFee;
	@Excel(name="费用合计(元)")
	private String totalFee;

	private String remark;
	private Date reportDate;
	private String aprvId;
	@Excel(name="包装运费单价(元/吨)")
	private BigDecimal packageFreightUnit;
	@Excel(name="散运运费单价(元/吨)")
	private BigDecimal bulkFreightUnit;
	@Excel(name="包装板前费率(元/吨)")
	private BigDecimal packagePreBoardRate;
	@Excel(name="包装入库费率(元/吨)")
	private BigDecimal packageInStoreRate;
	@Excel(name="散运板前费率(元/吨)")
	private BigDecimal bulkPreBoardRate;
	@Excel(name="散运入库费率(元/吨)")
	private BigDecimal bulkInStoreRate;

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGrainType() {
		return grainType;
	}
	public void setGrainType(String grainType) {
		this.grainType = grainType;
	}
	public String getReportUnit() {
		return reportUnit;
	}
	public void setReportUnit(String reportUnit) {
		this.reportUnit = reportUnit;
	}

	public String getOutUnit() {
		return outUnit;
	}
	public void setOutUnit(String outUnit) {
		this.outUnit = outUnit;
	}
	public String getOutStartPlace() {
		return outStartPlace;
	}
	public void setOutStartPlace(String outStartPlace) {
		this.outStartPlace = outStartPlace;
	}
	public String getInAimPlace() {
		return inAimPlace;
	}
	public void setInAimPlace(String inAimPlace) {
		this.inAimPlace = inAimPlace;
	}
	public String getDistance() {
		return distance;
	}
	public void setDistance(String distance) {
		this.distance = distance;
	}
	public String getShipType() {
		return shipType;
	}
	public void setShipType(String shipType) {
		this.shipType = shipType;
	}
	public String getQuantity() {
		return quantity;
	}
	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}
	public String getBulk() {
		return bulk;
	}
	public void setBulk(String bulk) {
		this.bulk = bulk;
	}
	public String getPackageNum() {
		return packageNum;
	}
	public void setPackageNum(String packageNum) {
		this.packageNum = packageNum;
	}
	public String getFreightUnit() {
		return freightUnit;
	}
	public void setFreightUnit(String freightUnit) {
		this.freightUnit = freightUnit;
	}
	public String getFreight() {
		return freight;
	}
	public void setFreight(String freight) {
		this.freight = freight;
	}
	public String getOtherFee() {
		return otherFee;
	}
	public void setOtherFee(String otherFee) {
		this.otherFee = otherFee;
	}
	public String getBoardFee() {
		return boardFee;
	}
	public void setBoardFee(String boardFee) {
		this.boardFee = boardFee;
	}
	public String getWarehouseFee() {
		return warehouseFee;
	}
	public void setWarehouseFee(String warehouseFee) {
		this.warehouseFee = warehouseFee;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Date getReportDate() {
		return reportDate;
	}
	public void setReportDate(Date reportDate) {
		this.reportDate = reportDate;
	}
	public String getAprvId() {
		return aprvId;
	}
	public void setAprvId(String aprvId) {
		this.aprvId = aprvId;
	}
	public String getTotalFee() {
		return totalFee;
	}
	public void setTotalFee(String totalFee) {
		this.totalFee = totalFee;
	}

	public BigDecimal getPackageFreightUnit() {
		return packageFreightUnit;
	}

	public void setPackageFreightUnit(BigDecimal packageFreightUnit) {
		this.packageFreightUnit = packageFreightUnit;
	}

	public BigDecimal getBulkFreightUnit() {
		return bulkFreightUnit;
	}

	public void setBulkFreightUnit(BigDecimal bulkFreightUnit) {
		this.bulkFreightUnit = bulkFreightUnit;
	}

	public BigDecimal getPackagePreBoardRate() {
		return packagePreBoardRate;
	}

	public void setPackagePreBoardRate(BigDecimal packagePreBoardRate) {
		this.packagePreBoardRate = packagePreBoardRate;
	}

	public BigDecimal getPackageInStoreRate() {
		return packageInStoreRate;
	}

	public void setPackageInStoreRate(BigDecimal packageInStoreRate) {
		this.packageInStoreRate = packageInStoreRate;
	}

	public BigDecimal getBulkPreBoardRate() {
		return bulkPreBoardRate;
	}

	public void setBulkPreBoardRate(BigDecimal bulkPreBoardRate) {
		this.bulkPreBoardRate = bulkPreBoardRate;
	}

	public BigDecimal getBulkInStoreRate() {
		return bulkInStoreRate;
	}

	public void setBulkInStoreRate(BigDecimal bulkInStoreRate) {
		this.bulkInStoreRate = bulkInStoreRate;
	}
}
