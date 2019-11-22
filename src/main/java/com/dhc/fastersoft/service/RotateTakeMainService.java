package com.dhc.fastersoft.service;

import com.dhc.fastersoft.entity.RotateTakeMain;
import com.dhc.fastersoft.utils.PageUtil;

import java.util.List;

public interface RotateTakeMainService {

    int save(RotateTakeMain rotateTakeMain);

    int update(RotateTakeMain rotateTakeMain);

    List<RotateTakeMain> limitByParams(PageUtil pageUtil);

    RotateTakeMain getById(String id);

    List<String> getWeight(String deal_serial);
    List<String> getAmount(String deal_serial);
    String getAmountById(String id);

    String getMaxSerial();
    RotateTakeMain getBySerial(String serial);
}
