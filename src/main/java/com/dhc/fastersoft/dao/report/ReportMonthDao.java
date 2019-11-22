package com.dhc.fastersoft.dao.report;

import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.report.ReportMonth;
import com.dhc.fastersoft.entity.system.SysUser;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public interface ReportMonthDao {
    int add(ReportMonth reportMonth);

    int deleteByMonthHouse(Map map);

    /**
     * 通过ID更新状态
     * @param  map (id status)
     * @return
     */
    int updateStatus(Map map);


    int updateStatusByMonthAndName(Map map);

    ReportMonth getReportMonthById(String reportId);

    ReportMonth getReport(ReportMonth reportMonth);

    List<ReportMonth> listReport(ReportMonth report);

    /**
     * 汇总驳回(包括各库月报)
     * @param map
     * @return
     */
    int appSumBack(Map map);

    int updateGatherId(ReportMonth report);

    int clearGatherId(String id);

    int sumOA(Map map);

    int update(ReportMonth reportMain);

    SysUser getUserInfoByAccount(String account);
    
    List<ReportMonth> fillTableQuery(Map<String,Object> param);

    List<ReportMonth> queryReportMonth(Map<String,Object> param);
    int fillTableQueryCount(Map<String,Object> param);

    int queryReportMonthCount(Map<String,Object> param);

    int kudianPageCount(HashMap<String, String> maps);

    List<StorageWarehouse> kudianPageQuery(HashMap<String, String> maps);

    int changeStatus(Map<String,Object> ids);

}
