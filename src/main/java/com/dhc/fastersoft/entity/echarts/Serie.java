package com.dhc.fastersoft.entity.echarts;


public class Serie {
    public final static String SERIE_TYPE_LINE = "line";
    private String name;
    private String type;
    private Object[] data;

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }
    public Object[] getData() {
        return data;
    }
    public void setData(Object[] data) {
        this.data = data;
    }
}