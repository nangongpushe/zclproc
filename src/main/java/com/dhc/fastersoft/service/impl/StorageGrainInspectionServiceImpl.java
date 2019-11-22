package com.dhc.fastersoft.service.impl;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import cn.afterturn.easypoi.excel.entity.params.ExcelExportEntity;
import com.alibaba.fastjson.JSONObject;
import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.constants.BusinessConstants;
import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.StorageGrainInspectionDao;
import com.dhc.fastersoft.dao.StorageGrainInspectionTempDao;
import com.dhc.fastersoft.entity.StorageGrainInspection;
import com.dhc.fastersoft.entity.StorageGrainInspectionEChart;
import com.dhc.fastersoft.entity.StorageGrainInspectionTemp;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.StorageGrainInspectionService;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.util.HttpUtil;
import com.dhc.fastersoft.utils.LayPage;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;

@Service("storageGrainInspectionService")
public class StorageGrainInspectionServiceImpl implements StorageGrainInspectionService {

    @Autowired
    StorageGrainInspectionDao dao;

    @Autowired
    StorageGrainInspectionTempDao sgtdao;

    @Autowired
    StorageWarehouseService storageWarehouseService;


    @Override
    public ActionResultModel save(StorageGrainInspection grainInspection) {
        // TODO Auto-generated method stub
        ActionResultModel result = new ActionResultModel();

        grainInspection.setPestSampleSiteByList();
        grainInspection.setPestCheckTypeByList();
        String PrimId = dao.getPrimId();


        grainInspection.setId(PrimId);
        grainInspection.setCreator(TokenManager.getNickname());
        //System.out.println(this.getClass().toString() + " : " + grainInspection.toString());

        if (dao.save(grainInspection) == 1) {
            List<StorageGrainInspectionTemp> storageGrainInspectionTemps = grainInspection.getStorageGrainInspectionTemp();
            for (StorageGrainInspectionTemp storageGrainInspectionTemp : storageGrainInspectionTemps) {
                storageGrainInspectionTemp.setP_id(PrimId);//主表id赋予子表p_id
                sgtdao.save(storageGrainInspectionTemp);
            }

            result.setMsg("新增成功");
            result.setSuccess(true);
        } else {
            result.setMsg("新增失败");
            result.setSuccess(false);
        }
        return result;
    }

    @Override
    public ActionResultModel update(StorageGrainInspection grainInspection) {
        // TODO Auto-generated method stub
        ActionResultModel result = new ActionResultModel();


        grainInspection.setPestSampleSiteByList();
        grainInspection.setPestCheckTypeByList();

        if (dao.update(grainInspection) == 1) {

            List<StorageGrainInspectionTemp> storageGrainInspectionTemps = grainInspection.getStorageGrainInspectionTemp();
            sgtdao.remove(grainInspection.getId());
            for (StorageGrainInspectionTemp storageGrainInspectionTemp : storageGrainInspectionTemps) {
                storageGrainInspectionTemp.setP_id(grainInspection.getId());//主表id赋予子表p_id

                sgtdao.save(storageGrainInspectionTemp);
            }

            result.setMsg("修改成功");
            result.setSuccess(true);
        } else {
            result.setMsg("修改失败");
            result.setSuccess(false);
        }
        return result;
    }

    @Override
    public LayPage<StorageGrainInspection> list(HttpServletRequest request) {
        // TODO Auto-generated method stub
        LayPage<StorageGrainInspection> page = new LayPage<>();
        HashMap<String, String> map = QueryUtil.pageQuery(request);

        String warehouse = request.getParameter("warehouse");
        String storehouseEncode = request.getParameter("storehouseEncode");
        String storehouseStatus = request.getParameter("storehouseStatus");
        String checkProperty = request.getParameter("checkProperty");
        String reportDate = request.getParameter("reportDate");

        map.put("warehouse", warehouse);
        map.put("storehouseEncode", storehouseEncode);
        map.put("storehouseStatus", storehouseStatus);
        map.put("checkProperty", checkProperty);
        map.put("reportDate", reportDate);

        SysUser user = TokenManager.getToken();
        String dept = user.getDepartment();
        String position = user.getPosition();
        String company = user.getCompany();
        //公司看全部  直属库看自己与所有代储点  代储点看自己


//		//代储
//		if (typeString.equals("0")) {
//			HashMap<String,Object> map = new HashMap<String, Object>();
//			map.put("warehouseType", "代储库");
//			if(!TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")){
//
//				if(isKudian){
////		   		他监管的库点
//					maps.put("shortName",  TokenManager.getToken().getShortName());
//				}else {
        if (StringUtils.isEmpty(warehouse)) {
            if (TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")) {
                //公司
                map.put("warehouse", warehouse);
            } else {

                String warehouse1 = "";
                boolean isKudian = false;
//		    //获取所有直属库列表
                List<StorageWarehouse> kudians = storageWarehouseService.limitListCBL();

                for (StorageWarehouse storageWarehouse : kudians
                ) {
                    if (storageWarehouse.getWarehouseShort().equals(TokenManager.getToken().getShortName())) {
                        isKudian = true;
                        warehouse1 = warehouse1 + "'" + storageWarehouse.getWarehouseShort() + "',";
                    } else {

                        warehouse1 = warehouse1 + "'" + storageWarehouse.getWarehouseShort() + "',";
                    }

                }
                if (warehouse1.length() > 0) {
//				截取
                    warehouse1 = warehouse1.substring(1, warehouse1.length());
                    warehouse1 = warehouse1.substring(0, warehouse1.length() - 2);
                }
                //

                if (isKudian) {
                    //直属的情况：库领导可以查看直属库所有，如果不是领导只能查看自己的


                    if ((position != null && (position.contains("经理") || position.contains("主任")))
                    ) {
                        //map.put("warehouse1", warehouse1);
                        map.put("warehouseId", TokenManager.getToken().getWareHouseId());
                        map.put("warehouse", "");
                    } else {
                        map.put("warehouse1", "");
                        /*map.put("warehouse", TokenManager.getToken().getShortName());*/
                        map.put("warehouseId", TokenManager.getToken().getWareHouseId());
                        map.put("creator", user.getName());
                    }
                } else {
                    map.put("warehouse", TokenManager.getToken().getShortName());
                }


            }
        } else {
            if (TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")) {
                //公司
                map.put("warehouse", warehouse);
            } else {
                String warehouse1 = "";
                boolean isKudian = false;
//		    //获取所有直属库列表
                List<StorageWarehouse> kudians = storageWarehouseService.limitListCBL();
                for (StorageWarehouse storageWarehouse : kudians
                ) {
                    if (storageWarehouse.getWarehouseShort().equals(TokenManager.getToken().getShortName())) {
                        isKudian = true;
                        warehouse1 = warehouse1 + "'" + storageWarehouse.getWarehouseShort() + "',";
                    } else {

                        warehouse1 = warehouse1 + "'" + storageWarehouse.getWarehouseShort() + "',";
                    }

                }
                if (warehouse1.length() > 0) {
//				截取
                    warehouse1 = warehouse1.substring(1, warehouse1.length());
                    warehouse1 = warehouse1.substring(0, warehouse1.length() - 2);
                }
                if (isKudian) {
                    //直属的情况：库领导可以查看直属库所有，如果不是领导只能查看自己的


                    if ((position != null && (position.contains("经理") || position.contains("主任")))
                    ) {
                        map.put("warehouse1", TokenManager.getToken().getShortName());
                        map.put("warehouse", warehouse);
                    } else {
                        map.put("warehouse1", TokenManager.getToken().getShortName());
                        map.put("warehouse", warehouse);
                        map.put("creator", user.getName());
                    }
                } else {
                    map.put("warehouse1", TokenManager.getToken().getShortName());
                    map.put("warehouse", warehouse);
                }

            }

        }
        //map.put("creator","");

        int count = dao.count(map);

        if (count <= 0) {
            return page;
        }

        List<StorageGrainInspection> data = dao.list(map);

        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
        return page;
    }

    @Override
    public StorageGrainInspection get(String id) {
        // TODO Auto-generated method stub
        StorageGrainInspection grainInspection = new StorageGrainInspection();
        grainInspection = dao.get(id);
        //System.out.println(grainInspection.getPestSampleSite());
        grainInspection.setPestSampleSiteListByStr();
        grainInspection.setPestCheckTypeListByStr();

        //查询小表信息根据
        String p_id = grainInspection.getId();
        List<StorageGrainInspectionTemp> storageGrainInspectionTemp = sgtdao.selectStorageGrainInspectionTempByPid(p_id);
        grainInspection.setStorageGrainInspectionTemp(storageGrainInspectionTemp);

        //System.err.print(storageGrainInspectionTemp);


        return grainInspection;
    }

    @Override
    public ActionResultModel remove(String id) {
        // TODO Auto-generated method stub
        ActionResultModel result = new ActionResultModel();
        String url = BusinessConstants.REMOTE_BASE_URL + "/api/receive/grainInspection/del/";
        if (dao.remove(id) == 1) {
            sgtdao.remove(id);
            HttpUtil.postJson(url + id + ".do", "");
            result.setMsg("删除成功");
            result.setSuccess(true);
        } else {
            result.setMsg("删除失败");
            result.setSuccess(false);
        }
        return result;
    }

    @Override
    public StorageGrainInspectionEChart getEChartData(HttpServletRequest request) {
        // TODO Auto-generated method stub
        String warehouse = request.getParameter("warehouse") == null || request.getParameter("warehouse").equals("") ?
                "" : request.getParameter("warehouse");
        ;//库点
        String encode = request.getParameter("encode") == null || request.getParameter("encode").equals("") ?
                "CF001" : request.getParameter("encode");//仓号
        String statisticBeginDate = request.getParameter("statisticBeginDate") == null || request.getParameter("statisticBeginDate").equals("") ?
                "2017-01-01" : request.getParameter("statisticBeginDate");
        ;
        String statisticEndDate = request.getParameter("statisticEndDate") == null || request.getParameter("statisticEndDate").equals("") ?
                "2017-12-31" : request.getParameter("statisticEndDate");

        HashMap<String, String> map = new HashMap<>();
		
		/*System.out.println(warehouse);
		System.out.println(encode);
		System.out.println(statisticBeginDate);
		System.out.println(statisticEndDate);*/

        map.put("warehouse", warehouse);
        map.put("encode", encode);
        map.put("statisticBeginDate", statisticBeginDate);
        map.put("statisticEndDate", statisticEndDate);

        List<StorageGrainInspection> list = dao.listForECahrt(map);
        //开始处理检索到的结果

        //System.out.println(this.getClass().getSimpleName() + ":" + list.size());

        StorageGrainInspectionEChart echart = new StorageGrainInspectionEChart();
        if (list.size() > 0) {
            String[] xAxisData = new String[list.size()];
            Float[] temperatureArray = new Float[list.size()];
            Float[] temperatureAvgArray = new Float[list.size()];
            Float[] storehouseTempArray = new Float[list.size()];

            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            for (int i = 0; i < list.size(); i++) {
                StorageGrainInspection s = list.get(i);
                xAxisData[i] = format.format(s.getReportDate());
                storehouseTempArray[i] = s.getStorehouseTemp();
                temperatureArray[i] = s.getTemperature();
                temperatureAvgArray[i] = s.getTemperatureAvg();
            }
            echart.setIsEmpty(false);
            echart.setxAxisData(xAxisData);
            echart.setStorehouseTempArray(storehouseTempArray);
            echart.setTemperatureArray(temperatureArray);
            echart.setTemperatureAvgArray(temperatureAvgArray);
        } else {
            echart.setIsEmpty(true);
        }
        return echart;
    }

    @Override
    public List<StorageGrainInspectionTemp> selectStorageGrainInspectionTempByPid(String p_id) {

        StorageGrainInspection grainInspection = new StorageGrainInspection();

        List<StorageGrainInspectionTemp> storageGrainInspectionTemp = sgtdao.selectStorageGrainInspectionTempByPid(p_id);
        grainInspection.setStorageGrainInspectionTemp(storageGrainInspectionTemp);

        return storageGrainInspectionTemp;
    }

    @Override
    public List<StorageGrainInspection> listByWarehouse(HashMap<String, String> map) {
        return dao.listByWarehouse(map);
    }

    @Override
    public String findMaxDateByWarehouse(HashMap<String, String> map) {
        return dao.findMaxDateByWarehouse(map);
    }

    @Override
    public int getTimeCount(HashMap<String, Object> map) {
        return dao.getTimeCount(map);
    }

    @Override
    public LayPage statistics(Integer pageNum, Integer pageSize, Map<String, Object> params) {
        LayPage layPage = new LayPage();
        PageHelper.startPage(pageNum, pageSize);
        List<Map<String, Object>> list = dao.statistics(params);
        PageInfo pageInfo = new PageInfo(list);

        // 对数据进行解析 原数据格式  (库点ID : 统计数 , 库点ID : 统计数 ……)
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> map = list.get(i);
            Map<String, Object> tempMap = new HashMap<>();    // 临时Map
            tempMap.put("reportDateStr", map.get("REPORT_DATE"));
            String[] data = ((String) map.get("DATA")).split(",");    // 库点ID : 统计数
            for (String str : data) {
                String[] tempStr = str.split(":");
                tempMap.put(tempStr[0], tempStr[1]);
            }
            list.set(i, tempMap);    // 数据替换
        }

        layPage.setData(list);
        layPage.setCode(0);
        layPage.setCount((int) pageInfo.getTotal());
        layPage.setMsg("");
        return layPage;
    }

    @Override
    public Workbook excel(Map<String, Object> params) {
        Workbook workbook = null;
        List<Map<String, Object>> list = dao.statistics(params);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        // 对数据进行解析 原数据格式  (库点ID : 统计数 , 库点ID : 统计数 ……)
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> map = list.get(i);
            Map<String, Object> tempMap = new HashMap<>();    // 临时Map
            tempMap.put("reportDateStr", sdf.format((Date) map.get("REPORT_DATE")));
            String[] data = ((String) map.get("DATA")).split(",");    // 库点ID : 统计数
            for (String str : data) {
                String[] tempStr = str.split(":");
                tempMap.put(tempStr[0], tempStr[1]);
            }
            list.set(i, tempMap);    // 数据替换
        }

        List<StorageWarehouse> warehouseList = storageWarehouseService.getStoreWarehouseByTypeWithCBK();
        List<ExcelExportEntity> entity = new ArrayList<ExcelExportEntity>();
        entity.add(new ExcelExportEntity("填报日期", "reportDateStr"));
        for (StorageWarehouse warehouse : warehouseList) {
            entity.add(new ExcelExportEntity(warehouse.getWarehouseShort(), warehouse.getId()));
        }
        try {
            workbook = ExcelExportUtil.exportExcel(new ExportParams("粮情检测记录统计", "粮情检测记录统计"), entity,
                    list);
        } catch (Exception e) {
            e.getStackTrace();
        }
        return workbook;
    }

    @Override
    public void reportGrainSituation(StorageGrainInspection storageGrainInspection) throws Exception{
        if(StringUtils.isEmpty(storageGrainInspection.getId())){
            throw new Exception("业务主键缺失");
        }
        StorageGrainInspection grainInspection = dao.get(storageGrainInspection.getId());
        // 查询库点ID
        String warehouseId = storageWarehouseService.getWareHouseIdByCode(storageGrainInspection.getWarehouseCode());
        if(StringUtils.isEmpty(warehouseId)){
            throw new Exception("库点代码不存在");
        }
        storageGrainInspection.setWarehouseId(warehouseId);
        storageGrainInspection.setPestSampleSiteByList();
        storageGrainInspection.setPestCheckTypeByList();
        if(grainInspection!=null){
            //throw new Exception("该粮情信息已存在，无法添加");
            if(dao.update(storageGrainInspection) == 1){
                List<StorageGrainInspectionTemp> storageGrainInspectionTemps = storageGrainInspection.getStorageGrainInspectionTemp();
                sgtdao.remove(storageGrainInspection.getId());
                for (StorageGrainInspectionTemp storageGrainInspectionTemp : storageGrainInspectionTemps) {
                    storageGrainInspectionTemp.setP_id(grainInspection.getId());//主表id赋予子表p_id
                    sgtdao.save(storageGrainInspectionTemp);
                }
            }
        }else {
            dao.save(storageGrainInspection);
            if(storageGrainInspection.getStorageGrainInspectionTemp() != null && storageGrainInspection.getStorageGrainInspectionTemp().size() > 0) {
                for (StorageGrainInspectionTemp storageGrainInspectionTemp : storageGrainInspection.getStorageGrainInspectionTemp()) {
                    sgtdao.save(storageGrainInspectionTemp);
                }
            }
        }


    }

    @Override
    public void reportGrainInspection(StorageGrainInspection storageGrainInspection){
        String reportUrl = BusinessConstants.REMOTE_BASE_URL + "/api/receive/grainInspection.do";

        Map<String, Object> dataMap = new HashMap<>();
        dataMap.put("bgrainGrainInspectionId", storageGrainInspection.getId());
        dataMap.put("bgrainWarehouseId", storageGrainInspection.getWarehouseId());  // 库点Id
        dataMap.put("warehouseshort", storageGrainInspection.getWarehouse());   // 库点名称
        dataMap.put("houseCodeCode", storageGrainInspection.getEncode());   // 仓号
        dataMap.put("grainType", storageGrainInspection.getGrainType());    // 粮食品种
        dataMap.put("quantity", storageGrainInspection.getQuantity());  // 数量
        dataMap.put("reportDate", storageGrainInspection.getReportDate());  // 填报日期
        dataMap.put("dew", storageGrainInspection.getDew());  // 水分
        dataMap.put("impurity", storageGrainInspection.getImpurity());  // 杂质
        dataMap.put("storehouseTemp", storageGrainInspection.getStorehouseTemp());  //仓温
        dataMap.put("temperature", storageGrainInspection.getTemperature());    //气温
        dataMap.put("storehouseWet", storageGrainInspection.getStorehouseWet());    // 仓湿
        dataMap.put("airWet", storageGrainInspection.getAirWet());  // 气湿
        dataMap.put("temperatureAvg", storageGrainInspection.getTemperatureAvg());  // 整仓平均温度
        dataMap.put("temperatureAbnormal", storageGrainInspection.getTemperatureAbnormal());  // 粮温是否异常
        dataMap.put("pestCheckType", storageGrainInspection.getPestCheckType());    // 虫害检测方式
        dataMap.put("pestSampleSite", storageGrainInspection.getPestSampleSite());  // 虫害采样部位
        dataMap.put("checkNum", storageGrainInspection.getCheckNum());  // 检测部位数量
        dataMap.put("pestSpot", storageGrainInspection.getPestSpot());  // 发现虫害部位
        dataMap.put("pestInsect", storageGrainInspection.getPestInsect());  // 虫害位置分布
        dataMap.put("pestNames", storageGrainInspection.getPestNames());    // 具体虫害名称
        dataMap.put("pestDensity", storageGrainInspection.getPestDensity());    // 害虫密度
        dataMap.put("majorPestDensity", storageGrainInspection.getMajorPestDensity());  // 主要虫害密度
        dataMap.put("pestLevel", storageGrainInspection.getPestLevel());  // 虫量等级
        dataMap.put("suffocate", storageGrainInspection.getSuffocate());  // 蒸熏措施
        dataMap.put("hygiene", storageGrainInspection.getHygiene());    // 清洁卫生是否达标
        dataMap.put("heat", storageGrainInspection.getHeat());  // 粮食有无发热
        dataMap.put("rot", storageGrainInspection.getRot());    // 有无霉变
        dataMap.put("shedLeakage", storageGrainInspection.getShedLeakage());    // 棚顶有无渗漏
        dataMap.put("wallLeakage", storageGrainInspection.getWallLeakage());    // 墙体,地坪有无渗漏
        dataMap.put("doorLeakage", storageGrainInspection.getDoorLeakage());    // 门窗有无渗漏
        dataMap.put("shedCrack", storageGrainInspection.getShedCrack());        // 顶棚有无裂缝
        dataMap.put("wallCrack", storageGrainInspection.getWallCrack());        // 墙体、地坪有无裂缝
        dataMap.put("doorCrack", storageGrainInspection.getDoorCrack());        // 门窗有无裂缝
        dataMap.put("light", storageGrainInspection.getLight());    // 照明是否故障
        dataMap.put("stairs", storageGrainInspection.getStairs());  // 上下楼梯是否安全
        dataMap.put("facilities", storageGrainInspection.getFacilities());  // 辅助设施是否完好
        dataMap.put("mouse", storageGrainInspection.getMouse());    // 仓内有无发现鼠雀
        dataMap.put("cobweb", storageGrainInspection.getCobweb());  // 仓内有无发现蛛网
        dataMap.put("checkSituation", storageGrainInspection.getCheckSituation());  // 检查评估情况
        dataMap.put("checkProperty", storageGrainInspection.getCheckProperty());    // 检查性质
        dataMap.put("checkCharge", storageGrainInspection.getCheckCharge());    // 检查负责人
        dataMap.put("checker", storageGrainInspection.getChecker());    // 检查人员
        dataMap.put("keeper", storageGrainInspection.getKeeper());  // 保管员
        dataMap.put("remark", storageGrainInspection.getRemark());  // 备注
        HttpUtil.postJson(reportUrl, JSONObject.toJSONString(dataMap));

    }
}
