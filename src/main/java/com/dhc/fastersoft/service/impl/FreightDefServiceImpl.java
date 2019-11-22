package com.dhc.fastersoft.service.impl;

import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.FreightDefDao;
import com.dhc.fastersoft.entity.FreightDef;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.service.FreightDefService;
import com.dhc.fastersoft.utils.LayPage;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Service("freightDefService")
public class FreightDefServiceImpl implements FreightDefService{
    @Resource
    private FreightDefDao freightDefDao;
    @Override
    public int save(FreightDef freightDef) {
        freightDef.setCreateBy(TokenManager.getSysUserId());
        freightDef.setCreateDate(new Date(System.currentTimeMillis()));
        freightDef.setUpdateDate(new Date(System.currentTimeMillis()));
        return freightDefDao.insert(freightDef);
    }
    @Override
    public void updateById(FreightDef freightDef) {
        freightDef.setUpdateBy(TokenManager.getSysUserId());
        freightDef.setUpdateDate(new Date(System.currentTimeMillis()));
        freightDefDao.updateByPrimaryKey(freightDef);
    }

    @Override
    public LayPage<FreightDef> pageList(HttpServletRequest request) {

        LayPage<FreightDef> page = new LayPage<FreightDef>();

        HashMap<String,String> map = QueryUtil.pageHashMap(request);

        String shipType = request.getParameter("shipType");
        map.put("shipType", shipType);
        map.put("packageType", request.getParameter("packageType"));

        int count = freightDefDao.getRecordCount(map);    //总记录数
        page.setCode(0);
        page.setCount(count);
        if (count<=0) {
            page.setMsg("没有查询到数据");
            return page;
        }
        page.setData(freightDefDao.pageQuery(map));
        page.setMsg("succes");
        return page;
    }
    @Override
    public FreightDef selectById(String id) {

        return freightDefDao.selectByPrimaryKey(id);
    }
    @Override
    public List<FreightDef> selectByShipType(HttpServletRequest request){
        String shipType = request.getParameter("shipType");
        return freightDefDao.selectByShipType(shipType);
    }

    @Override
    public List<FreightDef> selectByType(FreightDef freightDef) {
        List<FreightDef> freightDefList = new ArrayList<FreightDef>();
        Map<String,String> map = new HashMap<String, String>();
        String shipType = freightDef.getShipType();
        String packageType = freightDef.getPackageType();
        map.put("shipType", shipType);
        map.put("packageType",packageType);
        freightDefList = freightDefDao.selectByType(map);
        return freightDefList;
    }
    @Override
    public void deleteById(String id) {
        freightDefDao.deleteByPrimaryKey(id);
    }
}
