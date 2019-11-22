package com.dhc.fastersoft.entity;


public class QualityTask {
    private String id;

    private String taskSerial;

    private String taskName;

    private String sampleNo;

    private String wearhouse;

    private String taskPriority;

    private String taskExecutor;

    private String inspectionType;

    private String plannedInspectionTime;

    private String actualInspectionTime;

    private String taskStatus;

    private String creator;

    private String createDate;
    
    private String validType;

    public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	private String remark;

    private String company;
    
    public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getTaskSerial() {
        return taskSerial;
    }

    public void setTaskSerial(String taskSerial) {
        this.taskSerial = taskSerial == null ? null : taskSerial.trim();
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName == null ? null : taskName.trim();
    }

    public String getSampleNo() {
        return sampleNo;
    }

    public void setSampleNo(String sampleNo) {
        this.sampleNo = sampleNo == null ? null : sampleNo.trim();
    }

    public String getWearhouse() {
        return wearhouse;
    }

    public void setWearhouse(String wearhouse) {
        this.wearhouse = wearhouse == null ? null : wearhouse.trim();
    }

    public String getTaskPriority() {
        return taskPriority;
    }

    public void setTaskPriority(String taskPriority) {
        this.taskPriority = taskPriority == null ? null : taskPriority.trim();
    }

    public String getTaskExecutor() {
        return taskExecutor;
    }

    public void setTaskExecutor(String taskExecutor) {
        this.taskExecutor = taskExecutor == null ? null : taskExecutor.trim();
    }

    public String getInspectionType() {
        return inspectionType;
    }

    public void setInspectionType(String inspectionType) {
        this.inspectionType = inspectionType == null ? null : inspectionType.trim();
    }


    public String getTaskStatus() {
        return taskStatus;
    }

    public void setTaskStatus(String taskStatus) {
        this.taskStatus = taskStatus == null ? null : taskStatus.trim();
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator == null ? null : creator.trim();
    }


    public String getPlannedInspectionTime() {
		return plannedInspectionTime;
	}

	public void setPlannedInspectionTime(String plannedInspectionTime) {
		this.plannedInspectionTime = plannedInspectionTime;
	}

	public String getActualInspectionTime() {
		return actualInspectionTime;
	}

	public void setActualInspectionTime(String actualInspectionTime) {
		this.actualInspectionTime = actualInspectionTime;
	}



	public String getCreateDate() {
		return createDate;
	}

	public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

	public String getValidType() {
		return validType;
	}

	public void setValidType(String validType) {
		this.validType = validType;
	}
    
}