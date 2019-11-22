package com.dhc.fastersoft.entity.report;

import java.math.BigDecimal;

public class ReportBzw {
    private String reportId;

    private String reportMonth;

    private String reportWarehouse;

    private String reportWarehouseId;

    private String reportName;

    private String manageProperty;

    private String packageProperty;

    private BigDecimal biaoxin;

    private BigDecimal biaojiu;

    private BigDecimal subtotal;

    private BigDecimal ordernum;

    private String remark;

    private String storehouse;



    private BigDecimal zadai;

    private BigDecimal feidai;

    public BigDecimal getZadai() {
        return zadai;
    }

    public void setZadai(BigDecimal zadai) {
        this.zadai = zadai;
    }

    public BigDecimal getFeidai() {
        return feidai;
    }

    public void setFeidai(BigDecimal feidai) {
        this.feidai = feidai;
    }

    public String getReportId() {
        return reportId;
    }

    public void setReportId(String reportId) {
        this.reportId = reportId == null ? null : reportId.trim();
    }

    public String getReportMonth() {
        return reportMonth;
    }

    public void setReportMonth(String reportMonth) {
        this.reportMonth = reportMonth == null ? null : reportMonth.trim();
    }

    public String getReportWarehouse() {
        return reportWarehouse;
    }

    public void setReportWarehouse(String reportWarehouse) {
        this.reportWarehouse = reportWarehouse == null ? null : reportWarehouse.trim();
    }

    public String getReportName() {
        return reportName;
    }

    public void setReportName(String reportName) {
        this.reportName = reportName == null ? null : reportName.trim();
    }

    public String getManageProperty() {
        return manageProperty;
    }

    public void setManageProperty(String manageProperty) {
        this.manageProperty = manageProperty == null ? null : manageProperty.trim();
    }

    public String getPackageProperty() {
        return packageProperty;
    }

    public void setPackageProperty(String packageProperty) {
        this.packageProperty = packageProperty == null ? null : packageProperty.trim();
    }

    public BigDecimal getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public BigDecimal getOrdernum() {
        return ordernum;
    }

    public void setOrdernum(BigDecimal ordernum) {
        this.ordernum = ordernum;
    }

    public BigDecimal getBiaoxin() {
        return biaoxin;
    }

    public void setBiaoxin(BigDecimal biaoxin) {
        this.biaoxin = biaoxin;
    }

    public BigDecimal getBiaojiu() {
        return biaojiu;
    }

    public void setBiaojiu(BigDecimal biaojiu) {
        this.biaojiu = biaojiu;
    }

    public String getStorehouse() {
        return storehouse;
    }

    public void setStorehouse(String storehouse) {
        this.storehouse = storehouse;
    }

    public String getReportWarehouseId() {
        return reportWarehouseId;
    }

    public void setReportWarehouseId(String reportWarehouseId) {
        this.reportWarehouseId = reportWarehouseId;
    }
}