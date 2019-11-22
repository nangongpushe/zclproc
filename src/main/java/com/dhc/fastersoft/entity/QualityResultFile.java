package com.dhc.fastersoft.entity;

import com.dhc.fastersoft.entity.system.SysFile;

import java.text.SimpleDateFormat;
import java.util.Date;

public class QualityResultFile extends SysFile{
   private String templateNo;
   private String templateId;
   private String checkType;



    public String getTemplateNo() {
        return templateNo;
    }

    public void setTemplateNo(String templateNo) {
        this.templateNo = templateNo;
    }

    public String getTemplateId() {
        return templateId;
    }

    public void setTemplateId(String templateId) {
        this.templateId = templateId;
    }

    public String getCheckType() {
        return checkType;
    }

    public void setCheckType(String checkType) {
        this.checkType = checkType;
    }
}
