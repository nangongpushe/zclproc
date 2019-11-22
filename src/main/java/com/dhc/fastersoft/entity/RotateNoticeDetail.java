package com.dhc.fastersoft.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;

import java.math.BigDecimal;
import java.util.List;

public class RotateNoticeDetail {
	private String id;
	private String noticeId;
	private int serialNo;
	@Excel(name="品种")
	private String variety;
	@Excel(name="成本",replace= {"———_0.00"})
	private BigDecimal cost;
	@Excel(name="直管属性")
	private String pipeAttribute;
	@Excel(name="收获年份")
	private String harvestYear;
	@Excel(name="储存库点")
	private String storageWarehouse;
	@Excel(name="仓号")
	private String storehouse;
	@Excel(name="计划数")
	private BigDecimal planNumber;
	@Excel(name="实绩数")
	private BigDecimal actualNumber;
	private String removalUnit;
	private String immigrationUnit;
	private String schemeId;
	private String schemeName;
	private String dealSerial;
	private StorageWarehouse warehouse;
	private String enterpriseId;
	private String enterpriseName;

	/**
	 * 入库批号
	 */
	private String batchNumber;

    /**
     * 手工填报标记
     */
	private String manuReport;

	private BigDecimal manuActualNumber;

    /**
     * 同一企业下所有库点的集合
     */
	private List<EnterpriseWarehouse> enterpriseWarehouses;

	private List<String> enterpriseWarehouseNames;

	public BigDecimal getManuActualNumber() {
		return manuActualNumber;
	}

	public void setManuActualNumber(BigDecimal manuActualNumber) {
		this.manuActualNumber = manuActualNumber;
	}

	public List<String> getEnterpriseWarehouseNames() {
		return enterpriseWarehouseNames;
	}

	public void setEnterpriseWarehouseNames(List<String> enterpriseWarehouseNames) {
		this.enterpriseWarehouseNames = enterpriseWarehouseNames;
	}

	public List<EnterpriseWarehouse> getEnterpriseWarehouses() {
        return enterpriseWarehouses;
    }

    public void setEnterpriseWarehouses(List<EnterpriseWarehouse> enterpriseWarehouses) {
        this.enterpriseWarehouses = enterpriseWarehouses;
    }

    public String getBatchNumber() {
		return batchNumber;
	}

	public void setBatchNumber(String batchNumber) {
		this.batchNumber = batchNumber;
	}

    public String getManuReport() {
        return manuReport;
    }

    public void setManuReport(String manuReport) {
        this.manuReport = manuReport;
    }

    public String getSchemeId() {
		return schemeId;
	}
	public void setSchemeId(String schemeId) {
		this.schemeId = schemeId;
	}
	public String getSchemeName() {
		return schemeName;
	}
	public void setSchemeName(String schemeName) {
		this.schemeName = schemeName;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNoticeId() {
		return noticeId;
	}
	public void setNoticeId(String noticeId) {
		this.noticeId = noticeId;
	}
	public int getSerialNo() {
		return serialNo;
	}
	public void setSerialNo(int serialNo) {
		this.serialNo = serialNo;
	}
	public String getVariety() {
		return variety;
	}
	public void setVariety(String variety) {
		this.variety = variety;
	}
	public BigDecimal getCost() {
		return cost;
	}
	public void setCost(BigDecimal cost) {
		this.cost = cost;
	}
	public String getPipeAttribute() {
		return pipeAttribute;
	}
	public void setPipeAttribute(String pipeAttribute) {
		this.pipeAttribute = pipeAttribute;
	}
	public String getHarvestYear() {
		return harvestYear;
	}
	public void setHarvestYear(String harvestYear) {
		this.harvestYear = harvestYear;
	}
	public String getStorageWarehouse() {
		return storageWarehouse;
	}
	public void setStorageWarehouse(String storageWarehouse) {
		this.storageWarehouse = storageWarehouse;
	}
	public String getStorehouse() {
		return storehouse;
	}
	public void setStorehouse(String storehouse) {
		this.storehouse = storehouse;
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
	public String getDealSerial() {
		return dealSerial;
	}
	public void setDealSerial(String dealSerial) {
		this.dealSerial = dealSerial;
	}

	public StorageWarehouse getWarehouse() {
		return warehouse;
	}

	public void setWarehouse(StorageWarehouse warehouse) {
		this.warehouse = warehouse;
	}

	public String getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(String enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	public String getEnterpriseName() {
		return enterpriseName;
	}

	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}
}
