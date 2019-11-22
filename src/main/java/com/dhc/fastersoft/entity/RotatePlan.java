package com.dhc.fastersoft.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;
import cn.afterturn.easypoi.excel.annotation.ExcelCollection;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;


public class RotatePlan {
	private String id;
	@Excel(name="经办人",needMerge = true )
	private String colletor;
	@Excel(name="经办部门",needMerge = true)
	private String department;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@Excel(name="经办时间",exportFormat="yyyy-MM-dd",needMerge = true)
	private Date colletorDate;

	private String modifier;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date modifyDate;
	private String planName;
	private String planType;
	private String documentNumber;
	private String year;
	private String attachment;
	private String state;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date completeDate;
	private String description;
	//private Double stockIn;
	//private Double stockOut;
	private BigDecimal stockIn;
	private BigDecimal stockOut;
	private String planmainID;
	private BigDecimal inDealQuantiy;//入库已成交数量
	private BigDecimal inUnDealQuantiy;//入库未已成交数量
	private BigDecimal outDealQuantiy;//出库已成交数量
	private BigDecimal outUnDealQuantiy;//出库未已成交数量
	private List<RotatePlanDetail> planDetail;
	@ExcelCollection(name = "计划明细")
	private List<RotatePlanDetailForExcel> planDetailForExcels;//用于导出excel的


	public BigDecimal getStockIn() {
		return stockIn;
	}

	public void setStockIn(BigDecimal stockIn) {
		this.stockIn = stockIn;
	}

	public BigDecimal getStockOut() {
		return stockOut;
	}

	public void setStockOut(BigDecimal stockOut) {
		this.stockOut = stockOut;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getColletor() {
		return colletor;
	}
	public void setColletor(String colletor) {
		this.colletor = colletor;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public Date getColletorDate() {
		return colletorDate;
	}
	public void setColletorDate(Date colletorDate) {
		this.colletorDate = colletorDate;
	}
	public String getModifier() {
		return modifier;
	}
	public void setModifier(String modifier) {
		this.modifier = modifier;
	}
	public Date getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getPlanName() {
		return planName;
	}
	public void setPlanName(String planName) {
		this.planName = planName;
	}
	public String getPlanType() {
		return planType;
	}
	public void setPlanType(String planType) {
		this.planType = planType;
	}
	public String getDocumentNumber() {
		return documentNumber;
	}
	public void setDocumentNumber(String documentNumber) {
		this.documentNumber = documentNumber;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getAttachment() {
		return attachment;
	}
	public void setAttachment(String attachment) {
		this.attachment = attachment;
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
	public List<RotatePlanDetail> getPlanDetail() {
		return planDetail;
	}
	public void setPlanDetail(List<RotatePlanDetail> planDetail) {
		this.planDetail = planDetail;
	}
	public List<RotatePlanDetailForExcel> getPlanDetailForExcels() {
		return planDetailForExcels;
	}
	public void setPlanDetailForExcels(List<RotatePlanDetailForExcel> planDetailForExcels) {
		this.planDetailForExcels = planDetailForExcels;
	}
	public String getPlanmainID() {
		return planmainID;
	}
	public void setPlanmainID(String planmainID) {
		this.planmainID = planmainID;
	}

	public BigDecimal getInDealQuantiy() {
		return inDealQuantiy;
	}

	public void setInDealQuantiy(BigDecimal inDealQuantiy) {
		this.inDealQuantiy = inDealQuantiy;
	}

	public BigDecimal getOutDealQuantiy() {
		return outDealQuantiy;
	}

	public void setOutDealQuantiy(BigDecimal outDealQuantiy) {
		this.outDealQuantiy = outDealQuantiy;
	}

	public BigDecimal getInUnDealQuantiy() {
		return inUnDealQuantiy;
	}

	public void setInUnDealQuantiy(BigDecimal inUnDealQuantiy) {
		this.inUnDealQuantiy = inUnDealQuantiy;
	}

	public BigDecimal getOutUnDealQuantiy() {
		return outUnDealQuantiy;
	}

	public void setOutUnDealQuantiy(BigDecimal outUnDealQuantiy) {
		this.outUnDealQuantiy = outUnDealQuantiy;
	}
}
