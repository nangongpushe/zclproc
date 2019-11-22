package com.dhc.fastersoft.entity;

import cn.afterturn.easypoi.excel.annotation.ExcelCollection;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

public class RotateNoticeDto {
    private String id;
    private String noticetype;
    private String rotatetype;
    private String noticeserial;
    private String documentnumber;
    private String accepteunit;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date storagedate;
    private String creater;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date createtime;
    private String status;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date completedate;
    private String completehumen;
    private String grainannual;
    private String remark;
    private String annex;

    @ExcelCollection(name="")
    private List<RotateNoticeDetailDto> noticeDetailDto;

    public List<RotateNoticeDetailDto> getNoticeDetailDto() {
        return noticeDetailDto;
    }

    public void setNoticeDetailDto(List<RotateNoticeDetailDto> noticeDetailDto) {
        this.noticeDetailDto = noticeDetailDto;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNoticetype() {
        return noticetype;
    }

    public void setNoticetype(String noticetype) {
        this.noticetype = noticetype;
    }

    public String getRotatetype() {
        return rotatetype;
    }

    public void setRotatetype(String rotatetype) {
        this.rotatetype = rotatetype;
    }

    public String getNoticeserial() {
        return noticeserial;
    }

    public void setNoticeserial(String noticeserial) {
        this.noticeserial = noticeserial;
    }

    public String getDocumentnumber() {
        return documentnumber;
    }

    public void setDocumentnumber(String documentnumber) {
        this.documentnumber = documentnumber;
    }

    public String getAccepteunit() {
        return accepteunit;
    }

    public void setAccepteunit(String accepteunit) {
        this.accepteunit = accepteunit;
    }

    public Date getStoragedate() {
        return storagedate;
    }

    public void setStoragedate(Date storagedate) {
        this.storagedate = storagedate;
    }

    public String getCreater() {
        return creater;
    }

    public void setCreater(String creater) {
        this.creater = creater;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCompletedate() {
        return completedate;
    }

    public void setCompletedate(Date completedate) {
        this.completedate = completedate;
    }

    public String getCompletehumen() {
        return completehumen;
    }

    public void setCompletehumen(String completehumen) {
        this.completehumen = completehumen;
    }

    public String getGrainannual() {
        return grainannual;
    }

    public void setGrainannual(String grainannual) {
        this.grainannual = grainannual;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getAnnex() {
        return annex;
    }

    public void setAnnex(String annex) {
        this.annex = annex;
    }
}
