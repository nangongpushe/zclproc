package com.dhc.fastersoft.entity;

import java.util.List;

/**
 * 库点
 */
public class EnterpriseWarehouse {

    private String id;

    /**
     * 库点简称
     */
    private String enterpriseWareHouseName;
    /**
     * 库点对应的仓房编号
     */
    private List<String> storeHouseList;

    public List<String> getStoreHouseList() {
        return storeHouseList;
    }

    public void setStoreHouseList(List<String> storeHouseList) {
        this.storeHouseList = storeHouseList;
    }

    public String getEnterpriseWareHouseName() {
        return enterpriseWareHouseName;
    }

    public void setEnterpriseWareHouseName(String enterpriseWareHouseName) {
        this.enterpriseWareHouseName = enterpriseWareHouseName;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

}
