package com.dhc.fastersoft.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.omg.CosNaming.NamingContextExtPackage.StringNameHelper;
import org.springframework.format.annotation.DateTimeFormat;

import cn.afterturn.easypoi.excel.annotation.Excel;
import cn.afterturn.easypoi.excel.annotation.ExcelCollection;


public class RotateConclute {
	private String id;
	@Excel(name="成交明细号",needMerge = true)
	private String dealSerial;
	@Excel(name="品种",needMerge = true)
	private String grainType;
	@Excel(name="招标类别",needMerge = true)
	private String inviteType;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Excel(name="竞价交易时间",exportFormat="yyyy-MM-dd",needMerge = true)
	private Date dealDate;
	private String unit;
	private String gatherUnit;
	private String gather;
	private String gather1;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date gatherDate;
	private String remark;
	@Excel(name="数量合计(吨)",needMerge = true)
	private String totalQuantity;
	@Excel(name="成交价格合计(元/吨)",needMerge = true)
	private BigDecimal dealPriceTotal;
	@Excel(name="成交金额合计(元)",needMerge = true)
	private BigDecimal dealAmountTotal;
	@ExcelCollection(name = "成交子明细")
	private List<RotateConcluteDetail> detailList;
	private String status;
	
	private String dealDateStr;
	private String gatherDateStr;

	private String inviteId;

	public String getInviteId() {
		return inviteId;
	}

	public void setInviteId(String inviteId) {
		this.inviteId = inviteId;
	}

	public String getGather1() {
		return gather1;
	}

	public void setGather1(String gather1) {
		this.gather1 = gather1;
	}
	public String getDealDateStr() {
		return dealDateStr;
	}
	public void setDealDateStr(String dealDateStr) {
		this.dealDateStr = dealDateStr;
	}
	public String getGatherDateStr() {
		return gatherDateStr;
	}
	public void setGatherDateStr(String gatherDateStr) {
		this.gatherDateStr = gatherDateStr;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDealSerial() {
		return dealSerial;
	}
	public void setDealSerial(String dealSerial) {
		this.dealSerial = dealSerial;
	}
	public String getGrainType() {
		return grainType;
	}
	public void setGrainType(String grainType) {
		this.grainType = grainType;
	}
	public String getInviteType() {
		return inviteType;
	}
	public void setInviteType(String inviteType) {
		this.inviteType = inviteType;
	}
	public Date getDealDate() {
		return dealDate;
	}
	public void setDealDate(Date dealDate) {
		this.dealDate = dealDate;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getGatherUnit() {
		return gatherUnit;
	}
	public void setGatherUnit(String gatherUnit) {
		this.gatherUnit = gatherUnit;
	}
	public String getGather() {
		return gather;
	}
	public void setGather(String gather) {
		this.gather = gather;
	}
	public Date getGatherDate() {
		return gatherDate;
	}
	public void setGatherDate(Date gatherDate) {
		this.gatherDate = gatherDate;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public String getTotalQuantity() {
		return totalQuantity;
	}
	public void setTotalQuantity(String totalQuantity) {
		this.totalQuantity = totalQuantity;
	}

	public BigDecimal getDealPriceTotal() {
		return dealPriceTotal;
	}

	public void setDealPriceTotal(BigDecimal dealPriceTotal) {
		this.dealPriceTotal = dealPriceTotal;
	}

	public BigDecimal getDealAmountTotal() {
		return dealAmountTotal;
	}

	public void setDealAmountTotal(BigDecimal dealAmountTotal) {
		this.dealAmountTotal = dealAmountTotal;
	}

	public List<RotateConcluteDetail> getDetailList() {
		return detailList;
	}
	public void setDetailList(List<RotateConcluteDetail> detailList) {
		this.detailList = detailList;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "RotateConclute{" +
				"id='" + id + '\'' +
				", dealSerial='" + dealSerial + '\'' +
				", grainType='" + grainType + '\'' +
				", inviteType='" + inviteType + '\'' +
				", dealDate=" + dealDate +
				", unit='" + unit + '\'' +
				", gatherUnit='" + gatherUnit + '\'' +
				", gather='" + gather + '\'' +
				", gather1='" + gather1 + '\'' +
				", gatherDate=" + gatherDate +
				", remark='" + remark + '\'' +
				", totalQuantity='" + totalQuantity + '\'' +
				", dealPriceTotal=" + dealPriceTotal +
				", dealAmountTotal=" + dealAmountTotal +
				", detailList=" + detailList +
				", status='" + status + '\'' +
				", dealDateStr='" + dealDateStr + '\'' +
				", gatherDateStr='" + gatherDateStr + '\'' +
				'}';
	}
}
