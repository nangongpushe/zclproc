package com.dhc.fastersoft.entity;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

public class RotateRefundMain {
    private String id;
    private String serial;//联系单编号
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date handleTime;
    private String operator;
    private String department;
    private String modifier;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date modifyTime;
    private List<RotateRefund> rotateRefund;

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

    public Date getHandleTime() {
        return handleTime;
    }

    public void setHandleTime(Date handleTime) {
        this.handleTime = handleTime;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public List<RotateRefund> getRotateRefund() {
        return rotateRefund;
    }

    public void setRotateRefund(List<RotateRefund> rotateRefund) {
        this.rotateRefund = rotateRefund;
    }

    public String getModifier() {
        return modifier;
    }

    public void setModifier(String modifier) {
        this.modifier = modifier;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }
}
