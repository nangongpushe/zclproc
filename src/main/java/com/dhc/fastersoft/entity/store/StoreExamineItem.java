package com.dhc.fastersoft.entity.store;

public class StoreExamineItem {
    private String id;

    private String examineId; //考评ID

    private String parentId;  //上级ID

    private String item;  //考评项目

    private String standard;  //标准分

    private String point;  //得分

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getExamineId() {
		return examineId;
	}

	public void setExamineId(String examineId) {
		this.examineId = examineId;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getItem() {
		return item;
	}

	public void setItem(String item) {
		this.item = item;
	}

	public String getStandard() {
		return standard;
	}

	public void setStandard(String standard) {
		this.standard = standard;
	}

	public String getPoint() {
		return point;
	}

	public void setPoint(String point) {
		this.point = point;
	}

    
}