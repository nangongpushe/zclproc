package com.dhc.fastersoft.entity;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import cn.afterturn.easypoi.excel.annotation.Excel;
import cn.afterturn.easypoi.excel.annotation.ExcelCollection;

public class ConstructionPlan {
	private String id;
	@Excel(name="经办人")
	private String operator;
	@Excel(name="经办部门")
	private String department;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@Excel(name="经办时间",format="yyyy-MM-dd")
	private Date handleTime;
	@Excel(name="年份")
	private String year;
	@Excel(name="项目单位")
	private String projectUnit;
	@Excel(name="总投资小计")
	private double investmentSubtotal;
	private String dataType;
	private String creator;
	private Date createDate;
	@Excel(name="备注")
	private String remark;
	private double investmentTotal;
	@Excel(name="上年支出小计")
	private double lastExpendSubtotal;
	private double lastExpendTotal;
	@Excel(name="上年投资小计")
	private double lastInvestmentSubtotal;
	private double lastInvestmentTotal;
	@Excel(name="本年支出小计")
	private double currentExpendSubtotal;
	private double currentExpendTotal;
	@Excel(name="本年投资小计")
	private double currentInvestmentSubtotal;
	private double currentInvestmentTotal;
	private String fromTarget;
	private String warehouseId;
	public String getWarehouseId() {
		return warehouseId;
	}
	public void setWarehouseId(String warehouseId) {
		this.warehouseId = warehouseId;
	}

	@ExcelCollection(name="年度计划明细")
	private List<ConstructionPlanDetail> planDetail;
	
	public List<ConstructionPlanDetail> getPlanDetail() {
		return planDetail;
	}
	public void setPlanDetail(List<ConstructionPlanDetail> planDetail) {
		this.planDetail = planDetail;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public Date getHandleTime() {
		return handleTime;
	}
	public void setHandleTime(Date handleTime) {
		this.handleTime = handleTime;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getProjectUnit() {
		return projectUnit;
	}
	public void setProjectUnit(String projectUnit) {
		this.projectUnit = projectUnit;
	}
	public double getInvestmentSubtotal() {
		return investmentSubtotal;
	}
	public void setInvestmentSubtotal(double investmentSubtotal) {
		this.investmentSubtotal = investmentSubtotal;
	}
	public String getDataType() {
		return dataType;
	}
	public void setDataType(String dataType) {
		this.dataType = dataType;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public double getInvestmentTotal() {
		return investmentTotal;
	}
	public void setInvestmentTotal(double investmentTotal) {
		this.investmentTotal = investmentTotal;
	}
	public double getLastExpendSubtotal() {
		return lastExpendSubtotal;
	}
	public void setLastExpendSubtotal(double lastExpendSubtotal) {
		this.lastExpendSubtotal = lastExpendSubtotal;
	}
	public double getLastExpendTotal() {
		return lastExpendTotal;
	}
	public void setLastExpendTotal(double lastExpendTotal) {
		this.lastExpendTotal = lastExpendTotal;
	}
	public double getLastInvestmentSubtotal() {
		return lastInvestmentSubtotal;
	}
	public void setLastInvestmentSubtotal(double lastInvestmentSubtotal) {
		this.lastInvestmentSubtotal = lastInvestmentSubtotal;
	}
	public double getLastInvestmentTotal() {
		return lastInvestmentTotal;
	}
	public void setLastInvestmentTotal(double lastInvestmentTotal) {
		this.lastInvestmentTotal = lastInvestmentTotal;
	}
	public double getCurrentExpendSubtotal() {
		return currentExpendSubtotal;
	}
	public void setCurrentExpendSubtotal(double currentExpendSubtotal) {
		this.currentExpendSubtotal = currentExpendSubtotal;
	}
	public double getCurrentExpendTotal() {
		return currentExpendTotal;
	}
	public void setCurrentExpendTotal(double currentExpendTotal) {
		this.currentExpendTotal = currentExpendTotal;
	}
	public double getCurrentInvestmentSubtotal() {
		return currentInvestmentSubtotal;
	}
	public void setCurrentInvestmentSubtotal(double currentInvestmentSubtotal) {
		this.currentInvestmentSubtotal = currentInvestmentSubtotal;
	}
	public double getCurrentInvestmentTotal() {
		return currentInvestmentTotal;
	}
	public void setCurrentInvestmentTotal(double currentInvestmentTotal) {
		this.currentInvestmentTotal = currentInvestmentTotal;
	}
	public String getFromTarget() {
		return fromTarget;
	}
	public void setFromTarget(String fromTarget) {
		this.fromTarget = fromTarget;
	}
	
	@Override
	public boolean equals(Object obj) {
		ConstructionPlan plan = (ConstructionPlan)obj;
		if(this.getProjectUnit().equals(plan.getProjectUnit()))
			return true;
		return false;
	}
	
	
}
