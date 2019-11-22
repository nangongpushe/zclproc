package com.dhc.fastersoft.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.constants.BusinessConstants;
import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.StorageStoreHouseDao;
import com.dhc.fastersoft.dao.StorageWarehouseDao;
import com.dhc.fastersoft.entity.StorageStoreHouse;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.StorageStoreHouseService;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.util.DataAuthorityUtil;
import com.dhc.fastersoft.util.HttpUtil;
import com.dhc.fastersoft.utils.LayPage;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.*;

@Service("storageStoreHouseService")
public class StorageStoreHouseServiceImpl implements StorageStoreHouseService {

    @Autowired
    StorageStoreHouseDao dao;
    @Autowired
    StorageWarehouseDao warehouseDao;
    @Autowired
    StorageWarehouseService storageWarehouseService;

    @Override
    public ActionResultModel saveForSingle(StorageStoreHouse storageStoreHouse) {
        // TODO Auto-generated method stub
        ActionResultModel result = new ActionResultModel();

        /**判断当前库点下仓房编号是否唯一*/
        String encode = storageStoreHouse.getEncode();
        String warehouse = storageStoreHouse.getWarehouse();
        if (dao.getByEncodeAndWarehouse(encode, warehouse).size() == 0) {
//			storageStoreHouse.setId(dao.getNextId());
            storageStoreHouse.setCreator(TokenManager.getNickname());
            storageStoreHouse.setCreateDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime()));
            if (dao.saveForSingle(storageStoreHouse) == 1) {
                reportStorehouse(storageStoreHouse);    // 同步到远程监管
                result.setMsg("新增成功");
                result.setSuccess(true);
            } else {
                result.setMsg("新增失败");
                result.setSuccess(false);
            }
        } else {
            result.setSuccess(false);
            result.setMsg("仓房编号在此库点下不唯一，请更换");
        }
        return result;
    }

    @Override
    public ActionResultModel updateForSingle(StorageStoreHouse storageStoreHouse) {
        // TODO Auto-generated method stub
        ActionResultModel result = new ActionResultModel();
        /**判断当前库点下仓房编号是否唯一*/
        String encode = storageStoreHouse.getEncode();
        String warehouse = storageStoreHouse.getWarehouse();
        List<StorageStoreHouse> list = dao.getByEncodeAndWarehouse(encode, warehouse);
        if (list.size() == 0 ||
                (list.size() == 1 && list.get(0).getId().equals(storageStoreHouse.getId()))) {
            if (dao.updateForSingle(storageStoreHouse) == 1) {
                reportStorehouse(storageStoreHouse);    // 同步到远程监管
                result.setMsg("修改成功");
                result.setSuccess(true);
            } else {
                result.setMsg("修改失败");
                result.setSuccess(false);
            }
        } else {
            result.setSuccess(false);
            result.setMsg("仓房编号在此库点下不唯一，请更换");
        }
        return result;
    }

    @Override
    public LayPage<StorageStoreHouse> list(HttpServletRequest request) {
        // TODO Auto-generated method stub
        LayPage<StorageStoreHouse> page = new LayPage<>();
        HashMap<String, String> map = QueryUtil.pageQuery(request);

        String warehouse = request.getParameter("warehouse");
        String encode = request.getParameter("encode");
        String status = request.getParameter("status");
        String type = request.getParameter("type");
        String flag = request.getParameter("flag");
        String minCapacity = request.getParameter("minCapacity");
        String maxCapacity = request.getParameter("maxCapacity");
        String isStop = request.getParameter("isStop");
        map.put("isStop", isStop);
        map.put("warehouse", warehouse);
        map.put("encode", encode);
        map.put("status", status);
        map.put("type", type);
        map.put("minCapacity", minCapacity);
        map.put("maxCapacity", maxCapacity);
        map.put("flag", flag);
        map.put("encode1", request.getParameter("encode1"));

        String enterpriseName = DataAuthorityUtil.getDataAuthority(flag);
        map.put("enterpriseName", enterpriseName);

        int count = dao.count(map);

        if (count <= 0) {
            return page;
        }

        List<StorageStoreHouse> data = dao.list(map);


        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
        return page;
    }

    @Override
    public StorageStoreHouse getSingle(String id) {
        return dao.getSingle(id);
    }

    @Override
    public ActionResultModel remove(String id) {
        ActionResultModel result = new ActionResultModel();
        StorageStoreHouse storageStoreHouse = dao.getSingle(id);
        Integer monthBzwflag = dao.selectMonthBzw(storageStoreHouse);
        Integer monthSwtzflag = dao.selectMonthSwtz(storageStoreHouse);
        Integer planDetallflag = dao.selectPlanDetall(storageStoreHouse);
        Integer qualitySampleflag = dao.selectQualitySample(storageStoreHouse);
        if (monthBzwflag == 0 && monthSwtzflag == 0 && planDetallflag == 0 && qualitySampleflag == 0) {
            dao.remove(id);
            HttpUtil.postJson(BusinessConstants.REMOTE_BASE_URL + "/api/receive/storehouse/del/" + id + ".do", "");   // 同步到远程监管
            result.setSuccess(true);
            result.setMsg("删除仓房信息成功");
        } else {
            /*if (dao.remove(id)!=1){
                result.setSuccess(false);
                result.setMsg("删除仓房信息失败");
            }else{

            }*/
            if (monthBzwflag > 0) {
                result.setSuccess(false);
                result.setMsg("包装物库存月报表中存在此仓房,不能删除");
            }

            if (monthSwtzflag > 0) {
                result.setSuccess(false);
                result.setMsg("粮油库存实物台账中存在此仓房,不能删除");
            }
            if (planDetallflag > 0) {
                result.setSuccess(false);
                result.setMsg("轮换计划详情中存在此仓房,不能删除");
            }
            if (qualitySampleflag > 0) {
                result.setSuccess(false);
                result.setMsg("样品信息中存在此仓房,不能删除");
            }


        }
        return result;
    }

    @Override
    public String[] getEncodeByWarehouse(String warehouse) {
        // TODO Auto-generated method stub
        try {
            String[] strs = dao.getEncodeByWarehouse(new String(URLDecoder.decode(warehouse, "utf-8")));
            return dao.getEncodeByWarehouse(new String(URLDecoder.decode(warehouse, "utf-8")));
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public String[] getEncodeAndOilByWarehouse(String warehouse, String isHasOil) {
        return dao.getEncodeAndOilByWarehouse(warehouse, isHasOil);
    }

    @Override
    public int countStoreHouseByEncode(String encode, String warehouseId) {
        return dao.countStoreHouseByEncode(encode, warehouseId);
    }

    @Override
    public String[] getEncodeByWarehouseId(String warehouseId) {
        try {
            return dao.getEncodeByWarehouseId(new String(URLDecoder.decode(warehouseId, "utf-8")));
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<StorageStoreHouse> getByEncodeAndWarehouse(String encode, String warehouse) {
        return dao.getByEncodeAndWarehouse(encode, warehouse);
    }

    @Override
    public String[] getAllEncode() {
        // TODO Auto-generated method stub
        return dao.getAllEncode();
    }

    @Override
    public List<StorageStoreHouse> listStorehouseOfWarehouse(String warehouseName) {
        // TODO Auto-generated method stub
        return dao.listStorehouseOfWarehouse(warehouseName);
    }

    @Override
    public LayPage<StorageStoreHouse> list(String warehouse) {
        // TODO Auto-generated method stub
        LayPage<StorageStoreHouse> page = new LayPage<>();
        HashMap<String, String> map = new HashMap<>();

        map.put("warehouse", warehouse);

        map.put("creator", "");

        int count = dao.count(map);

        if (count <= 0) {
            return page;
        }

        List<StorageStoreHouse> data = dao.list(map);

        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
        return page;
    }

    @Override
    public List<String> listKudianCode() {
        return warehouseDao.listKudianCode();
    }

    @Override
    public LayPage<StorageStoreHouse> listStoreHouseByWarehouseCode(Map<String, Object> map) {

        int count = dao.storeHouseCount(map);

        List<StorageStoreHouse> list = dao.listStoreHouseByWarehouseCode(map);

        return new LayPage<>(list, count);
    }

    @Override
    public String[] listStoreHouseAndOilCanByWarehouse(String warehouseId, String warehouseCode) {
        return dao.listStoreHouseAndOilCanByWarehouse(warehouseId, warehouseCode);
    }

    @Override
    public LayPage<StorageStoreHouse> proxyList(HttpServletRequest request) {
        // TODO Auto-generated method stub
        LayPage<StorageStoreHouse> page = new LayPage<>();
        HashMap<String, String> maps = QueryUtil.pageQuery(request);
        HashMap<String, Object> map = new HashMap<String, Object>();
        String start = maps.get("start");
        String end = maps.get("end");
        String warehouse = request.getParameter("warehouse");
        String encode = request.getParameter("encode");
        String status = request.getParameter("status");
        String type = request.getParameter("type");
        //String flag = request.getParameter("flag");
        String minCapacity = request.getParameter("minCapacity");
        String maxCapacity = request.getParameter("maxCapacity");
        String dataScope = request.getParameter("dataScope");
        String enterpriseName = request.getParameter("enterpriseName");
        String isStop = request.getParameter("isStop");

        List kudianCodes = listKudianCode();
        map.put("enterpriseName", enterpriseName);
        map.put("kudianCodes", kudianCodes);
        map.put("isStop", isStop);
        if (StringUtils.isBlank(dataScope)) {
            dataScope = "1";
        }
        map.put("dataScope", dataScope);
        map.put("start", start);
        map.put("end", end);
        map.put("warehouse", warehouse);
        map.put("encode", encode);
        map.put("status", status);
        map.put("type", type);
        map.put("minCapacity", minCapacity);
        map.put("maxCapacity", maxCapacity);
        // map.put("flag", flag);


        //String enterpriseName = DataAuthorityUtil.getDataAuthority(flag);
        List<String> warehouseCode = null;
        warehouseCode = getCurrentDataAuthority();
        map.put("warehouseCode", warehouseCode);

        int count = dao.proxyCount(map);
        page.setMsg(TokenManager.getToken().getOriginCode());
        if (count <= 0) {
            return page;
        }

        List<StorageStoreHouse> data = dao.proxyList(map);

        page.setCount(count);
        page.setData(data);
        page.setCode(0);

        return page;
    }

    public List<String> getCurrentDataAuthority() {
        String warehouseCode = "";
        List<String> warehouseCodes = null;
        // 当前用户信息
        SysUser user = TokenManager.getToken();
        // 管理员能查看所有库点
        if ("admin".equals(user.getAccount())) {
            return null;
        }

        // 获取库点代码
        List kudianCodes = listKudianCode();
        if ("CBL".equals(user.getAccount())) {
            //如果是公司人员，返回空
            return null;
        }


        if (kudianCodes.contains(user.getOriginCode())) {
            //如果是直属库人员，返回直属库代码
            warehouseCodes = new ArrayList<String>();
            warehouseCode = user.getOriginCode();
            warehouseCodes.add(warehouseCode);
            return warehouseCodes;
        }

        if ("本系统创建".equals(user.getNote())) {
            //如果是代储点，返回代储点所在公司的所有库代码
            //根据公司名获取库点
            HashMap<String, String> map = new HashMap<String, String>();
            map.put("enterpriseName", user.getCompany());
            List<StorageWarehouse> storageWarehouseList = storageWarehouseService.selectWareHouseByEnterPriseName(map);
            List<String> list = new ArrayList<String>();
            for (StorageWarehouse storageWarehouse : storageWarehouseList) {
                list.add(storageWarehouse.getWarehouseCode());
            }
            //warehouseCode = StringUtils.join(list, ",");
            return list;
        }

        return warehouseCodes;
    }

    @Override
    public int getcountByWarehouseId(String warehouseId) {
        HashMap<String, String> map = new HashMap<>();
        map.put("warehouseId", warehouseId);
        return dao.getcountByWarehouseId(map);
    }

    @Override
    public List<StorageStoreHouse> findAllByWarehouseId(HttpServletRequest request, String warehouseId) {
        HashMap<String, String> map = QueryUtil.pageHashMap(request);
        QueryUtil.pageQuery(request);
        map.put("warehouseId", warehouseId);
        return dao.findAllByWarehouseId(map);
    }

    @Override
    public LayPage<StorageStoreHouse> storeHouseListByWarehouseName(HttpServletRequest request, String warehouseName) {
        HashMap<String, String> map = QueryUtil.pageHashMap(request);
        QueryUtil.pageQuery(request);
        map.put("warehouseName", warehouseName);
        int count = dao.countStorehouseOfWarehouseName(map);
        List<StorageStoreHouse> storageStoreHouses = dao.listStorehouseOfWarehouseName(map);
        LayPage<StorageStoreHouse> list = new LayPage<>(storageStoreHouses, count);
        return list;
    }


    @Override
    public void reportStorehouse(StorageStoreHouse storeHouse) {
        String url = BusinessConstants.REMOTE_BASE_URL + "/api/receive/storehouse.do";
        Map<String, Object> dataMap = new HashMap();

        dataMap.put("bgrainStorehouseId", storeHouse.getId());
        dataMap.put("bgrainWarehouseId", storeHouse.getWarehouseId());
        dataMap.put("warehouseCode", storeHouse.getWarehouseId());
        dataMap.put("houseCodeCode", storeHouse.getEncode());
        dataMap.put("houseCodeName", storeHouse.getStorehouseName());
        dataMap.put("houseTypeCode", storeHouse.getType());     // 仓房类型
        dataMap.put("houseStatusCode", storeHouse.getStatus());
        dataMap.put("enableDate", storeHouse.getEnableDate());  // 启用日期
        dataMap.put("structure", storeHouse.getStructure());    // 结构
        dataMap.put("bulkHeight", storeHouse.getBulkHeight());
        dataMap.put("gateNum", storeHouse.getGateNum());
        dataMap.put("silodiameter", storeHouse.getSiloDiameter());
        dataMap.put("houseTcnj", storeHouse.getSiloBore());
        dataMap.put("silovolume", storeHouse.getSiloVolume());
        dataMap.put("cfa", storeHouse.getCfa());
        dataMap.put("gateheight", storeHouse.getGateHeight());
        dataMap.put("gatewidth", storeHouse.getGateWidth());
        dataMap.put("eavesheight", storeHouse.getEavesHeight());
        dataMap.put("designedcapacity", storeHouse.getDesignedCapacity());
        dataMap.put("authorizedcapacity", storeHouse.getAuthorizedCapacity());
        dataMap.put("bulkarea", storeHouse.getBulkArea());
        dataMap.put("ventnum", storeHouse.getVentNum());
        dataMap.put("ducttype", storeHouse.getDuctType());
        dataMap.put("silotightness", storeHouse.getSiloTightness());
        dataMap.put("axialnum", storeHouse.getAxialNum());
        dataMap.put("heatinsulation", storeHouse.getHeatInsulation());
        dataMap.put("storetype", storeHouse.getStoreType());
        dataMap.put("keeper", storeHouse.getKeeper());
        dataMap.put("buildingTypeCode", storeHouse.getBuildingType());
        dataMap.put("length", storeHouse.getLength());
        dataMap.put("width", storeHouse.getWidth());
        dataMap.put("height", storeHouse.getHeight());
        dataMap.put("longitude", storeHouse.getLongitude());
        dataMap.put("latitude", storeHouse.getLatitude());
        dataMap.put("remarks", storeHouse.getRemark());
        dataMap.put("enterpriseId", BusinessConstants.ENTERPRISE_ID);

        HttpUtil.postJson(url, JSONObject.toJSONString(dataMap));

    }
}