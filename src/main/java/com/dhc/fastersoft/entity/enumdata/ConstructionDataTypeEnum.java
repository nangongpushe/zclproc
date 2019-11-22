package com.dhc.fastersoft.entity.enumdata;

public enum ConstructionDataTypeEnum {
	
	BIDDING("招投标"),
	CHANGE("变更计划"),
	ACCEPTANCE("工程验收");
	
	String value;
	
	ConstructionDataTypeEnum(String value){
		this.value = value;
	}
	
	public String getValue() {  
        return value;  
    } 
}
