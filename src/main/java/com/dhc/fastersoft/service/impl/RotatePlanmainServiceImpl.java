package com.dhc.fastersoft.service.impl;

import com.dhc.fastersoft.dao.RotatePlanmainDao;
import com.dhc.fastersoft.dao.RotatePlanmainDetailDao;
import com.dhc.fastersoft.entity.RotatePlanmain;
import com.dhc.fastersoft.entity.RotatePlanmainDetail;
import com.dhc.fastersoft.service.RotatePlanmainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;


@Service("rotatePlanmainService")
public class RotatePlanmainServiceImpl implements RotatePlanmainService {

    @Autowired
    private RotatePlanmainDao dao;
    @Autowired
    private RotatePlanmainDetailDao detaildao;

    @Override
    public int save(RotatePlanmain rotatePlan) {
        rotatePlan.setId(UUID.randomUUID().toString().replaceAll("-", ""));
        rotatePlan.setColletorDate(Calendar.getInstance().getTime());
        BigDecimal stock_in = new BigDecimal(0);
        BigDecimal stock_out =new BigDecimal(0);
        List<RotatePlanmainDetail> rotatePlanDetail = rotatePlan.getPlanmainDetail();
        for (int i = 0; i < rotatePlanDetail.size(); i++) {
            RotatePlanmainDetail detail = rotatePlanDetail.get(i);
            detail.setId(UUID.randomUUID().toString().replaceAll("-", ""));
            String type = detail.getRotateType();
            if (type.equals("轮入"))
                //stock_in += Double.valueOf(detail.getRotateNumber());
                stock_in= stock_in.add(detail.getRotateNumber());
            else if (type.equals("轮出"))
                //stock_out += Double.valueOf(detail.getRotateNumber());
                stock_out = stock_out.add(detail.getRotateNumber());
        }
        rotatePlan.setStockIn(stock_in);
        rotatePlan.setStockOut(stock_out);
        dao.save(rotatePlan);
        return 1;
    }

    @Override
    public RotatePlanmain getPlan(String id) {
        RotatePlanmain rotatePlanmain = dao.getPlan(id);
        List<RotatePlanmainDetail> rotatePlanmainDetails = dao.listPlanDetail(id);
        if(null != rotatePlanmain) {
            rotatePlanmain.setPlanmainDetail(rotatePlanmainDetails);
        }
        return rotatePlanmain;
    }

    @Override
    public int update(RotatePlanmain rotatePlanmain) {
        Date date = new Date();
        rotatePlanmain.setModifyDate(date);

        List<RotatePlanmainDetail> rotatePlanDetail = rotatePlanmain.getPlanmainDetail();
        BigDecimal stock_in = new BigDecimal(0);
        BigDecimal stock_out = new BigDecimal(0);
        for (int i = 0; i < rotatePlanDetail.size(); i++) {
            RotatePlanmainDetail detail = rotatePlanDetail.get(i);
            if (null == detail.getId() || "".equals(detail.getId()))
                detail.setId(UUID.randomUUID().toString().replaceAll("-", ""));
            String type = detail.getRotateType();
            if (type.equals("轮入"))
                //stock_in += Double.valueOf(detail.getRotateNumber());
                stock_in = stock_in.add(detail.getRotateNumber());
            else if (type.equals("轮出"))
                //stock_out += Double.valueOf(detail.getRotateNumber());
                stock_out = stock_out.add(detail.getRotateNumber());
        }
        rotatePlanmain.setStockIn(stock_in);
        rotatePlanmain.setStockOut(stock_out);
        return dao.update(rotatePlanmain);
    }

    @Override
    public List<RotatePlanmainDetail> listDetail(String id) {
        return dao.listPlanDetail(id);
    }

    @Override
    public List<RotatePlanmain> list(HashMap<String, Object> map) {
        return dao.list(map);
    }

    @Override
    public int count(HashMap<String, Object> map) {
        return dao.count(map);
    }

    @Override
    public int updateState(String id, String state) {
        HashMap<String, Object> map = new HashMap<>();
        map.put("id", id);
        map.put("state", state);
        map.put("completeDate", new Date());
        return dao.updateState(map);
    }

    @Override
    public List<RotatePlanmainDetail> listDetailByCondition(HashMap<String, String> map) {
        return dao.listDetailByCondition(map);
    }

    @Override
    public boolean checkPrimary(String planName) {
        int count = dao.checkPrimary(planName);
        return count > 0 ? false : true;
    }

    @Override
    public int detailcount(HashMap<String, String> map) {
        return dao.detailcount(map);
    }

    @Override
    public RotatePlanmainDetail findById(String id) {
        return detaildao.findById(id);
    }

    @Override
    public void updatedetailNumberByid(RotatePlanmainDetail rotatePlanmainDetail) {
        detaildao.updatedetailNumberByid(rotatePlanmainDetail);
    }

    @Override
    public List<RotatePlanmainDetail> findSumDetailNumberByPlanId(String planId) {
        return detaildao.findSumDetailNumberByPlanId(planId);
    }

    @Override
    public int remove(String id) {
        return  dao.remove(id);
    }

    @Override
    public int removeDetail(String id) {
        return dao.removeDetail(id);
    }

    @Override
    public int updateAttachment(RotatePlanmain rotatePlanmain) {
        return dao.updateAttachment(rotatePlanmain);
    }

    @Override
    public List<RotatePlanmain> tablelist(HashMap<String, Object> map) {
        return dao.tablelist(map);
    }

    @Override
    public int tablecount(HashMap<String, Object> map) {
        return dao.tablecount(map);
    }

    @Override
    public List<RotatePlanmain> listAll(RotatePlanmain plan) {
        // TODO Auto-generated method stub
        return dao.listAll(plan);
    }
}
