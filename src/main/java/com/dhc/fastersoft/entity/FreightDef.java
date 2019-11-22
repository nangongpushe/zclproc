package com.dhc.fastersoft.entity;

import java.math.BigDecimal;
import java.util.Date;

public class FreightDef {
    private String id;

    private String shipType;

    private String packageType;

    private BigDecimal transportPrice;

    private BigDecimal preBoardRate;

    private BigDecimal instoreRate;
    private String createBy;

    private Date createDate;

    private String updateBy;

    private Date updateDate;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getShipType() {
        return shipType;
    }

    public void setShipType(String shipType) {
        this.shipType = shipType;
    }

    public String getPackageType() {
        return packageType;
    }

    public void setPackageType(String packageType) {
        this.packageType = packageType;
    }

    public BigDecimal getTransportPrice() {
        return transportPrice;
    }

    public void setTransportPrice(BigDecimal transportPrice) {
        this.transportPrice = transportPrice;
    }

    public BigDecimal getPreBoardRate() {
        return preBoardRate;
    }

    public void setPreBoardRate(BigDecimal preBoardRate) {
        this.preBoardRate = preBoardRate;
    }

    public BigDecimal getInstoreRate() {
        return instoreRate;
    }

    public void setInstoreRate(BigDecimal instoreRate) {
        this.instoreRate = instoreRate;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }
}
