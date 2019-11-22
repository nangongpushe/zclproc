package com.dhc.fastersoft.entity.system;

import java.util.Date;

public class SysOAInfo {
	private String name;
	private String position;
	private String operation;
	private String advice;
	private String time;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getOperation() {
		return operation;
	}
	public void setOperation(String operation) {
		this.operation = operation;
	}
	public String getAdvice() {
		return advice;
	}
	public void setAdvice(String advice) {
		this.advice = advice;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return this.name+","+this.position+","+this.operation+","+this.advice+","+this.time;
	}
	
	
}