package com.dhc.fastersoft.service.system.impl;



import com.dhc.fastersoft.dao.RotateConcluteDao;
import com.dhc.fastersoft.entity.RotateConcluteDetail;
import com.dhc.fastersoft.entity.RotateNotice;
import com.dhc.fastersoft.entity.RotateNoticeDetail;
import com.dhc.fastersoft.entity.store.StoreEnterprise;
import com.dhc.fastersoft.service.system.SysOutinrepoNoticeService;
import com.dhc.fastersoft.util.HttpUtil;
import net.sf.json.JSONObject;
import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.HttpClients;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service("SysOutinrepoNoticeService")
public class SysOutinrepoNoticeServiceImpl implements SysOutinrepoNoticeService {

    private HttpClient request;
    private Properties prop = new Properties();
    private String host = new String();
    private String wshost = new String();
    @Autowired
    private RotateConcluteDao rotateConcluteDao;
    static File logFile = new File("OutinrepoNoticeProcessLog.txt");

    {
        request = HttpClients.createDefault();
        try {
            prop.load(this.getClass().getResourceAsStream("/OATable.properties"));
            host = prop.getProperty("STOUSE_HOST").toString().trim();
            wshost = prop.getProperty("WS_HOST").toString().trim();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    @Override
    public String sendMessage(RotateNotice notice) {
        //设置请求URI和请求方式
        SimpleDateFormat sim = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Map<String, Object> noticeMap = new HashMap();
        noticeMap.put("pk_id", notice.getId());
        noticeMap.put("noticeserial", notice.getNoticeSerial());
        noticeMap.put("noticetype", notice.getNoticeType());
        noticeMap.put("rotatetype", notice.getRotateType());
        noticeMap.put("documentnumber", notice.getDocumentNumber());
        noticeMap.put("accepteunit", notice.getStoreEnterprise().getEnterpriseName());
        if (notice.getStorageDate() != null) {
            noticeMap.put("storagedate", sim.format(notice.getStorageDate()));
        }
        noticeMap.put("creater", notice.getCreater());
        if (notice.getCreateTime() != null) {
            noticeMap.put("createtime", sim.format(notice.getCreateTime()));
        }
        noticeMap.put("status", notice.getStatus());
        if (notice.getCompleteDate() != null) {
            noticeMap.put("completedate", sim.format(notice.getCompleteDate()));
        }
        noticeMap.put("completehumen", notice.getCompleteHumen());
        if (notice.getStorageDate() != null) {
            noticeMap.put("grainannual", new SimpleDateFormat("yyyy").format(notice.getStorageDate()));
        }
        noticeMap.put("remark", notice.getRemark());
        noticeMap.put("operatetype", "1");
        List<Map<String, Object>> mapList = new ArrayList();
        if (notice.getNoticeDetail() != null && notice.getNoticeDetail().size() > 0) {
            for (RotateNoticeDetail noticeDetail : notice.getNoticeDetail()) {
                Map<String, Object> noticeDetailMap = new HashMap();
                noticeDetailMap.put("variety", noticeDetail.getVariety());
                noticeDetailMap.put("cost", noticeDetail.getCost());
                noticeDetailMap.put("pipeattribute", noticeDetail.getPipeAttribute());
                noticeDetailMap.put("grainannual", noticeDetail.getHarvestYear());
                noticeDetailMap.put("storagegraindepot", noticeDetail.getStorageWarehouse());
                noticeDetailMap.put("granarycode", noticeDetail.getStorehouse());
                noticeDetailMap.put("plannumber", noticeDetail.getPlanNumber());
                noticeDetailMap.put("actualnumber", noticeDetail.getActualNumber());
                noticeDetailMap.put("removalunit", noticeDetail.getRemovalUnit());
                noticeDetailMap.put("immigrationunit", noticeDetail.getImmigrationUnit());
                noticeDetailMap.put("schemeid", noticeDetail.getSchemeId());//方案 ID 视为子表主键
                noticeDetailMap.put("schemename", noticeDetail.getSchemeName());
                noticeDetailMap.put("dealseria", noticeDetail.getDealSerial() + "_" +noticeDetail.getWarehouse().getWarehouseCode() + "_" + noticeDetail.getStorehouse());

                mapList.add(noticeDetailMap);
            }
        }
        noticeMap.put("inoutnoticedetails", mapList);
        JSONObject json = new JSONObject();
        json.put("inoutnotice", noticeMap);
        StoreEnterprise storeEnterprise = notice.getStoreEnterprise();
        String result = "";
        if ("衢州库".equals(storeEnterprise.getEnterpriseName().trim())) {
            //host 为衢州库地址
            result = HttpUtil.postJson(host + "webresources/inoutRest/inoutNotice", json.toString());
        }
        return result;
    }

    @Override
    public String sendMessageToLangchao(RotateNotice notice) {
        Map<String, Object> noticeMap = getNoticeMap(notice, "outinrepoNoticeDetailVoList");
        JSONObject json = new JSONObject();
        json.put("outinrepoNoticeVo", noticeMap);
        String result = HttpUtil.postJson(wshost + "services/outinrepoNotice/outinrepoNoticeInfo", json.toString());
        return result;
    }

    private Map<String, Object> getNoticeMap(RotateNotice notice, String noticeDetils) {
        SimpleDateFormat sim = new  SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
        Map<String, Object> noticeMap = new HashMap();
        noticeMap.put("pkId", notice.getId());
        noticeMap.put("noticeserial", notice.getNoticeSerial());
        noticeMap.put("noticetype", notice.getNoticeType());
        noticeMap.put("rotatetype", notice.getRotateType());
        noticeMap.put("documentnumber", notice.getDocumentNumber());
        noticeMap.put("accepteunit", notice.getStoreEnterprise().getEnterpriseName());
        if (notice.getStorageDate() != null) {
            noticeMap.put("storagedate", sim.format(notice.getStorageDate()));
        }
        noticeMap.put("creater", notice.getCreater());
        if(notice.getCreateTime()!=null) {
            noticeMap.put("createtime", sim.format(notice.getCreateTime()));
        }
        noticeMap.put("status", notice.getStatus());
        if(notice.getCompleteDate()!=null) {
            noticeMap.put("completedate", sim.format(notice.getCompleteDate()));
        }
        noticeMap.put("completehumen", notice.getCompleteHumen());
        if (notice.getStorageDate() != null) {
            noticeMap.put("grainannual", new SimpleDateFormat("yyyy").format(notice.getStorageDate()));
        }
        noticeMap.put("remark", notice.getRemark());
        noticeMap.put("operatetype", "1");
        noticeMap.put("executeStatus", "未执行完毕");
        List<Map<String, Object>> mapList = new ArrayList();
        if (notice.getNoticeDetail() != null && notice.getNoticeDetail().size() > 0) {
            for (RotateNoticeDetail noticeDetail : notice.getNoticeDetail()) {
                Map<String, Object> noticeDetailMap = new HashMap();
                noticeDetailMap.put("variety", noticeDetail.getVariety());
                noticeDetailMap.put("cost", noticeDetail.getCost());
                noticeDetailMap.put("pipeattribute", noticeDetail.getPipeAttribute());
                noticeDetailMap.put("grainannual", noticeDetail.getHarvestYear());
                noticeDetailMap.put("storagegraindepot", noticeDetail.getStorageWarehouse());
                noticeDetailMap.put("granarycode", noticeDetail.getStorehouse());
                noticeDetailMap.put("plannumber", noticeDetail.getPlanNumber());
                noticeDetailMap.put("actualnumber", noticeDetail.getActualNumber());
                noticeDetailMap.put("removalunit", noticeDetail.getRemovalUnit());
                noticeDetailMap.put("immigrationunit", noticeDetail.getImmigrationUnit());
                noticeDetailMap.put("schemeid", noticeDetail.getSchemeId());//方案 ID 视为子表主键
                noticeDetailMap.put("schemename", noticeDetail.getSchemeName());
                noticeDetailMap.put("dealserial", noticeDetail.getDealSerial() + "_" +noticeDetail.getWarehouse().getWarehouseCode() + "_" + noticeDetail.getStorehouse());
                noticeDetailMap.put("detailpkid", noticeDetail.getId());
                RotateConcluteDetail rotateConcluteDetail =   rotateConcluteDao.getRotateConcluteDetailByDealSerial(noticeDetail.getDealSerial());
                noticeDetailMap.put("produceArea", rotateConcluteDetail.getProduceArea());
                String compId = null;
                if("入库".equals(notice.getNoticeType())){
                    compId = rotateConcluteDetail.getDeliveryId();
                }else if("出库".equals(notice.getNoticeType())){
                    compId =  rotateConcluteDetail.getReceiveId();
                }
                if(compId!=null){
                    String clientInfo = rotateConcluteDao.getClientInfoById(compId);
                    noticeDetailMap.put("customer", clientInfo);
                }
                mapList.add(noticeDetailMap);
            }
        }
        noticeMap.put(noticeDetils, mapList);
        return noticeMap;
    }
}
