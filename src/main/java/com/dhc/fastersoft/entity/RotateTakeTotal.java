package com.dhc.fastersoft.entity;

/**
 * 提货单汇总
 */
public class RotateTakeTotal {

     private String id;
    /**
     * 库点简称
     */
    private String  wareHouseShort;
    /**
     * 品种
     */
    private String variety;
    /**
     * 入库年份
     */
    private String wareHouseYear;
    /**
     * 发货数量
     */
    private String shipment;
    /**
     * 分发开始时间
     */
    private String beginDistributionDate;
    /**
     * 分发结束时间
     */
    private String endDistributionDate;

    public String getBeginDistributionDate() {
        return beginDistributionDate;
    }

    public void setBeginDistributionDate(String beginDistributionDate) {
        this.beginDistributionDate = beginDistributionDate;
    }

    public String getEndDistributionDate() {
        return endDistributionDate;
    }

    public void setEndDistributionDate(String endDistributionDate) {
        this.endDistributionDate = endDistributionDate;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getWareHouseShort() {
        return wareHouseShort;
    }

    public void setWareHouseShort(String wareHouseShort) {
        this.wareHouseShort = wareHouseShort;
    }

    public String getVariety() {
        return variety;
    }

    public void setVariety(String variety) {
        this.variety = variety;
    }

    public String getWareHouseYear() {
        return wareHouseYear;
    }

    public void setWareHouseYear(String wareHouseYear) {
        this.wareHouseYear = wareHouseYear;
    }

    public String getShipment() {
        return shipment;
    }

    public void setShipment(String shipment) {
        this.shipment = shipment;
    }
}
