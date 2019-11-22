package com.dhc.fastersoft.entity;

import cn.afterturn.easypoi.excel.annotation.ExcelCollection;
import com.dhc.fastersoft.entity.store.StoreEnterprise;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

/**
 * 通知书
 * @author 少凡
 * @version 20171013
 */
public class RotateNotice {
	private String id;
	private String noticeType;
	private String rotateType;
	private String noticeSerial;
	private String documentNumber;
	private String accepteUnit="";
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date storageDate;
	private String creater;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date createTime;
	private String status;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date completeDate;
	private String completeHumen;
	private String year;
	private String remark;
	private String annex;
	private Integer sendStatus;
	private String createrId;
	private String audit;
	private String sender;
	/**
	 * 对应公司信息（代储_企业信息表）
	 */
	private StoreEnterprise storeEnterprise;

	private String enterpriseId;

	/**
	 * 是否上报进度
	 */
	private Boolean reportProgress;
	/**
	 * 是否为手工填报
	 */
	private String manuReport;

	public String getManuReport() {
		return manuReport;
	}

	public void setManuReport(String manuReport) {
		this.manuReport = manuReport;
	}

	@ExcelCollection(name="")
	private List<RotateNoticeDetail> noticeDetail;
	
	public List<RotateNoticeDetail> getNoticeDetail() {
		return noticeDetail;
	}
	public void setNoticeDetail(List<RotateNoticeDetail> noticeDetail) {
		this.noticeDetail = noticeDetail;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNoticeType() {
		return noticeType;
	}
	public void setNoticeType(String noticeType) {
		this.noticeType = noticeType;
	}
	public String getRotateType() {
		return rotateType;
	}
	public void setRotateType(String rotateType) {
		this.rotateType = rotateType;
	}
	public String getNoticeSerial() {
		return noticeSerial;
	}
	public void setNoticeSerial(String noticeSerial) {
		this.noticeSerial = noticeSerial;
	}
	public String getDocumentNumber() {
		return documentNumber;
	}
	public void setDocumentNumber(String documentNumber) {
		this.documentNumber = documentNumber;
	}
	public String getAccepteUnit() {
		return accepteUnit;
	}
	public void setAccepteUnit(String accepteUnit) {
		this.accepteUnit = accepteUnit;
	}
	@JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
	public Date getStorageDate() {
		return storageDate;
	}
	public void setStorageDate(Date storageDate) {
		this.storageDate = storageDate;
	}
	public String getCreater() {
		return creater;
	}
	public void setCreater(String creater) {
		this.creater = creater;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	@JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
	public Date getCompleteDate() {
		return completeDate;
	}
	public void setCompleteDate(Date completeDate) {
		this.completeDate = completeDate;
	}
	public String getCompleteHumen() {
		return completeHumen;
	}
	public void setCompleteHumen(String completeHumen) {
		this.completeHumen = completeHumen;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
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
	public Integer getSendStatus() {
		return sendStatus;
	}
	public void setSendStatus(int sendStatus) {
		this.sendStatus = sendStatus;
	}
	public String getCreaterId() {
		return createrId;
	}
	public void setCreaterId(String createrId) {
		this.createrId = createrId;
	}
	public void setSendStatus(Integer sendStatus) {
		this.sendStatus = sendStatus;
	}
	public String getAudit() {
		return audit;
	}
	public void setAudit(String audit) {
		this.audit = audit;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}

	public StoreEnterprise getStoreEnterprise() {
		return storeEnterprise;
	}

	public void setStoreEnterprise(StoreEnterprise storeEnterprise) {
		this.storeEnterprise = storeEnterprise;
	}

	public String getEnterpriseId() {
		return enterpriseId;
	}

	public void setEnterpriseId(String enterpriseId) {
		this.enterpriseId = enterpriseId;
	}

	public Boolean getReportProgress() {
		return reportProgress;
	}

	public void setReportProgress(Boolean reportProgress) {
		this.reportProgress = reportProgress;
	}
}
