package com.dhc.fastersoft.entity;

import java.math.BigDecimal;
import java.util.Date;

public class NgasOperaSituation {
    private String id;
    private String operaRecordId;
    private String period;
    private BigDecimal targetThickness;
    private Date startTime;
    private Date endTime;
    private BigDecimal duringTime;
    private BigDecimal maxThickness;
    private BigDecimal minThickness;
    private BigDecimal avgThickness;
    private BigDecimal orderNo;
    private NgasOperaRecord ngasOperaRecord;

    public NgasOperaRecord getNgasOperaRecord() {
        return ngasOperaRecord;
    }

    public void setNgasOperaRecord(NgasOperaRecord ngasOperaRecord) {
        this.ngasOperaRecord = ngasOperaRecord;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOperaRecordId() {
        return operaRecordId;
    }

    public void setOperaRecordId(String operaRecordId) {
        this.operaRecordId = operaRecordId;
    }

    public String getPeriod() {
        return period;
    }

    public void setPeriod(String period) {
        this.period = period;
    }

    public BigDecimal getTargetThickness() {
        return targetThickness;
    }

    public void setTargetThickness(BigDecimal targetThickness) {
        this.targetThickness = targetThickness;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public BigDecimal getDuringTime() {
        return duringTime;
    }

    public void setDuringTime(BigDecimal duringTime) {
        this.duringTime = duringTime;
    }

    public BigDecimal getMaxThickness() {
        return maxThickness;
    }

    public void setMaxThickness(BigDecimal maxThickness) {
        this.maxThickness = maxThickness;
    }

    public BigDecimal getMinThickness() {
        return minThickness;
    }

    public void setMinThickness(BigDecimal minThickness) {
        this.minThickness = minThickness;
    }

    public BigDecimal getAvgThickness() {
        return avgThickness;
    }

    public void setAvgThickness(BigDecimal avgThickness) {
        this.avgThickness = avgThickness;
    }

    public BigDecimal getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(BigDecimal orderNo) {
        this.orderNo = orderNo;
    }

    @Override
    public String toString() {
        return "NgasOperaSituation{" +
                "id='" + id + '\'' +
                ", operaRecordId='" + operaRecordId + '\'' +
                ", period=" + period +
                ", targetThickness=" + targetThickness +
                ", startTime=" + startTime +
                ", endTime='" + endTime + '\'' +
                ", duringTime=" + duringTime +
                ", maxThickness=" + maxThickness +
                ", minThickness=" + minThickness +
                ", avgThickness=" + avgThickness +
                ", orderNo=" + orderNo +
                ", ngasOperaRecord=" + ngasOperaRecord +
                '}';
    }

}
