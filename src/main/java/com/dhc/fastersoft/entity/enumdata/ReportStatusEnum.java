package com.dhc.fastersoft.entity.enumdata;

public enum ReportStatusEnum {
    CG("草稿"),
    DSH("待审核"),
    SHTG("审核通过"),
    BH("审核驳回"),
    SBDS("上报待审"),
    SBTG("上报通过"),
    SBBH("上报驳回"),
    HZDS("汇总待审"),
    HZTG("汇总通过"),
    HZBH("汇总驳回"),
    OASUM("OA汇总送审");

    String value;

    ReportStatusEnum(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
