package com.dhc.fastersoft.entity.store;

public class StorageStarUnit {
    private String id;

    private String warehouse;		//粮库名称

    private String postalAddress; //通讯地址

    private String director; //粮库主任

    private String email;		//电子信箱

    private String zip;		//邮编

    private String telphone;		//电话

    private String fax;		//传真

    private Integer entireStaff;		//职工总人数

    private Integer nvq;		//有职业资格证书人员

    private Integer juniorCollege;		//大专（含）以上学历

    private Integer mediumGrade;		//中级（含）以上职称

    private Integer keeper;		//粮油保管员

    private Integer monitor;		//粮油质量检验员

    private Integer mechanic;		//粮仓机械员

    private Integer controlOperator;		//中央控制室操作员

    private Integer electrician;		//电工

    private Integer safety;		//安全生产管理员

    private String oldLevel;		//原"星级"等级

    private String applyLevel;		//现申请评定"星级"等级

    private String enterprise;		//申请企业名称

    private String groupId;		//附件

    private String creator;		//创建人



    private String createDate;		//创建时间

    private String remark;		//备注
    private String creatorId;//
    private String storeHouse;    //库点名称
    private String isMyself;//是否是自己的
    
    private String type;//0:星级 1:四化

	public String getWarehouseId() {
		return warehouseId;
	}

	public void setWarehouseId(String warehouseId) {
		this.warehouseId = warehouseId;
	}

	private String warehouseId;    //库名id

    
  	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getIsMyself() {
  		return isMyself;
  	}

  	public void setIsMyself(String isMyself) {
  		this.isMyself = isMyself;
  	}
    
	public String getStoreHouse() {
		return storeHouse;
	}

	public void setStoreHouse(String storeHouse) {
		this.storeHouse = storeHouse;
	}

	public String getCreatorId() {
		return creatorId;
	}

	public void setCreatorId(String creatorId) {
		this.creatorId = creatorId;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getWarehouse() {
		return warehouse;
	}

	public void setWarehouse(String warehouse) {
		this.warehouse = warehouse;
	}

	public String getPostalAddress() {
		return postalAddress;
	}

	public void setPostalAddress(String postalAddress) {
		this.postalAddress = postalAddress;
	}

	public String getDirector() {
		return director;
	}

	public void setDirector(String director) {
		this.director = director;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getZip() {
		return zip;
	}

	public void setZip(String zip) {
		this.zip = zip;
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

	public Integer getEntireStaff() {
		return entireStaff;
	}

	public void setEntireStaff(Integer entireStaff) {
		this.entireStaff = entireStaff;
	}

	public Integer getNvq() {
		return nvq;
	}

	public void setNvq(Integer nvq) {
		this.nvq = nvq;
	}

	public Integer getJuniorCollege() {
		return juniorCollege;
	}

	public void setJuniorCollege(Integer juniorCollege) {
		this.juniorCollege = juniorCollege;
	}

	public Integer getMediumGrade() {
		return mediumGrade;
	}

	public void setMediumGrade(Integer mediumGrade) {
		this.mediumGrade = mediumGrade;
	}

	public Integer getKeeper() {
		return keeper;
	}

	public void setKeeper(Integer keeper) {
		this.keeper = keeper;
	}

	public Integer getMonitor() {
		return monitor;
	}

	public void setMonitor(Integer monitor) {
		this.monitor = monitor;
	}

	public Integer getMechanic() {
		return mechanic;
	}

	public void setMechanic(Integer mechanic) {
		this.mechanic = mechanic;
	}

	public Integer getControlOperator() {
		return controlOperator;
	}

	public void setControlOperator(Integer controlOperator) {
		this.controlOperator = controlOperator;
	}

	public Integer getElectrician() {
		return electrician;
	}

	public void setElectrician(Integer electrician) {
		this.electrician = electrician;
	}

	public Integer getSafety() {
		return safety;
	}

	public void setSafety(Integer safety) {
		this.safety = safety;
	}

	public String getOldLevel() {
		return oldLevel;
	}

	public void setOldLevel(String oldLevel) {
		this.oldLevel = oldLevel;
	}

	public String getApplyLevel() {
		return applyLevel;
	}

	public void setApplyLevel(String applyLevel) {
		this.applyLevel = applyLevel;
	}

	public String getEnterprise() {
		return enterprise;
	}

	public void setEnterprise(String enterprise) {
		this.enterprise = enterprise;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
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
    

   
}