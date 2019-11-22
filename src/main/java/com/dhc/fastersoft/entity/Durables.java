package com.dhc.fastersoft.entity;              

import java.util.Date;              

public class Durables {
    private String id;              	//主键ID

    private String encode;              //物资编码

    private String type;              // '类型:药剂类、物资、麻袋';

    private String commodity;            //'品名'

    private String model;              //'规格型号';

    private String unit;              //'制造单位:个、件、套';

    private String status;              //'目前状态';

    private double amount;              //'金额';

    private String manufacturer;              //'生产厂家';

    private String serialNumber;              // '出厂编号';

    private String supplier;              // '供应商';

    private String options;              // '随机资料'

    private String groupId;              //'物资照片(附件分组ID)';

    private String storageDate;              //入库时间(YYYY-MM-DD)'

    private String warehouseId;              //'所入库房ID';

    private String storehouse;              //'所入库房';

    private String storagePlace;              //'存放地点';

    private String needCard;              //是否需要建立物资卡片:是、否'

    private String purchaseDate;              //采购时间(YYYY-MM-DD)'

    private String power;              // '功率';

    private String yield;              // '产量';

    private String overallDimension;              //外形尺寸'

    private String majorFunction;              //主要功能'

    private String custodian;              //'保管负责人'

    private String guardian;              //维护负责人'

    private String operator;              //操作负责人'

    private String storageRequire;              //主要保管要求'

    private String creator;              //创建人'

    private String createDate;              //创建时间'

    private String remark;              //备注'
    
    private String optionNum;

    public String getOptionNum() {
		return optionNum;
	}

	public void setOptionNum(String optionNum) {
		this.optionNum = optionNum;
	}

	public String getId() {
        return id;              
    }

    public void setId(String id) {
        this.id = id;              
    }

    public String getEncode() {
        return encode;              
    }

    public void setEncode(String encode) {
        this.encode = encode;              
    }

    public String getType() {
        return type;              
    }

    public void setType(String type) {
        this.type = type;              
    }

    public String getCommodity() {
        return commodity;              
    }

    public void setCommodity(String commodity) {
        this.commodity = commodity;              
    }

    public String getModel() {
        return model;              
    }

    public void setModel(String model) {
        this.model = model;              
    }

    public String getUnit() {
        return unit;              
    }

    public void setUnit(String unit) {
        this.unit = unit;              
    }

    public String getStatus() {
        return status;              
    }

    public void setStatus(String status) {
        this.status = status;              
    }

    public double getAmount() {
        return amount;              
    }

    public void setAmount(double amount) {
        this.amount = amount;              
    }

    public String getManufacturer() {
        return manufacturer;              
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;              
    }

    public String getSerialNumber() {
        return serialNumber;              
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;              
    }

    public String getSupplier() {
        return supplier;              
    }

    public void setSupplier(String supplier) {
        this.supplier = supplier;              
    }

    public String getOptions() {
        return options;              
    }

    public void setOptions(String options) {
        this.options = options;              
    }

    public String getGroupId() {
        return groupId;              
    }

    public void setGroupId(String groupId) {
        this.groupId = groupId;              
    }

    public String getStorageDate() {
        return storageDate;              
    }

    public void setStorageDate(String storageDate) {
        this.storageDate = storageDate;              
    }

    public String getStorehouse() {
        return storehouse;              
    }

    public void setStorehouse(String storehouse) {
        this.storehouse = storehouse;              
    }

    public String getStoragePlace() {
        return storagePlace;              
    }

    public void setStoragePlace(String storagePlace) {
        this.storagePlace = storagePlace;              
    }

    public String getNeedCard() {
        return needCard;              
    }

    public void setNeedCard(String needCard) {
        this.needCard = needCard;              
    }

    public String getPurchaseDate() {
        return purchaseDate;              
    }

    public void setPurchaseDate(String purchaseDate) {
        this.purchaseDate = purchaseDate;              
    }

    public String getPower() {
        return power;              
    }

    public void setPower(String power) {
        this.power = power;              
    }

    public String getYield() {
        return yield;              
    }

    public void setYield(String yield) {
        this.yield = yield;              
    }

    public String getOverallDimension() {
        return overallDimension;              
    }

    public void setOverallDimension(String overallDimension) {
        this.overallDimension = overallDimension;              
    }

    public String getMajorFunction() {
        return majorFunction;              
    }

    public void setMajorFunction(String majorFunction) {
        this.majorFunction = majorFunction;              
    }

    public String getCustodian() {
        return custodian;              
    }

    public void setCustodian(String custodian) {
        this.custodian = custodian;              
    }

    public String getGuardian() {
        return guardian;              
    }

    public void setGuardian(String guardian) {
        this.guardian = guardian;              
    }

    public String getOperator() {
        return operator;              
    }

    public void setOperator(String operator) {
        this.operator = operator;              
    }

    public String getStorageRequire() {
        return storageRequire;              
    }

    public void setStorageRequire(String storageRequire) {
        this.storageRequire = storageRequire;              
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

    public String getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(String warehouseId) {
        this.warehouseId = warehouseId;
    }
}