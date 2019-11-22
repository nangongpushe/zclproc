package com.dhc.fastersoft.entity.echarts;

import java.util.List;
import java.util.Map;

public class EchartsData {
    private Object [] legendData;
    private Object [] xAxisData;
    private List<Serie> series;
    private List<PieData> pieData;
    private String name;
    private String value;

    public EchartsData() {
        super();
    }

    public EchartsData(String name, String value) {
        this.name = name;
        this.value = value;
    }

    public Object[] getLegendData() {
        return legendData;
    }
    public void setLegendData(Object[] legendData) {
        this.legendData = legendData;
    }
    public Object[] getxAxisData() {
        return xAxisData;
    }
    public void setxAxisData(Object[] xAxisData) {
        this.xAxisData = xAxisData;
    }
    public List<Serie> getSeries() {
        return series;
    }
    public void setSeries(List<Serie> series) {
        this.series = series;
    }
    public List<PieData> getPieData() {
        return pieData;
    }

    public void setPieData(List<PieData> pieData) {
        this.pieData = pieData;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getValue() {
        return value;
    }
    public void setValue(String value) {
        this.value = value;
    }
}

class Serie1 extends Serie{
    private String stack;
    private Map itemStyle;

    public String getStack() {
        return stack;
    }
    public void setStack(String stack) {
        this.stack = stack;
    }
    public Map getItemStyle() {
        return itemStyle;
    }
    public void setItemStyle(Map itemStyle) {
        this.itemStyle = itemStyle;
    }

}

class PieData{
    private String name;
    private int value;

    public PieData(String name, int value) {
        this.name = name;
        this.value = value;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public int getValue() {
        return value;
    }
    public void setValue(int value) {
        this.value = value;
    }
}