package com.dhc.fastersoft.entity;

import java.util.Date;
import java.util.List;

public class StoreSupervise {
    private String id;

    private String superviseSerial;//编号

    private String superviseYear;//年份

    private String superviseName;//名称

    private String groupId;//附件

    private String creator;//创建人
    private String creatorId;//创建人

    public String getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(String creatorId) {
        this.creatorId = creatorId;
    }

    private String createDept;//创建部门

    private Date createDate;//创建时间
    
    private String createDateFmt;//创建时间
    
    private List<StoreSuperviseItem> detail;

    public List<StoreSuperviseItem> getDetail() {
		return detail;
	}

	public void setDetail(List<StoreSuperviseItem> detail) {
		this.detail = detail;
	}

	public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getSuperviseSerial() {
        return superviseSerial;
    }

    public void setSuperviseSerial(String superviseSerial) {
        this.superviseSerial = superviseSerial == null ? null : superviseSerial.trim();
    }

    public String getSuperviseYear() {
        return superviseYear;
    }

    public void setSuperviseYear(String superviseYear) {
        this.superviseYear = superviseYear == null ? null : superviseYear.trim();
    }

    public String getSuperviseName() {
        return superviseName;
    }

    public void setSuperviseName(String superviseName) {
        this.superviseName = superviseName == null ? null : superviseName.trim();
    }

    public String getGroupId() {
        return groupId;
    }

    public void setGroupId(String groupId) {
        this.groupId = groupId == null ? null : groupId.trim();
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator == null ? null : creator.trim();
    }

    public String getCreateDept() {
        return createDept;
    }

    public void setCreateDept(String createDept) {
        this.createDept = createDept == null ? null : createDept.trim();
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

	@Override
	public String toString() {
		return "StoreSupervise [id=" + id + ", superviseSerial=" + superviseSerial + ", superviseYear=" + superviseYear
				+ ", superviseName=" + superviseName + ", groupId=" + groupId + ", creator=" + creator + ", createDept="
				+ createDept + ", createDate=" + createDate + ", detail=" + detail + "]";
	}

	public String getCreateDateFmt() {
		return createDateFmt;
	}

	public void setCreateDateFmt(String createDateFmt) {
		this.createDateFmt = createDateFmt;
	}
}