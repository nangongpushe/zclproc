package com.dhc.fastersoft.service;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.entity.NgasOperaRecord;
import com.dhc.fastersoft.entity.NgasOperaSituation;
import com.dhc.fastersoft.entity.StorageGrainInspection;
import com.dhc.fastersoft.entity.StorageGrainInspectionTemp;
import com.dhc.fastersoft.utils.LayPage;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface NgasOperaRecordService {

    ActionResultModel save(NgasOperaRecord ngasOperaRecord);
    ActionResultModel update(NgasOperaRecord ngasOperaRecord);
    LayPage<NgasOperaRecord> list(HttpServletRequest request);
    NgasOperaRecord get(String id);
    //查询小表
    List<NgasOperaSituation> selectNgasOperaSituationByPid(String p_id);
    ActionResultModel remove(String id);

}
