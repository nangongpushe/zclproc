package com.dhc.fastersoft.entity;

import java.util.Date;

public class StoreSuperviseItem {
	 private String id;

	    private String superviseId;

	    private String warehouseCode;

	    private String warehouseId;

	    private String warehouseName;

	    private String enterpriseId;

	    private String enterpriseSerial;

	    private String enterpriseName;

	    private String organizationCode;

	    private String division;

	    private String personIncharge;

	    private String telephone;

	    private Date superviseStart;
	    
	    private Date superviseEnd;
	    
	    private String socialCreditCode;
	    
	    public String getWarehouseCode() {
			return warehouseCode;
		}

		public void setWarehouseCode(String warehouseCode) {
			this.warehouseCode = warehouseCode;
		}

		public String getSocialCreditCode() {
			return socialCreditCode;
		}

		public void setSocialCreditCode(String socialCreditCode) {
			this.socialCreditCode = socialCreditCode;
		}


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getSuperviseId() {
        return superviseId;
    }

    public void setSuperviseId(String superviseId) {
        this.superviseId = superviseId == null ? null : superviseId.trim();
    }


    public String getWarehouseName() {
        return warehouseName;
    }

    public void setWarehouseName(String warehouseName) {
        this.warehouseName = warehouseName == null ? null : warehouseName.trim();
    }

    public String getEnterpriseId() {
        return enterpriseId;
    }

    public void setEnterpriseId(String enterpriseId) {
        this.enterpriseId = enterpriseId == null ? null : enterpriseId.trim();
    }

    public String getEnterpriseSerial() {
        return enterpriseSerial;
    }

    public void setEnterpriseSerial(String enterpriseSerial) {
        this.enterpriseSerial = enterpriseSerial == null ? null : enterpriseSerial.trim();
    }

    public String getEnterpriseName() {
        return enterpriseName;
    }

    public void setEnterpriseName(String enterpriseName) {
        this.enterpriseName = enterpriseName == null ? null : enterpriseName.trim();
    }

    public String getOrganizationCode() {
        return organizationCode;
    }

    public void setOrganizationCode(String organizationCode) {
        this.organizationCode = organizationCode == null ? null : organizationCode.trim();
    }

    public String getDivision() {
        return division;
    }

    public void setDivision(String division) {
        this.division = division == null ? null : division.trim();
    }

    public String getPersonIncharge() {
        return personIncharge;
    }

    public void setPersonIncharge(String personIncharge) {
        this.personIncharge = personIncharge == null ? null : personIncharge.trim();
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone == null ? null : telephone.trim();
    }

    public Date getSuperviseStart() {
        return superviseStart;
    }

    public void setSuperviseStart(Date superviseStart) {
        this.superviseStart = superviseStart;
    }

    public Date getSuperviseEnd() {
        return superviseEnd;
    }

    public void setSuperviseEnd(Date superviseEnd) {
        this.superviseEnd = superviseEnd;
    }

    public String getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(String warehouseId) {
        this.warehouseId = warehouseId;
    }

    @Override
	public String toString() {
		return "StoreSuperviseItem [id=" + id + ", superviseId=" + superviseId + ", warehouseCode=" + warehouseCode
				+ ", warehouseName=" + warehouseName + ", enterpriseId=" + enterpriseId + ", enterpriseSerial="
				+ enterpriseSerial + ", enterpriseName=" + enterpriseName + ", organizationCode=" + organizationCode
				+ ", division=" + division + ", personIncharge=" + personIncharge + ", telephone=" + telephone
				+ ", superviseStart=" + superviseStart + ", superviseEnd=" + superviseEnd + "]";
	}
}