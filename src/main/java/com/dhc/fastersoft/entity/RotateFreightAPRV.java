package com.dhc.fastersoft.entity;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

public class RotateFreightAPRV {
	private String id;
	private String grainType;
	private String totalQuantity;

	private String totalBulk;

	private String totalPackage;

	private String totalFreight;

	private String totalOtherFee;

	private String totalBoardFee;

	private String totalWarehouseFee;
	private String totalFee;

	private String status;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date reportDate;
	private String reporter;
	private String reportUnit;
	private String reportId;
	private String reportUnitAddress;
	private String gatherId;
	private String company;
	private List<RotateFreightAPRVDetail> detailList;
	private String reporterId;
	private String warehouseId;    //库名id
	public String getWarehouseId() {
		return warehouseId;
	}

	public void setWarehouseId(String warehouseId) {
		this.warehouseId = warehouseId;
	}

	public String getReportId() {
		return reportId;
	}

	public void setReportId(String reportId) {
		this.reportId = reportId;
	}
	private String enterpriseId;

	public String getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(String enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	public String getReporterId() {
		return reporterId;
	}
	public void setReporterId(String reporterId) {
		this.reporterId = reporterId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGrainType() {
		return grainType;
	}
	public void setGrainType(String grainType) {
		this.grainType = grainType;
	}
	public String getTotalQuantity() {
		return totalQuantity;
	}
	public void setTotalQuantity(String totalQuantity) {
		this.totalQuantity = totalQuantity;
	}
	public String getTotalBulk() {
		return totalBulk;
	}
	public void setTotalBulk(String totalBulk) {
		this.totalBulk = totalBulk;
	}
	public String getTotalPackage() {
		return totalPackage;
	}
	public void setTotalPackage(String totalPackage) {
		this.totalPackage = totalPackage;
	}
	public String getTotalFreight() {
		return totalFreight;
	}
	public void setTotalFreight(String totalFreight) {
		this.totalFreight = totalFreight;
	}
	public String getTotalOtherFee() {
		return totalOtherFee;
	}
	public void setTotalOtherFee(String totalOtherFee) {
		this.totalOtherFee = totalOtherFee;
	}
	public String getTotalBoardFee() {
		return totalBoardFee;
	}
	public void setTotalBoardFee(String totalBoardFee) {
		this.totalBoardFee = totalBoardFee;
	}
	public String getTotalWarehouseFee() {
		return totalWarehouseFee;
	}
	public void setTotalWarehouseFee(String totalWarehouseFee) {
		this.totalWarehouseFee = totalWarehouseFee;
	}
	public String getTotalFee() {
		return totalFee;
	}
	public void setTotalFee(String totalFee) {
		this.totalFee = totalFee;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getReportDate() {
		return reportDate;
	}
	public void setReportDate(Date reportDate) {
		this.reportDate = reportDate;
	}

	public String getReporter() {
		return reporter;
	}
	public void setReporter(String reporter) {
		this.reporter = reporter;
	}
	public String getReportUnit() {
		return reportUnit;
	}
	public void setReportUnit(String reportUnit) {
		this.reportUnit = reportUnit;
	}
	public List<RotateFreightAPRVDetail> getDetailList() {
		return detailList;
	}
	public void setDetailList(List<RotateFreightAPRVDetail> detailList) {
		this.detailList = detailList;
	}
	public String getReportUnitAddress() {
		return reportUnitAddress;
	}
	public void setReportUnitAddress(String reportUnitAddress) {
		this.reportUnitAddress = reportUnitAddress;
	}
	public String getGatherId() {
		return gatherId;
	}
	public void setGatherId(String gatherId) {
		this.gatherId = gatherId;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}


	
}
