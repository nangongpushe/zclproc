package com.dhc.fastersoft.entity.store;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class StorageCooling {
	private String id;
	private String warehouse;
	private String warehouseId;
	private String encode;
	private String type;
	private String diameter;
	private String bulkHeight;
	private String bulkCubage;
	private String grainVariety;
	private String dew;
	private String impurity;
	private String realQuantity;
	private String valleyCoolerModel;
	private String valleyCoolerNum;
	private String kw;
	private String mht;
	private String aspirationType;
	private String mh;
	private String purpose;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date startTime;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm")
	private Date endTime;
	private String totalTime;
	
	private String tempMax;
	private String tempMin;
	private String tempAvg;
	private String rhMax;
	private String rhMin;
	private String rhAvg;
	private String beforeMax;
	private String beforeMin;
	private String beforeAvg;
	private String afterMax;
	private String afterMin;
	private String afterAvg;
	private String gradMax;
	private String gradMin;
	private String gradAvg;
	private String dewMax;
	private String dewMin;
	private String dewAvg;
	
	private String coolingAirTemp;
	private String coolingAirRh;
	private String ability;
	private String totalPower;
	private String energyConsum;
	private String electrovalency;
	private String cost;
	private String custodian;
	private String operator;
	private String operatorId;
	private String leader;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date recordDate;
	private String creator;
	private Date createDate;
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
	public String getDiameter() {
		return diameter;
	}
	public void setDiameter(String diameter) {
		this.diameter = diameter;
	}
	public String getBulkHeight() {
		return bulkHeight;
	}
	public void setBulkHeight(String bulkHeight) {
		this.bulkHeight = bulkHeight;
	}
	public String getBulkCubage() {
		return bulkCubage;
	}
	public void setBulkCubage(String bulkCubage) {
		this.bulkCubage = bulkCubage;
	}
	public String getGrainVariety() {
		return grainVariety;
	}
	public void setGrainVariety(String grainVariety) {
		this.grainVariety = grainVariety;
	}
	public String getDew() {
		return dew;
	}
	public void setDew(String dew) {
		this.dew = dew;
	}
	public String getImpurity() {
		return impurity;
	}
	public void setImpurity(String impurity) {
		this.impurity = impurity;
	}
	public String getRealQuantity() {
		return realQuantity;
	}
	public void setRealQuantity(String realQuantity) {
		this.realQuantity = realQuantity;
	}
	public String getValleyCoolerModel() {
		return valleyCoolerModel;
	}
	public void setValleyCoolerModel(String valleyCoolerModel) {
		this.valleyCoolerModel = valleyCoolerModel;
	}
	public String getValleyCoolerNum() {
		return valleyCoolerNum;
	}
	public void setValleyCoolerNum(String valleyCoolerNum) {
		this.valleyCoolerNum = valleyCoolerNum;
	}
	public String getKw() {
		return kw;
	}
	public void setKw(String kw) {
		this.kw = kw;
	}
	public String getMht() {
		return mht;
	}
	public void setMht(String mht) {
		this.mht = mht;
	}
	public String getAspirationType() {
		return aspirationType;
	}
	public void setAspirationType(String aspirationType) {
		this.aspirationType = aspirationType;
	}
	public String getMh() {
		return mh;
	}
	public void setMh(String mh) {
		this.mh = mh;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public String getTotalTime() {
		return totalTime;
	}
	public void setTotalTime(String totalTime) {
		this.totalTime = totalTime;
	}
	public String getTempMax() {
		return tempMax;
	}
	public void setTempMax(String tempMax) {
		this.tempMax = tempMax;
	}
	public String getTempMin() {
		return tempMin;
	}
	public void setTempMin(String tempMin) {
		this.tempMin = tempMin;
	}
	public String getTempAvg() {
		return tempAvg;
	}
	public void setTempAvg(String tempAvg) {
		this.tempAvg = tempAvg;
	}
	public String getRhMax() {
		return rhMax;
	}
	public void setRhMax(String rhMax) {
		this.rhMax = rhMax;
	}
	public String getRhMin() {
		return rhMin;
	}
	public void setRhMin(String rhMin) {
		this.rhMin = rhMin;
	}
	public String getRhAvg() {
		return rhAvg;
	}
	public void setRhAvg(String rhAvg) {
		this.rhAvg = rhAvg;
	}
	public String getBeforeMax() {
		return beforeMax;
	}
	public void setBeforeMax(String beforeMax) {
		this.beforeMax = beforeMax;
	}
	public String getBeforeMin() {
		return beforeMin;
	}
	public void setBeforeMin(String beforeMin) {
		this.beforeMin = beforeMin;
	}
	public String getBeforeAvg() {
		return beforeAvg;
	}
	public void setBeforeAvg(String beforeAvg) {
		this.beforeAvg = beforeAvg;
	}
	public String getAfterMax() {
		return afterMax;
	}
	public void setAfterMax(String afterMax) {
		this.afterMax = afterMax;
	}
	public String getAfterMin() {
		return afterMin;
	}
	public void setAfterMin(String afterMin) {
		this.afterMin = afterMin;
	}
	public String getAfterAvg() {
		return afterAvg;
	}
	public void setAfterAvg(String afterAvg) {
		this.afterAvg = afterAvg;
	}
	public String getGradMax() {
		return gradMax;
	}
	public void setGradMax(String gradMax) {
		this.gradMax = gradMax;
	}
	public String getGradMin() {
		return gradMin;
	}
	public void setGradMin(String gradMin) {
		this.gradMin = gradMin;
	}
	public String getGradAvg() {
		return gradAvg;
	}
	public void setGradAvg(String gradAvg) {
		this.gradAvg = gradAvg;
	}
	public String getDewMax() {
		return dewMax;
	}
	public void setDewMax(String dewMax) {
		this.dewMax = dewMax;
	}
	public String getDewMin() {
		return dewMin;
	}
	public void setDewMin(String dewMin) {
		this.dewMin = dewMin;
	}
	public String getDewAvg() {
		return dewAvg;
	}
	public void setDewAvg(String dewAvg) {
		this.dewAvg = dewAvg;
	}
	public String getCoolingAirTemp() {
		return coolingAirTemp;
	}
	public void setCoolingAirTemp(String coolingAirTemp) {
		this.coolingAirTemp = coolingAirTemp;
	}
	public String getCoolingAirRh() {
		return coolingAirRh;
	}
	public void setCoolingAirRh(String coolingAirRh) {
		this.coolingAirRh = coolingAirRh;
	}
	public String getAbility() {
		return ability;
	}
	public void setAbility(String ability) {
		this.ability = ability;
	}
	public String getTotalPower() {
		return totalPower;
	}
	public void setTotalPower(String totalPower) {
		this.totalPower = totalPower;
	}
	public String getEnergyConsum() {
		return energyConsum;
	}
	public void setEnergyConsum(String energyConsum) {
		this.energyConsum = energyConsum;
	}
	public String getElectrovalency() {
		return electrovalency;
	}
	public void setElectrovalency(String electrovalency) {
		this.electrovalency = electrovalency;
	}
	public String getCost() {
		return cost;
	}
	public void setCost(String cost) {
		this.cost = cost;
	}
	public String getCustodian() {
		return custodian;
	}
	public void setCustodian(String custodian) {
		this.custodian = custodian;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getLeader() {
		return leader;
	}
	public void setLeader(String leader) {
		this.leader = leader;
	}

	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public Date getRecordDate() {
		return recordDate;
	}
	public void setRecordDate(Date recordDate) {
		this.recordDate = recordDate;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getOperatorId() {
		return operatorId;
	}

	public void setOperatorId(String operatorId) {
		this.operatorId = operatorId;
	}

	public String getWarehouseId() {
		return warehouseId;
	}

	public void setWarehouseId(String warehouseId) {
		this.warehouseId = warehouseId;
	}
}