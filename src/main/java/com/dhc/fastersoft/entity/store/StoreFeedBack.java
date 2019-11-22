package com.dhc.fastersoft.entity.store;

public class StoreFeedBack {
    private String id;
    private String examineSerial; //考评编号(年月日+四位流水号)
    
    private String feedbackSerial; //问题反馈表编号(年月日+四位流水号

    private String feedbackName;  //问题反馈表名称

    private String storehouse;   //库点名称

    private String warehouseId;   //库点ID

    private String manager;   //库点负责人

    private String inspectors;  //检查人员(多人)

    private String inspectorManager;  //检查组负责人

    private String reportDate;  //填表时间

    private String groupId; //附件
    private String inspectorType;//检查类型：自查、检查
    private String creatorId; //
    private String isMyself;//是否是自己的
    private String enterpriseName;//企业名称
    private String enterpriseManager;//企业名称
    private String type;  //1.仓储 0.代储
	private String creator;		//创建人

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getExamineSerial() {
		return examineSerial;
	}

	public void setExamineSerial(String examineSerial) {
		this.examineSerial = examineSerial;
	}

	public String getEnterpriseName() {
		return enterpriseName;
	}

	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}

	public String getEnterpriseManager() {
		return enterpriseManager;
	}

	public void setEnterpriseManager(String enterpriseManager) {
		this.enterpriseManager = enterpriseManager;
	}

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

	public String getCreatorId() {
		return creatorId;
	}

	public void setCreatorId(String creatorId) {
		this.creatorId = creatorId;
	}

	public String getInspectorType() {
		return inspectorType;
	}

	public void setInspectorType(String inspectorType) {
		this.inspectorType = inspectorType;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFeedbackSerial() {
		return feedbackSerial;
	}

	public void setFeedbackSerial(String feedbackSerial) {
		this.feedbackSerial = feedbackSerial;
	}

	public String getFeedbackName() {
		return feedbackName;
	}

	public void setFeedbackName(String feedbackName) {
		this.feedbackName = feedbackName;
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

	public String getInspectors() {
		return inspectors;
	}

	public void setInspectors(String inspectors) {
		this.inspectors = inspectors;
	}

	public String getInspectorManager() {
		return inspectorManager;
	}

	public void setInspectorManager(String inspectorManager) {
		this.inspectorManager = inspectorManager;
	}

	public String getReportDate() {
		return reportDate;
	}

	public void setReportDate(String reportDate) {
		this.reportDate = reportDate;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getWarehouseId() {
		return warehouseId;
	}

	public void setWarehouseId(String warehouseId) {
		this.warehouseId = warehouseId;
	}
}