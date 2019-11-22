package com.dhc.fastersoft.service.impl;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.dao.StorageGrainInspectionTempDao;
import com.dhc.fastersoft.entity.StorageGrainInspectionTemp;
import com.dhc.fastersoft.service.StorageGrainInspectionTempService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;

@Service("storageGrainInspectionTempService")
public class StorageGrainInspectionTempServiceImpl implements StorageGrainInspectionTempService {
    @Autowired
    StorageGrainInspectionTempDao sgtdao;

    @Override
    public int add(StorageGrainInspectionTemp storageGrainInspectionTemp) {
        return 0 ;
    }

    @Override
    public int update(StorageGrainInspectionTemp storageGrainInspectionTemp) {
        return 0;
    }

    @Override
    public List<StorageGrainInspectionTemp> getStorageGrainInspectionTempByID(String id) {
        return null;
    }

    @Override
    public int remove(String id) {
        return 0;
    }


}
