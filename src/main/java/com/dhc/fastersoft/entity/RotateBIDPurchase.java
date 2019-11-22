package com.dhc.fastersoft.entity;



import cn.afterturn.easypoi.excel.annotation.Excel;

import java.math.BigDecimal;


public class RotateBIDPurchase {
	private String id;
	private String bidID;
//	@Excel(name="所属方案标号",isImportField="true")
	private String schemeID;
//	@Excel(name="所属方案名称",isImportField="true")
	private String schemeName;
	@Excel(name="标的号",isImportField="true")
	private String bidSerial;
	@Excel(name="所属企业", isImportField = "true")
	private String enterprise;
	private String enterpriseId;
	@Excel(name="所属库点",isImportField="true")
	private String company;
	@Excel(name="仓房编号",isImportField="true")
	private String storeHouse;
	@Excel(name="数量(吨)",isImportField="true")
	private BigDecimal quantity;
	@Excel(name="产地",isImportField="true")
	private String produceArea;
	@Excel(name="生产年份",isImportField="true")
	private String produceYear;
	@Excel(name="包装储粮方式",isImportField="true")
	private String packageType;
	@Excel(name="粒型",isImportField="true")
	private String grainShape;
	@Excel(name="交货日期起",isImportField="true")
	private String deliveryStart;
	@Excel(name="交货日期止",isImportField="true")
	private String deliveryEnd;
	@Excel(name="滞纳金率",isImportField="true")
	private BigDecimal overdueRate;
	@Excel(name="日接受能力",isImportField="true")
	private BigDecimal dailyReceptivity;
	@Excel(name="运输类型",isImportField="true")
	private String transportType;
	@Excel(name="所属库点联系人",isImportField="true")
	private String contact;
	@Excel(name="联系电话",isImportField="true")
	private String contactNumber;
	private String wareHouseId;//库点id
	@Excel(name="质量等级",isImportField="true")
	private String planLevel;
	@Excel(name="货款支付免息截止日期",isImportField="true")
	private String loanPaymentEndDate;
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
	@Excel(name = "脱氧雪腐镰刀菌(μg/kg)", isImportField = "true")
	private String fusariumSolani;
	@Excel(name = "玉米赤霉烯酮(μg/kg)", isImportField = "true")
	private String zearalenone;
	@Excel(name = "出糙(%)", isImportField = "true")
	private String brownRiceRecovery;

	@Excel(name = "杂质(%)", isImportField = "true")
	private String adulteration;
	@Excel(name = "黄粒米(%)", isImportField = "true")
	private String yellowColouredRice;
	@Excel(name = "小麦湿面筋(%)", isImportField = "true")
	private String wetWheatGluten;
	@Excel(name = "酸价(KOH)(mg/g)", isImportField = "true")
	private String acidValue;

	@Excel(name = "过氧化值(mmol/kg)", isImportField = "true")
	private String peroxideValue;
	@Excel(name = "三唑磷(mg/kg)", isImportField = "true")
	private String triazophos;
	@Excel(name = "不溶性杂质(%)", isImportField = "true")
	private String insolubleImpurities;
	@Excel(name = "乐果(mg/kg)", isImportField = "true")
	private String dimethoate;
	@Excel(name = "亚油酸", isImportField = "true")
	private String linoleicAcid;

	@Excel(name = "亚麻酸", isImportField = "true")
	private String linolenicAcid;
	@Excel(name = "加热试验(280℃)", isImportField = "true")
	private String heatingTest;
	@Excel(name = "呕吐毒素含量(μg/kg)", isImportField = "true")
	private String vomitoxinContent;
	@Excel(name = "总汞(以Hg计)(mg/kg)", isImportField = "true")
	private String totalMercury;
	@Excel(name = "总砷(mg/kg)", isImportField = "true")
	private String arsenic;
	@Excel(name = "整精米率(%)", isImportField = "true")
	private String headRice;
	@Excel(name = "无机砷(mg/kg)", isImportField = "true")
	private String inorganicArsenic;
	@Excel(name = "棕桐酸", isImportField = "true")
	private String palmiticAcidP;
	@Excel(name = "棕榈酸", isImportField = "true")
	private String palmiticAcid;
	@Excel(name = "毒死蜱(mg/kg)", isImportField = "true")
	private String dursban;
	@Excel(name = "比重（d2020）", isImportField = "true")
	private String specificGravity;
	@Excel(name = "气味、滋味", isImportField = "true")
	private String odour;
	@Excel(name = "水分及挥发物(%)", isImportField = "true")
	private String moistureAndVolatileMatter;
	@Excel(name = "水分及不挥发物%", isImportField = "true")
	private String moistureAndNvolatileMatter;
	@Excel(name = "水胺硫磷(mg/kg)", isImportField = "true")
	private String isocarbophos;
	@Excel(name = "汞(mg/kg)", isImportField = "true")
	private String mercury;
	@Excel(name = "油酸", isImportField = "true")
	private String oleicAcid;
	@Excel(name = "溶剂残留量", isImportField = "true")
	private String residualSolvent;
	@Excel(name = "硬脂酸", isImportField = "true")
	private String stearicAcid;
	@Excel(name = "脂肪酸值（mgKOH/100g干基）", isImportField = "true")
	private String fattyAcid;
	@Excel(name = "花生酸", isImportField = "true")
	private String arachidicAcid;

	@Excel(name = "花生烯酸", isImportField = "true")
	private String arachidonicAcid;

	@Excel(name = "芥酸", isImportField = "true")
	private String erucicAcid;
	@Excel(name = "谷外糙米(%)", isImportField = "true")
	private String huskedRiceInPeddy;
	@Excel(name = "铅(以Pb计)(mg/kg)", isImportField = "true")
	private String lead;

	@Excel(name = "镉(以Cd计)(mg/kg)", isImportField = "true")
	private String chromium;
	@Excel(name = "马拉硫磷(mg/kg)", isImportField = "true")
	private String malathion;

	public String getPlanLevel() {
		return planLevel;
	}

	public void setPlanLevel(String planLevel) {
		this.planLevel = planLevel;
	}

	public String getLoanPaymentEndDate() {
		return loanPaymentEndDate;
	}

	public void setLoanPaymentEndDate(String loanPaymentEndDate) {
		this.loanPaymentEndDate = loanPaymentEndDate;
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
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getStoreHouse() {
		return storeHouse;
	}
	public void setStoreHouse(String storeHouse) {
		this.storeHouse = storeHouse;
	}
	public String getProduceArea() {
		return produceArea;
	}
	public void setProduceArea(String produceArea) {
		this.produceArea = produceArea;
	}
	public String getProduceYear() {
		return produceYear;
	}
	public void setProduceYear(String produceYear) {
		this.produceYear = produceYear;
	}
	
	public String getPackageType() {
		return packageType;
	}
	public void setPackageType(String packageType) {
		this.packageType = packageType;
	}
	public String getGrainShape() {
		return grainShape;
	}
	public void setGrainShape(String grainShape) {
		this.grainShape = grainShape;
	}
	public String getDeliveryStart() {
		return deliveryStart;
	}
	public void setDeliveryStart(String deliveryStart) {
		this.deliveryStart = deliveryStart;
	}
	public String getDeliveryEnd() {
		return deliveryEnd;
	}
	public void setDeliveryEnd(String deliveryEnd) {
		this.deliveryEnd = deliveryEnd;
	}
	public String getTransportType() {
		return transportType;
	}
	public void setTransportType(String transportType) {
		this.transportType = transportType;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getContactNumber() {
		return contactNumber;
	}
	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}

	public String getEnterprise() {
		return enterprise;
	}

	public void setEnterprise(String enterprise) {
		this.enterprise = enterprise;
	}

	public String getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(String enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	public BigDecimal getQuantity() {
		return quantity;
	}

	public void setQuantity(BigDecimal quantity) {
		this.quantity = quantity;
	}

	public BigDecimal getOverdueRate() {
		return overdueRate;
	}

	public void setOverdueRate(BigDecimal overdueRate) {
		this.overdueRate = overdueRate;
	}

	public BigDecimal getDailyReceptivity() {
		return dailyReceptivity;
	}

	public void setDailyReceptivity(BigDecimal dailyReceptivity) {
		this.dailyReceptivity = dailyReceptivity;
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

	public void setAFB1(String AFB1) {
		this.AFB1 = AFB1;
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

	public String getYellowColouredRice() {
		return yellowColouredRice;
	}

	public void setYellowColouredRice(String yellowColouredRice) {
		this.yellowColouredRice = yellowColouredRice;
	}

	public String getWetWheatGluten() {
		return wetWheatGluten;
	}

	public void setWetWheatGluten(String wetWheatGluten) {
		this.wetWheatGluten = wetWheatGluten;
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

	public String getTriazophos() {
		return triazophos;
	}

	public void setTriazophos(String triazophos) {
		this.triazophos = triazophos;
	}

	public String getInsolubleImpurities() {
		return insolubleImpurities;
	}

	public void setInsolubleImpurities(String insolubleImpurities) {
		this.insolubleImpurities = insolubleImpurities;
	}

	public String getDimethoate() {
		return dimethoate;
	}

	public void setDimethoate(String dimethoate) {
		this.dimethoate = dimethoate;
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

	public String getHeatingTest() {
		return heatingTest;
	}

	public void setHeatingTest(String heatingTest) {
		this.heatingTest = heatingTest;
	}

	public String getVomitoxinContent() {
		return vomitoxinContent;
	}

	public void setVomitoxinContent(String vomitoxinContent) {
		this.vomitoxinContent = vomitoxinContent;
	}

	public String getTotalMercury() {
		return totalMercury;
	}

	public void setTotalMercury(String totalMercury) {
		this.totalMercury = totalMercury;
	}

	public String getArsenic() {
		return arsenic;
	}

	public void setArsenic(String arsenic) {
		this.arsenic = arsenic;
	}

	public String getHeadRice() {
		return headRice;
	}

	public void setHeadRice(String headRice) {
		this.headRice = headRice;
	}

	public String getInorganicArsenic() {
		return inorganicArsenic;
	}

	public void setInorganicArsenic(String inorganicArsenic) {
		this.inorganicArsenic = inorganicArsenic;
	}

	public String getPalmiticAcidP() {
		return palmiticAcidP;
	}

	public void setPalmiticAcidP(String palmiticAcidP) {
		this.palmiticAcidP = palmiticAcidP;
	}

	public String getPalmiticAcid() {
		return palmiticAcid;
	}

	public void setPalmiticAcid(String palmiticAcid) {
		this.palmiticAcid = palmiticAcid;
	}

	public String getDursban() {
		return dursban;
	}

	public void setDursban(String dursban) {
		this.dursban = dursban;
	}

	public String getSpecificGravity() {
		return specificGravity;
	}

	public void setSpecificGravity(String specificGravity) {
		this.specificGravity = specificGravity;
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

	public String getMoistureAndNvolatileMatter() {
		return moistureAndNvolatileMatter;
	}

	public void setMoistureAndNvolatileMatter(String moistureAndNvolatileMatter) {
		this.moistureAndNvolatileMatter = moistureAndNvolatileMatter;
	}

	public String getIsocarbophos() {
		return isocarbophos;
	}

	public void setIsocarbophos(String isocarbophos) {
		this.isocarbophos = isocarbophos;
	}

	public String getMercury() {
		return mercury;
	}

	public void setMercury(String mercury) {
		this.mercury = mercury;
	}

	public String getOleicAcid() {
		return oleicAcid;
	}

	public void setOleicAcid(String oleicAcid) {
		this.oleicAcid = oleicAcid;
	}

	public String getResidualSolvent() {
		return residualSolvent;
	}

	public void setResidualSolvent(String residualSolvent) {
		this.residualSolvent = residualSolvent;
	}

	public String getStearicAcid() {
		return stearicAcid;
	}

	public void setStearicAcid(String stearicAcid) {
		this.stearicAcid = stearicAcid;
	}

	public String getFattyAcid() {
		return fattyAcid;
	}

	public void setFattyAcid(String fattyAcid) {
		this.fattyAcid = fattyAcid;
	}

	public String getArachidicAcid() {
		return arachidicAcid;
	}

	public void setArachidicAcid(String arachidicAcid) {
		this.arachidicAcid = arachidicAcid;
	}

	public String getArachidonicAcid() {
		return arachidonicAcid;
	}

	public void setArachidonicAcid(String arachidonicAcid) {
		this.arachidonicAcid = arachidonicAcid;
	}

	public String getErucicAcid() {
		return erucicAcid;
	}

	public void setErucicAcid(String erucicAcid) {
		this.erucicAcid = erucicAcid;
	}

	public String getHuskedRiceInPeddy() {
		return huskedRiceInPeddy;
	}

	public void setHuskedRiceInPeddy(String huskedRiceInPeddy) {
		this.huskedRiceInPeddy = huskedRiceInPeddy;
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

	public String getMalathion() {
		return malathion;
	}

	public void setMalathion(String malathion) {
		this.malathion = malathion;
	}
}
