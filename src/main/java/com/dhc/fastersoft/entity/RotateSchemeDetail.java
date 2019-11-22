package com.dhc.fastersoft.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;

import java.math.BigDecimal;
import java.util.Date;

public class RotateSchemeDetail {
	private String dId;
	@Excel(name="批次")
	private Long schemeBatch;
	@Excel(name="轮换类型")
	private String schemeType;
	@Excel(name="轮换方式")
	private String rotateType;
	@Excel(name="竞价时间",exportFormat="yyyy-MM-dd")
	private Date biddingTime;
	@Excel(name="轮换开始时间",exportFormat="yyyy-MM-dd")
	private Date startTime;
	@Excel(name="轮换结束时间",exportFormat="yyyy-MM-dd")
	private Date endTime;
	private String expectedCycle;
	@Excel(name="所属库点")
	private String libraryId;
	@Excel(name="仓房编号")
	private String branNumber;
	@Excel(name="生产年份")
	private String yieldTime;
	@Excel(name="粮食品种")
	private String foodType;
	private String realContainer;
	private String realStorage;
	@Excel(name="轮换数量")
	private double rotateNumber;
	@Excel(name="产地")
	private String ogirin;
	@Excel(name="计划等级")
	private String planLevel;
	private int realRotateNumber;
	private String schemeId;
	private String planDetailId;
	private String status;
	
	private String mainSchemeName;
	@Excel(name="质量详情")
	private String qualityDetail;

	private String warehouseId;

	private String enterpriseName;
	private String enterpriseId;
	@Excel(name="存储方式")
	private String storeType;

	private String planMainDetailId;//计划申报子表id

	private BigDecimal dealDetailNumber;//计划申报子表已轮换数量；

	private BigDecimal overdueTime;//允许逾期天数
	private BigDecimal qualityResultNum;//质检个数（出、入）

	private BigDecimal restNumber;

	@Excel(name="容重(g/L)")
	private String unitWeight;
	@Excel(name="不完善粒(%)")
	private String unsoundGrain;
	@Excel(name="杂质总量(%)")
	private String totalImpurities;
	@Excel(name="其中:矿物质(%)")
	private String mineral;
	@Excel(name="水分(%)")
	private String dew;
	@Excel(name="硬度指数")
	private String hardnessIndex;
	@Excel(name="色泽")
	private String colourOdor;
	@Excel(name="气味")
	private String smell;
	@Excel(name="面筋吸水量(%)")
	private String glutenSoakage;
	@Excel(name="品尝评分值(分)")
	private String tasteScore;
	@Excel(name="脱氧雪腐镰刀菌烯醇(μg/kg)")
	private String deoxynivalenol;
	@Excel(name="黄曲霉毒素B1(μg/kg)")
	private String aflatoxinB1;
	@Excel(name="玉米赤霉烯酮(μg/kg)")
	private String zearalenone;
	@Excel(name="铅(以Pb计)(mg/kg)")
	private String lead;
	@Excel(name="镉(以Cd计)(mg/kg)")
	private String cadmium;
	@Excel(name="汞(mg/kg)")
	private String mercury;
	@Excel(name="总砷(mg/kg)")
	private String totalArsenic;
	@Excel(name="无机砷(mg/kg)")
	private String inorganicArsenic;
	@Excel(name="出糙(%)")
	private String brown;
	@Excel(name="杂质(%)")
	private String impurity;
	@Excel(name="谷外糙米(%)")
	private String outBrownRice;
	@Excel(name="黄粒米(%)")
	private String yellowRice;
	@Excel(name="整精米率(%)")
	private String polishedRice;
	@Excel(name="脂肪酸值（mgKOH/100g干基）")
	private String fatAcidity;
	@Excel(name="乐果(mg/kg)")
	private String  rogor;
	@Excel(name="三唑磷(mg/kg)")
	private String triazophos;
	@Excel(name="毒死蜱(mg/kg)")
	private String chlorpyrifos;
	@Excel(name="水胺硫磷(mg/kg)")
	private String isocarbophos;
	@Excel(name="马拉硫磷(mg/kg)")
	private String malathion;

	@Excel(name="存储品质判定")
	private String storeJudeg;
	@Excel(name="气味、滋味")
	private String smellAndTaste;
	@Excel(name="水分及挥发物(%)")
	private String dewVolatile;
	@Excel(name="不溶性杂质(%)")
	private String insolubleImpurity;
	@Excel(name="加热试验(280℃)")
	private String heat;
	@Excel(name="酸价(KOH)(mg/g)")
	private String koh;
	@Excel(name="过氧化值(mmol/kg)")
	private String mmol;
	@Excel(name="溶剂残留量")
	private String residualSolvents;
	@Excel(name="棕榈酸")
	private String cetylicAcid;
	@Excel(name="硬脂酸")
	private String stearicAcid;
	@Excel(name="油酸")
	private String oleicAcid;
	@Excel(name="亚油酸")
	private String linoleicAcid;
	@Excel(name="亚麻酸")
	private String linolenicAcid;
	@Excel(name="花生酸")
	private String arachidonicAcid;
	@Excel(name="花生一烯酸")
	private String arachidonicAlkeneAcid;
	@Excel(name="芥酸")
	private String erucicAcid;
	@Excel(name="比重（d2020）")
	private String proportion;
	@Excel(name="质量等级")
	private String qualityGrade;
//	@Excel(name="小麦湿面筋(%)")
//	private String wetGluten;
//	@Excel(name="呕吐毒素含量(μg/kg)")
//	private String vomitoxin;
//	@Excel(name="总汞(以Hg计)(mg/kg)")
//	private String totalMercury;
//	@Excel(name="棕桐酸")
//	private String palmiticAcid;
//	@Excel(name="水分及不挥发物%")
//	private String dewNonvolatile;
	private String schemeName;
	private String year;
	private String originId;
	private String completeDate;
	private String executeState;



	public String getdId() {
		return dId;
	}
	public void setdId(String dId) {
		this.dId = dId;
	}

	public Long getSchemeBatch() {
		return schemeBatch;
	}

	public void setSchemeBatch(Long schemeBatch) {
		this.schemeBatch = schemeBatch;
	}

	public String getSchemeType() {
		return schemeType;
	}
	public void setSchemeType(String schemeType) {
		this.schemeType = schemeType;
	}
	public String getRotateType() {
		return rotateType;
	}
	public void setRotateType(String rotateType) {
		this.rotateType = rotateType;
	}
	public Date getBiddingTime() {
		return biddingTime;
	}
	public void setBiddingTime(Date biddingTime) {
		this.biddingTime = biddingTime;
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
	public String getExpectedCycle() {
		return expectedCycle;
	}
	public void setExpectedCycle(String expectedCycle) {
		this.expectedCycle = expectedCycle;
	}
	public String getLibraryId() {
		return libraryId;
	}
	public void setLibraryId(String libraryId) {
		this.libraryId = libraryId;
	}
	public String getBranNumber() {
		return branNumber;
	}
	public void setBranNumber(String branNumber) {
		this.branNumber = branNumber;
	}
	public String getYieldTime() {
		return yieldTime;
	}
	public void setYieldTime(String yieldTime) {
		this.yieldTime = yieldTime;
	}
	public String getFoodType() {
		return foodType;
	}
	public void setFoodType(String foodType) {
		this.foodType = foodType;
	}
	public String getRealContainer() {
		return realContainer;
	}
	public void setRealContainer(String realContainer) {
		this.realContainer = realContainer;
	}
	public String getRealStorage() {
		return realStorage;
	}
	public void setRealStorage(String realStorage) {
		this.realStorage = realStorage;
	}
	public double getRotateNumber() {
		return rotateNumber;
	}
	public void setRotateNumber(double rotateNumber) {
		this.rotateNumber = rotateNumber;
	}
	public String getOgirin() {
		return ogirin;
	}
	public void setOgirin(String ogirin) {
		this.ogirin = ogirin;
	}
	public String getPlanLevel() {
		return planLevel;
	}
	public void setPlanLevel(String planLevel) {
		this.planLevel = planLevel;
	}
	public int getRealRotateNumber() {
		return realRotateNumber;
	}
	public void setRealRotateNumber(int realRotateNumber) {
		this.realRotateNumber = realRotateNumber;
	}
	public String getSchemeId() {
		return schemeId;
	}
	public void setSchemeId(String schemeId) {
		this.schemeId = schemeId;
	}
	public String getPlanDetailId() {
		return planDetailId;
	}
	public void setPlanDetailId(String planDetailId) {
		this.planDetailId = planDetailId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getMainSchemeName() {
		return mainSchemeName;
	}
	public void setMainSchemeName(String mainSchemeName) {
		this.mainSchemeName = mainSchemeName;
	}

	public String getQualityDetail() {
		return qualityDetail;
	}

	public void setQualityDetail(String qualityDetail) {
		this.qualityDetail = qualityDetail;
	}

	public String getWarehouseId() {
		return warehouseId;
	}

	public void setWarehouseId(String warehouseId) {
		this.warehouseId = warehouseId;
	}

	public String getEnterpriseName() {
		return enterpriseName;
	}

	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}

    public String getEnterpriseId() {
        return enterpriseId;
    }

    public void setEnterpriseId(String enterpriseId) {
        this.enterpriseId = enterpriseId;
    }

	public String getStoreType() {
		return storeType;
	}

	public void setStoreType(String storeType) {
		this.storeType = storeType;
	}

	public String getPlanMainDetailId() {
		return planMainDetailId;
	}

	public void setPlanMainDetailId(String planMainDetailId) {
		this.planMainDetailId = planMainDetailId;
	}

	public BigDecimal getDealDetailNumber() {
		return dealDetailNumber;
	}

	public void setDealDetailNumber(BigDecimal dealDetailNumber) {
		this.dealDetailNumber = dealDetailNumber;
	}

	public String getBrown() {
		return brown;
	}

	public void setBrown(String brown) {
		this.brown = brown;
	}

	public String getUnitWeight() {
		return unitWeight;
	}

	public void setUnitWeight(String unitWeight) {
		this.unitWeight = unitWeight;
	}

	public String getImpurity() {
		return impurity;
	}

	public void setImpurity(String impurity) {
		this.impurity = impurity;
	}

	public String getDew() {
		return dew;
	}

	public void setDew(String dew) {
		this.dew = dew;
	}

	public String getYellowRice() {
		return yellowRice;
	}

	public void setYellowRice(String yellowRice) {
		this.yellowRice = yellowRice;
	}

	public String getUnsoundGrain() {
		return unsoundGrain;
	}

	public void setUnsoundGrain(String unsoundGrain) {
		this.unsoundGrain = unsoundGrain;
	}

	public String getKoh() {
		return koh;
	}

	public void setKoh(String koh) {
		this.koh = koh;
	}

	public String getMmol() {
		return mmol;
	}

	public void setMmol(String mmol) {
		this.mmol = mmol;
	}

	public String getTriazophos() {
		return triazophos;
	}

	public void setTriazophos(String triazophos) {
		this.triazophos = triazophos;
	}

	public String getInsolubleImpurity() {
		return insolubleImpurity;
	}

	public void setInsolubleImpurity(String insolubleImpurity) {
		this.insolubleImpurity = insolubleImpurity;
	}

	public String getRogor() {
		return rogor;
	}

	public void setRogor(String rogor) {
		this.rogor = rogor;
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

	public String getMineral() {
		return mineral;
	}

	public void setMineral(String mineral) {
		this.mineral = mineral;
	}

	public String getHeat() {
		return heat;
	}

	public void setHeat(String heat) {
		this.heat = heat;
	}


	public String getTasteScore() {
		return tasteScore;
	}

	public void setTasteScore(String tasteScore) {
		this.tasteScore = tasteScore;
	}


	public String getTotalArsenic() {
		return totalArsenic;
	}

	public void setTotalArsenic(String totalArsenic) {
		this.totalArsenic = totalArsenic;
	}

	public String getPolishedRice() {
		return polishedRice;
	}

	public void setPolishedRice(String polishedRice) {
		this.polishedRice = polishedRice;
	}

	public String getInorganicArsenic() {
		return inorganicArsenic;
	}

	public void setInorganicArsenic(String inorganicArsenic) {
		this.inorganicArsenic = inorganicArsenic;
	}

	public String getTotalImpurities() {
		return totalImpurities;
	}

	public void setTotalImpurities(String totalImpurities) {
		this.totalImpurities = totalImpurities;
	}

	public String getCetylicAcid() {
		return cetylicAcid;
	}

	public void setCetylicAcid(String cetylicAcid) {
		this.cetylicAcid = cetylicAcid;
	}

	public String getChlorpyrifos() {
		return chlorpyrifos;
	}

	public void setChlorpyrifos(String chlorpyrifos) {
		this.chlorpyrifos = chlorpyrifos;
	}

	public String getProportion() {
		return proportion;
	}

	public void setProportion(String proportion) {
		this.proportion = proportion;
	}

	public String getSmell() {
		return smell;
	}

	public void setSmell(String smell) {
		this.smell = smell;
	}

	public String getDewVolatile() {
		return dewVolatile;
	}

	public void setDewVolatile(String dewVolatile) {
		this.dewVolatile = dewVolatile;
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

	public String getResidualSolvents() {
		return residualSolvents;
	}

	public void setResidualSolvents(String residualSolvents) {
		this.residualSolvents = residualSolvents;
	}

	public String getZearalenone() {
		return zearalenone;
	}

	public void setZearalenone(String zearalenone) {
		this.zearalenone = zearalenone;
	}

	public String getHardnessIndex() {
		return hardnessIndex;
	}

	public void setHardnessIndex(String hardnessIndex) {
		this.hardnessIndex = hardnessIndex;
	}

	public String getStearicAcid() {
		return stearicAcid;
	}

	public void setStearicAcid(String stearicAcid) {
		this.stearicAcid = stearicAcid;
	}

	public String getFatAcidity() {
		return fatAcidity;
	}

	public void setFatAcidity(String fatAcidity) {
		this.fatAcidity = fatAcidity;
	}

	public String getDeoxynivalenol() {
		return deoxynivalenol;
	}

	public void setDeoxynivalenol(String deoxynivalenol) {
		this.deoxynivalenol = deoxynivalenol;
	}

	public String getColourOdor() {
		return colourOdor;
	}

	public void setColourOdor(String colourOdor) {
		this.colourOdor = colourOdor;
	}

	public String getErucicAcid() {
		return erucicAcid;
	}

	public void setErucicAcid(String erucicAcid) {
		this.erucicAcid = erucicAcid;
	}

	public String getArachidonicAlkeneAcid() {
		return arachidonicAlkeneAcid;
	}

	public void setArachidonicAlkeneAcid(String arachidonicAlkeneAcid) {
		this.arachidonicAlkeneAcid = arachidonicAlkeneAcid;
	}

	public String getArachidonicAcid() {
		return arachidonicAcid;
	}

	public void setArachidonicAcid(String arachidonicAcid) {
		this.arachidonicAcid = arachidonicAcid;
	}

	public String getOutBrownRice() {
		return outBrownRice;
	}

	public void setOutBrownRice(String outBrownRice) {
		this.outBrownRice = outBrownRice;
	}

	public String getLead() {
		return lead;
	}

	public void setLead(String lead) {
		this.lead = lead;
	}

	public String getCadmium() {
		return cadmium;
	}

	public void setCadmium(String cadmium) {
		this.cadmium = cadmium;
	}

	public String getGlutenSoakage() {
		return glutenSoakage;
	}

	public void setGlutenSoakage(String glutenSoakage) {
		this.glutenSoakage = glutenSoakage;
	}

	public String getMalathion() {
		return malathion;
	}

	public void setMalathion(String malathion) {
		this.malathion = malathion;
	}

	public String getAflatoxinB1() {
		return aflatoxinB1;
	}

	public void setAflatoxinB1(String aflatoxinB1) {
		this.aflatoxinB1 = aflatoxinB1;
	}

	public BigDecimal getOverdueTime() {
		return overdueTime;
	}

	public void setOverdueTime(BigDecimal overdueTime) {
		this.overdueTime = overdueTime;
	}

	public String getSchemeName() {
		return schemeName;
	}

	public void setSchemeName(String schemeName) {
		this.schemeName = schemeName;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getOriginId() {
		return originId;
	}

	public void setOriginId(String originId) {
		this.originId = originId;
	}

	public String getCompleteDate() {
		return completeDate;
	}

	public void setCompleteDate(String completeDate) {
		this.completeDate = completeDate;
	}

	public String getExecuteState() {
		return executeState;
	}

	public void setExecuteState(String executeState) {
		this.executeState = executeState;
	}

	public BigDecimal getQualityResultNum() {
		return qualityResultNum;
	}

	public void setQualityResultNum(BigDecimal qualityResultNum) {
		this.qualityResultNum = qualityResultNum;
	}

	public BigDecimal getRestNumber() {
		return restNumber;
	}

	public void setRestNumber(BigDecimal restNumber) {
		this.restNumber = restNumber;
	}

	public String getStoreJudeg() {
		return storeJudeg;
	}

	public void setStoreJudeg(String storeJudeg) {
		this.storeJudeg = storeJudeg;
	}

	public String getSmellAndTaste() {
		return smellAndTaste;
	}

	public void setSmellAndTaste(String smellAndTaste) {
		this.smellAndTaste = smellAndTaste;
	}

	public String getQualityGrade() {
		return qualityGrade;
	}

	public void setQualityGrade(String qualityGrade) {
		this.qualityGrade = qualityGrade;
	}
}
