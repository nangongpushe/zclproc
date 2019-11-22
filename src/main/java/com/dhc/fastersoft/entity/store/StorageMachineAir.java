package com.dhc.fastersoft.entity.store;

import java.util.Date;

import com.dhc.fastersoft.entity.StorageWarehouse;
import org.springframework.format.annotation.DateTimeFormat;

public class StorageMachineAir {
  private String id;
  private String warehouse;
  private String storehouse;
  private String warehouseId;
  private String grainType;
  private String realQuantity;
  private String airAim;
  private String grainBulkHeight;
  private String grainBulkVolume;
  private String fanVersion;
  private String fanPower;
  private String fanQuantity;
  private String totalAirVolume;
  private String airDuctType;
  private String airNetLayout;
  private String airDuctQuantity;
  private String airDuctGap;
  private String averageAirVolume;
  private String airType;
  private String airPathRatio;
  @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
  private Date airStartTime;
  @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
  private Date airEndTime;
  private String totalAirTime;
  private String maxAirTemperature;
  private String minAirTemperature;
  private String averageAirTemperature;
  private String maxAirHumidity;
  private String minAirHumidity;
  private String averageAirHumidity;
  private String maxGrainTemperature;
  private String minGrainTemperature;
  private String averageGrainTemperature;
  private String maxGrainTemperatureNew;
  private String minGrainTemperatureNew;
  private String averageGrainTemperatureNew;
  private String maxGrainDew;
  private String minGrainDew;
  private String averageGrainDew;
  private String maxGrainDewNew;
  private String minGrainDewNew;
  private String averageGrainDewNew;
  private String totalPowerConsumption;
  private String averagePowerConsumption;
  private String storeMan;
  private String operator;
  private String creatorId;
  private String chargeMan;
  private String remark;
  @DateTimeFormat(pattern="yyyy-MM-dd")
  private Date reportTime;

  
public String getId() {
	return id;
}
public void setId(String id) {
	this.id = id;
}
public String getWarehouse() {
	return warehouse;
}
public void setWarehouse(String warehouse) {
	this.warehouse = warehouse;
}
public String getStorehouse() {
	return storehouse;
}
public void setStorehouse(String storehouse) {
	this.storehouse = storehouse;
}
public String getGrainType() {
	return grainType;
}
public void setGrainType(String grainType) {
	this.grainType = grainType;
}
public String getRealQuantity() {
	return realQuantity;
}
public void setRealQuantity(String realQuantity) {
	this.realQuantity = realQuantity;
}
public String getAirAim() {
	return airAim;
}
public void setAirAim(String airAim) {
	this.airAim = airAim;
}
public String getGrainBulkHeight() {
	return grainBulkHeight;
}
public void setGrainBulkHeight(String grainBulkHeight) {
	this.grainBulkHeight = grainBulkHeight;
}
public String getGrainBulkVolume() {
	return grainBulkVolume;
}
public void setGrainBulkVolume(String grainBulkVolume) {
	this.grainBulkVolume = grainBulkVolume;
}
public String getFanVersion() {
	return fanVersion;
}
public void setFanVersion(String fanVersion) {
	this.fanVersion = fanVersion;
}
public String getFanPower() {
	return fanPower;
}
public void setFanPower(String fanPower) {
	this.fanPower = fanPower;
}
public String getFanQuantity() {
	return fanQuantity;
}
public void setFanQuantity(String fanQuantity) {
	this.fanQuantity = fanQuantity;
}
public String getTotalAirVolume() {
	return totalAirVolume;
}
public void setTotalAirVolume(String totalAirVolume) {
	this.totalAirVolume = totalAirVolume;
}
public String getAirDuctType() {
	return airDuctType;
}
public void setAirDuctType(String airDuctType) {
	this.airDuctType = airDuctType;
}
public String getAirNetLayout() {
	return airNetLayout;
}
public void setAirNetLayout(String airNetLayout) {
	this.airNetLayout = airNetLayout;
}
public String getAirDuctGap() {
	return airDuctGap;
}
public void setAirDuctGap(String airDuctGap) {
	this.airDuctGap = airDuctGap;
}
public String getAverageAirVolume() {
	return averageAirVolume;
}
public void setAverageAirVolume(String averageAirVolume) {
	this.averageAirVolume = averageAirVolume;
}
public String getAirType() {
	return airType;
}
public void setAirType(String airType) {
	this.airType = airType;
}
public String getAirPathRatio() {
	return airPathRatio;
}
public void setAirPathRatio(String airPathRatio) {
	this.airPathRatio = airPathRatio;
}
public Date getAirStartTime() {
	return airStartTime;
}
public void setAirStartTime(Date airStartTime) {
	this.airStartTime = airStartTime;
}
public Date getAirEndTime() {
	return airEndTime;
}
public void setAirEndTime(Date airEndTime) {
	this.airEndTime = airEndTime;
}
public String getMaxAirTemperature() {
	return maxAirTemperature;
}
public void setMaxAirTemperature(String maxAirTemperature) {
	this.maxAirTemperature = maxAirTemperature;
}
public String getMinAirTemperature() {
	return minAirTemperature;
}
public void setMinAirTemperature(String minAirTemperature) {
	this.minAirTemperature = minAirTemperature;
}

public String getAverageAirTemperature() {
	return averageAirTemperature;
}
public void setAverageAirTemperature(String averageAirTemperature) {
	this.averageAirTemperature = averageAirTemperature;
}
public String getMaxAirHumidity() {
	return maxAirHumidity;
}
public void setMaxAirHumidity(String maxAirHumidity) {
	this.maxAirHumidity = maxAirHumidity;
}
public String getMinAirHumidity() {
	return minAirHumidity;
}
public void setMinAirHumidity(String minAirHumidity) {
	this.minAirHumidity = minAirHumidity;
}
public String getAverageAirHumidity() {
	return averageAirHumidity;
}
public void setAverageAirHumidity(String averageAirHumidity) {
	this.averageAirHumidity = averageAirHumidity;
}
public String getMaxGrainDew() {
	return maxGrainDew;
}
public void setMaxGrainDew(String maxGrainDew) {
	this.maxGrainDew = maxGrainDew;
}
public String getMinGrainDew() {
	return minGrainDew;
}
public void setMinGrainDew(String minGrainDew) {
	this.minGrainDew = minGrainDew;
}
public String getAverageGrainDew() {
	return averageGrainDew;
}
public void setAverageGrainDew(String averageGrainDew) {
	this.averageGrainDew = averageGrainDew;
}
public String getTotalPowerConsumption() {
	return totalPowerConsumption;
}
public void setTotalPowerConsumption(String totalPowerConsumption) {
	this.totalPowerConsumption = totalPowerConsumption;
}
public String getAveragePowerConsumption() {
	return averagePowerConsumption;
}
public void setAveragePowerConsumption(String averagePowerConsumption) {
	this.averagePowerConsumption = averagePowerConsumption;
}
public String getStoreMan() {
	return storeMan;
}
public void setStoreMan(String storeMan) {
	this.storeMan = storeMan;
}
public String getOperator() {
	return operator;
}
public void setOperator(String operator) {
	this.operator = operator;
}
public String getChargeMan() {
	return chargeMan;
}
public void setChargeMan(String chargeMan) {
	this.chargeMan = chargeMan;
}
public String getRemark() {
	return remark;
}
public void setRemark(String remark) {
	this.remark = remark;
}
public Date getReportTime() {
	return reportTime;
}
public void setReportTime(Date reportTime) {
	this.reportTime = reportTime;
}
public String getAirDuctQuantity() {
	return airDuctQuantity;
}
public void setAirDuctQuantity(String airDuctQuantity) {
	this.airDuctQuantity = airDuctQuantity;
}
public String getMaxGrainTemperature() {
	return maxGrainTemperature;
}
public void setMaxGrainTemperature(String maxGrainTemperature) {
	this.maxGrainTemperature = maxGrainTemperature;
}
public String getMinGrainTemperature() {
	return minGrainTemperature;
}
public void setMinGrainTemperature(String minGrainTemperature) {
	this.minGrainTemperature = minGrainTemperature;
}
public String getAverageGrainTemperature() {
	return averageGrainTemperature;
}
public void setAverageGrainTemperature(String averageGrainTemperature) {
	this.averageGrainTemperature = averageGrainTemperature;
}
public String getMaxGrainTemperatureNew() {
	return maxGrainTemperatureNew;
}
public void setMaxGrainTemperatureNew(String maxGrainTemperatureNew) {
	this.maxGrainTemperatureNew = maxGrainTemperatureNew;
}
public String getMinGrainTemperatureNew() {
	return minGrainTemperatureNew;
}
public void setMinGrainTemperatureNew(String minGrainTemperatureNew) {
	this.minGrainTemperatureNew = minGrainTemperatureNew;
}
public String getAverageGrainTemperatureNew() {
	return averageGrainTemperatureNew;
}
public void setAverageGrainTemperatureNew(String averageGrainTemperatureNew) {
	this.averageGrainTemperatureNew = averageGrainTemperatureNew;
}
public String getMaxGrainDewNew() {
	return maxGrainDewNew;
}
public void setMaxGrainDewNew(String maxGrainDewNew) {
	this.maxGrainDewNew = maxGrainDewNew;
}
public String getMinGrainDewNew() {
	return minGrainDewNew;
}
public void setMinGrainDewNew(String minGrainDewNew) {
	this.minGrainDewNew = minGrainDewNew;
}
public String getAverageGrainDewNew() {
	return averageGrainDewNew;
}
public void setAverageGrainDewNew(String averageGrainDewNew) {
	this.averageGrainDewNew = averageGrainDewNew;
}
public String getTotalAirTime() {
	return totalAirTime;
}
public void setTotalAirTime(String totalAirTime) {
	this.totalAirTime = totalAirTime;
}

	public String getCreatorId() {
		return creatorId;
	}

	public void setCreatorId(String creatorId) {
		this.creatorId = creatorId;
	}

	public String getWarehouseId() {
		return warehouseId;
	}

	public void setWarehouseId(String warehouseId) {
		this.warehouseId = warehouseId;
	}
}