package com.dhc.fastersoft.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.dhc.fastersoft.common.constants.BusinessConstants;
import com.dhc.fastersoft.common.page.PageList;
import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.DurablesDao;
import com.dhc.fastersoft.entity.Durables;
import com.dhc.fastersoft.service.DurablesService;
import com.dhc.fastersoft.util.HttpUtil;
import com.dhc.fastersoft.utils.LayPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("DurablesService")
public class DurablesServiceImpl implements DurablesService {


    @Autowired
    DurablesDao durablesDao;


    @Override
    public LayPage<Durables> list(HttpServletRequest request) {
        // TODO Auto-generated method stub
        LayPage<Durables> page = new LayPage<>();
        String shortName = "";
        HashMap<String, String> maps = QueryUtil.pageQuery(request);
        maps.put("commodity", request.getParameter("commodity"));
        maps.put("type", request.getParameter("type"));
        maps.put("encode", request.getParameter("encode"));
        String timeStart = request.getParameter("timeStart");
        String timeEnd = request.getParameter("timeEnd");
        maps.put("timeStart", timeStart);
        maps.put("timeEnd", timeEnd);
        //shortName=request.getParameter("shortName");
        String warehouseId = request.getParameter("warehouseId");
        String str = TokenManager.getToken().getShortName();
        if (shortName != null && shortName != "") {
            //maps.put("storehouse",shortName);
            maps.put("warehouseId", warehouseId);
        } else {
            /*maps.put("storehouse", TokenManager.getToken().getShortName());*/
            maps.put("warehouseId", TokenManager.getToken().getWareHouseId());
        }

        int count = durablesDao.getRecordCount(maps);

        if (count <= 0) {
            return page;
        }

        List<Durables> data = durablesDao.pageQuery(maps);

        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
        return page;

    }

    @Override
    public PageList pageQuery(HttpServletRequest request) {
        // TODO Auto-generated method stub
        // User user=(User) WebUtils.getSessionAttribute(request, "user");
        PageList page = new PageList();
        HashMap<String, String> maps = QueryUtil.pageQuery(request);
        maps.put("commodity", request.getParameter("commodity"));
        maps.put("model", request.getParameter("model"));
        String timeStart = request.getParameter("timeStart");
        String timeEnd = request.getParameter("timeEnd");
        maps.put("timeStart", timeStart);
        maps.put("timeEnd", timeEnd);

        int allRow = durablesDao.getRecordCount(maps);            //System.out.println("allRow:"+allRow);
        page.setCount(allRow);
        if (allRow <= 0) {
            return page;
        }
        page.setRecords(durablesDao.pageQuery(maps));

        return page;
    }

    @Override
    public int add(Durables durables) {
        // TODO Auto-generated method stub
        reoprtDurables(durables);
        return durablesDao.add(durables);
    }

    @Override
    public int update(Durables durables) {
        // TODO Auto-generated method stub
        reoprtDurables(durables);
        return durablesDao.update(durables);
    }

    @Override
    public Durables getDurablesByID(String id) {
        // TODO Auto-generated method stub
        return durablesDao.getDurablesById(id);
    }

    @Override
    public int remove(String id) {
        // TODO Auto-generated method stub
        HttpUtil.postJson(BusinessConstants.REMOTE_BASE_URL + "/api/receive/device/del/" + id + ".do", "");
        return durablesDao.remove(id);
    }

    @Override
    public int updateApply(Durables durables) {
        // TODO Auto-generated method stub
        return durablesDao.updateApply(durables);
    }

    @Override
    public int getEncodeCount(String encode) {
        // TODO Auto-generated method stub
        return durablesDao.getEncodeCount(encode);
    }

    @Override
    public List<Durables> listDurables(HashMap<String, Object> map) {
        // TODO Auto-generated method stub
        return durablesDao.listDurables(map);
    }


    public void reoprtDurables(Durables durables) {
        String url = BusinessConstants.REMOTE_BASE_URL + "/api/receive/device.do";
        Map<String, Object> data = new HashMap<>();

        data.put("bgrainDeviceInfoId", durables.getId());
        data.put("bgrainWarehouseId", durables.getWarehouseId());
        data.put("deviceCode", durables.getEncode());
        data.put("deviceName", durables.getCommodity());

//        data.put("deviceType", "");     // 设备类型   预留字段 之后进行添加

        data.put("remark", durables.getRemark());
        data.put("enterpriseId", BusinessConstants.ENTERPRISE_ID);

        HttpUtil.postJson(url, JSONObject.toJSONString(data));

    }


}
