package com.dhc.fastersoft.entity.report;
import java.math.BigDecimal;
import java.util.Date;

public class ReportBzwcrmx {
    private String reportId;
    private String reportMonth;
    private String reportWarehouse;
    private String reportName;



    private String detailDate;//日期
    private String summary;//摘要
    private BigDecimal priorNew;//上期库存标新
    private BigDecimal priorOld;//上期库存标旧
    private BigDecimal priorMixed;//上期库存杂袋
    private BigDecimal priorWaste;//上期库存废袋
    private BigDecimal incomeNew;//收入标新
    private BigDecimal incomeOld;//收入标旧
    private BigDecimal incomeMixed;//收入标杂袋
    private BigDecimal incomeWaste;//收入废袋
    private BigDecimal expendNew;//支出标新
    private BigDecimal expendOld;//支出标旧
    private BigDecimal expendMixed;//支出杂袋
    private BigDecimal expendWaste;//支出废袋
    private BigDecimal balanceNew;//结余库存标新
    private BigDecimal balanceOld;//结余库存标旧
    private BigDecimal balanceMixed;//结余库存杂袋
    private BigDecimal balanceWaste;//结余库存废袋
    private String remark;//备注
    private BigDecimal ordernum;


    public String getDetailDate() {
        return detailDate;
    }

    public void setDetailDate(String detailDate) {
        this.detailDate = detailDate;
    }
    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public BigDecimal getPriorNew() {
        return priorNew;
    }

    public void setPriorNew(BigDecimal priorNew) {
        this.priorNew = priorNew;
    }

    public BigDecimal getPriorOld() {
        return priorOld;
    }

    public void setPriorOld(BigDecimal priorOld) {
        this.priorOld = priorOld;
    }

    public BigDecimal getPriorMixed() {
        return priorMixed;
    }

    public void setPriorMixed(BigDecimal priorMixed) {
        this.priorMixed = priorMixed;
    }

    public BigDecimal getPriorWaste() {
        return priorWaste;
    }

    public void setPriorWaste(BigDecimal priorWaste) {
        this.priorWaste = priorWaste;
    }

    public BigDecimal getIncomeNew() {
        return incomeNew;
    }

    public void setIncomeNew(BigDecimal incomeNew) {
        this.incomeNew = incomeNew;
    }

    public BigDecimal getIncomeOld() {
        return incomeOld;
    }

    public void setIncomeOld(BigDecimal incomeOld) {
        this.incomeOld = incomeOld;
    }

    public BigDecimal getIncomeMixed() {
        return incomeMixed;
    }

    public void setIncomeMixed(BigDecimal incomeMixed) {
        this.incomeMixed = incomeMixed;
    }

    public BigDecimal getIncomeWaste() {
        return incomeWaste;
    }

    public void setIncomeWaste(BigDecimal incomeWaste) {
        this.incomeWaste = incomeWaste;
    }

    public BigDecimal getExpendNew() {
        return expendNew;
    }

    public void setExpendNew(BigDecimal expendNew) {
        this.expendNew = expendNew;
    }

    public BigDecimal getExpendOld() {
        return expendOld;
    }

    public void setExpendOld(BigDecimal expendOld) {
        this.expendOld = expendOld;
    }

    public BigDecimal getExpendMixed() {
        return expendMixed;
    }

    public void setExpendMixed(BigDecimal expendMixed) {
        this.expendMixed = expendMixed;
    }

    public BigDecimal getExpendWaste() {
        return expendWaste;
    }

    public void setExpendWaste(BigDecimal expendWaste) {
        this.expendWaste = expendWaste;
    }

    public BigDecimal getBalanceNew() {
        return balanceNew;
    }

    public void setBalanceNew(BigDecimal balanceNew) {
        this.balanceNew = balanceNew;
    }

    public BigDecimal getBalanceOld() {
        return balanceOld;
    }

    public void setBalanceOld(BigDecimal balanceOld) {
        this.balanceOld = balanceOld;
    }

    public BigDecimal getBalanceMixed() {
        return balanceMixed;
    }

    public void setBalanceMixed(BigDecimal balanceMixed) {
        this.balanceMixed = balanceMixed;
    }

    public BigDecimal getBalanceWaste() {
        return balanceWaste;
    }

    public void setBalanceWaste(BigDecimal balanceWaste) {
        this.balanceWaste = balanceWaste;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }


    public String getReportId() {
        return reportId;
    }

    public void setReportId(String reportId) {
        this.reportId = reportId;
    }
    public String getReportMonth() {
        return reportMonth;
    }

    public void setReportMonth(String reportMonth) {
        this.reportMonth = reportMonth;
    }

    public String getReportWarehouse() {
        return reportWarehouse;
    }

    public void setReportWarehouse(String reportWarehouse) {
        this.reportWarehouse = reportWarehouse;
    }

    public String getReportName() {
        return reportName;
    }

    public void setReportName(String reportName) {
        this.reportName = reportName;
    }

    public BigDecimal getOrdernum() {
        return ordernum;
    }

    public void setOrdernum(BigDecimal ordernum) {
        this.ordernum = ordernum;
    }
}
