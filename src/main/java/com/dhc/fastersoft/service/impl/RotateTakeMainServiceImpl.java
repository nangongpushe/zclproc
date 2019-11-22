package com.dhc.fastersoft.service.impl;

import com.dhc.fastersoft.dao.RotateTakeMainDao;
import com.dhc.fastersoft.entity.RotateTake;
import com.dhc.fastersoft.entity.RotateTakeMain;
import com.dhc.fastersoft.service.RotateTakeMainService;
import com.dhc.fastersoft.service.RotateTakeService;
import com.dhc.fastersoft.utils.PageUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service("rotateTakeMainService")
public class RotateTakeMainServiceImpl implements RotateTakeMainService {

    @Autowired
    private RotateTakeMainDao rotateTakeMainDao;

    @Autowired
    private RotateTakeService rotateTakeService;

    @Override
    public int save(RotateTakeMain rotateTakeMain) {
        String mainId = UUID.randomUUID().toString().replace("-", "");
        rotateTakeMain.setId(mainId);
        int count = rotateTakeMainDao.save(rotateTakeMain);
        for (RotateTake rotateTake : rotateTakeMain.getRotateTakes()) {
            rotateTake.setId(UUID.randomUUID().toString().replace("-", ""));
            rotateTake.setMainId(mainId);
            rotateTakeService.AddRotateTake(rotateTake);
        }
        return count;
    }


    @Override
    public int update(RotateTakeMain rotateTakeMain) {
        int count = rotateTakeMainDao.update(rotateTakeMain);
        if (rotateTakeMain.getRotateTakes() == null || rotateTakeMain.getRotateTakes().size() == 0) {
            return count;
        }
        // 删除子信息
        rotateTakeService.deleteByMainId(rotateTakeMain.getId());

        // 重新插入
        for (RotateTake rotateTake : rotateTakeMain.getRotateTakes()) {
            rotateTake.setId(UUID.randomUUID().toString().replace("-", ""));
            rotateTake.setMainId(rotateTakeMain.getId());
            rotateTakeService.AddRotateTake(rotateTake);
        }
        return count;
    }

    @Override
    public List<RotateTakeMain> limitByParams(PageUtil pageUtil) {
        pageUtil.setTotalCount(rotateTakeMainDao.getTotalCount(pageUtil));
        List<RotateTakeMain> dataList = rotateTakeMainDao.limitByParams(pageUtil);
        for (RotateTakeMain takeMain : dataList) {
            StringBuffer storeHouse = new StringBuffer();
            StringBuffer payCompany = new StringBuffer();
            for (RotateTake rotateTake : takeMain.getRotateTakes()) {
                if (StringUtils.isNotEmpty(rotateTake.getAcceptanceUnit())) {
                    payCompany.append(rotateTake.getAcceptanceUnit());
                    payCompany.append("、");
                }
                if (StringUtils.isNotEmpty(rotateTake.getStoreEncode())) {
                    storeHouse.append(rotateTake.getStoreEncode());
                    storeHouse.append("、");
                }
            }
            if (payCompany.length() > 0) {
                payCompany.delete(payCompany.length() - 1, payCompany.length());
            }
            if (storeHouse.length() > 0) {
                storeHouse.delete(storeHouse.length() - 1, storeHouse.length());
            }
            takeMain.setPayCompany(payCompany.toString());
            takeMain.setStoreHouses(storeHouse.toString());
        }
        return dataList;
    }

    @Override
    public RotateTakeMain getById(String id) {
        return rotateTakeMainDao.getById(id);
    }

    @Override
    public RotateTakeMain getBySerial(String serial) {
        return rotateTakeMainDao.getBySerial(serial);
    }
    @Override
    public List<String> getAmount(String deal_serial) {
        return rotateTakeMainDao.getAmount(deal_serial);
    }

    @Override
    public String getAmountById(String id) {
        return rotateTakeMainDao.getAmountById(id);
    }

    @Override
    public String getMaxSerial() {
        return rotateTakeMainDao.getMaxSerial();
    }
    @Override
    public List<String> getWeight(String deal_serial) {
        return rotateTakeMainDao.getWeight(deal_serial);
    }

}
