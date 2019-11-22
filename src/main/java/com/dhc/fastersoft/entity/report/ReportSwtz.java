package com.dhc.fastersoft.entity.report;

import cn.afterturn.easypoi.excel.annotation.Excel;
import cn.afterturn.easypoi.excel.annotation.ExcelCollection;

import javax.validation.constraints.Pattern;
import java.math.BigDecimal;
import java.util.List;

public class ReportSwtz {
    private String reportId;

    private String reportMonth;

    private String reportWarehouse;

    private String reportName;

    private String warehouse;

    @Excel(name = "仓号(货位)")
    private String storehouse;
    @Excel(name = "品种")
    private String variety;
    @Excel(name = "数量")
    private BigDecimal quantity;
    @Excel(name = "产地")
    private String origin;
    @Excel(name = "收获年份")
    private String harvestYear;

    private String brown;
    private String unitWeight;
    private String impurity;
    private String dew;
    private String yellowRice;
    private String unsoundGrain;
    private String wetGluten;
    private String koh;
    private String mmol;

    private BigDecimal advisedDeposit;

    private BigDecimal slightlyUnsuitable;

    private BigDecimal severeUnsuitable;

    private BigDecimal ordernum;

    private BigDecimal packing;

    private BigDecimal bulk;

    @Excel(name = "成交子明细号", needMerge = true)
    private String dealSerial;
    
    private BigDecimal rotateNumber;

    private BigDecimal detailNumber;

    @Excel(name = "储存库点名称")
    private String extendsWarehouse;
    private String extendsWarehouseId;

    private String enterpriseId;

    private String enterpriseShortName;

    @ExcelCollection(name = "入库质量情况")
    private List<StoreInfo> storeInfoList;
    @ExcelCollection(name = "储存品质情况")
    private List<StroageInfo> stroageInfoList;
    @ExcelCollection(name="存储方式")
    private List<StroageMode> stroageModeList;

    public String getEnterpriseId() {
        return enterpriseId;
    }

    public void setEnterpriseId(String enterpriseId) {
        this.enterpriseId = enterpriseId;
    }

    public String getEnterpriseShortName() {
        return enterpriseShortName;
    }

    public void setEnterpriseShortName(String enterpriseShortName) {
        this.enterpriseShortName = enterpriseShortName;
    }

    public String getExtendsWarehouseId() {
        return extendsWarehouseId;
    }

    public void setExtendsWarehouseId(String extendsWarehouseId) {
        this.extendsWarehouseId = extendsWarehouseId;
    }

    private String plandetailid;

    public String getReportId() {
        return reportId;
    }

    public void setReportId(String reportId) {
        this.reportId = reportId == null ? null : reportId.trim();
    }

    public String getReportMonth() {
        return reportMonth;
    }

    public void setReportMonth(String reportMonth) {
        this.reportMonth = reportMonth == null ? null : reportMonth.trim();
    }

    public String getReportWarehouse() {
        return reportWarehouse;
    }

    public void setReportWarehouse(String reportWarehouse) {
        this.reportWarehouse = reportWarehouse == null ? null : reportWarehouse.trim();
    }

    public String getReportName() {
        return reportName;
    }

    public void setReportName(String reportName) {
        this.reportName = reportName == null ? null : reportName.trim();
    }

    public String getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(String warehouse) {
        this.warehouse = warehouse == null ? null : warehouse.trim();
    }

    public String getStorehouse() {
        return storehouse;
    }

    public void setStorehouse(String storehouse) {
        this.storehouse = storehouse == null ? null : storehouse.trim();
    }

    public String getVariety() {
        return variety;
    }

    public void setVariety(String variety) {
        this.variety = variety == null ? null : variety.trim();
    }

    public BigDecimal getQuantity() {
        return quantity;
    }

    public void setQuantity(BigDecimal quantity) {
        this.quantity = quantity;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin == null ? null : origin.trim();
    }

    public String getHarvestYear() {
        return harvestYear;
    }

    public void setHarvestYear(String harvestYear) {
        this.harvestYear = harvestYear == null ? null : harvestYear.trim();
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

	public BigDecimal getAdvisedDeposit() {
        return advisedDeposit;
    }

    public void setAdvisedDeposit(BigDecimal advisedDeposit) {
        this.advisedDeposit = advisedDeposit;
    }

    public BigDecimal getSlightlyUnsuitable() {
        return slightlyUnsuitable;
    }

    public void setSlightlyUnsuitable(BigDecimal slightlyUnsuitable) {
        this.slightlyUnsuitable = slightlyUnsuitable;
    }

    public BigDecimal getSevereUnsuitable() {
        return severeUnsuitable;
    }

    public void setSevereUnsuitable(BigDecimal severeUnsuitable) {
        this.severeUnsuitable = severeUnsuitable;
    }

    public BigDecimal getOrdernum() {
        return ordernum;
    }

    public void setOrdernum(BigDecimal ordernum) {
        this.ordernum = ordernum;
    }

    public BigDecimal getPacking() {
        return packing;
    }

    public void setPacking(BigDecimal packing) {
        this.packing = packing;
    }

    public BigDecimal getBulk() {
        return bulk;
    }

    public void setBulk(BigDecimal bulk) {
        this.bulk = bulk;
    }

    public String getDealSerial() {
        return dealSerial;
    }

    public void setDealSerial(String dealSerial) {
        this.dealSerial = dealSerial;
    }

	public String getExtendsWarehouse() {
		return extendsWarehouse;
	}

	public void setExtendsWarehouse(String extendsWarehouse) {
		this.extendsWarehouse = extendsWarehouse;
	}

    public BigDecimal getRotateNumber() {return rotateNumber;}
    public void setRotateNumber(BigDecimal rotateNumber) {
        this.rotateNumber = rotateNumber;
    }

    public BigDecimal getDetailNumber() {
        return detailNumber;
    }
    public void setDetailNumber(BigDecimal detailNumber) {
        this.detailNumber = detailNumber;
    }

    public String getPlandetailid() {
        return plandetailid;
    }
    public void setPlandetailid(String plandetailid) {
        this.plandetailid = plandetailid;
    }

    public List<StoreInfo> getStoreInfoList() {
        return storeInfoList;
    }

    public void setStoreInfoList(List<StoreInfo> storeInfoList) {
        this.storeInfoList = storeInfoList;
    }

    public List<StroageInfo> getStroageInfoList() {
        return stroageInfoList;
    }

    public void setStroageInfoList(List<StroageInfo> stroageInfoList) {
        this.stroageInfoList = stroageInfoList;
    }

    public List<StroageMode> getStroageModeList() {
        return stroageModeList;
    }

    public void setStroageModeList(List<StroageMode> stroageModeList) {
        this.stroageModeList = stroageModeList;
    }

    @Override
    public String toString() {
        return "ReportSwtz{" +
                "reportId='" + reportId + '\'' +
                ", reportMonth='" + reportMonth + '\'' +
                ", reportWarehouse='" + reportWarehouse + '\'' +
                ", reportName='" + reportName + '\'' +
                ", warehouse='" + warehouse + '\'' +
                ", storehouse='" + storehouse + '\'' +
                ", variety='" + variety + '\'' +
                ", quantity=" + quantity +
                ", origin='" + origin + '\'' +
                ", harvestYear='" + harvestYear + '\'' +
                ", brown='" + brown + '\'' +
                ", unitWeight='" + unitWeight + '\'' +
                ", impurity='" + impurity + '\'' +
                ", dew='" + dew + '\'' +
                ", yellowRice='" + yellowRice + '\'' +
                ", unsoundGrain='" + unsoundGrain + '\'' +
                ", wetGluten='" + wetGluten + '\'' +
                ", koh='" + koh + '\'' +
                ", mmol='" + mmol + '\'' +
                ", advisedDeposit=" + advisedDeposit +
                ", slightlyUnsuitable=" + slightlyUnsuitable +
                ", severeUnsuitable=" + severeUnsuitable +
                ", ordernum=" + ordernum +
                ", packing=" + packing +
                ", bulk=" + bulk +
                ", dealSerial='" + dealSerial + '\'' +
                ", rotateNumber=" + rotateNumber +
                ", detailNumber=" + detailNumber +
                ", extendsWarehouse='" + extendsWarehouse + '\'' +
                ", extendsWarehouseId='" + extendsWarehouseId + '\'' +
                ", enterpriseId='" + enterpriseId + '\'' +
                ", enterpriseShortName='" + enterpriseShortName + '\'' +
                ", plandetailid='" + plandetailid + '\'' +
                '}';
    }
}