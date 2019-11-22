package com.dhc.fastersoft.entity.enumdata;

public enum ReportNameEnum {
	CBLY("储备粮油收支月报表"),
	SPLY("商品粮油收支月报表"),
	SWTZ("粮油库存实物台账月报表"),
	XWSW("销往省外"),
	SWGJ("省外购进"),
	BZW("包装物库存月报表"),
	BZWCRMX("库存包装物出入库明细表");

	String value;

	ReportNameEnum(String value) {
		this.value = value;
	}
	
	public String getValue() {  
        return value;  
    }
}
