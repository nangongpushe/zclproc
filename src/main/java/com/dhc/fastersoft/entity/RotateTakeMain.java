package com.dhc.fastersoft.entity;

import java.util.Date;
import java.util.List;

/**
 * 提货单
 */
public class RotateTakeMain {

    private String id;

    /**
     * 提货单编号
     */
    private String serial;

    /**
     * 接收库点
     */
    private String receiveWarehouse;

    /**
     * 接收库点id
     */
    private String receiveWarehouseId;

    /**
     * 库点联系人
     */
    private String warehouseContactor;

    /**
     * 库点联系电话
     */
    private String warehouseTel;

    /**
     * 承储单位联系方式（库点对应公司联系方式）
     */
    private String enterpriseTel;

    /**
     * 接收单位（客户）
     */
    private String customer;

    /**
     * 状态(待提交、待审核、用印申请、分发、已完成)
     */
    private String status;

    /**
     * 联系方式（客户联系方式）
     */
    private String customerTel;

    /**
     * 客户ID
     */
    private String customerId;

    /**
     * 创建人(经办人)
     */
    private String creater;

    /**
     * 创建日期(经办时间)
     */
    private Date createDate;

    /**
     * 分发日期
     */
    private Date completeDate;


    /**
     * 汇总所有子信息中的仓号
     */
    private String storeHouses;

    /**
     * 汇总所有子信息中的 acceptanceUnit
     */
    private String payCompany;

    /**
     * 子信息
     */
    private List<RotateTake> rotateTakes;

    public RotateTakeMain() {
    }

    public RotateTakeMain(Date createDate) {
        this.createDate = createDate;
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

    public String getReceiveWarehouse() {
        return receiveWarehouse;
    }

    public void setReceiveWarehouse(String receiveWarehouse) {
        this.receiveWarehouse = receiveWarehouse;
    }

    public String getReceiveWarehouseId() {
        return receiveWarehouseId;
    }

    public void setReceiveWarehouseId(String receiveWarehouseId) {
        this.receiveWarehouseId = receiveWarehouseId;
    }

    public String getWarehouseContactor() {
        return warehouseContactor;
    }

    public void setWarehouseContactor(String warehouseContactor) {
        this.warehouseContactor = warehouseContactor;
    }

    public String getWarehouseTel() {
        return warehouseTel;
    }

    public void setWarehouseTel(String warehouseTel) {
        this.warehouseTel = warehouseTel;
    }

    public String getEnterpriseTel() {
        return enterpriseTel;
    }

    public void setEnterpriseTel(String enterpriseTel) {
        this.enterpriseTel = enterpriseTel;
    }

    public String getCustomer() {
        return customer;
    }

    public void setCustomer(String customer) {
        this.customer = customer;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCustomerTel() {
        return customerTel;
    }

    public void setCustomerTel(String customerTel) {
        this.customerTel = customerTel;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
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

    public Date getCompleteDate() {
        return completeDate;
    }

    public void setCompleteDate(Date completeDate) {
        this.completeDate = completeDate;
    }

    public List<RotateTake> getRotateTakes() {
        return rotateTakes;
    }

    public void setRotateTakes(List<RotateTake> rotateTakes) {
        this.rotateTakes = rotateTakes;
    }

    public String getStoreHouses() {
        return storeHouses;
    }

    public void setStoreHouses(String storeHouses) {
        this.storeHouses = storeHouses;
    }

    public String getPayCompany() {
        return payCompany;
    }

    public void setPayCompany(String payCompany) {
        this.payCompany = payCompany;
    }
}
