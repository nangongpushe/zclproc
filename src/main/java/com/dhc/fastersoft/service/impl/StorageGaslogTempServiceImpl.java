package com.dhc.fastersoft.service.impl;

import com.dhc.fastersoft.dao.StorageGaslogDao;
import com.dhc.fastersoft.dao.StorageGaslogTempDao;
import com.dhc.fastersoft.entity.StorageGaslogTemp;
import com.dhc.fastersoft.service.StorageGaslogTempService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("storageGaslogTempService")
public class StorageGaslogTempServiceImpl implements StorageGaslogTempService {

    @Autowired
    StorageGaslogTempDao storageGaslogTempDao;
    @Override
    public int add(StorageGaslogTemp storageGaslogTemp) {
        return 0;
    }

    @Override
    public int update(StorageGaslogTemp storageGaslogTemp) {

        return storageGaslogTempDao.update(storageGaslogTemp);
    }

    @Override
    public int remove(String p_id) {
        return storageGaslogTempDao.remove(p_id);
    }

    @Override
    public List<StorageGaslogTemp> selectStorageGaslogTempByPid(String p_id) {

        return storageGaslogTempDao.selectStorageGaslogTempByPid(p_id);
    }
}
