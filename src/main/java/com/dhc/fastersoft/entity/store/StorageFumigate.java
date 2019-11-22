package com.dhc.fastersoft.entity.store;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class StorageFumigate {
  private String id;
  private String serial;
  private String warehouse;
  private String warehouseId;

  private String weather;
  private String temperature;
  private String humidity;
  
  private String storehouse;
  private String storehouseType;
  private String storehouseStructure;
  private String storehouseVolume;
  private String stack;
  private String gas;
  private String sealing;
  @DateTimeFormat(pattern="yyyy-MM-dd")
  private Date storeDate;
  private String grainVolume;
  private String spaceVolume;
  private String grainHeight;
  private String isFumigateLastYear;
  
  private String grainType;
  private String realQuantity;
  private String impurity;
  private String storageTemperature;
  private String storageHumidity;
  private String dew;
  private String maxGrainTemperature;
  private String minGrainTemperature;
  private String averageGrainTemperature;
  
  private String maxPestDensity;
  private String among;
  private String discoverySite;
  @DateTimeFormat(pattern="yyyy-MM-dd")
  private Date discoveryDate;
  
  private String drugName;
  private String personNumber;
  private String drugMethod;
  private String fumigateType;
  private String unitDrugSpace;
  private String unitDrugGrain;
  private String totalDrugSpace;
  private String totalDrugGrain;
  private String applyDrugTime;
  
  @DateTimeFormat(pattern="yyyy-MM-dd")
  private Date firstSupplyDate;
  private String firstSupplyQuantity;
  private String firstSupplyOperateTime;
  private String supplyType;
  private String isMultiSupply;
  private String totalSupplyCount;
  private String totalSupplyQuantity;
  
  private String circulationType;
  private String totalCirculationTime;
  
  @DateTimeFormat(pattern="yyyy-MM-dd")
  private Date releaseGasDate;
  private String releaseGasType;
  private String releaseGasTime;
  
  private String draffDeal;
  private String drugPackageDeal;
  private String effectCheck;
  private String storeMan;
  private String storeKeeper;
  private String fumigateOperator;
  private String fumigateCommander;
  private String unitChargeMan;
  private String supervisor;
  private String storeChargeMan;
  private String remark;
  @DateTimeFormat(pattern="yyyy-MM-dd")
  private Date reportTime;

  private String totalSupplyDosage;
  private String totalCirculationStarttime;
  private String totalCirculationEndtime;
  private String creatorId;


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
public String getWarehouse() {
	return warehouse;
}
public void setWarehouse(String warehouse) {
	this.warehouse = warehouse;
}
public String getWeather() {
	return weather;
}
public void setWeather(String weather) {
	this.weather = weather;
}
public String getTemperature() {
	return temperature;
}
public void setTemperature(String temperature) {
	this.temperature = temperature;
}
public String getHumidity() {
	return humidity;
}
public void setHumidity(String humidity) {
	this.humidity = humidity;
}
public String getStorehouse() {
	return storehouse;
}
public void setStorehouse(String storehouse) {
	this.storehouse = storehouse;
}
public String getStorehouseType() {
	return storehouseType;
}
public void setStorehouseType(String storehouseType) {
	this.storehouseType = storehouseType;
}
public String getStorehouseStructure() {
	return storehouseStructure;
}
public void setStorehouseStructure(String storehouseStructure) {
	this.storehouseStructure = storehouseStructure;
}
public String getStorehouseVolume() {
	return storehouseVolume;
}
public void setStorehouseVolume(String storehouseVolume) {
	this.storehouseVolume = storehouseVolume;
}
public String getStack() {
	return stack;
}
public void setStack(String stack) {
	this.stack = stack;
}
public String getGas() {
	return gas;
}
public void setGas(String gas) {
	this.gas = gas;
}
public String getSealing() {
	return sealing;
}
public void setSealing(String sealing) {
	this.sealing = sealing;
}
public Date getStoreDate() {
	return storeDate;
}
public void setStoreDate(Date storeDate) {
	this.storeDate = storeDate;
}
public String getGrainVolume() {
	return grainVolume;
}
public void setGrainVolume(String grainVolume) {
	this.grainVolume = grainVolume;
}
public String getSpaceVolume() {
	return spaceVolume;
}
public void setSpaceVolume(String spaceVolume) {
	this.spaceVolume = spaceVolume;
}
public String getGrainHeight() {
	return grainHeight;
}
public void setGrainHeight(String grainHeight) {
	this.grainHeight = grainHeight;
}
public String getIsFumigateLastYear() {
	return isFumigateLastYear;
}
public void setIsFumigateLastYear(String isFumigateLastYear) {
	this.isFumigateLastYear = isFumigateLastYear;
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
public String getImpurity() {
	return impurity;
}
public void setImpurity(String impurity) {
	this.impurity = impurity;
}
public String getStorageTemperature() {
	return storageTemperature;
}
public void setStorageTemperature(String storageTemperature) {
	this.storageTemperature = storageTemperature;
}
public String getStorageHumidity() {
	return storageHumidity;
}
public void setStorageHumidity(String storageHumidity) {
	this.storageHumidity = storageHumidity;
}
public String getDew() {
	return dew;
}
public void setDew(String dew) {
	this.dew = dew;
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
public String getMaxPestDensity() {
	return maxPestDensity;
}
public void setMaxPestDensity(String maxPestDensity) {
	this.maxPestDensity = maxPestDensity;
}
public String getAmong() {
	return among;
}
public void setAmong(String among) {
	this.among = among;
}
public String getDiscoverySite() {
	return discoverySite;
}
public void setDiscoverySite(String discoverySite) {
	this.discoverySite = discoverySite;
}
public Date getDiscoveryDate() {
	return discoveryDate;
}
public void setDiscoveryDate(Date discoveryDate) {
	this.discoveryDate = discoveryDate;
}
public String getDrugName() {
	return drugName;
}
public void setDrugName(String drugName) {
	this.drugName = drugName;
}
public String getPersonNumber() {
	return personNumber;
}
public void setPersonNumber(String personNumber) {
	this.personNumber = personNumber;
}
public String getDrugMethod() {
	return drugMethod;
}
public void setDrugMethod(String drugMethod) {
	this.drugMethod = drugMethod;
}
public String getFumigateType() {
	return fumigateType;
}
public void setFumigateType(String fumigateType) {
	this.fumigateType = fumigateType;
}
public String getUnitDrugSpace() {
	return unitDrugSpace;
}
public void setUnitDrugSpace(String unitDrugSpace) {
	this.unitDrugSpace = unitDrugSpace;
}
public String getUnitDrugGrain() {
	return unitDrugGrain;
}
public void setUnitDrugGrain(String unitDrugGrain) {
	this.unitDrugGrain = unitDrugGrain;
}
public String getTotalDrugSpace() {
	return totalDrugSpace;
}
public void setTotalDrugSpace(String totalDrugSpace) {
	this.totalDrugSpace = totalDrugSpace;
}
public String getTotalDrugGrain() {
	return totalDrugGrain;
}
public void setTotalDrugGrain(String totalDrugGrain) {
	this.totalDrugGrain = totalDrugGrain;
}
public String getApplyDrugTime() {
	return applyDrugTime;
}
public void setApplyDrugTime(String applyDrugTime) {
	this.applyDrugTime = applyDrugTime;
}
public Date getFirstSupplyDate() {
	return firstSupplyDate;
}
public void setFirstSupplyDate(Date firstSupplyDate) {
	this.firstSupplyDate = firstSupplyDate;
}
public String getFirstSupplyQuantity() {
	return firstSupplyQuantity;
}
public void setFirstSupplyQuantity(String firstSupplyQuantity) {
	this.firstSupplyQuantity = firstSupplyQuantity;
}
public String getFirstSupplyOperateTime() {
	return firstSupplyOperateTime;
}
public void setFirstSupplyOperateTime(String firstSupplyOperateTime) {
	this.firstSupplyOperateTime = firstSupplyOperateTime;
}
public String getSupplyType() {
	return supplyType;
}
public void setSupplyType(String supplyType) {
	this.supplyType = supplyType;
}
public String getIsMultiSupply() {
	return isMultiSupply;
}
public void setIsMultiSupply(String isMultiSupply) {
	this.isMultiSupply = isMultiSupply;
}
public String getTotalSupplyCount() {
	return totalSupplyCount;
}
public void setTotalSupplyCount(String totalSupplyCount) {
	this.totalSupplyCount = totalSupplyCount;
}
public String getTotalSupplyQuantity() {
	return totalSupplyQuantity;
}
public void setTotalSupplyQuantity(String totalSupplyQuantity) {
	this.totalSupplyQuantity = totalSupplyQuantity;
}
public String getCirculationType() {
	return circulationType;
}
public void setCirculationType(String circulationType) {
	this.circulationType = circulationType;
}
public String getTotalCirculationTime() {
	return totalCirculationTime;
}
public void setTotalCirculationTime(String totalCirculationTime) {
	this.totalCirculationTime = totalCirculationTime;
}
public Date getReleaseGasDate() {
	return releaseGasDate;
}
public void setReleaseGasDate(Date releaseGasDate) {
	this.releaseGasDate = releaseGasDate;
}
public String getReleaseGasType() {
	return releaseGasType;
}
public void setReleaseGasType(String releaseGasType) {
	this.releaseGasType = releaseGasType;
}
public String getReleaseGasTime() {
	return releaseGasTime;
}
public void setReleaseGasTime(String releaseGasTime) {
	this.releaseGasTime = releaseGasTime;
}
public String getDraffDeal() {
	return draffDeal;
}
public void setDraffDeal(String draffDeal) {
	this.draffDeal = draffDeal;
}
public String getDrugPackageDeal() {
	return drugPackageDeal;
}
public void setDrugPackageDeal(String drugPackageDeal) {
	this.drugPackageDeal = drugPackageDeal;
}
public String getEffectCheck() {
	return effectCheck;
}
public void setEffectCheck(String effectCheck) {
	this.effectCheck = effectCheck;
}
public String getStoreMan() {
	return storeMan;
}
public void setStoreMan(String storeMan) {
	this.storeMan = storeMan;
}
public String getStoreKeeper() {
	return storeKeeper;
}
public void setStoreKeeper(String storeKeeper) {
	this.storeKeeper = storeKeeper;
}
public String getFumigateOperator() {
	return fumigateOperator;
}
public void setFumigateOperator(String fumigateOperator) {
	this.fumigateOperator = fumigateOperator;
}
public String getFumigateCommander() {
	return fumigateCommander;
}
public void setFumigateCommander(String fumigateCommander) {
	this.fumigateCommander = fumigateCommander;
}
public String getUnitChargeMan() {
	return unitChargeMan;
}
public void setUnitChargeMan(String unitChargeMan) {
	this.unitChargeMan = unitChargeMan;
}
public String getSupervisor() {
	return supervisor;
}
public void setSupervisor(String supervisor) {
	this.supervisor = supervisor;
}
public String getStoreChargeMan() {
	return storeChargeMan;
}
public void setStoreChargeMan(String storeChargeMan) {
	this.storeChargeMan = storeChargeMan;
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

public String getTotalSupplyDosage() { return totalSupplyDosage; }
public void setTotalSupplyDosage(String totalSupplyDosage) { this.totalSupplyDosage = totalSupplyDosage; }
public String getTotalCirculationStarttime() { return totalCirculationStarttime; }
public void setTotalCirculationStarttime(String totalCirculationStarttime) { this.totalCirculationStarttime = totalCirculationStarttime; }
public String getTotalCirculationEndtime() { return totalCirculationEndtime; }
public void setTotalCirculationEndtime(String totalCirculationEndtime) { this.totalCirculationEndtime = totalCirculationEndtime; }

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