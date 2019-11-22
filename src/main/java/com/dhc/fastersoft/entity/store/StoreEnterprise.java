package com.dhc.fastersoft.entity.store;

import java.math.BigDecimal;

//代储_企业信息表
public class StoreEnterprise {
    private String id;			//主键ID

    private String enterpriseSerial;//代储企业编号

    private String enterpriseName;//企业名称

    private String shortName; //企业简称

    private String organizationCode;//组织机构代码(唯一)

    private String socialCreditCode;//统一社会信用代码

    private String economicType;//企业经济类型

    private String registType;//登记注册类型

    private String businessNo;//工商登记注册号

    private String seniority;//'是否具备中央储备粮代储资格

    private String personIncharge;//法定代表人

    private String address;//企业地址

    private String telephone;  //企业电话

    private String fax;		//企业传真

    private String email;	//企业电子邮箱

    private String website;	//企业网址

    private String postalcode;	//企业邮政编码

    private String province;	//省

    private String provinceCode;	//省代码

    private String city;	//市

    private String cityCode;	//市代码

    private String area;	//区
    private String provinceCityArea;	//区

    private String areaCode;	//区代码

    private String depositBank;	//开户行

    private String depositAccount;	//开户账号

    private String bankCreditRating;	//银行信用等级
  
    private BigDecimal fixedAssets;	//固定资产

    private BigDecimal registeredCapital;	//注册资本

    private BigDecimal assets;	//资产

    private Integer people; 	//企业从业人数

    private String creator;	//创建人
    private String creatorId;	//创建人

    private String createDate;	//创建时间

    private String remark;	//备注
    
    private String wareHouse;	//库点

	private String wareHouseId;	//库点
    
    private String mananger;	//库点负责人
    private String isMyself;	//
	private String isStop; //是否停用


	private String isInput; //是否输入框

	//联系人
	private String contacts;
	//联系电话
	private String contactNumber;



	private String enterpriseID;

	public String getEnterpriseID() {
		return enterpriseID;
	}

	public void setEnterpriseID(String enterpriseID) {
		this.enterpriseID = enterpriseID;
	}

	public String getIsInput() {
		return isInput;
	}

	public void setIsInput(String isInput) {
		this.isInput = isInput;
	}

	public String getIsStop() {
		return isStop;
	}

	public void setIsStop(String isStop) {
		this.isStop = isStop;
	}

	public String getIsMyself() {
		return isMyself;
	}

	public void setIsMyself(String isMyself) {
		this.isMyself = isMyself;
	}

	public String getWareHouse() {
		return wareHouse;
	}

	public void setWareHouse(String wareHouse) {
		this.wareHouse = wareHouse;
	}

	public String getMananger() {
		return mananger;
	}

	public void setMananger(String mananger) {
		this.mananger = mananger;
	}

	public String getCreatorId() {
		return creatorId;
	}

	public void setCreatorId(String creatorId) {
		this.creatorId = creatorId;
	}

	public String getProvinceCityArea() {
		return provinceCityArea;
	}

	public void setProvinceCityArea(String provinceCityArea) {
		this.provinceCityArea = provinceCityArea;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getEnterpriseSerial() {
		return enterpriseSerial;
	}

	public void setEnterpriseSerial(String enterpriseSerial) {
		this.enterpriseSerial = enterpriseSerial;
	}

	public String getEnterpriseName() {
		return enterpriseName;
	}

	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}

	public String getShortName() {
		return shortName;
	}

	public void setShortName(String shortName) {
		this.shortName = shortName;
	}

	public String getOrganizationCode() {
		return organizationCode;
	}

	public void setOrganizationCode(String organizationCode) {
		this.organizationCode = organizationCode;
	}

	public String getSocialCreditCode() {
		return socialCreditCode;
	}

	public void setSocialCreditCode(String socialCreditCode) {
		this.socialCreditCode = socialCreditCode;
	}

	public String getEconomicType() {
		return economicType;
	}

	public void setEconomicType(String economicType) {
		this.economicType = economicType;
	}

	public String getRegistType() {
		return registType;
	}

	public void setRegistType(String registType) {
		this.registType = registType;
	}

	public String getBusinessNo() {
		return businessNo;
	}

	public void setBusinessNo(String businessNo) {
		this.businessNo = businessNo;
	}

	public String getSeniority() {
		return seniority;
	}

	public void setSeniority(String seniority) {
		this.seniority = seniority;
	}

	public String getPersonIncharge() {
		return personIncharge;
	}

	public void setPersonIncharge(String personIncharge) {
		this.personIncharge = personIncharge;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}

	public String getPostalcode() {
		return postalcode;
	}

	public void setPostalcode(String postalcode) {
		this.postalcode = postalcode;
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

	public String getDepositBank() {
		return depositBank;
	}

	public void setDepositBank(String depositBank) {
		this.depositBank = depositBank;
	}

	public String getDepositAccount() {
		return depositAccount;
	}

	public void setDepositAccount(String depositAccount) {
		this.depositAccount = depositAccount;
	}

	public String getBankCreditRating() {
		return bankCreditRating;
	}

	public void setBankCreditRating(String bankCreditRating) {
		this.bankCreditRating = bankCreditRating;
	}

	public BigDecimal getFixedAssets() {
		return fixedAssets;
	}

	public void setFixedAssets(BigDecimal fixedAssets) {
		this.fixedAssets = fixedAssets;
	}

	public BigDecimal getRegisteredCapital() {
		return registeredCapital;
	}

	public void setRegisteredCapital(BigDecimal registeredCapital) {
		this.registeredCapital = registeredCapital;
	}

	public BigDecimal getAssets() {
		return assets;
	}

	public void setAssets(BigDecimal assets) {
		this.assets = assets;
	}

	public Integer getPeople() {
		return people;
	}

	public void setPeople(Integer people) {
		this.people = people;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
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

	public String getWareHouseId() {
		return wareHouseId;
	}

	public void setWareHouseId(String wareHouseId) {
		this.wareHouseId = wareHouseId;
	}
}