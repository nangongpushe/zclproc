package com.dhc.fastersoft.service;

import java.util.List;
import com.dhc.fastersoft.entity.StorageGrainInspectionTemp;

public interface StorageGrainInspectionTempService {
    public int add(StorageGrainInspectionTemp storageGrainInspectionTemp);

    public int update(StorageGrainInspectionTemp storageGrainInspectionTemp);

    public List<StorageGrainInspectionTemp> getStorageGrainInspectionTempByID(String p_id);

    public int remove(String p_id);

}
