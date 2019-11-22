package com.dhc.fastersoft.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;
import cn.afterturn.easypoi.excel.annotation.ExcelCollection;

import java.util.Date;
import java.util.List;

public class RotateScheme {
	private String id;
	@Excel(name="方案名称",needMerge = true)
	private String schemeName;
	@Excel(name="轮换类型",needMerge = true)
	private String schemeType;
	@Excel(name="轮换方式",needMerge = true)
	private String rotateType;
	private String originId;//原来的计划详情主表id
	private String planMainId;//后加的计划申报主表id
	@Excel(name="方案年份",needMerge = true)
	private String year;
	@Excel(name="经办部门",needMerge = true)
	private String department;
	@Excel(name="经办人",needMerge = true)
	private String creater;
	@Excel(name="经办时间",exportFormat="yyyy-MM-dd",needMerge = true)
	private Date createTime;
	private String modifier;
	private Date modifyTime;
	private String annex;
	private String state;
	private Date completeDate;
	@Excel(name="备注",needMerge = true)
	private String description;
	private int originType;
	private String executeState;
	private String isEnd;//是否终结
	@ExcelCollection(name = "方案明细")
	private List<RotateSchemeDetail> schemeDetail;

	public String getId() {
		return id;
	}
 
	public void setId(String id) {
		this.id = id;
	}

	public String getSchemeName() {
		return schemeName;
	}

	public void setSchemeName(String schemeName) {
		this.schemeName = schemeName;
	}

	public String getSchemeType() {
		return schemeType;
	}

	public void setSchemeType(String schemeType) {
		this.schemeType = schemeType;
	}

	public String getRotateType() {
		return rotateType;
	}

	public void setRotateType(String rotateType) {
		this.rotateType = rotateType;
	}

	public String getOriginId() {
		return originId;
	}

	public void setOriginId(String originId) {
		this.originId = originId;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getCreater() {
		return creater;
	}

	public void setCreater(String creater) {
		this.creater = creater;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getModifier() {
		return modifier;
	}

	public void setModifier(String modifier) {
		this.modifier = modifier;
	}

	public Date getModifyTime() {
		return modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}

	public String getAnnex() {
		return annex;
	}

	public void setAnnex(String annex) {
		this.annex = annex;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Date getCompleteDate() {
		return completeDate;
	}

	public void setCompleteDate(Date completeDate) {
		this.completeDate = completeDate;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getOriginType() {
		return originType;
	}

	public void setOriginType(int originType) {
		this.originType = originType;
	}

	public List<RotateSchemeDetail> getSchemeDetail() {
		return schemeDetail;
	}

	public void setSchemeDetail(List<RotateSchemeDetail> schemeDetail) {
		this.schemeDetail = schemeDetail;
	}

	public String getExecuteState() {
		return executeState;
	}

	public void setExecuteState(String executeState) {
		this.executeState = executeState;
	}

	public String getPlanMainId() {
		return planMainId;
	}

	public void setPlanMainId(String planMainId) {
		this.planMainId = planMainId;
	}

	public String getIsEnd() {
		return isEnd;
	}

	public void setIsEnd(String isEnd) {
		this.isEnd = isEnd;
	}

	@Override
	public String toString() {
		return "RotateScheme{" +
				"id='" + id + '\'' +
				", schemeName='" + schemeName + '\'' +
				", schemeType='" + schemeType + '\'' +
				", rotateType='" + rotateType + '\'' +
				", originId='" + originId + '\'' +
				", year='" + year + '\'' +
				", department='" + department + '\'' +
				", creater='" + creater + '\'' +
				", createTime=" + createTime +
				", modifier='" + modifier + '\'' +
				", modifyTime=" + modifyTime +
				", annex='" + annex + '\'' +
				", state='" + state + '\'' +
				", completeDate=" + completeDate +
				", description='" + description + '\'' +
				", originType=" + originType +
				", executeState='" + executeState + '\'' +
				", schemeDetail=" + schemeDetail +
				'}';
	}
}
