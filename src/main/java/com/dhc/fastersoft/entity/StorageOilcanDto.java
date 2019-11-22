package com.dhc.fastersoft.entity;

public class StorageOilcanDto {
    private String id;
    private String graindepot;
    private String oilcanserial;
    private String oilcantype;
    private String oilcanstatus;
    private String deliverdate;
    private String designedcapacity;
    private String authorizedcapacity;
    private String oilcanheigh;
    private String oilcaninnerdiameter;
    private String oilcanouterdiameter;
    private String designedoilline;
    private String authorizedoilline;
    private String longitude;
    private String latitude;
    private String oilcanname;

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

    public String getOilcanserial() {
        return oilcanserial;
    }

    public void setOilcanserial(String oilcanserial) {
        this.oilcanserial = oilcanserial;
    }

    public String getOilcantype() {
        return oilcantype;
    }

    public void setOilcantype(String oilcantype) {
        this.oilcantype = oilcantype;
    }

    public String getOilcanstatus() {
        return oilcanstatus;
    }

    public void setOilcanstatus(String oilcanstatus) {
        this.oilcanstatus = oilcanstatus;
    }

    public String getDeliverdate() {
        return deliverdate;
    }

    public void setDeliverdate(String deliverdate) {
        this.deliverdate = deliverdate;
    }

    public String getDesignedcapacity() {
        return designedcapacity;
    }

    public void setDesignedcapacity(String designedcapacity) {
        this.designedcapacity = designedcapacity;
    }

    public String getAuthorizedcapacity() {
        return authorizedcapacity;
    }

    public void setAuthorizedcapacity(String authorizedcapacity) {
        this.authorizedcapacity = authorizedcapacity;
    }

    public String getOilcanheigh() {
        return oilcanheigh;
    }

    public void setOilcanheigh(String oilcanheigh) {
        this.oilcanheigh = oilcanheigh;
    }

    public String getOilcaninnerdiameter() {
        return oilcaninnerdiameter;
    }

    public void setOilcaninnerdiameter(String oilcaninnerdiameter) {
        this.oilcaninnerdiameter = oilcaninnerdiameter;
    }

    public String getOilcanouterdiameter() {
        return oilcanouterdiameter;
    }

    public void setOilcanouterdiameter(String oilcanouterdiameter) {
        this.oilcanouterdiameter = oilcanouterdiameter;
    }

    public String getDesignedoilline() {
        return designedoilline;
    }

    public void setDesignedoilline(String designedoilline) {
        this.designedoilline = designedoilline;
    }

    public String getAuthorizedoilline() {
        return authorizedoilline;
    }

    public void setAuthorizedoilline(String authorizedoilline) {
        this.authorizedoilline = authorizedoilline;
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

    public String getOilcanname() {
        return oilcanname;
    }

    public void setOilcanname(String oilcanname) {
        this.oilcanname = oilcanname;
    }

    @Override
    public String toString() {
        return "StorageOilcanDto{" +
                "graindepot='" + graindepot + '\'' +
                ", oilcanserial='" + oilcanserial + '\'' +
                ", oilcantype='" + oilcantype + '\'' +
                ", oilcanstatus='" + oilcanstatus + '\'' +
                ", deliverdate='" + deliverdate + '\'' +
                ", designedcapacity='" + designedcapacity + '\'' +
                ", authorizedcapacity='" + authorizedcapacity + '\'' +
                ", oilcanheigh='" + oilcanheigh + '\'' +
                ", oilcaninnerdiameter='" + oilcaninnerdiameter + '\'' +
                ", oilcanouterdiameter='" + oilcanouterdiameter + '\'' +
                ", designedoilline='" + designedoilline + '\'' +
                ", authorizedoilline='" + authorizedoilline + '\'' +
                ", longitude='" + longitude + '\'' +
                ", latitude='" + latitude + '\'' +
                ", oilcanname='" + oilcanname + '\'' +
                '}';
    }
}
