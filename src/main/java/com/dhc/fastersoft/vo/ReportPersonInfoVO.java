package com.dhc.fastersoft.vo;

import cn.afterturn.easypoi.excel.annotation.Excel;


public class ReportPersonInfoVO {
	
	
	private String personId;
	
	@Excel(name="类型",isImportField = "true_st")
	private String type;
	
	@Excel(name="计量单位",isImportField = "true_st")
	private String units;
	
	@Excel(name="本年",isImportField = "true_st")
	private String thisYear;
	
	@Excel(name="上一年",isImportField = "true_st")
	private String lastYear;

	public String getPersonId() {
		return personId;
	}

	public void setPersonId(String personId) {
		this.personId = personId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getUnits() {
		return units;
	}

	public void setUnits(String units) {
		this.units = units;
	}

	public String getThisYear() {
		return thisYear;
	}

	public void setThisYear(String thisYear) {
		this.thisYear = thisYear;
	}

	public String getLastYear() {
		return lastYear;
	}

	public void setLastYear(String lastYear) {
		this.lastYear = lastYear;
	}
	

}
