package com.dhc.fastersoft.entity;/*
 *
 *------------吴亦凡大魔王最帅-------------------/
 *         ┌─┐            ┌─┐
 *     ┌─┘─┴──────┘─┴─┐
 *     │                            │
 *     │             ─             │
 *     │    ┬─┘        └─┬    │
 *     │                            │
 *     │             ┴             │
 *     │                            │
 *     └───┐            ┌───┘
 *             │            │
 *             │            │
 *             │            └──────┐
 *             │                          ├┐
 *             │                          ┌┘
 *             └┐  ┐  ┌───┬─┐  ┌┘
 *               │  ┤  ┤      │  ┤  ┤
 *               └─┴─┘      └─┴─┘
 *─────────神兽出没──────────/
 */

public class ReportMonthBzwDTO {

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

    private String msg;

    private boolean success;

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
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

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }
}
