package com.dhc.fastersoft.entity.store;



public class StoreWinUnit {
    private String id;

    private String serial; //编号(年月日+四位流水)';

    private String year;  //评选年份

    private String declareUnit; //上报单位

    private String declareDate; //上报时间

    private String regulatoryUnit; //监管单位

    private String recommend; //推荐(1：已推荐 0：未推荐)

    private String groupId; //评选材料（附件
    private String creatorId; //
    private String isMyself;//是否是自己的
    

	public String getIsMyself() {
		return isMyself;
	}

	public void setIsMyself(String isMyself) {
		this.isMyself = isMyself;
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

	public String getSerial() {
		return serial;
	}

	public void setSerial(String serial) {
		this.serial = serial;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getDeclareUnit() {
		return declareUnit;
	}

	public void setDeclareUnit(String declareUnit) {
		this.declareUnit = declareUnit;
	}

	public String getDeclareDate() {
		return declareDate;
	}

	public void setDeclareDate(String declareDate) {
		this.declareDate = declareDate;
	}

	public String getRegulatoryUnit() {
		return regulatoryUnit;
	}

	public void setRegulatoryUnit(String regulatoryUnit) {
		this.regulatoryUnit = regulatoryUnit;
	}

	public String getRecommend() {
		return recommend;
	}

	public void setRecommend(String recommend) {
		this.recommend = recommend;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

   
}