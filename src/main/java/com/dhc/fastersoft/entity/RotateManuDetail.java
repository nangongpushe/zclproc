package com.dhc.fastersoft.entity;

public class RotateManuDetail {

    /**
     * 企业ID
     */
    private String id;

    /**
     * 库点ID
     */
    private String wareId;

    /**
     * 品种
     */
    private String grainType;
    /**
     * 收获年份
     */
    private String warehoueYear;
    /**
     * 企业
     */
    private String enterpriseName;
    /**
     * 存储库点
     */
    private String receivePlace;
    /**
     * 仓号
     */
    private String storehouse;
    /**
     * 数量
     */
    private Double quantity;

    /**
     *
     * 入库批号
     */
    private String batchNumber;

    public String getWareId() {
        return wareId;
    }

    public void setWareId(String wareId) {
        this.wareId = wareId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getBatchNumber() {
        return batchNumber;
    }

    public void setBatchNumber(String batchNumber) {
        this.batchNumber = batchNumber;
    }

    public String getGrainType() {
        return grainType;
    }

    public void setGrainType(String grainType) {
        this.grainType = grainType;
    }

    public String getWarehoueYear() {
        return warehoueYear;
    }

    public void setWarehoueYear(String warehoueYear) {
        this.warehoueYear = warehoueYear;
    }

    public String getEnterpriseName() {
        return enterpriseName;
    }

    public void setEnterpriseName(String enterpriseName) {
        this.enterpriseName = enterpriseName;
    }

    public String getReceivePlace() {
        return receivePlace;
    }

    public void setReceivePlace(String receivePlace) {
        this.receivePlace = receivePlace;
    }

    public String getStorehouse() {
        return storehouse;
    }

    public void setStorehouse(String storehouse) {
        this.storehouse = storehouse;
    }

    public Double getQuantity() {
        return quantity;
    }

    public void setQuantity(Double quantity) {
        this.quantity = quantity;
    }
}
