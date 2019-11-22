package com.dhc.fastersoft.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;

import java.math.BigDecimal;

public class RotateBIDSale {
    private String id;
    private String bidID;
    //	@Excel(name="所属方案标号",isImportField="true")
    private String schemeID;
    //	@Excel(name="所属方案名称",isImportField="true")
    private String schemeName;
    @Excel(name = "标的号", isImportField = "true")
    private String bidSerial;
    @Excel(name = "合计(吨)", isImportField = "true")
    private BigDecimal total;
    @Excel(name = "粮食品种", isImportField = "true")
    private String grainType;
    @Excel(name = "粮食产地", isImportField = "true")
    private String produceArea;
    @Excel(name = "入库年度", isImportField = "true")
    private String warehouseYear;
    @Excel(name = "存储方式", isImportField = "true")
    private String storageType;
    @Excel(name = "提货日期起", isImportField = "true")
    private String takeStart;
    @Excel(name = "提货日期止", isImportField = "true")
    private String takeEnd;
    @Excel(name = "交货所属库点", isImportField = "true")
    private String deliveryPlace;
    @Excel(name = "仓号", isImportField = "true")
    private String storehouse;
    @Excel(name = "容重g/L", isImportField = "true")
    private String unitWeight;
    @Excel(name = "不完善粒%", isImportField = "true")
    private String unsoundGrain;
    @Excel(name = "杂质总量%", isImportField = "true")
    private String impurity;
    @Excel(name = "其中:矿物质%", isImportField = "true")
    private String mineral;
    @Excel(name = "水分", isImportField = "true")
    private String dew;
    @Excel(name = "硬度指数", isImportField = "true")
    private String hardness;
    @Excel(name = "色泽", isImportField = "true")
    private String tincture;
    @Excel(name = "气味", isImportField = "true")
    private String smell;
    @Excel(name = "面筋吸水量%", isImportField = "true")
    private String waterAbsorption;
    @Excel(name = "品尝评分值", isImportField = "true")
    private String tastingScore;
    @Excel(name = "黄曲霉毒素B1(μg/kg)", isImportField = "true")
    private String AFB1;
    @Excel(name = "脱氧雪腐镰刀菌烯醇(μg/kg)", isImportField = "true")
    private String fusariumSolani;
    @Excel(name = "玉米赤霉烯酮(μg/kg)", isImportField = "true")
    private String zearalenone;

    // --------------------------------------------------------
    @Excel(name = "铅(以Pb计)(mg/kg)", isImportField = "true")
    private String lead;

    @Excel(name = "镉(以Cd计)(mg/kg)", isImportField = "true")
    private String chromium;

    @Excel(name = "汞(mg/kg)", isImportField = "true")
    private String mercury;

    @Excel(name = "总砷(mg/kg)", isImportField = "true")
    private String arsenic;

    @Excel(name = "无机砷(mg/kg)", isImportField = "true")
    private String inorganicArsenic;

    @Excel(name = "出糙(%)", isImportField = "true")
    private String brownRiceRecovery;

    @Excel(name = "杂质(%)", isImportField = "true")
    private String adulteration;

    @Excel(name = "谷外糙米(%)", isImportField = "true")
    private String huskedRiceInPeddy;

    @Excel(name = "黄粒米(%)", isImportField = "true")
    private String yellowColouredRice;

    @Excel(name = "整精米率(%)", isImportField = "true")
    private String headRice;

    @Excel(name = "脂肪酸值（mgKOH/100g干基）", isImportField = "true")
    private String fattyAcid;

    @Excel(name = "乐果(mg/kg)", isImportField = "true")
    private String dimethoate;

    @Excel(name = "三唑磷(mg/kg)", isImportField = "true")
    private String triazophos;

    @Excel(name = "毒死蜱(mg/kg)", isImportField = "true")
    private String dursban;

    @Excel(name = "水胺硫磷(mg/kg)", isImportField = "true")
    private String isocarbophos;

    @Excel(name = "马拉硫磷(mg/kg)", isImportField = "true")
    private String malathion;

    @Excel(name = "气味、滋味", isImportField = "true")
    private String odour;

    @Excel(name = "水分及挥发物(%)", isImportField = "true")
    private String moistureAndVolatileMatter;

    @Excel(name = "不溶性杂质(%)", isImportField = "true")
    private String insolubleImpurities;

    @Excel(name = "加热试验(280℃)", isImportField = "true")
    private String heatingTest;

    @Excel(name = "酸价(KOH)(mg/g)", isImportField = "true")
    private String acidValue;

    @Excel(name = "过氧化值(mmol/kg)", isImportField = "true")
    private String peroxideValue;

    @Excel(name = "溶剂残留量（mg/kg）", isImportField = "true")
    private String residualSolvent;

    @Excel(name = "棕榈酸（%）", isImportField = "true")
    private String palmiticAcid;

    @Excel(name = "硬脂酸（%）", isImportField = "true")
    private String stearicAcid;

    @Excel(name = "油酸（%）", isImportField = "true")
    private String oleicAcid;

    @Excel(name = "亚油酸（%）", isImportField = "true")
    private String linoleicAcid;

    @Excel(name = "亚麻酸（%）", isImportField = "true")
    private String linolenicAcid;

    @Excel(name = "花生酸（%）", isImportField = "true")
    private String arachidicAcid;

    @Excel(name = "花生一烯酸（%）", isImportField = "true")
    private String arachidicOneAcid;

    @Excel(name = "芥酸（%）", isImportField = "true")
    private String erucicAcid;

    @Excel(name = "比重（d2020）", isImportField = "true")
    private String specificGravity;

    // --------------------------------------------------
    @Excel(name = "存储品质判定", isImportField = "true")
    private String storageQuality;

    private String wareHouseId;//库点id

    @Excel(name = "质量等级", isImportField = "true")
    private String planLevel;

    public String getPlanLevel() {
        return planLevel;
    }

    public void setPlanLevel(String planLevel) {
        this.planLevel = planLevel;
    }

    public String getWareHouseId() {
        return wareHouseId;
    }

    public void setWareHouseId(String wareHouseId) {
        this.wareHouseId = wareHouseId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getBidID() {
        return bidID;
    }

    public void setBidID(String bidID) {
        this.bidID = bidID;
    }

    public String getSchemeID() {
        return schemeID;
    }

    public void setSchemeID(String schemeID) {
        this.schemeID = schemeID;
    }

    public String getSchemeName() {
        return schemeName;
    }

    public void setSchemeName(String schemeName) {
        this.schemeName = schemeName;
    }

    public String getBidSerial() {
        return bidSerial;
    }

    public void setBidSerial(String bidSerial) {
        this.bidSerial = bidSerial;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    public String getGrainType() {
        return grainType;
    }

    public void setGrainType(String grainType) {
        this.grainType = grainType;
    }

    public String getProduceArea() {
        return produceArea;
    }

    public void setProduceArea(String produceArea) {
        this.produceArea = produceArea;
    }

    public String getWarehouseYear() {
        return warehouseYear;
    }

    public void setWarehouseYear(String warehouseYear) {
        this.warehouseYear = warehouseYear;
    }

    public String getStorageType() {
        return storageType;
    }

    public void setStorageType(String storageType) {
        this.storageType = storageType;
    }

    public String getTakeStart() {
        return takeStart;
    }

    public void setTakeStart(String takeStart) {
        this.takeStart = takeStart;
    }

    public String getTakeEnd() {
        return takeEnd;
    }

    public void setTakeEnd(String takeEnd) {
        this.takeEnd = takeEnd;
    }

    public String getDeliveryPlace() {
        return deliveryPlace;
    }

    public void setDeliveryPlace(String deliveryPlace) {
        this.deliveryPlace = deliveryPlace;
    }

    public String getUnitWeight() {
        return unitWeight;
    }

    public void setUnitWeight(String unitWeight) {
        this.unitWeight = unitWeight;
    }

    public String getUnsoundGrain() {
        return unsoundGrain;
    }

    public void setUnsoundGrain(String unsoundGrain) {
        this.unsoundGrain = unsoundGrain;
    }

    public String getImpurity() {
        return impurity;
    }

    public void setImpurity(String impurity) {
        this.impurity = impurity;
    }

    public String getMineral() {
        return mineral;
    }

    public void setMineral(String mineral) {
        this.mineral = mineral;
    }

    public String getDew() {
        return dew;
    }

    public void setDew(String dew) {
        this.dew = dew;
    }

    public String getHardness() {
        return hardness;
    }

    public void setHardness(String hardness) {
        this.hardness = hardness;
    }

    public String getTincture() {
        return tincture;
    }

    public void setTincture(String tincture) {
        this.tincture = tincture;
    }

    public String getSmell() {
        return smell;
    }

    public void setSmell(String smell) {
        this.smell = smell;
    }

    public String getWaterAbsorption() {
        return waterAbsorption;
    }

    public void setWaterAbsorption(String waterAbsorption) {
        this.waterAbsorption = waterAbsorption;
    }

    public String getTastingScore() {
        return tastingScore;
    }

    public void setTastingScore(String tastingScore) {
        this.tastingScore = tastingScore;
    }

    public String getAFB1() {
        return AFB1;
    }

    public void setAFB1(String aFB1) {
        AFB1 = aFB1;
    }

    public String getFusariumSolani() {
        return fusariumSolani;
    }

    public void setFusariumSolani(String fusariumSolani) {
        this.fusariumSolani = fusariumSolani;
    }

    public String getZearalenone() {
        return zearalenone;
    }

    public void setZearalenone(String zearalenone) {
        this.zearalenone = zearalenone;
    }

    public String getStorageQuality() {
        return storageQuality;
    }

    public void setStorageQuality(String storageQuality) {
        this.storageQuality = storageQuality;
    }

    public String getStorehouse() {
        return storehouse;
    }

    public void setStorehouse(String storehouse) {
        this.storehouse = storehouse;
    }

    public String getLead() {
        return lead;
    }

    public void setLead(String lead) {
        this.lead = lead;
    }

    public String getChromium() {
        return chromium;
    }

    public void setChromium(String chromium) {
        this.chromium = chromium;
    }

    public String getMercury() {
        return mercury;
    }

    public void setMercury(String mercury) {
        this.mercury = mercury;
    }

    public String getArsenic() {
        return arsenic;
    }

    public void setArsenic(String arsenic) {
        this.arsenic = arsenic;
    }

    public String getInorganicArsenic() {
        return inorganicArsenic;
    }

    public void setInorganicArsenic(String inorganicArsenic) {
        this.inorganicArsenic = inorganicArsenic;
    }

    public String getBrownRiceRecovery() {
        return brownRiceRecovery;
    }

    public void setBrownRiceRecovery(String brownRiceRecovery) {
        this.brownRiceRecovery = brownRiceRecovery;
    }

    public String getAdulteration() {
        return adulteration;
    }

    public void setAdulteration(String adulteration) {
        this.adulteration = adulteration;
    }

    public String getHuskedRiceInPeddy() {
        return huskedRiceInPeddy;
    }

    public void setHuskedRiceInPeddy(String huskedRiceInPeddy) {
        this.huskedRiceInPeddy = huskedRiceInPeddy;
    }

    public String getYellowColouredRice() {
        return yellowColouredRice;
    }

    public void setYellowColouredRice(String yellowColouredRice) {
        this.yellowColouredRice = yellowColouredRice;
    }

    public String getHeadRice() {
        return headRice;
    }

    public void setHeadRice(String headRice) {
        this.headRice = headRice;
    }

    public String getFattyAcid() {
        return fattyAcid;
    }

    public void setFattyAcid(String fattyAcid) {
        this.fattyAcid = fattyAcid;
    }

    public String getDimethoate() {
        return dimethoate;
    }

    public void setDimethoate(String dimethoate) {
        this.dimethoate = dimethoate;
    }

    public String getTriazophos() {
        return triazophos;
    }

    public void setTriazophos(String triazophos) {
        this.triazophos = triazophos;
    }

    public String getDursban() {
        return dursban;
    }

    public void setDursban(String dursban) {
        this.dursban = dursban;
    }

    public String getIsocarbophos() {
        return isocarbophos;
    }

    public void setIsocarbophos(String isocarbophos) {
        this.isocarbophos = isocarbophos;
    }

    public String getMalathion() {
        return malathion;
    }

    public void setMalathion(String malathion) {
        this.malathion = malathion;
    }

    public String getOdour() {
        return odour;
    }

    public void setOdour(String odour) {
        this.odour = odour;
    }

    public String getMoistureAndVolatileMatter() {
        return moistureAndVolatileMatter;
    }

    public void setMoistureAndVolatileMatter(String moistureAndVolatileMatter) {
        this.moistureAndVolatileMatter = moistureAndVolatileMatter;
    }

    public String getInsolubleImpurities() {
        return insolubleImpurities;
    }

    public void setInsolubleImpurities(String insolubleImpurities) {
        this.insolubleImpurities = insolubleImpurities;
    }

    public String getHeatingTest() {
        return heatingTest;
    }

    public void setHeatingTest(String heatingTest) {
        this.heatingTest = heatingTest;
    }

    public String getAcidValue() {
        return acidValue;
    }

    public void setAcidValue(String acidValue) {
        this.acidValue = acidValue;
    }

    public String getPeroxideValue() {
        return peroxideValue;
    }

    public void setPeroxideValue(String peroxideValue) {
        this.peroxideValue = peroxideValue;
    }

    public String getResidualSolvent() {
        return residualSolvent;
    }

    public void setResidualSolvent(String residualSolvent) {
        this.residualSolvent = residualSolvent;
    }

    public String getPalmiticAcid() {
        return palmiticAcid;
    }

    public void setPalmiticAcid(String palmiticAcid) {
        this.palmiticAcid = palmiticAcid;
    }

    public String getStearicAcid() {
        return stearicAcid;
    }

    public void setStearicAcid(String stearicAcid) {
        this.stearicAcid = stearicAcid;
    }

    public String getOleicAcid() {
        return oleicAcid;
    }

    public void setOleicAcid(String oleicAcid) {
        this.oleicAcid = oleicAcid;
    }

    public String getLinoleicAcid() {
        return linoleicAcid;
    }

    public void setLinoleicAcid(String linoleicAcid) {
        this.linoleicAcid = linoleicAcid;
    }

    public String getLinolenicAcid() {
        return linolenicAcid;
    }

    public void setLinolenicAcid(String linolenicAcid) {
        this.linolenicAcid = linolenicAcid;
    }

    public String getArachidicAcid() {
        return arachidicAcid;
    }

    public void setArachidicAcid(String arachidicAcid) {
        this.arachidicAcid = arachidicAcid;
    }

    public String getArachidicOneAcid() {
        return arachidicOneAcid;
    }

    public void setArachidicOneAcid(String arachidicOneAcid) {
        this.arachidicOneAcid = arachidicOneAcid;
    }

    public String getErucicAcid() {
        return erucicAcid;
    }

    public void setErucicAcid(String erucicAcid) {
        this.erucicAcid = erucicAcid;
    }

    public String getSpecificGravity() {
        return specificGravity;
    }

    public void setSpecificGravity(String specificGravity) {
        this.specificGravity = specificGravity;
    }
}
