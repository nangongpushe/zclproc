package com.dhc.fastersoft.entity;

import java.util.Date;
import java.util.List;

import org.omg.CosNaming.NamingContextExtPackage.StringNameHelper;
import org.springframework.format.annotation.DateTimeFormat;


public class RotateFreightAPRVGather {
	private String id;
	private String freightAprvId;
	private String grainType;
	private String status;
	private String gatherMan;
	private Date gatherTime;

	public String getFreightAprvId() {
		return freightAprvId;
	}

	public void setFreightAprvId(String freightAprvId) {
		this.freightAprvId = freightAprvId;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getGrainType() {
		return grainType;
	}
	public void setGrainType(String grainType) {
		this.grainType = grainType;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getGatherMan() {
		return gatherMan;
	}
	public void setGatherMan(String gatherMan) {
		this.gatherMan = gatherMan;
	}
	public Date getGatherTime() {
		return gatherTime;
	}
	public void setGatherTime(Date gatherTime) {
		this.gatherTime = gatherTime;
	}
	
}
