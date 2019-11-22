package com.dhc.fastersoft.entity;

import java.math.BigDecimal;
import java.util.Date;

/**
* @ClassName: StorageWarehouse
* @Description: 库点管理
* 
*/

public class StorageWarehouse {
    private String id;

    private String warehouseCode;

    private String warehouseName;

    private String warehouseShort;

    private String warehouseNature;

    private String warehouseType;

    private String completionDate;

    private BigDecimal storageCapacity;

    private BigDecimal acreage;

    private String telphone;

    private String fax;

    private String province;

    private String provinceCode;

    private String city;

    private String cityCode;

    private String area;

    private String areaCode;

    private String address;

    private String longitude;

    private String latitude;

    private String postalcode;

    private String isHost;  //是否是主库


    private String isStop;  //是否停用

    private String orderNo;

    //联系人
    private String contacts;
    //联系电话
    private String contactNumber;

    private Integer isInput;

    public String getIsStop() {
        return isStop;
    }

    public void setIsStop(String isStop) {
        this.isStop = isStop;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getIsHost() {
        return isHost;
    }

    public void setIsHost(String isHost) {
        this.isHost = isHost;
    }

    private String creator;
    private String creatorId;

    public String getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(String creatorId) {
        this.creatorId = creatorId;
    }

    private Date createDate;

    private String remark;

    private String enterpriseName;

    private String organizationCode;
    private String enterpriseId;

    public String getEnterpriseId() {
        return enterpriseId;
    }

    public void setEnterpriseId(String enterpriseId) {
        this.enterpriseId = enterpriseId;
    }

    private String socialCreditCode;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getWarehouseCode() {
        return warehouseCode;
    }

    public void setWarehouseCode(String warehouseCode) {
        this.warehouseCode = warehouseCode;
    }

    public String getWarehouseName() {
        return warehouseName;
    }

    public void setWarehouseName(String warehouseName) {
        this.warehouseName = warehouseName;
    }

    public String getWarehouseShort() {
        return warehouseShort;
    }

    public void setWarehouseShort(String warehouseShort) {
        this.warehouseShort = warehouseShort;
    }

    public String getWarehouseNature() {
        return warehouseNature;
    }

    public void setWarehouseNature(String warehouseNature) {
        this.warehouseNature = warehouseNature;
    }

    public String getWarehouseType() {
        return warehouseType;
    }

    public void setWarehouseType(String warehouseType) {
        this.warehouseType = warehouseType;
    }

    public String getCompletionDate() {
        return completionDate;
    }

    public void setCompletionDate(String completionDate) {
        this.completionDate = completionDate;
    }

    public BigDecimal getStorageCapacity() {
        return storageCapacity;
    }

    public void setStorageCapacity(BigDecimal storageCapacity) {
        this.storageCapacity = storageCapacity;
    }

    public BigDecimal getAcreage() {
        return acreage;
    }

    public void setAcreage(BigDecimal acreage) {
        this.acreage = acreage;
    }

    public String getTelphone() {
        return telphone;
    }

    public void setTelphone(String telphone) {
        this.telphone = telphone;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getProvinceCode() {
        return provinceCode;
    }

    public void setProvinceCode(String provinceCode) {
        this.provinceCode = provinceCode;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCityCode() {
        return cityCode;
    }

    public void setCityCode(String cityCode) {
        this.cityCode = cityCode;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getAreaCode() {
        return areaCode;
    }

    public void setAreaCode(String areaCode) {
        this.areaCode = areaCode;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public String getPostalcode() {
        return postalcode;
    }

    public void setPostalcode(String postalcode) {
        this.postalcode = postalcode;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getEnterpriseName() {
        return enterpriseName;
    }

    public void setEnterpriseName(String enterpriseName) {
        this.enterpriseName = enterpriseName == null ? null : enterpriseName.trim();
    }

    public String getOrganizationCode() {
        return organizationCode;
    }

    public void setOrganizationCode(String organizationCode) {
        this.organizationCode = organizationCode == null ? null : organizationCode.trim();
    }

    public String getSocialCreditCode() {
        return socialCreditCode;
    }

    public void setSocialCreditCode(String socialCreditCode) {
        this.socialCreditCode = socialCreditCode == null ? null : socialCreditCode.trim();
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

    public Integer getIsInput() {
        return isInput;
    }

    public void setIsInput(Integer isInput) {
        this.isInput = isInput;
    }

    public StorageWarehouse() {
	}

	public StorageWarehouse(String id, String warehouseName, String warehouseShort) {
		this.id = id;
		this.warehouseName = warehouseName;
		this.warehouseShort = warehouseShort;
	}

	@Override
	public String toString() {
		return "StorageWarehouse [id=" + id + ", warehouseCode=" + warehouseCode + ", warehouseName=" + warehouseName
				+ ", warehouseShort=" + warehouseShort + ", warehouseNature=" + warehouseNature + ", warehouseType="
				+ warehouseType + ", completionDate=" + completionDate + ", storageCapacity=" + storageCapacity
				+ ", acreage=" + acreage + ", telphone=" + telphone + ", fax=" + fax + ", province=" + province
				+ ", provinceCode=" + provinceCode + ", city=" + city + ", cityCode=" + cityCode + ", area=" + area
				+ ", areaCode=" + areaCode + ", address=" + address + ", longitude=" + longitude + ", latitude="
				+ latitude + ", postalcode=" + postalcode + ", creator=" + creator + ", createDate=" + createDate
				+ ", remark=" + remark + ", enterpriseName=" + enterpriseName + ", organizationCode=" + organizationCode
				+ ", socialCreditCode=" + socialCreditCode + "]";
	}
}