package com.dhc.fastersoft.entity.store;

public class StoreExamine {
    private String id;

    private String examineSerial; //考评编号(年月日+四位流水号)

    private String examineName;  //考评编号名称

    private String storehouse;  //库点名称

    private String manager;   // 库点负责人

    private String examineType;  // 考评方式

    private String examineTime;  //考评时间

    private String examineTemplet;//  考评模板

    private String templetName;  //模板名称

    private double points;   //综合得分

    private String inspectors;  //考评组成员

    private String groupId;  //附件
    
    private String creatorId;//
    private String isMyself;//是否是自己的
    private String enterpriseName;//企业名称
    private String enterpriseManager;//企业名称
    private String type;  //1.仓储 0.代储
    
    private String examineTempletType;  //考评类型

	private String creator;		//创建人
	private String warehouseId;    //库名id
	public String getWarehouseId() {
		return warehouseId;
	}

	public void setWarehouseId(String warehouseId) {
		this.warehouseId = warehouseId;
	}



	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getExamineTempletType() {
		return examineTempletType;
	}

	public void setExamineTempletType(String examineTempletType) {
		this.examineTempletType = examineTempletType;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getEnterpriseManager() {
		return enterpriseManager;
	}

	public void setEnterpriseManager(String enterpriseManager) {
		this.enterpriseManager = enterpriseManager;
	}

	public String getEnterpriseName() {
		return enterpriseName;
	}

	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}

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

	public String getExamineSerial() {
		return examineSerial;
	}

	public void setExamineSerial(String examineSerial) {
		this.examineSerial = examineSerial;
	}

	public String getExamineName() {
		return examineName;
	}

	public void setExamineName(String examineName) {
		this.examineName = examineName;
	}

	public String getStorehouse() {
		return storehouse;
	}

	public void setStorehouse(String storehouse) {
		this.storehouse = storehouse;
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}

	public String getExamineType() {
		return examineType;
	}

	public void setExamineType(String examineType) {
		this.examineType = examineType;
	}

	public String getExamineTime() {
		return examineTime;
	}

	public void setExamineTime(String examineTime) {
		this.examineTime = examineTime;
	}

	public String getExamineTemplet() {
		return examineTemplet;
	}

	public void setExamineTemplet(String examineTemplet) {
		this.examineTemplet = examineTemplet;
	}

	public String getTempletName() {
		return templetName;
	}

	public void setTempletName(String templetName) {
		this.templetName = templetName;
	}

	public double getPoints() {
		return points;
	}

	public void setPoints(double points) {
		this.points = points;
	}

	public String getInspectors() {
		return inspectors;
	}

	public void setInspectors(String inspectors) {
		this.inspectors = inspectors;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}


    
}