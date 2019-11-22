package com.dhc.fastersoft.entity.yearReport;

import java.math.BigDecimal;

public class ReportYearPEOPLE {
    private String reportId;

    private String reportYear;

    private String reportName;

    private String indicator;

    private String unit;

    private BigDecimal thisYear;

    private BigDecimal lastYear;

    public String getReportId() {
        return reportId;
    }

    public void setReportId(String reportId) {
        this.reportId = reportId == null ? null : reportId.trim();
    }

    public String getReportYear() {
        return reportYear;
    }

    public void setReportYear(String reportYear) {
        this.reportYear = reportYear == null ? null : reportYear.trim();
    }

    public String getReportName() {
        return reportName;
    }

    public void setReportName(String reportName) {
        this.reportName = reportName == null ? null : reportName.trim();
    }

    public String getIndicator() {
        return indicator;
    }

    public void setIndicator(String indicator) {
        this.indicator = indicator == null ? null : indicator.trim();
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit == null ? null : unit.trim();
    }

    public BigDecimal getThisYear() {
        return thisYear;
    }

    public void setThisYear(BigDecimal thisYear) {
        this.thisYear = thisYear;
    }

    public BigDecimal getLastYear() {
        return lastYear;
    }

    public void setLastYear(BigDecimal lastYear) {
        this.lastYear = lastYear;
    }
}