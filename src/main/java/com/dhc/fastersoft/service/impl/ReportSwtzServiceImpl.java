package com.dhc.fastersoft.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.StoreSuperviseItemDao;
import com.dhc.fastersoft.dao.report.ReportMonthDao;
import com.dhc.fastersoft.dao.report.ReportSwtzDao;
import com.dhc.fastersoft.dao.store.StoreEnterpriseDao;
import com.dhc.fastersoft.dao.system.SysUserDao;
import com.dhc.fastersoft.entity.*;
import com.dhc.fastersoft.entity.echarts.EchartsData;
import com.dhc.fastersoft.entity.echarts.Serie;
import com.dhc.fastersoft.entity.enumdata.ReportNameEnum;
import com.dhc.fastersoft.entity.enumdata.ReportStatusEnum;
import com.dhc.fastersoft.entity.report.ReportMonth;
import com.dhc.fastersoft.entity.report.ReportSwtz;
import com.dhc.fastersoft.entity.store.StoreEnterprise;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.ReportSwtzService;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.service.StoreSuperviseService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.utils.DateUtil;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.vo.KCTJChartsVO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.*;

@Service("reportSwtzService")
public class ReportSwtzServiceImpl implements ReportSwtzService {

    @Autowired
    public ReportSwtzDao dao;
    @Autowired
    public ReportMonthDao monthDao;
    @Autowired
    private StorageWarehouseService storageWarehouseService;
    @Autowired
    private SysDictService sysDictService;
    @Autowired
    SysUserDao userDao;

    @Autowired
    StoreEnterpriseDao enterpriseDao;

    @Autowired
    private StoreSuperviseService storeSuperviseService;
    @Autowired
    private StoreSuperviseItemDao storeSuperviseItemDao  ;
    @Override
    public List<ReportSwtz> listSwtz(HttpServletRequest request, String reportWarehouse) {
        Map map = new HashMap();
        String reportMonth = request.getParameter("reportMonth");
        String storehouse = request.getParameter("storehouse");
        String minHarvestYear = request.getParameter("minHarvestYear");
        String maxHarvestYear = request.getParameter("maxHarvestYear");
        String variety = request.getParameter("variety");
        String minQuantity = request.getParameter("minQuantity");
        String maxQuantity = request.getParameter("maxQuantity");
        String province = request.getParameter("province");
        map.put("reportId", request.getParameter("reportId"));
        map.put("reportMonth", reportMonth);
        map.put("storehouse", storehouse);
        map.put("minHarvestYear", minHarvestYear);
        map.put("maxHarvestYear", maxHarvestYear);
        map.put("variety", variety);
        map.put("minQuantity", minQuantity);
        map.put("maxQuantity", maxQuantity);
        map.put("reportWarehouse", reportWarehouse);
        map.put("areafilter", province != null && !province.isEmpty());
        if (province != null && !province.isEmpty()) {
            List<StorageWarehouse> warehouselist = storageWarehouseService.list(request).getData();
            StringBuilder warehouse = new StringBuilder();
            for (StorageWarehouse item : warehouselist)
                warehouse.append(item.getWarehouseShort() + ",");
            if (warehouse.length() > 1)
                warehouse.subSequence(0, warehouse.length() - 1);
            map.put("reportWarehouse", warehouse);
        }
        return dao.listSwtz(map);
    }

    @Override
    public List<ReportSwtz> listSwtzByReportId(String reportId) {
        return dao.listSwtzByReportId(reportId);
    }

    @Override
    public String addSwtz(String reportId, String reportMonth, List<ReportSwtz> swtzList, String manager, String reserveProperty) {
        SysUser user = TokenManager.getToken();
        String reportWarehouse = user.getShortName();
        if (StringUtils.isEmpty(reportId)) {
            ReportMonth reportMain = new ReportMonth();
            reportId = UUID.randomUUID().toString().replace("-", "");
            reportMain.setReportMonth(reportMonth);
            reportMain.setReportName(ReportNameEnum.SWTZ.getValue());
            reportMain.setId(reportId);
            reportMain.setReportWarehouse(reportWarehouse);
            reportMain.setReportWarehouseId(user.getWareHouseId());
            ;
            reportMain.setReportStatus(ReportStatusEnum.CG.getValue());
            reportMain.setCreator(user.getAccount());
            reportMain.setManager(manager);
            reportMain.setReserveProperty(reserveProperty);
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
            monthDao.update(reportMain);
        }

        for (int i = 0; i < swtzList.size(); i++) {
            ReportSwtz reportSwtz = swtzList.get(i);
            reportSwtz.setReportId(reportId);
            reportSwtz.setReportMonth(reportMonth);
            reportSwtz.setReportWarehouse(reportWarehouse);
            reportSwtz.setReportName(ReportNameEnum.SWTZ.getValue());

            reportSwtz.setOrdernum(new BigDecimal(i));
            dao.add(reportSwtz);
        }

        return reportId;
    }

    @Override
    public LayPage<ReportSwtz> pageList(HttpServletRequest request) {
        LayPage<ReportSwtz> page = new LayPage<>();

        HashMap<String, String> map1 = QueryUtil.pageHashMap(request);
        Map<String,Object> map = new HashMap<String,Object>();
        String variety = request.getParameter("key[variety]");
        map.put("start",map1.get("start"));
        map.put("end",map1.get("end"));
        map.put("variety", variety);
        map.put("origin", request.getParameter("key[origin]"));
        map.put("minQuantity", request.getParameter("key[minQuantity]"));
        map.put("maxQuantity", request.getParameter("key[maxQuantity]"));
        map.put("reportMonth", request.getParameter("key[month]"));
        map.put("minMonth", request.getParameter("key[minMonth]"));
        map.put("maxMonth", request.getParameter("key[maxMonth]"));
        map.put("quota", request.getParameter("key[quota]"));
        map.put("minQuota", request.getParameter("key[minQuota]"));
        map.put("maxQuota", request.getParameter("key[maxQuota]"));
        map.put("warehouse", request.getParameter("key[warehouse]"));
        map.put("storehouse", request.getParameter("key[storehouse]"));
        map.put("receiptYear", request.getParameter("key[receiptYear]"));
        map.put("extendsWarehouse", request.getParameter("key[extendsWarehouse]"));
        map.put("warehouseId", request.getParameter("key[warehouseId]"));
        map.put("enterpriseId", request.getParameter("key[enterpriseId]"));
        List kudianCodes = storageWarehouseService.listKudianCode();
        List kudianIds = storageWarehouseService.listKudianId();
        SysUser user = TokenManager.getToken();
        //来自远程监管系统
        String userId = request.getParameter("userId");
        if (userId != null && !"".equals(userId)) {
            user = userDao.selectByPrimaryKey(userId);
        }

        boolean isKudian = kudianCodes.contains(user.getOriginCode());
        /*1、公司人员看到全部，2、6个直属库点可以看到本身和所有代储点的数据
        * 3、代储点的可以看到本公司的数据
        * */

        if (isKudian) {
            //6个直属库点，不能看到其余5个直属库点的数据
            Iterator<String> it = kudianIds.iterator();
            while(it.hasNext()){
                String item = it.next();
                StorageWarehouse storageWarehouse = storageWarehouseService.getStorageWarehouse(user.getOriginCode());
                if(storageWarehouse.getId().equals(item)){
                    it.remove();
                }
            }
            map.put("excludeWarehouseId",kudianIds);
            //map.put("warehouse", user.getShortName());
            //如果选了是当前监管库点，则需要加入in当前库点最新监管库点的条件
            //String isSuperivise = request.getParameter("key[isSuperivise]");
            String isSuperivise = request.getParameter("isSuperivise");
            if("1".equals(isSuperivise)){
                StoreSupervise storeSupervise = storeSuperviseService.getMaxSuperiviseYear();
                Map<String,Object> superviseMap = new HashMap<String,Object>();
                if(storeSupervise != null){
                    superviseMap.put("superiviseId",storeSupervise.getId());
                }
                StorageWarehouse storageWarehouse = storageWarehouseService.getStorageWarehouse(user.getOriginCode());
                if(storageWarehouse != null) {
                    superviseMap.put("warehouseId", storageWarehouse.getId());
                }
                List<StoreSuperviseItem> storeSuperviseItems = storeSuperviseItemDao.getNewSuperiviseByWarehouseId(superviseMap);
                StoreSuperviseItem storeSuperviseItem = new StoreSuperviseItem();
                if(storageWarehouse != null) {
                    storeSuperviseItem.setWarehouseId(storageWarehouse.getId());
                    storeSuperviseItems.add(storeSuperviseItem);
                }
                map.put("storeSuperviseItems",storeSuperviseItems);

            }
        }else if("CBL".equals(user.getOriginCode())){
            //公司人员
        }else{
            if(StringUtils.isNotEmpty(user.getOriginCode())) {
                //代储点人员
                //StorageWarehouse storageWarehouse = storageWarehouseService.get(user.getWareHouseId());
                StorageWarehouse storageWarehouse = storageWarehouseService.getStorageWarehouse(user.getOriginCode());
                map.put("enterpriseId", storageWarehouse.getEnterpriseId());
            }else{
                //如果没有库点代码默认按公司人员权限

            }
        }
        int count = dao.getRecordCount(map);//总记录数
        page.setCode(0);
        page.setCount(count);
        if (count <= 0) {
            page.setMsg("没有查询到数据");
            return page;
        }
        page.setData(dao.pageQuery(map));
        page.setMsg("succes");
        return page;
    }

    @Override
    public LayPage<ReportSwtz> pageList1(HttpServletRequest request, String plandetailid) {
        LayPage<ReportSwtz> page = new LayPage<ReportSwtz>();

        HashMap<String, String> map1 = QueryUtil.pageHashMap(request);
        QueryUtil.pageQuery(request);
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("start",map1.get("start"));
        map.put("end",map1.get("end"));
        String variety = request.getParameter("key[variety]");
        String excludeOutCondition = request.getParameter("key[excludeOutCondition]");
        List<RotatePlanDetail> excludeOutConditionList = (List<RotatePlanDetail>) JSONArray.parseArray(excludeOutCondition,RotatePlanDetail.class);
        map.put("excludeOutConditionList",excludeOutConditionList);
        map.put("variety", variety);
        map.put("origin", request.getParameter("key[origin]"));
        map.put("minQuantity", request.getParameter("key[minQuantity]"));
        map.put("maxQuantity", request.getParameter("key[maxQuantity]"));
        map.put("reportMonth", request.getParameter("key[month]"));
        map.put("quota", request.getParameter("key[quota]"));
        map.put("minQuota", request.getParameter("key[minQuota]"));
        map.put("maxQuota", request.getParameter("key[maxQuota]"));
        map.put("warehouse", request.getParameter("key[warehouse]"));
        String storehouse = request.getParameter("key[storehouse]");
        map.put("storehouse", storehouse==null?storehouse:storehouse.toUpperCase());
        map.put("receiptYear", request.getParameter("key[receiptYear]"));
        map.put("warehouse", request.getParameter("key[extendsWarehouse]"));
        map.put("warehouse_type", request.getParameter("key[warehouse_type]"));
        map.put("plandetailid", plandetailid);
        List kudianCodes = storageWarehouseService.listKudianCode();
        boolean isKudian = kudianCodes.contains(TokenManager.getToken().getOriginCode());
        //代储
        if (isKudian) {
//            map.put("extendsWarehouse", TokenManager.getToken().getShortName());
            map.put("warehouseCode",TokenManager.getToken().getOriginCode().toUpperCase());
        }
        int count = dao.getRecordCount1(map);    //总记录数
        page.setCode(0);
        page.setCount(count);
        if (count <= 0) {
            page.setMsg("没有查询到数据");
            return page;
        }
        page.setData(dao.pageQuery1(map));
        page.setMsg("succes");
        return page;
    }

    @Override
    public List<KCTJChartsVO> getKCTJChartsY(HttpServletRequest request) {
        HashMap<String, String> map = new HashMap<String, String>();
        String reportWarehouseId = request.getParameter("reportWarehouseId"); //库点
        String month = request.getParameter("month"); //月份
        String variety = request.getParameter("variety"); //粮油品种
        String harvestYear = request.getParameter("harvestYear"); //入库年份
        String origin = request.getParameter("origin"); //产地
        map.put("reportWarehouseId", reportWarehouseId);
        map.put("month", month);
        map.put("variety", variety);
        map.put("harvestYear", harvestYear);
        map.put("origin", origin);
        return dao.getCharts(map);
    }

    @Override
    public Map<String, Object> getKCTJCharts(HttpServletRequest request) {

        HashMap<String, String> map = this.getRequestParameter(request);
        String type = request.getParameter("type");
        String grouping = request.getParameter("grouping");
        String variety = map.get("variety");
        String harvestYear = map.get("harvestYear");
        String reportWarehouse = map.get("reportWarehouse");
        Map<String, Object> map1 = new HashMap<String, Object>();
        //取得所有粮油品种
        List<KCTJChartsVO> varietyList = new ArrayList<>();
        //是否第一次访问页面，是:获取有数据的最近一个月，否:获取页面填写的月份
        if ("init".equals(type)) {
            String reportMonth = "";
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(new Date());
            //从当前月的前一个月开始查询，直到有数据
            while (varietyList.size() <= 0) {
                calendar.add(calendar.MONTH, -1);
                reportMonth = sdf.format(calendar.getTime());
                reportMonth = reportMonth.trim();
                map.put("month", reportMonth);
                varietyList = dao.getDistinctVariety(map);
            }
            map.put("month", reportMonth);
            map1.put("reportMonth", reportMonth);
        } else {
            varietyList = dao.getDistinctVariety(map);
        }
        //获取所有收获年份
        List<ReportSwtz> list5 = dao.getDistinctHarvestYear(map);
        if (map.get("enterprise") != null && map.get("enterprise").equals("所属企业")) {
            //查询每个公司的粮油总量
            List<KCTJChartsVO> list1 = dao.getSumQuantityByEnterpriseid(map);
            String maxquantity = dao.geMaxQuantityByEnterpriseid(map);
            map1.put("maxquantity", maxquantity);
            map1.put("list1", list1);
            if ("品种".equals(grouping)) {
                //y轴为粮油品种时:
                List<Map> list = new ArrayList<>();
                for (KCTJChartsVO s : varietyList) {
                    Map map2 = new HashMap();
                    List<Double> list2 = new ArrayList<>();
                    for (KCTJChartsVO k : list1) {
                        map.put("variety", s.getVariety());
                        map.put("reportWarehouse", k.getReportWarehouse());
                        String sumQuantity = dao.getSumByEnterpriseidVariety(map);
                        if (sumQuantity != null) {
                            list2.add(Double.valueOf(sumQuantity));
                        } else {
                            list2.add(0.0);
                        }
                    }
                    map2.put("variety", s.getVariety());
                    map2.put("list2", list2);
                    list.add(map2);
                    map1.put("list", list);
                    map.put("variety", variety);
                    map.put("reportWarehouse", reportWarehouse);
                }
            }
            if ("年份".equals(grouping)) {
                //y轴为收获年份时:
                List<Map> list4 = new ArrayList<>();
                List<Integer> yearList = new ArrayList<>();
                for (ReportSwtz reportSwtz : list5) {
                    int year = Integer.valueOf(reportSwtz.getHarvestYear());
                    yearList.add(year);
                }
                Collections.sort(yearList);
                for (int year : yearList) {
                    List<Double> list2 = new ArrayList<>();
                    HashMap<String, Object> map3 = new HashMap<String, Object>();
                    for (KCTJChartsVO kCTJChartsVO : list1) {
                        map.put("harvestYear", String.valueOf(year));
                        map.put("reportWarehouse", kCTJChartsVO.getReportWarehouse());
                        String sumQuantity = dao.getSumByYearEnterpriseid(map);
                        if (sumQuantity != null) {
                            list2.add(Double.valueOf(sumQuantity));
                        } else {
                            list2.add(0.0);
                        }
                    }
                    map3.put("variety", String.valueOf(year));
                    map3.put("list3", list2);
                    list4.add(map3);
                }
                map1.put("list4", list4);
                map.put("harvestYear", harvestYear);
                map.put("reportWarehouse", reportWarehouse);
            }
            if ("品质".equals(grouping)) {
                //y轴为品质时:
                List<KCTJChartsVO> list6 = dao.getSumQuantityByEnterpriseid(map);
                map1.put("list2", list6);
            }
        } else {
            //查询每个库点的粮油总量
            List<KCTJChartsVO> list1 = dao.getSumQuantityByReportwarehouse(map);
            String maxquantity = dao.getMaxQuantityByReportwarehouse(map);
            map1.put("maxquantity", maxquantity);
            map1.put("list1", list1);
            if ("品种".equals(grouping)) {
                //y轴为粮油品种时:
                List<Map> list = new ArrayList<>();
                for (KCTJChartsVO s : varietyList) {
                    Map map2 = new HashMap();
                    List<Double> list2 = new ArrayList<>();
                    for (KCTJChartsVO k : list1) {
                        map.put("variety", s.getVariety());
                        map.put("reportWarehouse", k.getReportWarehouse());
                        String sumQuantity = dao.getSumQuantityByVariety(map);
                        if (sumQuantity != null) {
                            list2.add(Double.valueOf(sumQuantity));
                        } else {
                            list2.add(0.0);
                        }
                    }
                    map2.put("variety", s.getVariety());
                    map2.put("list2", list2);
                    list.add(map2);
                    map1.put("list", list);
                    map.put("variety", variety);
                    map.put("reportWarehouse", reportWarehouse);
                }
            }
            if ("年份".equals(grouping)) {
                //y轴为收获年份时:
                List<Map> list4 = new ArrayList<>();
                List<Integer> yearList = new ArrayList<>();
                for (ReportSwtz reportSwtz : list5) {
                    int year = Integer.valueOf(reportSwtz.getHarvestYear());
                    yearList.add(year);
                }
                Collections.sort(yearList);
                for (int year : yearList) {
                    List<Double> list2 = new ArrayList<>();
                    HashMap<String, Object> map3 = new HashMap<String, Object>();
                    for (KCTJChartsVO kCTJChartsVO : list1) {
                        map.put("harvestYear", String.valueOf(year));
                        map.put("reportWarehouse", kCTJChartsVO.getReportWarehouse());
                        String sumQuantity = dao.getSumQuantityByHarvestYear(map);
                        if (sumQuantity != null) {
                            list2.add(Double.valueOf(sumQuantity));
                        } else {
                            list2.add(0.0);
                        }
                    }
                    map3.put("variety", String.valueOf(year));
                    map3.put("list3", list2);
                    list4.add(map3);
                }
                map1.put("list4", list4);
                map.put("harvestYear", harvestYear);
                map.put("reportWarehouse", reportWarehouse);
            }
            if ("品质".equals(grouping)) {
                //y轴为品质时:
                List<KCTJChartsVO> list6 = dao.getSumQuantityByReportwarehouse(map);
                map1.put("list2", list6);
            }
        }
        return map1;
    }

    @Override
    public List<ReportSwtz> listSumSwtzByReportId(String reportId) {
        return dao.listSumSwtzByReportId(reportId);
    }

    @Override
    public ReportSwtz getReportSwtzByOther(String reportMonth, String reportWarehouse, String storehouse,
                                           String variety, String origin, String harvestYear) {
        // TODO Auto-generated method stub
        HashMap<String, String> map = new HashMap<>();
        map.put("reportMonth", reportMonth);
        map.put("reportWarehouse", reportWarehouse);
        map.put("storehouse", storehouse);
        map.put("variety", variety);
        map.put("origin", origin);
        map.put("harvestYear", harvestYear);
        return dao.getReportSwtz(map);
    }

    @Override
    public ReportSwtz getReportSwtzById(String reportId) {
        // TODO Auto-generated method stub
        HashMap<String, String> map = new HashMap<>();
        map.put("reportId", reportId);
        return dao.getReportSwtz(map);
    }

    @Override
    public ActionResultModel getCurrMonthQuantity(HttpServletRequest request) {
        // TODO Auto-generated method stub
        Date date = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
        String reportMonth = format.format(date);

        String warehouse = "";
        String storehouse = "";
        try {
            storehouse = new String(URLDecoder.decode(request.getParameter("storehouse"), "utf-8"));
            warehouse = new String(URLDecoder.decode(request.getParameter("warehouse"), "utf-8"));
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }


        HashMap<String, String> map = new HashMap<String, String>();
        map.put("reportMonth", reportMonth);
        map.put("reportWarehouse", warehouse);
        map.put("storehouse", storehouse);

        ActionResultModel result = new ActionResultModel();
        String quantity = dao.getCurrMonthQuantity(map);

        if (quantity == null || quantity.equals("")) {
            result.setSuccess(false);
            result.setMsg("在实物台账中暂无找到选择的仓房本月的实际数量");
        } else {
            result.setSuccess(true);
            result.setData(quantity);
        }
        return result;
    }

    @Override
    public ActionResultModel getLastMonthQuantity(HttpServletRequest request) {
        /*Date date = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
		String reportMonth = format.format(date);*/

//        Date date = new Date();//当前日期
//        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//格式化对象
//        Calendar calendar = Calendar.getInstance();//日历对象
//        calendar.setTime(date);//设置当前日期
//        calendar.add(Calendar.MONTH, -1);//月份减一
//        String reportMonth = sdf.format(calendar.getTime());
        //System.out.println(sdf.format(calendar.getTime()));//输出格式化的日期



        String reportMonth;
        String warehouse = "";
        String storehouse = "";
        try {
            storehouse = new String(URLDecoder.decode(request.getParameter("storehouse"), "utf-8"));
            warehouse = new String(URLDecoder.decode(request.getParameter("warehouse"), "utf-8"));
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }


        HashMap<String, String> map = new HashMap<String, String>();
        //map.put("reportMonth", reportMonth);
        map.put("reportWarehouse", warehouse);
        map.put("storehouse", storehouse);
        ActionResultModel result = new ActionResultModel();
        //获取符合条件的最大日期
        reportMonth = dao.listMaxKCTJMonth(map);
        StorageGrainInspection quantity = null;
        if(com.dhc.fastersoft.utils.StringUtils.isEmpty(reportMonth)){

        }else{
            //map.put("month", reportMonth);
            map.put("reportMonth", reportMonth);
            quantity = dao.getLastMonthQuantity(map);
        }


        if (quantity == null || "".equals(quantity)) {
            result.setSuccess(false);
            result.setMsg("在最近的实物台账中暂无找到选择的仓房的实际数量");
        } else {
            result.setSuccess(true);
            result.setData(quantity);
        }
        return result;
    }

    @Override
    public List<ReportSwtz> listSumSwtz(String gatherId) {
        return dao.listSumSwtz(gatherId);
    }

    @Override
    public List<ReportSwtz> listSwtzForWebApi(HashMap<String, Object> map) {
        return dao.listSwtzForWebApi(map);
    }

    @Override
    public List<KCTJChartsVO> listKCTJCharts(HashMap<String, String> map) {
        List<KCTJChartsVO> kctjChartsVOs = dao.getCharts(map);
        return kctjChartsVOs;
    }


    @Override
    public String listMaxKCTJMonth(HashMap<String, String> map) {
        String reportMonth = dao.listMaxKCTJMonth(map);
        return reportMonth;
    }

    @Override
    public Double getLastestQuantity(HashMap<String, Object> map) {
        return dao.getLastestQuantity(map);
    }

    @Override
    public EchartsData queryKCQSCharts(HttpServletRequest request) {
        String monthStart = request.getParameter("monthStart");
        String monthEnd = request.getParameter("monthEnd");
        String reportWarehouseId = request.getParameter("reportWarehouseId");

        //枚举所有月份
        Date month1 = DateUtil.StringtoDate(monthStart, DateUtil.MONTH_FORMAT);
        Date month2 = DateUtil.StringtoDate(monthEnd, DateUtil.MONTH_FORMAT);
        int diffMonth = DateUtil.getDiffMonth(month1, month2);
        String monthStr[] = new String[diffMonth + 1];

        Map<String, Integer> monthMap = new HashMap<>(); //方便找到数量对应月份的序号
        for (int i = 0; i < diffMonth + 1; i++) {
            monthStr[i] = DateUtil.DateToString(DateUtil.nextMonth(month1, i), DateUtil.MONTH_FORMAT);
            monthMap.put(monthStr[i], i);
        }

        Map<String, String> map = new HashMap<>();
        map.put("monthStart", monthStart);
        map.put("monthEnd", monthEnd);
        map.put("reportWarehouseId", reportWarehouseId);
        List<ReportSwtz> dataList = dao.querySumByMonth(map);

        EchartsData echart = new EchartsData();
        List<Serie> series = new ArrayList<Serie>();
        Serie serie = null;
        BigDecimal[] data = null;
        String variety = null;

        //组装数据
        Map<String, BigDecimal[]> dataMap = new HashMap<>();
        for (ReportSwtz reportSwtz : dataList) {
            variety = reportSwtz.getVariety();
            if (dataMap.containsKey(variety)) { //修改对应月份的值
                data = dataMap.get(variety);
                data[monthMap.get(reportSwtz.getReportMonth())] = reportSwtz.getQuantity();
                dataMap.remove(variety);
                dataMap.put(variety, data);
            } else {
                data = new BigDecimal[monthStr.length];
                data[monthMap.get(reportSwtz.getReportMonth())] = reportSwtz.getQuantity();
                dataMap.put(variety, data);
            }
        }

        //组装echarts数据
        String[] attrs = new String[dataMap.size()];
        int i = 0;
        for (Map.Entry<String, BigDecimal[]> entry : dataMap.entrySet()) {
            data = entry.getValue();
            for (int j = 0; j < data.length; j++) {
                if (data[j] == null) data[j] = new BigDecimal(0);
            }
            attrs[i++] = entry.getKey();
            serie = new Serie();
            serie.setName(entry.getKey());
            serie.setType("line");
            serie.setData(data);
            series.add(serie);
        }
        echart.setLegendData(attrs);
        echart.setxAxisData(monthStr);
        echart.setSeries(series);
        return echart;
    }

    @Override
    public String addProxySwtz(String reportWarehouseId, String reportWarehouse, String reportId, String reportMonth, List<ReportSwtz> swtzList, String manager, String reserveProperty) {
        SysUser user = TokenManager.getToken();
        //String reportWarehouse = user.getShortName();
        if (StringUtils.isEmpty(reportId)) {
            ReportMonth reportMain = new ReportMonth();
            reportId = UUID.randomUUID().toString().replace("-", "");
            reportMain.setReportMonth(reportMonth);
            reportMain.setReportName(ReportNameEnum.SWTZ.getValue());
            reportMain.setId(reportId);
            reportMain.setReportWarehouse(reportWarehouse);
            reportMain.setReportWarehouseId(reportWarehouseId);
            reportMain.setReportStatus(ReportStatusEnum.CG.getValue());
            reportMain.setCreator(user.getAccount());
            reportMain.setManager(manager);
            reportMain.setReserveProperty(reserveProperty);
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
            monthDao.update(reportMain);
        }

        for (int i = 0; i < swtzList.size(); i++) {
            ReportSwtz reportSwtz = swtzList.get(i);
            reportSwtz.setReportId(reportId);
            reportSwtz.setReportMonth(reportMonth);
            reportSwtz.setReportWarehouse(reportWarehouse);
            reportSwtz.setReportName(ReportNameEnum.SWTZ.getValue());

            reportSwtz.setOrdernum(new BigDecimal(i));
            dao.add(reportSwtz);
        }

        return reportId;
    }

    @Override
    public Map<String, Object> getKCTJPie(HttpServletRequest request) {

        Map<String, Object> map1 = new HashMap<String, Object>();
        HashMap<String, String> map = this.getRequestParameter(request);
        String type = request.getParameter("type");
        //按粮油品种分类查询
        List<KCTJChartsVO> list1 = new ArrayList<>();
        if ("init".equals(type)) {
            String reportMonth = "";
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(new Date());
            while (list1.size() <= 0) {
                calendar.add(calendar.MONTH, -1);
                reportMonth = sdf.format(calendar.getTime());
                reportMonth = reportMonth.trim();
                map.put("month", reportMonth);
                list1 = dao.getDistinctVariety(map);
            }
            map.put("month", reportMonth);
            map1.put("reportMonth", reportMonth);
        } else {
            list1 = dao.getDistinctVariety(map);
        }
        //查询所有库点的粮油总量
        String sumQuantity = dao.getSumQuantity(map);
        //按收获年份分类查询
        List<ReportSwtz> list2 = dao.getDistinctHarvestYear(map);
        //按品质分类查询
        KCTJChartsVO kCTJChartsVO = dao.getSumQuantityPinzhi(map);
        List<KCTJChartsVO> list3 = new ArrayList<>();
        if (kCTJChartsVO != null) {
            KCTJChartsVO kCTJChartsVO2 = new KCTJChartsVO();
            kCTJChartsVO2.setQuantityTotal(kCTJChartsVO.getAdvisedTotal());//总数量
            kCTJChartsVO2.setReportWarehouse("宜存数量");
            list3.add(kCTJChartsVO2);
            KCTJChartsVO kCTJChartsVO3 = new KCTJChartsVO();
            kCTJChartsVO3.setQuantityTotal(kCTJChartsVO.getSlightlyTotal());//总数量
            kCTJChartsVO3.setReportWarehouse("轻度不宜存放数量");
            list3.add(kCTJChartsVO3);
            KCTJChartsVO kCTJChartsVO4 = new KCTJChartsVO();
            kCTJChartsVO4.setQuantityTotal(kCTJChartsVO.getSevereTotal());//总数量
            kCTJChartsVO4.setReportWarehouse("重度不宜存放数量");
            list3.add(kCTJChartsVO4);
        }
        map1.put("sumQuantity", sumQuantity);
        map1.put("sumQuantityByVariety", list1);
        map1.put("sumQuantityByHarvestYear", list2);
        map1.put("sumQuantityPinzhi", list3);
        return map1;
    }

    private HashMap<String, String> getRequestParameter(HttpServletRequest request) {
        HashMap<String, String> map = new HashMap<String, String>();
        String reportWarehouseId = request.getParameter("reportWarehouseId"); //库点
        String month = request.getParameter("month");                         //月份
        String variety = request.getParameter("variety");                     //粮油品种
        String harvestYear = request.getParameter("harvestYear");             //入库年份
        String warehouseType = request.getParameter("warehouseType");         //库点别
        String province = request.getParameter("province");                   //省
        String city = request.getParameter("city");                           //市
        String district = request.getParameter("district");                   //区
        String enterprise = request.getParameter("enterprise");               //统计方式
        map.put("province", province);
        map.put("city", city);
        map.put("district", district);
        map.put("warehouseType", warehouseType);
        map.put("reportWarehouse", reportWarehouseId);
        map.put("month", month);
        map.put("variety", variety);
        map.put("harvestYear", harvestYear);
        map.put("enterprise", enterprise);
        return map;
    }

    @Override
    public List<StoreEnterprise> getAllStoreEnterprise() {

        return enterpriseDao.getAllEnterprise();
    }

    @Override
    public StoreEnterprise getStoreEnterpriseById(String enterpriseId) {
        return enterpriseDao.getStoreEnterpriseById(enterpriseId);
    }

    @Override
    public Map<String, Object> getStoreAndOilMap() {
        Map<String,Object> storeAndOilMap = new HashMap<>();
        // 获取仓罐列表
        List<Map<String,Object>> storeAndOilList = enterpriseDao.getStoreAndOilList();
        for(Map<String,Object> tempMap:storeAndOilList){
            String encodes = "";
            if(tempMap.get("ENCODE")!=null) {
                encodes = (String) tempMap.get("ENCODE");
            }
            List<String> encodeList = Arrays.asList(encodes.split(","));
            Map<String,Object> encodeMap = new HashMap<>();
            encodeMap.put("encodeList",encodeList); // 仓罐列表
            encodeMap.put("isInput",tempMap.get("ISINPUT"));    // 根据公司判断出是否是输入框
            storeAndOilMap.put((String) tempMap.get("WAREHOUSEID"),encodeMap);
        }
        return storeAndOilMap;
    }
}
