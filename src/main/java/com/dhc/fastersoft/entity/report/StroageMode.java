package com.dhc.fastersoft.entity.report;

import cn.afterturn.easypoi.excel.annotation.Excel;

import java.math.BigDecimal;

/**
 * 存储方式
 */
public class StroageMode {
    @Excel(name = "包装")
    private BigDecimal packing;
    @Excel(name = "散装")
    private BigDecimal bulk;

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
}
