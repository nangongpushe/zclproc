package com.dhc.fastersoft.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;

import java.math.BigDecimal;

public class MoveBound {
	@Excel(name="品种")
	private String variety;
	@Excel(name="移出单位")
	private String removalUnit;
	@Excel(name="移入单位")
	private String immigrationUnit;
	@Excel(name="储存库点")
	private String storageWarehouse;
	@Excel(name="计划数")
	private BigDecimal planNumber;
	@Excel(name="实绩数")
	private BigDecimal actualNumber;
	public String getVariety() {
		return variety;
	}
	public void setVariety(String variety) {
		this.variety = variety;
	}
	public String getRemovalUnit() {
		return removalUnit;
	}
	public void setRemovalUnit(String removalUnit) {
		this.removalUnit = removalUnit;
	}
	public String getImmigrationUnit() {
		return immigrationUnit;
	}
	public void setImmigrationUnit(String immigrationUnit) {
		this.immigrationUnit = immigrationUnit;
	}
	public String getStorageWarehouse() {
		return storageWarehouse;
	}
	public void setStorageWarehouse(String storageWarehouse) {
		this.storageWarehouse = storageWarehouse;
	}

	public BigDecimal getPlanNumber() {
		return planNumber;
	}

	public void setPlanNumber(BigDecimal planNumber) {
		this.planNumber = planNumber;
	}

	public BigDecimal getActualNumber() {
		return actualNumber;
	}

	public void setActualNumber(BigDecimal actualNumber) {
		this.actualNumber = actualNumber;
	}
}
