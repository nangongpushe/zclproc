package com.dhc.fastersoft.entity;

import com.dhc.fastersoft.entity.StorageGaslog;

public class StorageGaslogTemp {

    private  String id;
    private String p_id;
    private String placeId; //层数
    private String testing;

    private StorageGaslog storageGaslog;

    public StorageGaslog getStorageGaslog() {
        return storageGaslog;
    }

    public void setStorageGaslog(StorageGaslog storageGaslog) {
        this.storageGaslog = storageGaslog;
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

    public String getPlaceId() {
        return placeId;
    }

    public void setPlaceId(String placeId) {
        this.placeId = placeId;
    }

    public String getTesting() {
        return testing;
    }

    public void setTesting(String testing) {
        this.testing = testing;
    }

    @Override
    public String toString() {
        return "StorageGaslogTemp{" +
                "id='" + id + '\'' +
                ", p_id='" + p_id + '\'' +
                ", placeId='" + placeId + '\'' +
                ", testing='" + testing + '\'' +
                ", storageGaslog=" + storageGaslog +
                '}';
    }
}
