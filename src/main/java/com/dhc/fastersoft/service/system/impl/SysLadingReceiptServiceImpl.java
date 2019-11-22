package com.dhc.fastersoft.service.system.impl;


import com.dhc.fastersoft.entity.RotateConcluteDetail;
import com.dhc.fastersoft.entity.RotateTakeMain;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.RotateConcluteService;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.service.system.SysLadingReceiptService;
import com.dhc.fastersoft.service.system.SysUserService;
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

@Service("SysLadingReceiptService")
public class SysLadingReceiptServiceImpl implements SysLadingReceiptService {
    @Autowired
    private SysUserService sysUserService;
    @Autowired
    private StorageWarehouseService storageWarehouseService;
    @Autowired
    private RotateConcluteService rotateConcluteService;
    private HttpClient request;
    private Properties prop = new Properties();
    private String host = new String();
    static File logFile = new File("LadingReceiptProcessLog.txt");

    {
        request = HttpClients.createDefault();
        try {
            prop.load(this.getClass().getResourceAsStream("/OATable.properties"));
            host = prop.getProperty("WS_HOST").toString().trim();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    @Override
    public String sendMessage(RotateTakeMain rotateTakeMain) {
        SysUser sysUser=sysUserService.selectById(rotateTakeMain.getCreater());
        //设置请求URI和请求方式
        SimpleDateFormat sim = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
        Map<String, Object> noticeMap = new HashMap();
        Map<String, Object> noticeMap2 = new HashMap();
//        noticeMap.put("id", rotateTake.getId());
        noticeMap.put("id", rotateTakeMain.getId());
        noticeMap.put("serial", rotateTakeMain.getSerial());
        noticeMap.put("receivewarehouse", storageWarehouseService.getWarehouseShortById(rotateTakeMain.getReceiveWarehouseId()));
        noticeMap.put("warehousecontactor", rotateTakeMain.getWarehouseContactor());
        noticeMap.put("warehousetel", rotateTakeMain.getWarehouseTel());
        noticeMap.put("enterprisetel", rotateTakeMain.getEnterpriseTel());
        noticeMap.put("creater", sysUser.getName());

        if(rotateTakeMain.getCreateDate()!=null) {
            noticeMap.put("createdate", sim.format(rotateTakeMain.getCreateDate()));
        }
        noticeMap.put("status", rotateTakeMain.getStatus());
        if(rotateTakeMain.getCompleteDate()!=null) {
            noticeMap.put("completedate", sim.format(rotateTakeMain.getCompleteDate()));
        }
        List list = new ArrayList();
        if(rotateTakeMain.getRotateTakes().size()>0){
            for(int i=0;i<rotateTakeMain.getRotateTakes().size();i++){
                Map <String,Object> map = new HashMap<>();
                map.put("id",rotateTakeMain.getRotateTakes().get(i).getId());
               // map.put("ton",rotateTakeMain.getRotateTakes().get(i).getTon());
                RotateConcluteDetail rotateConcluteDetail=rotateConcluteService.listByDealSerial(rotateTakeMain.getRotateTakes().get(i).getDealSerial());
                List<String> dealSerial=rotateConcluteService.listInDetailSerial(rotateConcluteDetail);
                StorageWarehouse storageWarehouse=storageWarehouseService.getWarehouseById(rotateConcluteDetail.getDeliveryId());
                String wareHouseCode="";
                if(storageWarehouse!=null){
                    wareHouseCode=storageWarehouse.getWarehouseCode();
                }
                if(null != dealSerial && dealSerial.size()==1){
                   map.put("dealserial",dealSerial.get(0)+"_"+wareHouseCode+"_"+rotateTakeMain.getRotateTakes().get(i).getStoreEncode());
                }else{
                    map.put("dealserial","");
                }
                map.put("storeencode",rotateTakeMain.getRotateTakes().get(i).getStoreEncode());
                map.put("variety",rotateTakeMain.getRotateTakes().get(i).getVariety());
                map.put("contract",rotateTakeMain.getRotateTakes().get(i).getContract());
                map.put("ladingbills",rotateTakeMain.getRotateTakes().get(i).getLadingBills());
                map.put("thisshipment",rotateTakeMain.getRotateTakes().get(i).getThisShipment());
                map.put("accumulatedbills",rotateTakeMain.getRotateTakes().get(i).getAccumulatedBills());
                //map.put("takeend",rotateTakeMain.getRotateTakes().get(i).getTakeEnd());
                map.put("unitprice",rotateTakeMain.getRotateTakes().get(i).getUnitPrice());
                map.put("storagemode",rotateTakeMain.getRotateTakes().get(i).getStorageMode());
                map.put("acceptanceunit",rotateTakeMain.getRotateTakes().get(i).getAcceptanceUnit());
                map.put("telephone",rotateTakeMain.getRotateTakes().get(i).getTelephone());
                map.put("acceptanceunitid",rotateTakeMain.getRotateTakes().get(i).getAcceptanceUnitId());
                map.put("mainid",rotateTakeMain.getId());
                list.add(map);
            }
        }
        noticeMap.put("ladingReceiptDetailVo",list);
        noticeMap.put("operatetype", "1");
        noticeMap.put("executeStatus", "未执行完毕");
        JSONObject json = new JSONObject();
        json.put("ladingVo", noticeMap);
        String url =host+"services/ladingReceipt/ladingSendInfo";
        String result =  HttpUtil.postJson(url, json.toString());
        //String result = "";
        return result;
    }
}
