package com.dhc.fastersoft.entity;

public class StorageGrainInspectionEChart {
	private Boolean isEmpty; 
	private String[] xAxisData;//x坐标轴数据
	private Float[] storehouseTempArray;//仓温
	private Float[] temperatureArray;//气温
	private Float[] temperatureAvgArray;//粮温
	
	public String[] getxAxisData() {
		return xAxisData;
	}
	public void setxAxisData(String[] xAxisData) {
		this.xAxisData = xAxisData;
	}
	public Float[] getTemperatureArray() {
		return temperatureArray;
	}
	public void setTemperatureArray(Float[] temperatureArray) {
		this.temperatureArray = temperatureArray;
	}
	public Float[] getTemperatureAvgArray() {
		return temperatureAvgArray;
	}
	public void setTemperatureAvgArray(Float[] temperatureAvgArray) {
		this.temperatureAvgArray = temperatureAvgArray;
	}
	public Float[] getStorehouseTempArray() {
		return storehouseTempArray;
	}
	public void setStorehouseTempArray(Float[] storehouseTempArray) {
		this.storehouseTempArray = storehouseTempArray;
	}
	public Boolean getIsEmpty() {
		return isEmpty;
	}
	public void setIsEmpty(Boolean isEmpty) {
		this.isEmpty = isEmpty;
	}		
}
