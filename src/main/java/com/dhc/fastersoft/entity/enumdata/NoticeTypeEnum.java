package com.dhc.fastersoft.entity.enumdata;

public enum NoticeTypeEnum {
	IN_BOUMD("入库"),
	OUT_BOUND("出库"),
	MOVE_BOUND("移库");
	
	String value;
	
	NoticeTypeEnum(String value) {
		this.value = value;
	}
	
	public String getValue() {  
        return value;  
    }  
}
