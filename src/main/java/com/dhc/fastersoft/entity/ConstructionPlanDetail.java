package com.dhc.fastersoft.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;

public class ConstructionPlanDetail {
	private String id;
	private String planId;
	@Excel(name="序号",isImportField="true")
	private int serial;
	@Excel(name="项目名称",isImportField="true")
	private String projectName;
	@Excel(name="建设内容",isImportField="true")
	private String constructionContent;
	@Excel(name="建设年限起",isImportField="true")
	private String constructionStart;
	@Excel(name="建设年限止",isImportField="true")
	private String constructionEnd;
	@Excel(name="建设性质",isImportField="true")
	private String constructionNature;
	@Excel(name="总投资(万元)",isImportField="true")
	private double investment;
	@Excel(name="资金来源",isImportField="true")
	private String fundsProvid;
	@Excel(name="(上年)财务支出(万元)",isImportField="true")
	private double lastExpend;
	@Excel(name="(上年)投资额(万元)",isImportField="true")
	private double lastInvestment;
	@Excel(name="(本年)财务支出(万元)",isImportField="true")
	private double currentExpend;
	@Excel(name="(本年)投资额(万元)",isImportField="true")
	private double currentInvestment;
	@Excel(name="(本年)形象进度",isImportField="true")
	private String currentProgress;
	@Excel(name="备注",isImportField="true")
	private String remark;
	private String projectId;

	public String getProjectId() {
		return projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPlanId() {
		return planId;
	}
	public void setPlanId(String planId) {
		this.planId = planId;
	}
	public int getSerial() {
		return serial;
	}
	public void setSerial(int serial) {
		this.serial = serial;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getConstructionContent() {
		return constructionContent;
	}
	public void setConstructionContent(String constructionContent) {
		this.constructionContent = constructionContent;
	}
	public String getConstructionStart() {
		return constructionStart;
	}
	public void setConstructionStart(String constructionStart) {
		this.constructionStart = constructionStart;
	}
	public String getConstructionEnd() {
		return constructionEnd;
	}
	public void setConstructionEnd(String constructionEnd) {
		this.constructionEnd = constructionEnd;
	}
	public String getConstructionNature() {
		return constructionNature;
	}
	public void setConstructionNature(String constructionNature) {
		this.constructionNature = constructionNature;
	}
	public double getInvestment() {
		return investment;
	}
	public void setInvestment(double investment) {
		this.investment = investment;
	}
	public String getFundsProvid() {
		return fundsProvid;
	}
	public void setFundsProvid(String fundsProvid) {
		this.fundsProvid = fundsProvid;
	}
	public double getLastExpend() {
		return lastExpend;
	}
	public void setLastExpend(double lastExpend) {
		this.lastExpend = lastExpend;
	}
	public double getLastInvestment() {
		return lastInvestment;
	}
	public void setLastInvestment(double lastInvestment) {
		this.lastInvestment = lastInvestment;
	}
	public double getCurrentExpend() {
		return currentExpend;
	}
	public void setCurrentExpend(double currentExpend) {
		this.currentExpend = currentExpend;
	}
	public double getCurrentInvestment() {
		return currentInvestment;
	}
	public void setCurrentInvestment(double currentInvestment) {
		this.currentInvestment = currentInvestment;
	}
	public String getCurrentProgress() {
		return currentProgress;
	}
	public void setCurrentProgress(String currentProgress) {
		this.currentProgress = currentProgress;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
}
