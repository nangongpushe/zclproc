package com.dhc.fastersoft.entity;

import java.util.Date;
import java.util.List;

import org.omg.CosNaming.NamingContextExtPackage.StringNameHelper;
import org.springframework.format.annotation.DateTimeFormat;


public class RotatePaymentDetail {
	private String id;
	private String paymentId;
	private String schemeName;
	private String bidSerial;
	private String grainType;
	private String quantity;
	private String price;
	private String amount;
	private String concluteId;

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPaymentId() {
		return paymentId;
	}
	public void setPaymentId(String paymentId) {
		this.paymentId = paymentId;
	}
	public String getSchemeName() {
		return schemeName;
	}
	public void setSchemeName(String schemeName) {
		this.schemeName = schemeName;
	}
	public String getBidSerial() {
		return bidSerial;
	}
	public void setBidSerial(String bidSerial) {
		this.bidSerial = bidSerial;
	}
	public String getGrainType() {
		return grainType;
	}
	public void setGrainType(String grainType) {
		this.grainType = grainType;
	}
	public String getQuantity() {
		return quantity;
	}
	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getConcluteId() {
		return concluteId;
	}

	public void setConcluteId(String concluteId) {
		this.concluteId = concluteId;
	}
}
