package com.dhc.fastersoft.dao;

import com.dhc.fastersoft.entity.StorageGaslogTemp;

import java.util.List;

public interface StorageGaslogTempDao {
    String getPrimId();

    int save(StorageGaslogTemp storageGaslogTemp);

    int query(String id);

    int remove(String id);

    int update(StorageGaslogTemp storageGaslogTemp);

    List<StorageGaslogTemp> selectStorageGaslogTempByPid(String p_id);
}
