package com.dhc.fastersoft.dao;

import com.dhc.fastersoft.entity.RotateTakeMain;
import com.dhc.fastersoft.utils.PageUtil;

import java.util.List;

public interface RotateTakeMainDao {

    int save(RotateTakeMain rotateTakeMain);

    int update(RotateTakeMain rotaeTakeMain);

    int remove(String id);

    List<RotateTakeMain> limitByParams(PageUtil pageUtil);

    int getTotalCount(PageUtil pageUtil);

    RotateTakeMain getById(String id);

    RotateTakeMain getBySerial(String serial);
    List<String> getWeight(String deal_serial);
    List<String> getAmount(String deal_serial);
    String getAmountById(String id);

    String getMaxSerial();
}
