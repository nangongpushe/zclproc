package com.dhc.fastersoft.entity;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

public class NgasOperaRecord {
    private static SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
    private String id;
    private String warehouse;//所属库点
    private String warehouseId; // 库点ID
    private String weather;//天气
    private BigDecimal temperature;//气温
    private BigDecimal airWet;//气湿
    private String storehouseType;//仓房类型
    private String encode;//仓房编号
    private String sealMethod;//密封方法
    private String storehouseStructure;//仓房结构
    private String airTightness;//气密性
    private Date instoreTime;//入库时间
    private BigDecimal storehouseVolume;//仓房总体积
    private BigDecimal grainBulkVolume;//粮堆体积
    private BigDecimal spaceVolume;//空间体积
    private String stackForm;//堆放形式
    private BigDecimal grainHeight;//粮堆高度
    private String isfumigated;//是否熏蒸
    private String grainType;//粮食品种
    private BigDecimal quantity;//数量
    private BigDecimal impurity;//杂质
    private BigDecimal storehouseTemp;//仓温(℃)
    private BigDecimal storehouseWet;//仓湿
    private BigDecimal dew;//水分(%)
    private BigDecimal maxGraintemp;//最高粮温
    private BigDecimal minGrainTemp;//最低粮温
    private BigDecimal avgGraintemp;//平均粮温
    private String pestLevel;//虫粮等级
    private String pestNames;//具体虫害名称
    private BigDecimal pestDensity;//害虫密度
    private String pestInsect;//虫害位置分布
    private Date findPestTime;//发现害虫时间
    private String windTunnelType;//风道类型
    private String gasChargeType;//充气方式
    private String nmakePlant;//制氮装置
    private Date degasDate;//散气日期
    private String degasType;//散气方式
    private BigDecimal degasTime;//散气时间
    private String resultJudge;
    private BigDecimal sumEnergy;//总能耗
    private BigDecimal avgEnergy;//吨粮能耗
    private String remark;//备注
    private Date createDate;//创建日期
    private String creatorId;//
    private List<NgasOperaSituation> ngasOperaSituation ;
    private Date reportDate;
    private String reportDateStr;
    private String creator;
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getWeather() {
        return weather;
    }

    public void setWeather(String weather) {
        this.weather = weather;
    }

    public BigDecimal getTemperature() {
        return temperature;
    }

    public void setTemperature(BigDecimal temperature) {
        this.temperature = temperature;
    }

    public BigDecimal getAirWet() {
        return airWet;
    }

    public void setAirWet(BigDecimal airWet) {
        this.airWet = airWet;
    }

    public String getStorehouseType() {
        return storehouseType;
    }

    public void setStorehouseType(String storehouseType) {
        this.storehouseType = storehouseType;
    }

    public String getEncode() {
        return encode;
    }

    public void setEncode(String encode) {
        this.encode = encode;
    }

    public String getSealMethod() {
        return sealMethod;
    }

    public void setSealMethod(String sealMethod) {
        this.sealMethod = sealMethod;
    }

    public String getStorehouseStructure() {
        return storehouseStructure;
    }

    public void setStorehouseStructure(String storehouseStructure) {
        this.storehouseStructure = storehouseStructure;
    }

    public String getAirTightness() {
        return airTightness;
    }

    public void setAirTightness(String airTightness) {
        this.airTightness = airTightness;
    }

    public Date getInstoreTime() {
        return instoreTime;
    }

    public void setInstoreTime(Date instoreTime) {
        this.instoreTime = instoreTime;
    }

    public BigDecimal getStorehouseVolume() {
        return storehouseVolume;
    }

    public void setStorehouseVolume(BigDecimal storehouseVolume) {
        this.storehouseVolume = storehouseVolume;
    }

    public BigDecimal getGrainBulkVolume() {
        return grainBulkVolume;
    }

    public void setGrainBulkVolume(BigDecimal grainBulkVolume) {
        this.grainBulkVolume = grainBulkVolume;
    }

    public BigDecimal getSpaceVolume() {
        return spaceVolume;
    }

    public void setSpaceVolume(BigDecimal spaceVolume) {
        this.spaceVolume = spaceVolume;
    }

    public String getStackForm() {
        return stackForm;
    }

    public void setStackForm(String stackForm) {
        this.stackForm = stackForm;
    }

    public BigDecimal getGrainHeight() {
        return grainHeight;
    }

    public void setGrainHeight(BigDecimal grainHeight) {
        this.grainHeight = grainHeight;
    }

    public String getIsfumigated() {
        return isfumigated;
    }

    public void setIsfumigated(String isfumigated) {
        this.isfumigated = isfumigated;
    }

    public String getGrainType() {
        return grainType;
    }

    public void setGrainType(String grainType) {
        this.grainType = grainType;
    }

    public BigDecimal getQuantity() {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getImpurity() {
        return impurity;
    }

    public void setImpurity(BigDecimal impurity) {
        this.impurity = impurity;
    }

    public BigDecimal getStorehouseTemp() {
        return storehouseTemp;
    }

    public void setStorehouseTemp(BigDecimal storehouseTemp) {
        this.storehouseTemp = storehouseTemp;
    }

    public BigDecimal getStorehouseWet() {
        return storehouseWet;
    }

    public void setStorehouseWet(BigDecimal storehouseWet) {
        this.storehouseWet = storehouseWet;
    }

    public BigDecimal getDew() {
        return dew;
    }

    public void setDew(BigDecimal dew) {
        this.dew = dew;
    }

    public BigDecimal getMaxGraintemp() {
        return maxGraintemp;
    }

    public void setMaxGraintemp(BigDecimal maxGraintemp) {
        this.maxGraintemp = maxGraintemp;
    }

    public BigDecimal getMinGrainTemp() {
        return minGrainTemp;
    }

    public void setMinGrainTemp(BigDecimal minGrainTemp) {
        this.minGrainTemp = minGrainTemp;
    }

    public BigDecimal getAvgGraintemp() {
        return avgGraintemp;
    }

    public void setAvgGraintemp(BigDecimal avgGraintemp) {
        this.avgGraintemp = avgGraintemp;
    }

    public String getPestLevel() {
        return pestLevel;
    }

    public void setPestLevel(String pestLevel) {
        this.pestLevel = pestLevel;
    }

    public String getPestNames() {
        return pestNames;
    }

    public void setPestNames(String pestNames) {
        this.pestNames = pestNames;
    }

    public BigDecimal getPestDensity() {
        return pestDensity;
    }

    public void setPestDensity(BigDecimal pestDensity) {
        this.pestDensity = pestDensity;
    }

    public String getPestInsect() {
        return pestInsect;
    }

    public void setPestInsect(String pestInsect) {
        this.pestInsect = pestInsect;
    }

    public Date getFindPestTime() {
        return findPestTime;
    }

    public void setFindPestTime(Date findPestTime) {
        this.findPestTime = findPestTime;
    }

    public String getWindTunnelType() {
        return windTunnelType;
    }

    public void setWindTunnelType(String windTunnelType) {
        this.windTunnelType = windTunnelType;
    }

    public String getGasChargeType() {
        return gasChargeType;
    }

    public void setGasChargeType(String gasChargeType) {
        this.gasChargeType = gasChargeType;
    }

    public String getNmakePlant() {
        return nmakePlant;
    }

    public void setNmakePlant(String nmakePlant) {
        this.nmakePlant = nmakePlant;
    }

    public Date getDegasDate() {
        return degasDate;
    }

    public void setDegasDate(Date degasDate) {
        this.degasDate = degasDate;
    }

    public String getDegasType() {
        return degasType;
    }

    public void setDegasType(String degasType) {
        this.degasType = degasType;
    }

    public BigDecimal getDegasTime() {
        return degasTime;
    }

    public void setDegasTime(BigDecimal degasTime) {
        this.degasTime = degasTime;
    }

    public BigDecimal getSumEnergy() {
        return sumEnergy;
    }

    public void setSumEnergy(BigDecimal sumEnergy) {
        this.sumEnergy = sumEnergy;
    }

    public BigDecimal getAvgEnergy() {
        return avgEnergy;
    }

    public void setAvgEnergy(BigDecimal avgEnergy) {
        this.avgEnergy = avgEnergy;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(String creatorId) {
        this.creatorId = creatorId;
    }

    public List<NgasOperaSituation> getNgasOperaSituation() {
        return ngasOperaSituation;
    }

    public void setNgasOperaSituation(List<NgasOperaSituation> ngasOperaSituation) {
        this.ngasOperaSituation = ngasOperaSituation;
    }

    public Date getReportDate() {
        return reportDate;
    }

    public void setReportDate(Date reportDate) {
        this.reportDate = reportDate;
        this.reportDateStr = DATE_FORMAT.format(reportDate);
    }

    public String getReportDateStr() {
        return reportDateStr;
    }

    public void setReportDateStr(String reportDateStr) {
        this.reportDateStr = reportDateStr;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(String warehouse) {
        this.warehouse = warehouse;
    }

    public String getResultJudge() {
        return resultJudge;
    }

    public void setResultJudge(String resultJudge) {
        this.resultJudge = resultJudge;
    }

    public String getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(String warehouseId) {
        this.warehouseId = warehouseId;
    }
    /* @Override
    public String toString() {
        return "NgasOperaRecord{" +
                "id='" + id + '\'' +
                ", warehouse='" + warehouse + '\'' +
                ", weather='" + weather + '\'' +
                ", temperature='" + temperature + '\'' +
                ", storehouseType='" + storehouseType + '\'' +
                ", encode=" + encode +
                ", sealMethod=" + sealMethod +
                ", storehouseStructure=" + storehouseStructure +
                ", airTightness=" + airTightness +
                ", instoreTime=" + instoreTime +
                ", storehouseVolume=" + storehouseVolume +
                ", grainBulkVolume=" + grainBulkVolume +
                ", spaceVolume=" + spaceVolume +
                ", stackForm=" + stackForm +
                ", grainHeight=" + grainHeight +
                ", isfumigated=" + isfumigated +
                ", grainType=" + grainType +
                ", quantity=" + quantity +
                ", impurity=" + impurity +
                ", storehouseTemp=" + storehouseTemp +
                ", storehouseWet=" + storehouseWet +
                ", dew=" + dew +
                ", maxGraintemp=" + maxGraintemp +
                ", minGrainTemp=" + minGrainTemp +
                ", avgGraintemp=" + avgGraintemp +
                ", pestLevel='" + pestLevel + '\'' +
                ", pestNames=" + pestNames +
                ", pestDensity='" + pestDensity + '\'' +
                ", pestInsect='" + pestInsect + '\'' +
                ", findPestTime=" + findPestTime +
                ", windTunnelType=" + windTunnelType +
                ", gasChargeType='" + gasChargeType + '\'' +
                ", nmakePlant='" + nmakePlant + '\'' +
                ", degasDate=" + degasDate +
                ", degasType=" + degasType +
                ", degasTime='" + degasTime + '\'' +
                ", resultJudge='" + resultJudge + '\'' +
                ", sumEnergy='" + sumEnergy + '\'' +
                ", avgEnergy='" + avgEnergy + '\'' +
                ", remark='" + remark + '\'' +
                ", createDate='" + createDate + '\'' +
                ", creatorId='" + creatorId + '\'' +
                ", ngasOperaSituation='" + ngasOperaSituation + '\'' +
                ", reportDate='" + reportDate + '\'' +
                ", reportDateStr='" + reportDateStr + '\'' +
                ", creator='" + creator + '\'' +
                '}';
    }*/
}
