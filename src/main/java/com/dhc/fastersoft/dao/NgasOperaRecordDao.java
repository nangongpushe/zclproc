package com.dhc.fastersoft.dao;

import com.dhc.fastersoft.entity.NgasOperaRecord;
import com.dhc.fastersoft.entity.StorageGrainInspection;

import java.util.HashMap;
import java.util.List;


public interface NgasOperaRecordDao {
    String getPrimId();
    int save(NgasOperaRecord ngasOperaRecord);
    int update(NgasOperaRecord ngasOperaRecord);
    int count(HashMap<String, String> map);
    List<NgasOperaRecord> list(HashMap<String, String> map);
    NgasOperaRecord get(String id);
    int remove(String id);
}
