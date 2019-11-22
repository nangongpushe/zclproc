package com.dhc.fastersoft.entity;

import java.util.Date;

import cn.afterturn.easypoi.excel.annotation.Excel;

public class ConstructionFunds {
	private String id;
	@Excel(name="项目编号")
	private String projectSerial;
	@Excel(name="项目单位")
	private String projectUnit;
	@Excel(name="项目名称")
	private String projectName;
	@Excel(name="经办人")
	private String operator;
	@Excel(name="申报时间")
	private String reportTime;
	@Excel(name="申报单位")
	private String reportUnit;
	@Excel(name="申报部门")
	private String reportDept;
	@Excel(name="工程总投资额(万元)")
	private String investmentTotal;
	@Excel(name="已预拨数（万元）")
	private Double alreadyDialed;
	@Excel(name="工程进度")
	private String process;
	@Excel(name="本次申请拨款额(大写)")
	private String thisAppropriation;
	private String contractor;
	private String status;
	private double thisAppropriationLittle;
	private double investmentTotalLittle;
	private Date createTime;
	public String getWarehouseId() {
		return warehouseId;
	}
	public void setWarehouseId(String warehouseId) {
		this.warehouseId = warehouseId;
	}
	public String getProjectId() {
		return projectId;
	}
	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}

	private String warehouseId;
	private String projectId;

	private ConstructionProject parentProject;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getProjectSerial() {
		return projectSerial;
	}
	public void setProjectSerial(String projectSerial) {
		this.projectSerial = projectSerial;
	}
	public String getProjectUnit() {
		return projectUnit;
	}
	public void setProjectUnit(String projectUnit) {
		this.projectUnit = projectUnit;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getReportTime() {
		return reportTime;
	}
	public void setReportTime(String reportTime) {
		this.reportTime = reportTime;
	}
	public String getReportUnit() {
		return reportUnit;
	}
	public void setReportUnit(String reportUnit) {
		this.reportUnit = reportUnit;
	}
	public String getReportDept() {
		return reportDept;
	}
	public void setReportDept(String reportDept) {
		this.reportDept = reportDept;
	}
	public String getInvestmentTotal() {
		return investmentTotal;
	}
	public void setInvestmentTotal(String investmentTotal) {
		this.investmentTotal = investmentTotal;
	}
	public Double getAlreadyDialed() {
		return alreadyDialed;
	}
	public void setAlreadyDialed(Double alreadyDialed) {
		this.alreadyDialed = alreadyDialed;
	}
	public String getProcess() {
		return process;
	}
	public void setProcess(String process) {
		this.process = process;
	}
	public String getThisAppropriation() {
		return thisAppropriation;
	}
	public void setThisAppropriation(String thisAppropriation) {
		this.thisAppropriation = thisAppropriation;
	}
	public String getContractor() {
		return contractor;
	}
	public void setContractor(String contractor) {
		this.contractor = contractor;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public double getThisAppropriationLittle() {
		return thisAppropriationLittle;
	}
	public void setThisAppropriationLittle(double thisAppropriationLittle) {
		this.thisAppropriationLittle = thisAppropriationLittle;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public double getInvestmentTotalLittle() {
		return investmentTotalLittle;
	}

	public void setInvestmentTotalLittle(double investmentTotalLittle) {
		this.investmentTotalLittle = investmentTotalLittle;
	}

	public ConstructionProject getParentProject() {
		return parentProject;
	}

	public void setParentProject(ConstructionProject parentProject) {
		this.parentProject = parentProject;
	}
}
