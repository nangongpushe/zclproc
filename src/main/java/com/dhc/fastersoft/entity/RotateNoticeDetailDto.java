package com.dhc.fastersoft.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;

import java.math.BigDecimal;

public class RotateNoticeDetailDto {
    private String id;
    private String noticeid;
    private int serialno;
    @Excel(name="品种")
    private String variety;
    @Excel(name="成本",replace= {"———_0.0"})
    private BigDecimal cost;
    @Excel(name="直管属性")
    private String pipeattribute;
    @Excel(name="收获年份")
    private String grainannual;
    @Excel(name="储存库点")
    private String storagegraindepot;
    @Excel(name="仓号")
    private String granarycode;
    @Excel(name="计划数")
    private BigDecimal plannumber;
    @Excel(name="实绩数")
    private BigDecimal actualnumber;
    private String removalunit;
    private String immigrationunit;
    private String schemeid;
    private String schemename;
    private String dealserial;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNoticeid() {
        return noticeid;
    }

    public void setNoticeid(String noticeid) {
        this.noticeid = noticeid;
    }

    public int getSerialno() {
        return serialno;
    }

    public void setSerialno(int serialno) {
        this.serialno = serialno;
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

    public String getPipeattribute() {
        return pipeattribute;
    }

    public void setPipeattribute(String pipeattribute) {
        this.pipeattribute = pipeattribute;
    }

    public String getGrainannual() {
        return grainannual;
    }

    public void setGrainannual(String grainannual) {
        this.grainannual = grainannual;
    }

    public String getStoragegraindepot() {
        return storagegraindepot;
    }

    public void setStoragegraindepot(String storagegraindepot) {
        this.storagegraindepot = storagegraindepot;
    }

    public String getGranarycode() {
        return granarycode;
    }

    public void setGranarycode(String granarycode) {
        this.granarycode = granarycode;
    }

    public BigDecimal getPlannumber() {
        return plannumber;
    }

    public void setPlannumber(BigDecimal plannumber) {
        this.plannumber = plannumber;
    }

    public BigDecimal getActualnumber() {
        return actualnumber;
    }

    public void setActualnumber(BigDecimal actualnumber) {
        this.actualnumber = actualnumber;
    }

    public String getRemovalunit() {
        return removalunit;
    }

    public void setRemovalunit(String removalunit) {
        this.removalunit = removalunit;
    }

    public String getImmigrationunit() {
        return immigrationunit;
    }

    public void setImmigrationunit(String immigrationunit) {
        this.immigrationunit = immigrationunit;
    }

    public String getSchemeid() {
        return schemeid;
    }

    public void setSchemeid(String schemeid) {
        this.schemeid = schemeid;
    }

    public String getSchemename() {
        return schemename;
    }

    public void setSchemename(String schemename) {
        this.schemename = schemename;
    }

    public String getDealserial() {
        return dealserial;
    }

    public void setDealserial(String dealserial) {
        this.dealserial = dealserial;
    }
}
