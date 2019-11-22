package com.dhc.fastersoft.entity.report;

import cn.afterturn.easypoi.excel.annotation.Excel;

public class StoreInfo {
    @Excel(name = "出糙(%)")
    private String brown;
    @Excel(name = "容重(g/l)")
    private String unitWeight;
    @Excel(name = "杂质(%)")
    private String impurity;
    @Excel(name = "水分(%)")
    private String dew;
    @Excel(name = "黄粒米(%)")
    private String yellowRice;
    @Excel(name = "不完善粒(%)")
    private String unsoundGrain;
    @Excel(name = "小麦湿面筋(%)")
    private String wetGluten;
    @Excel(name = "酸价(KOH)(mg/g)")
    private String koh;
    @Excel(name = "过氧化值(mmol/kg)")
    private String mmol;

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
}
