package com.dhc.fastersoft.dto;

import java.io.Serializable;

public class ReportMonthSwtzDTO implements Serializable {

    /**
     * 报表明细
     */
    private Object data;
    /**
     * 统计负责人
     */
    private String manager;
    /**
     * 储备性质
     */
    private String reserveProperty;

    private boolean success = true;
    private String msg = "ok";

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getManager() {
        return manager;
    }

    public void setManager(String manager) {
        this.manager = manager;
    }

    public String getReserveProperty() {
        return reserveProperty;
    }

    public void setReserveProperty(String reserveProperty) {
        this.reserveProperty = reserveProperty;
    }
}
