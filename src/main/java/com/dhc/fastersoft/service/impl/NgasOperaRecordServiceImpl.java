package com.dhc.fastersoft.service.impl;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.NgasOperaRecordDao;
import com.dhc.fastersoft.dao.NgasOperaSituationDao;
import com.dhc.fastersoft.dao.StorageGrainInspectionDao;
import com.dhc.fastersoft.entity.NgasOperaRecord;
import com.dhc.fastersoft.entity.NgasOperaSituation;
import com.dhc.fastersoft.entity.StorageGrainInspection;
import com.dhc.fastersoft.entity.StorageGrainInspectionTemp;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.NgasOperaRecordService;
import com.dhc.fastersoft.service.StorageGrainInspectionService;
import com.dhc.fastersoft.utils.LayPage;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

@Service("ngasOperaRecordService")
public class NgasOperaRecordServiceImpl implements NgasOperaRecordService {
    @Autowired
    NgasOperaRecordDao dao;
    @Autowired
    NgasOperaSituationDao nordao;
    @Override
    public ActionResultModel save(NgasOperaRecord ngasOperaRecord) {
        ActionResultModel result = new ActionResultModel();
        //String PrimId = dao.getPrimId();
        String PrimId = UUID.randomUUID().toString().replace("-", "");
        ngasOperaRecord.setId(PrimId);
        ngasOperaRecord.setCreator(TokenManager.getNickname());
        if (dao.save(ngasOperaRecord) == 1) {
            List<NgasOperaSituation> ngasOperaSituations = ngasOperaRecord.getNgasOperaSituation();
            for (NgasOperaSituation ngasOperaSituation:ngasOperaSituations) {
                String id = UUID.randomUUID().toString().replace("-", "");
                ngasOperaSituation.setId(id);
                ngasOperaSituation.setOperaRecordId(PrimId);//主表id赋予子表p_id
                nordao.save(ngasOperaSituation);
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
    public ActionResultModel update(NgasOperaRecord ngasOperaRecord) {
        // TODO Auto-generated method stub
        ActionResultModel result = new ActionResultModel();
        if (dao.update(ngasOperaRecord) == 1) {
            List<NgasOperaSituation> ngasOperaSituations = ngasOperaRecord.getNgasOperaSituation();
            nordao.remove(ngasOperaRecord.getId());
            for (NgasOperaSituation ngasOperaSituation:ngasOperaSituations) {
                String id = UUID.randomUUID().toString().replace("-", "");
                ngasOperaSituation.setId(id);
                ngasOperaSituation.setOperaRecordId(ngasOperaRecord.getId());//主表id赋予子表p_id
                nordao.save(ngasOperaSituation);
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
    public LayPage<NgasOperaRecord> list(HttpServletRequest request) {
        LayPage<NgasOperaRecord> page = new LayPage<>();
        HashMap<String, String> map = QueryUtil.pageQuery(request);
        String warehouse = request.getParameter("warehouse");
        String storehouseEncode = request.getParameter("storehouseEncode");
        String reportDate = request.getParameter("reportDate");

        map.put("warehouse",warehouse);
        map.put("storehouseEncode",storehouseEncode);
        map.put("reportDate",reportDate);
        SysUser user = TokenManager.getToken();
        String dept = user.getDepartment();
        String company =  user.getCompany();
        String originCode = user.getOriginCode();
        if ((company != null && StringUtils.equals(originCode.toUpperCase(),"CBL") && dept != null && (dept.equals("仓储部") || dept.equals("上级部门领导")))
                || user.getAccount().equals("admin")) {
            map.put("creator", "");
        } else {
            map.put("creator", user.getName());
        }

        int count = dao.count(map);

        if (count <= 0) {
            return page;
        }
        List<NgasOperaRecord> data = dao.list(map);
        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
        return page;
    }

    @Override
    public NgasOperaRecord get(String id) {
        NgasOperaRecord ngasOperaRecord = new NgasOperaRecord();
        ngasOperaRecord = dao.get(id);
        //查询小表信息根据
       /* String p_id = ngasOperaRecord.getId();
        List<NgasOperaSituation> ngasOperaSituations =nordao.selectNgasOperaSituationByPid(p_id);
        ngasOperaRecord.setNgasOperaSituation(ngasOperaSituations);*/

        return ngasOperaRecord;
    }

    @Override
    public List<NgasOperaSituation> selectNgasOperaSituationByPid(String p_id) {
        List<NgasOperaSituation> ngasOperaSituations =nordao.selectNgasOperaSituationByPid(p_id);
        return ngasOperaSituations;
    }

    @Override
    public ActionResultModel remove(String id) {
        ActionResultModel result = new ActionResultModel();
        if (dao.remove(id) == 1) {
            nordao.remove(id);
            result.setMsg("删除成功");
            result.setSuccess(true);
        } else {
            result.setMsg("删除失败");
            result.setSuccess(false);
        }
        return result;
    }
}
