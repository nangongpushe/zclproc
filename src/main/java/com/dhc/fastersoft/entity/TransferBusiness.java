package com.dhc.fastersoft.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import cn.afterturn.easypoi.excel.annotation.Excel;
import cn.afterturn.easypoi.excel.annotation.ExcelCollection;

public class TransferBusiness {
	private String id;
	@Excel(name="单位名称")
	private String unitName;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@Excel(name="中转日期",format="yyyy-MM-dd")
	private Date transferDate;
	@Excel(name="上报时间",format="yyyy-MM-dd")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date reportTime;
	@Excel(name="状态")
	private String status;
	@Excel(name="中转收入合计(万元)")
	private BigDecimal totalIncome;
	@Excel(name="中转支出合计(万元)")
	private BigDecimal totalExpend;
	@Excel(name="中转总利润(万元)")
	private BigDecimal totalProfits;
	@Excel(name="经办人")
	private String creator;
	@Excel(name="备注")
	private String remark;
	private BigDecimal totalCount;
	@ExcelCollection(name="中转明细列表")
	private List<TransferBusinessDetail> transferDetail;
	

	public List<TransferBusinessDetail> getTransferDetail() {
		return transferDetail;
	}
	public void setTransferDetail(List<TransferBusinessDetail> transferDetail) {
		this.transferDetail = transferDetail;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUnitName() {
		return unitName;
	}
	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}
	public Date getTransferDate() {
		return transferDate;
	}
	public void setTransferDate(Date transferDate) {
		this.transferDate = transferDate;
	}
	public Date getReportTime() {
		return reportTime;
	}
	public void setReportTime(Date reportTime) {
		this.reportTime = reportTime;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

	public BigDecimal getTotalIncome() {
		return totalIncome;
	}

	public void setTotalIncome(BigDecimal totalIncome) {
		this.totalIncome = totalIncome;
	}

	public BigDecimal getTotalExpend() {
		return totalExpend;
	}

	public void setTotalExpend(BigDecimal totalExpend) {
		this.totalExpend = totalExpend;
	}

	public BigDecimal getTotalProfits() {
		return totalProfits;
	}

	public void setTotalProfits(BigDecimal totalProfits) {
		this.totalProfits = totalProfits;
	}

	public BigDecimal getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(BigDecimal totalCount) {
		this.totalCount = totalCount;
	}

	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
}
