package com.dhc.fastersoft.dao;

import com.dhc.fastersoft.entity.NgasOperaSituation;
import com.dhc.fastersoft.entity.StorageGrainInspectionTemp;

import java.util.List;

public interface NgasOperaSituationDao {
    int save(NgasOperaSituation ngasOperaSituation);
    int remove(String id);
    List<NgasOperaSituation> selectNgasOperaSituationByPid(String p_id);
}
