package com.dhc.fastersoft.entity;

import java.math.BigDecimal;
import java.util.Date;

public class StorageInspect {
    private String id;

    private String year;

    private String reportUnit;

    private String warehouseId; //库点ID

    private String inspectStart;

    private String inspectEnd;

    private String inspectContent;

    private String inspectResult;

    private BigDecimal inspectFunds;

    private String inspector;

    private String groupId;

    private String creator;
    private String creatorId;


    private String createDate;
    
    private String company;

    public String getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(String creatorId) {
        this.creatorId = creatorId;
    }

    public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	private String aaString;
     
    private String bbString;

    private String fileName;
    
    public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getAaString() {
		return aaString;
	}

	public void setAaString(String aaString) {
		this.aaString = aaString;
	}

	public String getBbString() {
		return bbString;
	}

	public void setBbString(String bbString) {
		this.bbString = bbString;
	}

	public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year == null ? null : year.trim();
    }

    public String getReportUnit() {
        return reportUnit;
    }

    public void setReportUnit(String reportUnit) {
        this.reportUnit = reportUnit == null ? null : reportUnit.trim();
    }

    public String getInspectContent() {
        return inspectContent;
    }

    public void setInspectContent(String inspectContent) {
        this.inspectContent = inspectContent == null ? null : inspectContent.trim();
    }

    public String getInspectResult() {
        return inspectResult;
    }

    public void setInspectResult(String inspectResult) {
        this.inspectResult = inspectResult == null ? null : inspectResult.trim();
    }

    public BigDecimal getInspectFunds() {
        return inspectFunds;
    }

    public void setInspectFunds(BigDecimal inspectFunds) {
        this.inspectFunds = inspectFunds;
    }

    public String getInspector() {
        return inspector;
    }

    public void setInspector(String inspector) {
        this.inspector = inspector == null ? null : inspector.trim();
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

	public String getInspectStart() {
		return inspectStart;
	}

	public void setInspectStart(String inspectStart) {
		this.inspectStart = inspectStart;
	}

	public String getInspectEnd() {
		return inspectEnd;
	}

	public void setInspectEnd(String inspectEnd) {
		this.inspectEnd = inspectEnd;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

    public String getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(String warehouseId) {
        this.warehouseId = warehouseId;
    }
}