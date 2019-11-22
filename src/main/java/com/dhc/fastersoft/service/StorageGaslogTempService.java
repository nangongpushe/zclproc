package com.dhc.fastersoft.service;

import com.dhc.fastersoft.entity.StorageGaslogTemp;

import java.util.List;

public interface StorageGaslogTempService {

    public int add(StorageGaslogTemp storageGaslogTemp);

    public int update(StorageGaslogTemp storageGaslogTemp);
    public int remove(String p_id);
    List<StorageGaslogTemp> selectStorageGaslogTempByPid(String p_id);
}
