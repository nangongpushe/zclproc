package com.dhc.fastersoft.entity;

import java.util.List;

public class ManuReportData {

    /**
     * 库点ID
     */
    private String id;

    /**
     * 企业名称
     */
    private String enterpriseName;

    /**
     * 库点简称
     */
    private String storageShortName;

    /**
     * 仓房编号
     */
    private List<String> warehouseNumber;

    /**
     * 品种
     */
    private List<String> variety;

    /**
     * 手工填报批号
     */
    private String manuBatchNumber;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getManuBatchNumber() {
        return manuBatchNumber;
    }

    public void setManuBatchNumber(String manuBatchNumber) {
        this.manuBatchNumber = manuBatchNumber;
    }

    public String getEnterpriseName() {
        return enterpriseName;
    }

    public void setEnterpriseName(String enterpriseName) {
        this.enterpriseName = enterpriseName;
    }

    public String getStorageShortName() {
        return storageShortName;
    }

    public void setStorageShortName(String storageShortName) {
        this.storageShortName = storageShortName;
    }

    public List<String> getWarehouseNumber() {
        return warehouseNumber;
    }

    public void setWarehouseNumber(List<String> warehouseNumber) {
        this.warehouseNumber = warehouseNumber;
    }

    public List<String> getVariety() {
        return variety;
    }

    public void setVariety(List<String> variety) {
        this.variety = variety;
    }

}
