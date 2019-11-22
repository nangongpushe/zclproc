package com.dhc.fastersoft.entity.report;


import java.util.Date;
import java.util.List;
public class ReportMonth {
    private String id;

    private String reportMonth;

    private String reportWarehouse;

    private String reportWarehouseId;

    private String reportName;

    private String reportStatus;

    private String reportMonthStatus;

    private String creator;

    private Date createDate;

    private String remark;

    private String reportIds;

    private String gatherId;

    private String manager;

    private String reserveProperty;

    private String comments;

    private String enterpriseShortName;

    private String enterpriseId;

    public String getEnterpriseShortName() {
        return enterpriseShortName;
    }

    public void setEnterpriseShortName(String enterpriseShortName) {
        this.enterpriseShortName = enterpriseShortName;
    }

    public String getEnterpriseId() {
        return enterpriseId;
    }

    public void setEnterpriseId(String enterpriseId) {
        this.enterpriseId = enterpriseId;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
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

    public String getReportStatus() {
        return reportStatus;
    }

    public void setReportStatus(String reportStatus) {
        this.reportStatus = reportStatus == null ? null : reportStatus.trim();
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getReportIds() {
        return reportIds;
    }

    public void setReportIds(String reportIds) {
        this.reportIds = reportIds;
    }

    public String getGatherId() {
        return gatherId;
    }

    public void setGatherId(String gatherId) {
        this.gatherId = gatherId;
    }

    public String getManager() {
        return manager;
    }

    public void setManager(String manager) {
        this.manager = manager;
    }

    public String getReserveProperty() {
        return reserveProperty;
    }

    public void setReserveProperty(String reserveProperty) {
        this.reserveProperty = reserveProperty;
    }

    public String getReportWarehouseId() {
        return reportWarehouseId;
    }

    public void setReportWarehouseId(String reportWarehouseId) {
        this.reportWarehouseId = reportWarehouseId;
    }

    public String getReportMonthStatus() {
        return reportMonthStatus;
    }

    public void setReportMonthStatus(String reportMonthStatus) {
        this.reportMonthStatus = reportMonthStatus;
    }


    @Override
    public String toString() {
        return "ReportMonth{" +
                "id='" + id + '\'' +
                ", reportMonth='" + reportMonth + '\'' +
                ", reportWarehouse='" + reportWarehouse + '\'' +
                ", reportWarehouseId='" + reportWarehouseId + '\'' +
                ", reportName='" + reportName + '\'' +
                ", reportStatus='" + reportStatus + '\'' +
                ", reportMonthStatus='" + reportMonthStatus + '\'' +
                ", creator='" + creator + '\'' +
                ", createDate=" + createDate +
                ", remark='" + remark + '\'' +
                ", reportIds='" + reportIds + '\'' +
                ", gatherId='" + gatherId + '\'' +
                ", manager='" + manager + '\'' +
                ", reserveProperty='" + reserveProperty + '\'' +
                ", comments='" + comments + '\'' +
                ", enterpriseShortName='" + enterpriseShortName + '\'' +
                ", enterpriseId='" + enterpriseId + '\'' +
                '}';
    }
}