package com.dhc.fastersoft.entity.store;

import java.util.List;

public class StoreTemplateItem {
    private String id;

    private String templetId;

    private String parentId;

    private String itemName;
    private String itemId;
    public String getPoint() {
		return point;
	}

	public void setPoint(String point) {
		this.point = point;
	}

	private String point;
    

    public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	private String standard;
    private int rowspan;
    public int getRowspan() {
		return rowspan;
	}

	public void setRowspan(int rowspan) {
		this.rowspan = rowspan;
	}

	private List<StoreTemplateItem> children;

	public List<StoreTemplateItem> getChildren() {
		return children;
	}

	public void setChildren(List<StoreTemplateItem> children) {
		this.children = children;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTempletId() {
		return templetId;
	}

	public void setTempletId(String templetId) {
		this.templetId = templetId;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getStandard() {
		return standard;
	}

	public void setStandard(String standard) {
		this.standard = standard;
	}
    
}