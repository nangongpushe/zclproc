package com.dhc.fastersoft.entity;


public class RotateFreightDetail {
	private String id;
	private String tenders;
	private String dealSerial;
	private String shipType;
	private String deliveryAddress;
	private String receiveAddress;
	private double distance;
	private double planNumber;
	private String groupId;
	private String clientName;
	private String clientId;
	private String price;
	private String remark;
	private String freightId;
	private String inviteType;
	private String fileName;

	public String getClientId() {
		return clientId;
	}

	public void setClientId(String clientId) {
		this.clientId = clientId;
	}

	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTenders() {
		return tenders;
	}
	public void setTenders(String tenders) {
		this.tenders = tenders;
	}
	public String getDealSerial() {
		return dealSerial;
	}
	public void setDealSerial(String dealSerial) {
		this.dealSerial = dealSerial;
	}
	public String getShipType() {
		return shipType;
	}
	public void setShipType(String shipType) {
		this.shipType = shipType;
	}
	public String getDeliveryAddress() {
		return deliveryAddress;
	}
	public void setDeliveryAddress(String deliveryAddress) {
		this.deliveryAddress = deliveryAddress;
	}
	public String getReceiveAddress() {
		return receiveAddress;
	}
	public void setReceiveAddress(String receiveAddress) {
		this.receiveAddress = receiveAddress;
	}

	public double getDistance() {
		return distance;
	}

	public void setDistance(double distance) {
		this.distance = distance;
	}

	public double getPlanNumber() {
		return planNumber;
	}

	public void setPlanNumber(double planNumber) {
		this.planNumber = planNumber;
	}



	public String getGroupId() {
		return groupId;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	public String getClientName() {
		return clientName;
	}
	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getFreightId() {
		return freightId;
	}
	public void setFreightId(String freightId) {
		this.freightId = freightId;
	}
	public String getInviteType() {
		return inviteType;
	}
	public void setInviteType(String inviteType) {
		this.inviteType = inviteType;
	}


	@Override
	public String toString() {
		return "RotateFreightDetail{" +
				"id='" + id + '\'' +
				", tenders='" + tenders + '\'' +
				", dealSerial='" + dealSerial + '\'' +
				", shipType='" + shipType + '\'' +
				", deliveryAddress='" + deliveryAddress + '\'' +
				", receiveAddress='" + receiveAddress + '\'' +
				", distance=" + distance +
				", planNumber=" + planNumber +
				", groupId='" + groupId + '\'' +
				", clientName='" + clientName + '\'' +
				", clientId='" + clientId + '\'' +
				", price='" + price + '\'' +
				", remark='" + remark + '\'' +
				", freightId='" + freightId + '\'' +
				", inviteType='" + inviteType + '\'' +
				", fileName='" + fileName + '\'' +
				'}';
	}
}
