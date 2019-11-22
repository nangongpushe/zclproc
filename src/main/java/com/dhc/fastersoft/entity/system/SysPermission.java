package com.dhc.fastersoft.entity.system;

import java.math.BigDecimal;
import java.util.Date;

import com.dhc.fastersoft.utils.tree.BaseTreeGrid;

public class SysPermission{
    private String id;

    private String name;
    
    private String parentId;

    private String type;

    private String url;

    private String createTime;

    private BigDecimal status;
    
    private BigDecimal sort;
    
    private String note;
    
    private BigDecimal menuLevel;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }
    
    public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }
    
    

    public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public BigDecimal getStatus() {
        return status;
    }

    public void setStatus(BigDecimal status) {
        this.status = status;
    }

	public BigDecimal getSort() {
		return sort;
	}

	public void setSort(BigDecimal sort) {
		this.sort = sort;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public BigDecimal getMenuLevel() {
		return menuLevel;
	}

	public void setMenuLevel(BigDecimal menuLevel) {
		this.menuLevel = menuLevel;
	}  
    
}