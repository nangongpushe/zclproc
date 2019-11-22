package com.dhc.fastersoft.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;
import com.dhc.fastersoft.entity.report.ReportSwtz;

import java.math.BigDecimal;
import java.util.List;

public class RotatePlanDetailForExcel {
	private String id;
	@Excel(name="轮换类型",isImportField="true")
	private String rotateType;
	@Excel(name="库点名称",isImportField="true")
	private String libraryName;
	@Excel(name="仓房编号",isImportField="true")
	private String barnNumber;
	@Excel(name="粮食品种",isImportField="true")
	private String foodType;
	@Excel(name="生产年份",isImportField="true")
	private String yieldTime;
	@Excel(name="产地",isImportField="true")
	private String orign;
	/*@Excel(name="核定仓容(吨)",isImportField="true")*/
	private String approvalCapacity;
	//@Excel(name="实际库存(吨)",isImportField="true")
	private String realCapacity;
	@Excel(name="轮换数量(吨)",isImportField="true")
	private String rotateNumber;
	@Excel(name="已成交数量(吨)",isImportField="true")
	private BigDecimal dealDetailNumber;
	@Excel(name="未成交数量(吨)",isImportField="true")
	private BigDecimal unDealDetailNumber;
	@Excel(name="等级",isImportField="true")
	private String quality;
	@Excel(name="质量详情",isImportField="true")
	private String qualityDetail;
	@Excel(name="出糙(%)",isImportField="true")
	private String brown;
	@Excel(name="容重(g/l)",isImportField="true")
	private String unitWeight;
	@Excel(name="杂质(%)",isImportField="true")
	private String impurity;
	@Excel(name="水分(%)",isImportField="true")
	private String dew;
	@Excel(name="黄粒米(%)",isImportField="true")
	private String yellowRice;
	@Excel(name="不完善粒(%)",isImportField="true")
	private String unsoundGrain;
	@Excel(name="小麦湿面筋(%)",isImportField="true")
	private String wetGluten;
	@Excel(name="酸价(KOH)(mg/g)",isImportField="true")
	private String koh;
	@Excel(name="过氧化值(mmol/kg)",isImportField="true")
	private String mmol;
	@Excel(name="存储方式",isImportField="true")
	private String storeType;
	
	public RotatePlanDetailForExcel() {}
	
	public RotatePlanDetailForExcel(RotatePlanDetail detail,ReportSwtz reportSwtz) {
		this.id=detail.getId();
		this.rotateType=detail.getRotateType();
		this.libraryName=detail.getLibraryName();
		this.barnNumber=detail.getBarnNumber();
		this.foodType=detail.getFoodType();
		this.yieldTime=detail.getYieldTime();
		this.orign=detail.getOrign();
		this.approvalCapacity=detail.getApprovalCapacity();
		this.realCapacity=detail.getRealCapacity();
		this.rotateNumber=detail.getRotateNumber().toString();
		this.dealDetailNumber=detail.getDealDetailNumber();
		this.unDealDetailNumber=detail.getUnDealDetailNumber();
		this.quality=detail.getQuality();
        this.storeType=detail.getStoreType();
		this.brown=reportSwtz!=null&&reportSwtz.getBrown()!=null?reportSwtz.getBrown().toString():"--";
		this.unitWeight=reportSwtz!=null&&reportSwtz.getUnitWeight()!=null?reportSwtz.getUnitWeight().toString():"--";
		this.impurity=reportSwtz!=null&&reportSwtz.getImpurity()!=null?reportSwtz.getImpurity().toString():"--";
		this.dew=reportSwtz!=null&&reportSwtz.getDew()!=null?reportSwtz.getDew().toString():"--";
		this.yellowRice=reportSwtz!=null&&reportSwtz.getYellowRice()!=null?reportSwtz.getYellowRice().toString():"--";
		this.unsoundGrain=reportSwtz!=null&&reportSwtz.getUnsoundGrain()!=null?reportSwtz.getUnsoundGrain().toString():"--";
		this.wetGluten=reportSwtz!=null&&reportSwtz.getWetGluten()!=null?reportSwtz.getWetGluten().toString():"--";
		this.koh=reportSwtz!=null&&reportSwtz.getKoh()!=null?reportSwtz.getKoh().toString():"--";
		this.mmol=reportSwtz!=null&&reportSwtz.getMmol()!=null?reportSwtz.getMmol().toString():"--";
	}
	
	public RotatePlanDetailForExcel(RotatePlanDetail detail,List<QualityQuotaItem> quotaItems) {
		this.id=detail.getId();
		this.rotateType=detail.getRotateType();
		this.libraryName=detail.getLibraryName();
		this.barnNumber=detail.getBarnNumber();
		this.foodType=detail.getFoodType();
		this.yieldTime=detail.getYieldTime();
		this.orign=detail.getOrign();
        this.storeType=detail.getStoreType();
		this.approvalCapacity=detail.getApprovalCapacity();
		this.realCapacity=detail.getRealCapacity();
		this.rotateNumber=detail.getRotateNumber().toString();
		this.dealDetailNumber=detail.getDealDetailNumber();
		this.unDealDetailNumber=detail.getUnDealDetailNumber();
		this.quality=detail.getQuality();
		this.qualityDetail=detail.getQualityDetail();
		this.brown="--";
		this.unitWeight="--";
		this.impurity="--";
		this.dew="--";
		this.yellowRice="--";
		this.unsoundGrain="--";
		this.wetGluten="--";
		this.koh="--";
		this.mmol="--";
		
		for(QualityQuotaItem item:quotaItems) {
			String itemName= item.getItemName();
			if(null==itemName&&"".equals(itemName))
				continue;
			else if(null!=itemName&&"出糙".equals(itemName))
				this.brown=item.getStandard();
			else if("容重".equals(itemName))
				this.unitWeight=item.getStandard();
			else if("杂质".equals(itemName))
				this.impurity=item.getStandard();
			else if("水分".equals(itemName))
				this.dew=item.getStandard();
			else if("黄粒米".equals(itemName))
				this.yellowRice=item.getStandard();
			else if("不完善粒".equals(itemName))
				this.unsoundGrain=item.getStandard();
			else if("小麦湿面筋".equals(itemName))
				this.wetGluten=item.getStandard();
			else if("酸价".equals(itemName))
				this.koh=item.getStandard();
			else if("过氧化值".equals(itemName))
				this.mmol=item.getStandard();
			
		}
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRotateType() {
		return rotateType;
	}
	public void setRotateType(String rotateType) {
		this.rotateType = rotateType;
	}
	public String getLibraryName() {
		return libraryName;
	}
	public void setLibraryName(String libraryName) {
		this.libraryName = libraryName;
	}
	public String getBarnNumber() {
		return barnNumber;
	}
	public void setBarnNumber(String barnNumber) {
		this.barnNumber = barnNumber;
	}
	public String getFoodType() {
		return foodType;
	}
	public void setFoodType(String foodType) {
		this.foodType = foodType;
	}
	public String getYieldTime() {
		return yieldTime;
	}
	public void setYieldTime(String yieldTime) {
		this.yieldTime = yieldTime;
	}
	public String getOrign() {
		return orign;
	}
	public void setOrign(String orign) {
		this.orign = orign;
	}
	public String getApprovalCapacity() {
		return approvalCapacity;
	}
	public void setApprovalCapacity(String approvalCapacity) {
		this.approvalCapacity = approvalCapacity;
	}
	public String getRealCapacity() {
		return realCapacity;
	}
	public void setRealCapacity(String realCapacity) {
		this.realCapacity = realCapacity;
	}
	public String getRotateNumber() {
		return rotateNumber;
	}
	public void setRotateNumber(String rotateNumber) {
		this.rotateNumber = rotateNumber;
	}
	public String getQuality() {
		return quality;
	}
	public void setQuality(String quality) {
		this.quality = quality;
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

	public String getWetGluten() {
		return wetGluten;
	}

	public void setWetGluten(String wetGluten) {
		this.wetGluten = wetGluten;
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

	public String getQualityDetail() {
		return qualityDetail;
	}

	public void setQualityDetail(String qualityDetail) {
		this.qualityDetail = qualityDetail;
	}

	public String getStoreType() {
		return storeType;
	}

	public void setStoreType(String storeType) {
		this.storeType = storeType;
	}

	public BigDecimal getDealDetailNumber() {
		return dealDetailNumber;
	}

	public void setDealDetailNumber(BigDecimal dealDetailNumber) {
		this.dealDetailNumber = dealDetailNumber;
	}

	public BigDecimal getUnDealDetailNumber() {
		return unDealDetailNumber;
	}

	public void setUnDealDetailNumber(BigDecimal unDealDetailNumber) {
		this.unDealDetailNumber = unDealDetailNumber;
	}
}
