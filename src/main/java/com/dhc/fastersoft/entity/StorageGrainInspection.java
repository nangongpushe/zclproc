package com.dhc.fastersoft.entity;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

/*
粮情检测记录表实体类
 */
public class StorageGrainInspection {
	
	private static SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
	
    private String id;//主键

    private String warehouse;//所属库点

    private String warehouseId;//库点id

    private String encode;//仓房编号

    private String weather;//天气

    private String quantity; //实际数量

    private Float dew;//水分

    private Float impurity;//杂质

    private Float storehouseTemp;//仓温

    private Float temperature;//气温

    private Float storehouseWet;//仓湿

    private Float airWet;//气湿

    //最高温
    private Float topMax;

    private Float topMin;

    private Float topAvg;

    private Float topMiddleMax;

    private Float topMiddleMin;

    private Float topMiddleAvg;

    private Float lowMiddleMax;

    private Float lowMiddleMin;

    private Float lowMiddleAvg;

    private Float lowMax;

    private Float lowMin;

    private Float lowAvg;

    //粮温
   private List<StorageGrainInspectionTemp> storageGrainInspectionTemp;


    //整仓平均
    private Float temperatureAvg;

    private String temperatureAbnormal;//粮温是否异常

    private String[] pestCheckTypeList;//虫害检测方式
    private String pestCheckType;

    private String pestSampleSite;

    private Integer checkNum;//检测点数

    private Integer pestSpot;//其中有害虫点数

    private String pestInsect;//发现虫害位置

    private String pestNames;//虫害名称

    private Float pestDensity;//最高害虫密度

    private Float majorPestDensity;//其中主要害虫密度

    private String pestLevel;//判定虫粮等级

    private String suffocate;//熏蒸措施

    private String hygiene;//仓内卫生情况

    private String creator;

    private String creatorId;

    private String createDate;

    private String remark;//备注

    private String heat;//粮食有无发现发热

    private String rot;//粮食有无发现霉变

    private String shedLeakage;//仓房设施方面

    private String wallLeakage;//漏雨防潮方面

    private String doorLeakage;//防火安全方面

    private String shedCrack;//用电安全方面

    private String wallCrack;//墙体、地坪有无发现裂缝

    private String doorCrack;//门窗有无发现裂缝

    private String light;//仓内照明是否故障

    private String stairs;//上下楼梯是否安全

    private String facilities;//辅助设施是否完好

    private String mouse;//仓内有无发现鼠雀

    private String cobweb;//仓内有无发现蛛网

    private String checkSituation;//检查情况评估

    private String checkProperty;//检查性质

    private String checkCharge;//检查负责人

    private String checker;//检查人员

    private String keeper;//保管员
    
    private Date reportDate;//填报日期
    
    private String reportDateStr;//
    
    private String[] pestSampleSiteList;//虫害采样部位

    private String advice;//存在隐患，处理意见


    private String status;

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    private  Float spaceOxy;//空间氧气
    private  Float grainBulkOxy;//粮堆氧气
    private  Float spacePhosphine;//空间磷化氢
    private  Float grainBulkPhosphine;//粮堆磷化氢
    private  String warehouseCode;//库点编码
    private String grainType;//粮食品种
    public String getAdvice() {
        return advice;
    }

    public void setAdvice(String advice) {
        this.advice = advice;
    }

    public void setStorageGrainInspectionTemp(List<StorageGrainInspectionTemp> storageGrainInspectionTemp) {
        this.storageGrainInspectionTemp = storageGrainInspectionTemp;
    }

    public List<StorageGrainInspectionTemp> getStorageGrainInspectionTemp() {
        return storageGrainInspectionTemp;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(String warehouse) {
        this.warehouse = warehouse == null ? null : warehouse.trim();
    }

    public String getEncode() {
        return encode;
    }

    public void setEncode(String encode) {
        this.encode = encode == null ? null : encode.trim();
    }

    public String getWeather() {
        return weather;
    }

    public void setWeather(String weather) {
        this.weather = weather == null ? null : weather.trim();
    }

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity == null ? null : quantity.trim();
    }

    public Float getDew() {
        return dew;
    }

    public void setDew(Float dew) {
        this.dew = dew;
    }

    public Float getImpurity() {
        return impurity;
    }

    public void setImpurity(Float impurity) {
        this.impurity = impurity;
    }

    public Float getStorehouseTemp() {
        return storehouseTemp;
    }

    public void setStorehouseTemp(Float storehouseTemp) {
        this.storehouseTemp = storehouseTemp;
    }

    public Float getTemperature() {
        return temperature;
    }

    public void setTemperature(Float temperature) {
        this.temperature = temperature;
    }

    public Float getStorehouseWet() {
        return storehouseWet;
    }

    public void setStorehouseWet(Float storehouseWet) {
        this.storehouseWet = storehouseWet;
    }

    public Float getAirWet() {
        return airWet;
    }

    public void setAirWet(Float airWet) {
        this.airWet = airWet;
    }

    public Float getTopMax() {
        return topMax;
    }

    public void setTopMax(Float topMax) {
        this.topMax = topMax;
    }

    public Float getTopMin() {
        return topMin;
    }

    public void setTopMin(Float topMin) {
        this.topMin = topMin;
    }

    public Float getTopAvg() {
        return topAvg;
    }

    public void setTopAvg(Float topAvg) {
        this.topAvg = topAvg;
    }

    public Float getTopMiddleMax() {
        return topMiddleMax;
    }

    public void setTopMiddleMax(Float topMiddleMax) {
        this.topMiddleMax = topMiddleMax;
    }

    public Float getTopMiddleMin() {
        return topMiddleMin;
    }

    public void setTopMiddleMin(Float topMiddleMin) {
        this.topMiddleMin = topMiddleMin;
    }

    public Float getTopMiddleAvg() {
        return topMiddleAvg;
    }

    public void setTopMiddleAvg(Float topMiddleAvg) {
        this.topMiddleAvg = topMiddleAvg;
    }

    public Float getLowMiddleMax() {
        return lowMiddleMax;
    }

    public void setLowMiddleMax(Float lowMiddleMax) {
        this.lowMiddleMax = lowMiddleMax;
    }

    public Float getLowMiddleMin() {
        return lowMiddleMin;
    }

    public void setLowMiddleMin(Float lowMiddleMin) {
        this.lowMiddleMin = lowMiddleMin;
    }

    public Float getLowMiddleAvg() {
        return lowMiddleAvg;
    }

    public void setLowMiddleAvg(Float lowMiddleAvg) {
        this.lowMiddleAvg = lowMiddleAvg;
    }

    public Float getLowMax() {
        return lowMax;
    }

    public void setLowMax(Float lowMax) {
        this.lowMax = lowMax;
    }

    public Float getLowMin() {
        return lowMin;
    }

    public void setLowMin(Float lowMin) {
        this.lowMin = lowMin;
    }

    public Float getLowAvg() {
        return lowAvg;
    }

    public void setLowAvg(Float lowAvg) {
        this.lowAvg = lowAvg;
    }


    public Float getTemperatureAvg() {
        return temperatureAvg;
    }

    public void setTemperatureAvg(Float temperatureAvg) {
        this.temperatureAvg = temperatureAvg;
    }

    public String getTemperatureAbnormal() {
        return temperatureAbnormal;
    }

    public void setTemperatureAbnormal(String temperatureAbnormal) {
        this.temperatureAbnormal = temperatureAbnormal == null ? null : temperatureAbnormal.trim();
    }
    //-----------

    public String[] getPestCheckTypeList() {
        return pestCheckTypeList;
    }

    public void setPestCheckTypeList(String[] pestCheckTypeList) {
        this.pestCheckTypeList = pestCheckTypeList;
    }

    public String getPestCheckType() {
        return pestCheckType;
    }

    public void setPestCheckType(String pestCheckType) {
        this.pestCheckType = pestCheckType == null ? null : pestCheckType.trim();
    }

    public String getPestSampleSite() {
        return pestSampleSite;
    }

    public void setPestSampleSite(String pestSampleSite) {
        this.pestSampleSite = pestSampleSite == null ? null : pestSampleSite.trim();
    }

    public Integer getCheckNum() {
        return checkNum;
    }

    public void setCheckNum(Integer checkNum) {
        this.checkNum = checkNum;
    }

    public Integer getPestSpot() {
        return pestSpot;
    }

    public void setPestSpot(Integer pestSpot) {
        this.pestSpot = pestSpot;
    }

    public String getPestInsect() {
        return pestInsect;
    }

    public void setPestInsect(String pestInsect) {
        this.pestInsect = pestInsect == null ? null : pestInsect.trim();
    }

    public String getPestNames() {
        return pestNames;
    }

    public void setPestNames(String pestNames) {
        this.pestNames = pestNames == null ? null : pestNames.trim();
    }

    public Float getPestDensity() {
        return pestDensity;
    }

    public void setPestDensity(Float pestDensity) {
        this.pestDensity = pestDensity;
    }

    public Float getMajorPestDensity() {
        return majorPestDensity;
    }

    public void setMajorPestDensity(Float majorPestDensity) {
        this.majorPestDensity = majorPestDensity;
    }

    public String getPestLevel() {
        return pestLevel;
    }

    public void setPestLevel(String pestLevel) {
        this.pestLevel = pestLevel == null ? null : pestLevel.trim();
    }

    public String getSuffocate() {
        return suffocate;
    }

    public void setSuffocate(String suffocate) {
        this.suffocate = suffocate == null ? null : suffocate.trim();
    }

    public String getHygiene() {
        return hygiene;
    }

    public void setHygiene(String hygiene) {
        this.hygiene = hygiene == null ? null : hygiene.trim();
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public String getHeat() {
        return heat;
    }

    public void setHeat(String heat) {
        this.heat = heat == null ? null : heat.trim();
    }

    public String getRot() {
        return rot;
    }

    public void setRot(String rot) {
        this.rot = rot == null ? null : rot.trim();
    }

    public String getShedLeakage() {
        return shedLeakage;
    }

    public void setShedLeakage(String shedLeakage) {
        this.shedLeakage = shedLeakage == null ? null : shedLeakage.trim();
    }

    public String getWallLeakage() {
        return wallLeakage;
    }

    public void setWallLeakage(String wallLeakage) {
        this.wallLeakage = wallLeakage == null ? null : wallLeakage.trim();
    }

    public String getDoorLeakage() {
        return doorLeakage;
    }

    public void setDoorLeakage(String doorLeakage) {
        this.doorLeakage = doorLeakage == null ? null : doorLeakage.trim();
    }

    public String getShedCrack() {
        return shedCrack;
    }

    public void setShedCrack(String shedCrack) {
        this.shedCrack = shedCrack == null ? null : shedCrack.trim();
    }

    public String getWallCrack() {
        return wallCrack;
    }

    public void setWallCrack(String wallCrack) {
        this.wallCrack = wallCrack == null ? null : wallCrack.trim();
    }

    public String getDoorCrack() {
        return doorCrack;
    }

    public void setDoorCrack(String doorCrack) {
        this.doorCrack = doorCrack == null ? null : doorCrack.trim();
    }

    public String getLight() {
        return light;
    }

    public void setLight(String light) {
        this.light = light == null ? null : light.trim();
    }

    public String getStairs() {
        return stairs;
    }

    public void setStairs(String stairs) {
        this.stairs = stairs == null ? null : stairs.trim();
    }

    public String getFacilities() {
        return facilities;
    }

    public void setFacilities(String facilities) {
        this.facilities = facilities == null ? null : facilities.trim();
    }

    public String getMouse() {
        return mouse;
    }

    public void setMouse(String mouse) {
        this.mouse = mouse == null ? null : mouse.trim();
    }

    public String getCobweb() {
        return cobweb;
    }

    public void setCobweb(String cobweb) {
        this.cobweb = cobweb == null ? null : cobweb.trim();
    }

    public String getCheckSituation() {
        return checkSituation;
    }

    public void setCheckSituation(String checkSituation) {
        this.checkSituation = checkSituation == null ? null : checkSituation.trim();
    }

    public String getCheckProperty() {
        return checkProperty;
    }

    public void setCheckProperty(String checkProperty) {
        this.checkProperty = checkProperty == null ? null : checkProperty.trim();
    }

    public String getCheckCharge() {
        return checkCharge;
    }

    public void setCheckCharge(String checkCharge) {
        this.checkCharge = checkCharge == null ? null : checkCharge.trim();
    }

    public String getChecker() {
        return checker;
    }

    public void setChecker(String checker) {
        this.checker = checker == null ? null : checker.trim();
    }

    public String getKeeper() {
        return keeper;
    }

    public void setKeeper(String keeper) {
        this.keeper = keeper == null ? null : keeper.trim();
    }

	public String[] getPestSampleSiteList() {
		return pestSampleSiteList;
	}

	public void setPestSampleSiteList(String[] pestSampleSiteList) {
		this.pestSampleSiteList = pestSampleSiteList;
	}
	
	public void setPestSampleSiteListByStr() {
		String[] pestSampleSiteList = null;
		pestSampleSiteList = pestSampleSiteToList(this.pestSampleSite);
		this.pestSampleSiteList = pestSampleSiteList;
	}
	
	public void setPestSampleSiteByList() {
		String pestSampleSite = new String();
		pestSampleSite = listToPestSampleSite(this.pestSampleSiteList);
		this.pestSampleSite = pestSampleSite;
	}
	
	public String listToPestSampleSite(String[] pestSampleSiteList) {
		String pestSampleSite = new String();
		if (pestSampleSiteList != null) {
			for (String s : pestSampleSiteList) {
				pestSampleSite += s + "|";
			}
		}
		return pestSampleSite;
	}
	
	public String[] pestSampleSiteToList(String pestSampleSite) {
		String[] pestSampleSiteList = null;
		if (pestSampleSite != null) {
			pestSampleSiteList = pestSampleSite.split("\\|");
		}
		return pestSampleSiteList;
	}

	//-------------------------------------------------
    public void setPestCheckTypeListByStr() {
        String[] pestCheckTypeList = null;
        pestCheckTypeList = pestCheckTypeToList(this.pestCheckType);
        this.pestCheckTypeList = pestCheckTypeList;
    }

    public void setPestCheckTypeByList() {
        String pestCheckType = new String();
        pestCheckType = listToPestCheckType(this.pestCheckTypeList);
        this.pestCheckType = pestCheckType;
    }

    public Float getSpaceOxy() {
        return spaceOxy;
    }

    public void setSpaceOxy(Float spaceOxy) {
        this.spaceOxy = spaceOxy;
    }

    public Float getGrainBulkOxy() {
        return grainBulkOxy;
    }

    public void setGrainBulkOxy(Float grainBulkOxy) {
        this.grainBulkOxy = grainBulkOxy;
    }

    public Float getSpacePhosphine() {
        return spacePhosphine;
    }

    public void setSpacePhosphine(Float spacePhosphine) {
        this.spacePhosphine = spacePhosphine;
    }

    public Float getGrainBulkPhosphine() {
        return grainBulkPhosphine;
    }

    public void setGrainBulkPhosphine(Float grainBulkPhosphine) {
        this.grainBulkPhosphine = grainBulkPhosphine;
    }

    public String listToPestCheckType(String[] pestCheckTypeList) {
        String pestCheckType = new String();
        if (pestCheckTypeList != null) {
            for (String s : pestCheckTypeList) {
                pestCheckType += s + "|";
            }
        }
        return pestCheckType;
    }

    public String[] pestCheckTypeToList(String pestCheckType) {
        String[] pestCheckTypeList = null;
        if (pestCheckType != null) {
            pestCheckTypeList = pestCheckType.split("\\|");
        }
        return pestCheckTypeList;
    }

    @Override
    public String toString() {
        return "StorageGrainInspection{" +
                "id='" + id + '\'' +
                ", warehouse='" + warehouse + '\'' +
                ", encode='" + encode + '\'' +
                ", weather='" + weather + '\'' +
                ", quantity='" + quantity + '\'' +
                ", dew=" + dew +
                ", impurity=" + impurity +
                ", storehouseTemp=" + storehouseTemp +
                ", temperature=" + temperature +
                ", storehouseWet=" + storehouseWet +
                ", airWet=" + airWet +
                ", topMax=" + topMax +
                ", topMin=" + topMin +
                ", topAvg=" + topAvg +
                ", topMiddleMax=" + topMiddleMax +
                ", topMiddleMin=" + topMiddleMin +
                ", topMiddleAvg=" + topMiddleAvg +
                ", lowMiddleMax=" + lowMiddleMax +
                ", lowMiddleMin=" + lowMiddleMin +
                ", lowMiddleAvg=" + lowMiddleAvg +
                ", lowMax=" + lowMax +
                ", lowMin=" + lowMin +
                ", lowAvg=" + lowAvg +
                ", storageGrainInspectionTemp=" + storageGrainInspectionTemp +
                ", temperatureAvg=" + temperatureAvg +
                ", temperatureAbnormal='" + temperatureAbnormal + '\'' +
                ", pestCheckTypeList=" + Arrays.toString(pestCheckTypeList) +
                ", pestCheckType='" + pestCheckType + '\'' +
                ", pestSampleSite='" + pestSampleSite + '\'' +
                ", checkNum=" + checkNum +
                ", pestSpot=" + pestSpot +
                ", pestInsect='" + pestInsect + '\'' +
                ", pestNames='" + pestNames + '\'' +
                ", pestDensity=" + pestDensity +
                ", majorPestDensity=" + majorPestDensity +
                ", pestLevel='" + pestLevel + '\'' +
                ", suffocate='" + suffocate + '\'' +
                ", hygiene='" + hygiene + '\'' +
                ", creator='" + creator + '\'' +
                ", createDate='" + createDate + '\'' +
                ", remark='" + remark + '\'' +
                ", heat='" + heat + '\'' +
                ", rot='" + rot + '\'' +
                ", shedLeakage='" + shedLeakage + '\'' +
                ", wallLeakage='" + wallLeakage + '\'' +
                ", doorLeakage='" + doorLeakage + '\'' +
                ", shedCrack='" + shedCrack + '\'' +
                ", wallCrack='" + wallCrack + '\'' +
                ", doorCrack='" + doorCrack + '\'' +
                ", light='" + light + '\'' +
                ", stairs='" + stairs + '\'' +
                ", facilities='" + facilities + '\'' +
                ", mouse='" + mouse + '\'' +
                ", cobweb='" + cobweb + '\'' +
                ", checkSituation='" + checkSituation + '\'' +
                ", checkProperty='" + checkProperty + '\'' +
                ", checkCharge='" + checkCharge + '\'' +
                ", checker='" + checker + '\'' +
                ", keeper='" + keeper + '\'' +
                ", reportDate=" + reportDate +
                ", reportDateStr='" + reportDateStr + '\'' +
                ", pestSampleSiteList=" + Arrays.toString(pestSampleSiteList) +
                ", advice='" + advice + '\'' +
                '}';
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

	/*private String[] topChildMax;

    public String[] getTopChildMax() {
        return topChildMax;
    }

    public void setTopChildMax(String[] topChildMax) {
        this.topChildMax = topChildMax;
    }*/

    public String getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(String creatorId) {
        this.creatorId = creatorId;
    }


    public String getWarehouseCode() {
        return warehouseCode;
    }

    public void setWarehouseCode(String warehouseCode) {
        this.warehouseCode = warehouseCode;
    }

    public String getGrainType() {
        return grainType;
    }

    public void setGrainType(String grainType) {
        this.grainType = grainType;
    }

    public String getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(String warehouseId) {
        this.warehouseId = warehouseId;
    }
}