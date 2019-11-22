package com.dhc.fastersoft.entity.yearReport;

import java.math.BigDecimal;

import cn.afterturn.easypoi.excel.annotation.Excel;

public class ReportYearGMKC implements java.io.Serializable{
    /**
	* @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么)
	*/
	
	private static final long serialVersionUID = 1L;

	private String reportId;

    private String reportYear;

    private String reportName;
    
    @Excel(name="品种指标",isImportField="true_st")
    private String grainType;

    @Excel(name="地方规模库存合计",isImportField="true_st")
    private BigDecimal subtotal;

    @Excel(name="省级规模库存",isImportField="true_st")
    private BigDecimal province;

    @Excel(name="市级规模库存",isImportField="true_st")
    private BigDecimal city;

    @Excel(name="县级规模库存",isImportField="true_st")
    private BigDecimal county;

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

    public String getGrainType() {
        return grainType;
    }

    public void setGrainType(String grainType) {
        this.grainType = grainType == null ? null : grainType.trim();
    }

    public BigDecimal getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
    }

    public BigDecimal getProvince() {
        return province;
    }

    public void setProvince(BigDecimal province) {
        this.province = province;
    }

    public BigDecimal getCity() {
        return city;
    }

    public void setCity(BigDecimal city) {
        this.city = city;
    }

    public BigDecimal getCounty() {
        return county;
    }

    public void setCounty(BigDecimal county) {
        this.county = county;
    }
}