package com.dhc.fastersoft.service;

import com.dhc.fastersoft.entity.FreightDef;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.utils.LayPage;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Component
public interface FreightDefService {
    int save(FreightDef freightDef);
    void updateById(FreightDef freightDef);
    LayPage<FreightDef> pageList(HttpServletRequest request);
    FreightDef selectById(String id);
    List<FreightDef> selectByShipType(HttpServletRequest request);

    List<FreightDef> selectByType(FreightDef freightDef);
    void deleteById(String id);
}
