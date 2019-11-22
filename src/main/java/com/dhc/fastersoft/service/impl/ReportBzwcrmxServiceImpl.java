package com.dhc.fastersoft.service.impl;

import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.report.ReportBzwcrmxDao;
import com.dhc.fastersoft.dao.report.ReportMonthDao;
import com.dhc.fastersoft.dao.report.ReportSwtzDao;
import com.dhc.fastersoft.entity.enumdata.ReportNameEnum;
import com.dhc.fastersoft.entity.enumdata.ReportStatusEnum;
import com.dhc.fastersoft.entity.report.ReportBzwcrmx;
import com.dhc.fastersoft.entity.report.ReportMonth;
import com.dhc.fastersoft.entity.report.ReportSwtz;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.ReportBzwcrmxService;
import com.dhc.fastersoft.service.ReportSwtzService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;
@Service("reportBzwcrmxService")
public class ReportBzwcrmxServiceImpl implements ReportBzwcrmxService {
    @Autowired
    public ReportMonthDao monthDao;
    @Autowired
    public ReportBzwcrmxDao dao;

    @Override
    public List<ReportBzwcrmx> listBzwcrmxByReportId(String reportId) {
        return dao.listBzwcrmxByReportId(reportId);
    }
    @Override
    public String addBzwcrmx(String reportId, String reportMonth, List<ReportBzwcrmx> bzwcrmxlist, String manager, String reserveProperty,String comments){
        SysUser user = TokenManager.getToken();
        String reportWarehouse = user.getShortName();
        if (StringUtils.isEmpty(reportId)){
            ReportMonth reportMain = new ReportMonth();
            reportId = UUID.randomUUID().toString().replace("-","");
            reportMain.setReportMonth(reportMonth);
            reportMain.setReportName(ReportNameEnum.BZWCRMX.getValue());
            reportMain.setId(reportId);
            reportMain.setReportWarehouse(reportWarehouse);
            reportMain.setReportWarehouseId(user.getWareHouseId());
            reportMain.setReportStatus(ReportStatusEnum.CG.getValue());
            reportMain.setCreator(user.getAccount());
            reportMain.setManager(manager);
            reportMain.setReserveProperty(reserveProperty);
            reportMain.setComments(comments);
            monthDao.add(reportMain);
        } else {
            //先清空当月当库数据
            dao.deleteByReportId(reportId);
            //更新状态
            ReportMonth reportMain = new ReportMonth();
            reportMain.setId(reportId);
            reportMain.setReportStatus(ReportStatusEnum.CG.getValue());
            reportMain.setManager(manager);
            reportMain.setReserveProperty(reserveProperty);
            reportMain.setCreator(user.getAccount());
            reportMain.setComments(comments);
            monthDao.update(reportMain);
        }

        for (int i = 0; i < bzwcrmxlist.size(); i++) {
            ReportBzwcrmx reportBzwcrmx = bzwcrmxlist.get(i);
            reportBzwcrmx.setReportId(reportId);
            reportBzwcrmx.setReportMonth(reportMonth);
            reportBzwcrmx.setReportWarehouse(reportWarehouse);
            reportBzwcrmx.setReportName(ReportNameEnum.BZWCRMX.getValue());
            reportBzwcrmx.setOrdernum(new BigDecimal(i));
            dao.add(reportBzwcrmx);
        }

        return reportId;
    }

    @Override
    public String addProxyBzwcrmx(String reportWarehouseId, String reportWarehouse,String reportId, String reportMonth, List<ReportBzwcrmx> bzwcrmxlist, String manager,String comments){
        SysUser user = TokenManager.getToken();
        //String reportWarehouse = user.getShortName();
        if (StringUtils.isEmpty(reportId)){
            ReportMonth reportMain = new ReportMonth();
            reportId = UUID.randomUUID().toString().replace("-","");
            reportMain.setReportMonth(reportMonth);
            reportMain.setReportName(ReportNameEnum.BZWCRMX.getValue());
            reportMain.setId(reportId);
            reportMain.setReportWarehouse(reportWarehouse);
            reportMain.setReportWarehouseId(reportWarehouseId);
            reportMain.setReportStatus(ReportStatusEnum.CG.getValue());
            reportMain.setCreator(user.getAccount());
            reportMain.setManager(manager);
            //reportMain.setReserveProperty(reserveProperty);
            reportMain.setComments(comments);
            monthDao.add(reportMain);
        } else {
            //先清空当月当库数据
            dao.deleteByReportId(reportId);
            //更新状态
            ReportMonth reportMain = new ReportMonth();
            reportMain.setId(reportId);
            reportMain.setReportStatus(ReportStatusEnum.CG.getValue());
            reportMain.setManager(manager);
            //reportMain.setReserveProperty(reserveProperty);
            reportMain.setCreator(user.getAccount());
            reportMain.setComments(comments);
            monthDao.update(reportMain);
        }

        for (int i = 0; i < bzwcrmxlist.size(); i++) {
            ReportBzwcrmx reportBzwcrmx = bzwcrmxlist.get(i);
            reportBzwcrmx.setReportId(reportId);
            reportBzwcrmx.setReportMonth(reportMonth);
            reportBzwcrmx.setReportWarehouse(reportWarehouse);
            reportBzwcrmx.setReportName(ReportNameEnum.BZWCRMX.getValue());
            reportBzwcrmx.setOrdernum(new BigDecimal(i));
            dao.add(reportBzwcrmx);
        }

        return reportId;
    }

    @Override
    public List<ReportBzwcrmx> listSumBzwcrmx(String gatherId) {
        return dao.listSumBzwcrmx(gatherId);
    }
}
