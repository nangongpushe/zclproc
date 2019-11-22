package com.dhc.fastersoft.vo;

import java.math.BigDecimal;

public class KCTJChartsVO {
	
	private String reportWarehouse;	//库点
	
	private String variety;			//品种
	
	private BigDecimal quantityTotal;//数量
	
	private BigDecimal advisedTotal;  //宜数量存
	
	private BigDecimal slightlyTotal; //轻度不适宜存放数量
	
	private BigDecimal severeTotal;		//重度不适宜存放数量

	private String warehouseType;		//库点类型(代储库/储备库)

	private String orderNo;		//库点序列号

	public String getReportWarehouse() {
		return reportWarehouse;
	}

	public void setReportWarehouse(String reportWarehouse) {
		this.reportWarehouse = reportWarehouse;
	}

	public String getVariety() {
		return variety;
	}

	public void setVariety(String variety) {
		this.variety = variety;
	}

	public BigDecimal getQuantityTotal() {
		return quantityTotal;
	}

	public void setQuantityTotal(BigDecimal quantityTotal) {
		this.quantityTotal = quantityTotal;
	}

	public BigDecimal getAdvisedTotal() {
		return advisedTotal;
	}

	public void setAdvisedTotal(BigDecimal advisedTotal) {
		this.advisedTotal = advisedTotal;
	}

	public BigDecimal getSlightlyTotal() {
		return slightlyTotal;
	}

	public void setSlightlyTotal(BigDecimal slightlyTotal) {
		this.slightlyTotal = slightlyTotal;
	}

	public BigDecimal getSevereTotal() {
		return severeTotal;
	}

	public void setSevereTotal(BigDecimal severeTotal) {
		this.severeTotal = severeTotal;
	}

	public String getWarehouseType() {
		return warehouseType;
	}

	public void setWarehouseType(String warehouseType) {
		this.warehouseType = warehouseType;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

}
