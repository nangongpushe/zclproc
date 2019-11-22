package com.dhc.fastersoft.entity;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import cn.afterturn.easypoi.excel.annotation.Excel;

public class RotateTake {
	private String id;
	private String mainId;
	private String serial;
	private String reserveUnit;
	private String reserveId;	// 库点id
	private String reserveTel;
	private String buyer;
	private String ton;
	private String creater;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date createDate;
	private String status;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date completeDate;
	private String dealSerial;
	@Excel(name="仓号")
	private String storeEncode;
	@Excel(name="品种")
	private String variety;
	@Excel(name="合同数量(吨)")
	private String contract;
	@Excel(name="已开提货单(吨)")
	private String ladingBills;
	@Excel(name="本次发货(吨)")
	private String thisShipment;
	@Excel(name="累计已开提货单(吨)")
	private String accumulatedBills;
	private String takeEnd;
	@Excel(name="粮食单价(元/吨)")
	private String unitPrice;
	@Excel(name="存储方式")
	private String storageMode;
	@Excel(name="接收单位")
	private String acceptanceUnit;
	private String acceptanceUnitId;
	@Excel(name="单位联系方式")
	private String telephone;

	private String contacts;//库点联系人
	private	 String contactNumber;//库点联系电话
	public String getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(String unitPrice) {
		this.unitPrice = unitPrice;
	}

	public String getStorageMode() {
		return storageMode;
	}

	public void setStorageMode(String storageMode) {
		this.storageMode = storageMode;
	}

	public String getAcceptanceUnit() {
		return acceptanceUnit;
	}

	public void setAcceptanceUnit(String acceptanceUnit) {
		this.acceptanceUnit = acceptanceUnit;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public String getMainId() {
		return mainId;
	}

	public void setMainId(String mainId) {
		this.mainId = mainId;
	}

	public String getSerial() {
		return serial;
	}
	public void setSerial(String serial) {
		this.serial = serial;
	}
	public String getReserveUnit() {
		return reserveUnit;
	}
	public void setReserveUnit(String reserveUnit) {
		this.reserveUnit = reserveUnit;
	}
	public String getReserveTel() {
		return reserveTel;
	}
	public void setReserveTel(String reserveTel) {
		this.reserveTel = reserveTel;
	}
	public String getBuyer() {
		return buyer;
	}
	public void setBuyer(String buyer) {
		this.buyer = buyer;
	}
	public String getTon() {
		return ton;
	}
	public void setTon(String ton) {
		this.ton = ton;
	}
	public String getCreater() {
		return creater;
	}
	public void setCreater(String creater) {
		this.creater = creater;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getCompleteDate() {
		return completeDate;
	}
	public void setCompleteDate(Date completeDate) {
		this.completeDate = completeDate;
	}
	public String getDealSerial() {
		return dealSerial;
	}
	public void setDealSerial(String dealSerial) {
		this.dealSerial = dealSerial;
	}
	public String getStoreEncode() {
		return storeEncode;
	}
	public void setStoreEncode(String storeEncode) {
		this.storeEncode = storeEncode;
	}
	public String getVariety() {
		return variety;
	}
	public void setVariety(String variety) {
		this.variety = variety;
	}
	public String getContract() {
		return contract;
	}
	public void setContract(String contract) {
		this.contract = contract;
	}
	public String getLadingBills() {
		return ladingBills;
	}
	public void setLadingBills(String ladingBills) {
		this.ladingBills = ladingBills;
	}
	public String getThisShipment() {
		return thisShipment;
	}
	public void setThisShipment(String thisShipment) {
		this.thisShipment = thisShipment;
	}
	public String getAccumulatedBills() {
		return accumulatedBills;
	}
	public void setAccumulatedBills(String accumulatedBills) {
		this.accumulatedBills = accumulatedBills;
	}
	public String getTakeEnd() {
		return takeEnd;
	}
	public void setTakeEnd(String takeEnd) {
		this.takeEnd = takeEnd;
	}
	
	public RotateTake(Date createDate) {
		this.createDate = createDate;
	}
	
	public RotateTake() {
	}

	public String getContacts() {
		return contacts;
	}

	public void setContacts(String contacts) {
		this.contacts = contacts;
	}

	public String getContactNumber() {
		return contactNumber;
	}

	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}

	public String getReserveId() {
		return reserveId;
	}

	public void setReserveId(String reserveId) {
		this.reserveId = reserveId;
	}

	public String getAcceptanceUnitId() {
		return acceptanceUnitId;
	}

	public void setAcceptanceUnitId(String acceptanceUnitId) {
		this.acceptanceUnitId = acceptanceUnitId;
	}
}
