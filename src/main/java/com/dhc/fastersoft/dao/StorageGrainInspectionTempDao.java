package com.dhc.fastersoft.dao;

import com.dhc.fastersoft.entity.StorageGrainInspectionTemp;

import java.util.List;


public interface StorageGrainInspectionTempDao {

    String getPrimId();

    int save(StorageGrainInspectionTemp storageGrainInspectionTemp);

    int query(String id);

    int remove(String id);

    int update(StorageGrainInspectionTemp storageGrainInspectionTemp);

    List<StorageGrainInspectionTemp> selectStorageGrainInspectionTempByPid(String p_id);







}
