package com.dhc.fastersoft.entity;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import cn.afterturn.easypoi.excel.annotation.Excel;
import cn.afterturn.easypoi.excel.annotation.ExcelCollection;

public class ConstructionSchedule {
	private String id;
	@Excel(name="年月")
	private String yearMonth;
	@Excel(name="项目单位")
	private String projectUnit;
	@Excel(name="经办人")
	private String operator;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date handleTime;
	private String reportTime;
	@Excel(name="批准投资小计(万元)")
	private double approvedInvestmentSubtotal;
	@Excel(name="本月完成投资小计(万元)")
	private double currentInvestmentSubtotal;
	@Excel(name="累计完成投资小计(万元)")
	private double accumulateInvestmentSubtotal;
	private Integer investmentQuota;
	private String status;
	private String remark;
	private Integer collect;
	private Integer reported;
	private String warehouseId;
	public String getWarehouseId() {
		return warehouseId;
	}
	public void setWarehouseId(String warehouseId) {
		this.warehouseId = warehouseId;
	}
	@ExcelCollection(name="工程进度明细")
	private List<ConstructionScheduleDetail> scheduleDetail;
	
	public List<ConstructionScheduleDetail> getScheduleDetail() {
		return scheduleDetail;
	}
	public void setScheduleDetail(List<ConstructionScheduleDetail> scheduleDetail) {
		this.scheduleDetail = scheduleDetail;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getYearMonth() {
		return yearMonth;
	}
	public void setYearMonth(String yearMonth) {
		this.yearMonth = yearMonth;
	}
	public String getProjectUnit() {
		return projectUnit;
	}
	public void setProjectUnit(String projectUnit) {
		this.projectUnit = projectUnit;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public Date getHandleTime() {
		return handleTime;
	}
	public void setHandleTime(Date handleTime) {
		this.handleTime = handleTime;
	}
	public String getReportTime() {
		return reportTime;
	}
	public void setReportTime(String reportTime) {
		this.reportTime = reportTime;
	}
	public double getApprovedInvestmentSubtotal() {
		return approvedInvestmentSubtotal;
	}
	public void setApprovedInvestmentSubtotal(double approvedInvestmentSubtotal) {
		this.approvedInvestmentSubtotal = approvedInvestmentSubtotal;
	}
	public double getCurrentInvestmentSubtotal() {
		return currentInvestmentSubtotal;
	}
	public void setCurrentInvestmentSubtotal(double currentInvestmentSubtotal) {
		this.currentInvestmentSubtotal = currentInvestmentSubtotal;
	}
	public double getAccumulateInvestmentSubtotal() {
		return accumulateInvestmentSubtotal;
	}
	public void setAccumulateInvestmentSubtotal(double accumulateInvestmentSubtotal) {
		this.accumulateInvestmentSubtotal = accumulateInvestmentSubtotal;
	}
	public Integer getInvestmentQuota() {
		return investmentQuota;
	}
	public void setInvestmentQuota(int investmentQuota) {
		this.investmentQuota = investmentQuota;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Integer getCollect() {
		return collect;
	}
	public void setCollect(int collect) {
		this.collect = collect;
	}
	public Integer getReported() {
		return reported;
	}
	public void setReported(int reported) {
		this.reported = reported;
	}
	@Override
	public boolean equals(Object obj) {
		ConstructionSchedule schedule = (ConstructionSchedule)obj;
		if(this.getProjectUnit().equals(schedule.getProjectUnit()))
			return true;
		return false;
	}
}
