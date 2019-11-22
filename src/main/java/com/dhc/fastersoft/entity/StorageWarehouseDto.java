package com.dhc.fastersoft.entity;


import java.math.BigDecimal;

//修改库点管理接口(库基本信息)
public class StorageWarehouseDto {
    private String id;

    private String graindepot;
    private String graindepotname;
    private String graindepotshort;
    private String enterprisenature;
    private String graindepottype;
    private String completiondate;
    private BigDecimal storecapacity;
    private BigDecimal acreage;
    private String phonenumber;
    private String fax;
    private String address;
    private String longitude;
    private String latitude;
    private String postalcode;
    private String enterprisename;
    private String organizationcode;
    private String socialcreditcode;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getGraindepot() {
        return graindepot;
    }

    public void setGraindepot(String graindepot) {
        this.graindepot = graindepot;
    }

    public String getGraindepotname() {
        return graindepotname;
    }

    public void setGraindepotname(String graindepotname) {
        this.graindepotname = graindepotname;
    }

    public String getGraindepotshort() {
        return graindepotshort;
    }

    public void setGraindepotshort(String graindepotshort) {
        this.graindepotshort = graindepotshort;
    }

    public String getEnterprisenature() {
        return enterprisenature;
    }

    public void setEnterprisenature(String enterprisenature) {
        this.enterprisenature = enterprisenature;
    }

    public String getGraindepottype() {
        return graindepottype;
    }

    public void setGraindepottype(String graindepottype) {
        this.graindepottype = graindepottype;
    }

    public String getCompletiondate() {
        return completiondate;
    }

    public void setCompletiondate(String completiondate) {
        this.completiondate = completiondate;
    }

    public BigDecimal getStorecapacity() {
        return storecapacity;
    }

    public void setStorecapacity(BigDecimal storecapacity) {
        this.storecapacity = storecapacity;
    }

    public BigDecimal getAcreage() {
        return acreage;
    }

    public void setAcreage(BigDecimal acreage) {
        this.acreage = acreage;
    }

    public String getPhonenumber() {
        return phonenumber;
    }

    public void setPhonenumber(String phonenumber) {
        this.phonenumber = phonenumber;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public String getPostalcode() {
        return postalcode;
    }

    public void setPostalcode(String postalcode) {
        this.postalcode = postalcode;
    }

    public String getEnterprisename() {
        return enterprisename;
    }

    public void setEnterprisename(String enterprisename) {
        this.enterprisename = enterprisename;
    }

    public String getOrganizationcode() {
        return organizationcode;
    }

    public void setOrganizationcode(String organizationcode) {
        this.organizationcode = organizationcode;
    }

    public String getSocialcreditcode() {
        return socialcreditcode;
    }

    public void setSocialcreditcode(String socialcreditcode) {
        this.socialcreditcode = socialcreditcode;
    }

    @Override
    public String toString() {
        return "StorageWarehouseDto{" +
                "id='" + id + '\'' +
                ", graindepot='" + graindepot + '\'' +
                ", graindepotname='" + graindepotname + '\'' +
                ", graindepotshort='" + graindepotshort + '\'' +
                ", enterprisenature='" + enterprisenature + '\'' +
                ", graindepottype='" + graindepottype + '\'' +
                ", completiondate='" + completiondate + '\'' +
                ", storecapacity='" + storecapacity + '\'' +
                ", acreage='" + acreage + '\'' +
                ", phonenumber='" + phonenumber + '\'' +
                ", fax='" + fax + '\'' +
                ", address='" + address + '\'' +
                ", longitude='" + longitude + '\'' +
                ", latitude='" + latitude + '\'' +
                ", postalcode='" + postalcode + '\'' +
                ", enterprisename='" + enterprisename + '\'' +
                ", organizationcode='" + organizationcode + '\'' +
                ", socialcreditcode='" + socialcreditcode + '\'' +
                '}';
    }
}

