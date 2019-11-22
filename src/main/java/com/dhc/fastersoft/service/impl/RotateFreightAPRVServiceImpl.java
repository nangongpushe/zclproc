package com.dhc.fastersoft.service.impl;

import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.RotateFreightAPRVDao;
import com.dhc.fastersoft.entity.RotateFreightAPRV;
import com.dhc.fastersoft.entity.RotateFreightAPRVDetail;
import com.dhc.fastersoft.entity.RotateFreightAPRVGather;
import com.dhc.fastersoft.service.RotateFreightAPRVService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;

@Service("rotateFreightAPRVService")
public class RotateFreightAPRVServiceImpl implements RotateFreightAPRVService {

    @Autowired
    private RotateFreightAPRVDao aprvDao;

    @Override
    public int save(RotateFreightAPRV record) {
        // TODO Auto-generated method stub
        record.setId(UUID.randomUUID().toString().replaceAll("-", ""));
        Date date = Calendar.getInstance().getTime();
        record.setReportDate(date);
        record.setReporter(TokenManager.getNickname());

        List<RotateFreightAPRVDetail> detailList = record.getDetailList();
        double totalQuantity = 0, totalBulk = 0, totalPackage = 0, totalFreight = 0,
                totalOtherFee = 0, totalBoardFee = 0, totalWarehouseFee = 0, totalFee = 0;
        for (RotateFreightAPRVDetail detail : detailList) {
            detail.setId(UUID.randomUUID().toString().replaceAll("-", ""));
            detail.setReportDate(date);
            totalQuantity = BigDecimal.valueOf(totalQuantity)
                    .add(BigDecimal.valueOf(Double.parseDouble(detail.getQuantity()))).doubleValue();
            totalBulk = BigDecimal.valueOf(totalBulk)
                    .add(BigDecimal.valueOf(Double.parseDouble(detail.getBulk()))).doubleValue();
            totalPackage = BigDecimal.valueOf(totalPackage)
                    .add(BigDecimal.valueOf(Double.parseDouble(detail.getPackageNum()))).doubleValue();
            totalFreight = BigDecimal.valueOf(totalFreight)
                    .add(BigDecimal.valueOf(Double.parseDouble(detail.getFreight()))).doubleValue();
            totalOtherFee = BigDecimal.valueOf(totalOtherFee)
                    .add(BigDecimal.valueOf(Double.parseDouble(detail.getOtherFee()))).doubleValue();
            totalBoardFee = BigDecimal.valueOf(totalBoardFee)
                    .add(BigDecimal.valueOf(Double.parseDouble(detail.getBoardFee()))).doubleValue();
            totalWarehouseFee = BigDecimal.valueOf(totalWarehouseFee)
                    .add(BigDecimal.valueOf(Double.parseDouble(detail.getWarehouseFee()))).doubleValue();
            totalFee = BigDecimal.valueOf(totalFee)
                    .add(BigDecimal.valueOf(Double.parseDouble(detail.getTotalFee()))).doubleValue();

        }

        record.setTotalQuantity(String.valueOf(totalQuantity));
        record.setTotalBulk(String.valueOf(totalBulk));
        record.setTotalPackage(String.valueOf(totalPackage));
        record.setTotalFreight(String.valueOf(totalFreight));
        record.setTotalOtherFee(String.valueOf(totalOtherFee));
        record.setTotalBoardFee(String.valueOf(totalBoardFee));
        record.setTotalWarehouseFee(String.valueOf(totalWarehouseFee));
        record.setTotalFee(String.valueOf(totalFee));
        return aprvDao.save(record);
    }

    @Override
    public int update(RotateFreightAPRV record) {
        // TODO Auto-generated method stub
        List<RotateFreightAPRVDetail> detailList = record.getDetailList();
        double totalQuantity = 0, totalBulk = 0, totalPackage = 0, totalFreight = 0,
                totalOtherFee = 0, totalBoardFee = 0, totalWarehouseFee = 0, totalFee = 0;
        for (RotateFreightAPRVDetail detail : detailList) {
            if (null == detail.getId() || "".equals(detail.getId())) {
                detail.setId(UUID.randomUUID().toString().replaceAll("-", ""));
                detail.setReportDate(record.getReportDate());
            }
            totalQuantity = BigDecimal.valueOf(totalQuantity)
                    .add(BigDecimal.valueOf(Double.parseDouble(detail.getQuantity()))).doubleValue();
            totalBulk = BigDecimal.valueOf(totalBulk)
                    .add(BigDecimal.valueOf(Double.parseDouble(detail.getBulk()))).doubleValue();
            totalPackage = BigDecimal.valueOf(totalPackage)
                    .add(BigDecimal.valueOf(Double.parseDouble(detail.getPackageNum()))).doubleValue();
            totalFreight = BigDecimal.valueOf(totalFreight)
                    .add(BigDecimal.valueOf(Double.parseDouble(detail.getFreight()))).doubleValue();
            totalOtherFee = BigDecimal.valueOf(totalOtherFee)
                    .add(BigDecimal.valueOf(Double.parseDouble(detail.getOtherFee()))).doubleValue();
            totalBoardFee = BigDecimal.valueOf(totalBoardFee)
                    .add(BigDecimal.valueOf(Double.parseDouble(detail.getBoardFee()))).doubleValue();
            totalWarehouseFee = BigDecimal.valueOf(totalWarehouseFee)
                    .add(BigDecimal.valueOf(Double.parseDouble(detail.getWarehouseFee()))).doubleValue();
            totalFee = BigDecimal.valueOf(totalFee)
                    .add(BigDecimal.valueOf(Double.parseDouble(detail.getTotalFee()))).doubleValue();
        }
        record.setTotalQuantity(String.valueOf(totalQuantity));
        record.setTotalBulk(String.valueOf(totalBulk));
        record.setTotalPackage(String.valueOf(totalPackage));
        record.setTotalFreight(String.valueOf(totalFreight));
        record.setTotalOtherFee(String.valueOf(totalOtherFee));
        record.setTotalBoardFee(String.valueOf(totalBoardFee));
        record.setTotalWarehouseFee(String.valueOf(totalWarehouseFee));
        record.setTotalFee(String.valueOf(totalFee));
        return aprvDao.update(record);
    }

    @Override
    public int remove(String id) {
        // TODO Auto-generated method stub
        return aprvDao.remove(id);
    }

    @Override
    public int removeDetail(String id) {
        // TODO Auto-generated method stub
        return aprvDao.removeDetail(id);
    }

    @Override
    public RotateFreightAPRV getById(String id) {
        // TODO Auto-generated method stub
        RotateFreightAPRV aprv = aprvDao.getById(id);
        HashMap<String, Object> map = new HashMap<>();
        map.put("aprvId", id);
        List<RotateFreightAPRVDetail> detailList = aprvDao.listDetail(map);
        aprv.setDetailList(detailList);
        return aprv;
    }

    @Override
    public int count(HashMap<String, Object> map) {
        // TODO Auto-generated method stub
        return aprvDao.count(map);
    }

    @Override
    public List<RotateFreightAPRV> list(HashMap<String, Object> map) {
        // TODO Auto-generated method stub
        return aprvDao.list(map);
    }

    @Override
    public List<RotateFreightAPRVDetail> listDetail(HashMap<String, Object> map) {
        // TODO Auto-generated method stub
        return aprvDao.listDetail(map);
    }

    @Override
    public int updateStatus(HashMap<String, Object> map) {
        // TODO Auto-generated method stub
        return aprvDao.updateStatus(map);
    }

    @Override
    public int updateIsGather(HashMap<String, Object> map) {
        // TODO Auto-generated method stub
        return aprvDao.updateIsGather(map);
    }

    @Override
    public int updateIsReport(HashMap<String, Object> map) {
        // TODO Auto-generated method stub
        return aprvDao.updateIsReport(map);
    }

    @Override
    public int countGather(HashMap<String, Object> map) {
        // TODO Auto-generated method stub
        return aprvDao.countGather(map);
    }

    @Override
    public List<RotateFreightAPRVGather> listGather(HashMap<String, Object> map) {
        // TODO Auto-generated method stub
        return aprvDao.listGather(map);
    }

    @Override
    public List<RotateFreightAPRVDetail> listDetailGather(HashMap<String, Object> map) {
        // TODO Auto-generated method stub
        return aprvDao.listDetailGather(map);
    }

    @Override
    public int saveGather(RotateFreightAPRVGather record) {
        // TODO Auto-generated method stub
        record.setId(UUID.randomUUID().toString().replaceAll("-", ""));
        return aprvDao.saveGather(record);
    }

    @Override
    public RotateFreightAPRVGather getGather(HashMap<String, Object> map) {
        // TODO Auto-generated method stub

        return aprvDao.getGather(map);
    }

    @Override
    public int updateGatherStatus(HashMap<String, Object> map) {
        // TODO Auto-generated method stub
        return aprvDao.updateGatherStatus(map);
    }

    @Override
    public int updateGatherId(HashMap<String, Object> map) {
        // TODO Auto-generated method stub
        return aprvDao.updateGatherId(map);
    }

    @Override
    public int removeGather(String id) {
        // TODO Auto-generated method stub
        return aprvDao.removeGather(id);
    }


}
