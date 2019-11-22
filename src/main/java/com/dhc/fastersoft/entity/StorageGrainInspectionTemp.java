package com.dhc.fastersoft.entity;

//粮情记录温度表
public class StorageGrainInspectionTemp {

    private  String id;
    private String p_id;
    private String placeId; //层数
    private Float topMax;
    private Float topMin;
    private Float topAvg;


    private StorageGrainInspection storageGrainInspection;
    public StorageGrainInspection getStorageGrainInspection() {
        return storageGrainInspection;
    }
    public void setStorageGrainInspection(StorageGrainInspection storageGrainInspection) {
        this.storageGrainInspection = storageGrainInspection;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getP_id() {
        return p_id;
    }

    public void setP_id(String p_id) {
        this.p_id = p_id;
    }

    public void setTopMax(Float topMax) {
        this.topMax = topMax;
    }
    public Float getTopMax() {
        return topMax;
    }

    public void setTopMin(Float topMin) {
        this.topMin = topMin;
    }
    public Float getTopMin() {
        return topMin;
    }

    public void setTopAvg(Float topAvg) {
        this.topAvg = topAvg;
    }
    public Float getTopAvg() {
        return topAvg;
    }

    public String getPlaceId() {
        return placeId;
    }

    public void setPlaceId(String placeId) {
        this.placeId = placeId;
    }

    @Override
    public String toString() {
        return "StorageGrainInspectionTemp{" +
                "id='" + id + '\'' +
                ", p_id='" + p_id + '\'' +
                ", topMax=" + topMax +
                ", topMin=" + topMin +
                ", topAvg=" + topAvg +
                ", placeId='" + placeId + '\'' +
                ", storageGrainInspection=" + storageGrainInspection +
                '}';
    }
}
