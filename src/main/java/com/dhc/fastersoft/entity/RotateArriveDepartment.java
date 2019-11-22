package com.dhc.fastersoft.entity;

import java.util.Date;
import java.util.List;

import org.omg.CosNaming.NamingContextExtPackage.StringNameHelper;
import org.springframework.format.annotation.DateTimeFormat;


public class RotateArriveDepartment {
	private String arriveId;
	private String department;
	public String getArriveId() {
		return arriveId;
	}
	public void setArriveId(String arriveId) {
		this.arriveId = arriveId;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
}
