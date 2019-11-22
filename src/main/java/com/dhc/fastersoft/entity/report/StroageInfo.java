package com.dhc.fastersoft.entity.report;

import cn.afterturn.easypoi.excel.annotation.Excel;

import java.math.BigDecimal;

/**
 * 储存品质情况
 */
public class StroageInfo {

    @Excel(name = "宜存数量")
    private BigDecimal advisedDeposit;

    @Excel(name = "轻度不宜存数量")
    private BigDecimal slightlyUnsuitable;

    @Excel(name = "重度不宜存数量")
    private BigDecimal severeUnsuitable;

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
}
