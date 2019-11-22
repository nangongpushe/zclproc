package com.dhc.fastersoft.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.*;
import com.dhc.fastersoft.dao.store.StoreEnterpriseDao;
import com.dhc.fastersoft.entity.*;
import com.dhc.fastersoft.entity.store.StoreEnterprise;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.QualityResultService;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysRoleService;
import com.dhc.fastersoft.service.system.SysUserService;
import com.dhc.fastersoft.util.HttpUtil;
import com.dhc.fastersoft.utils.DateUtil;
import com.dhc.fastersoft.utils.*;
import org.apache.commons.lang.ArrayUtils;
import org.apache.poi.ss.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service("QualityResultService")
public class QualityResultServiceImpl implements QualityResultService {
    @Autowired
    public QualityResultMapper dao;
    @Autowired
    public QualityResultItemMapper qualityResultItemDao;
    @Autowired
    private QualityResultItemMapper qualityResultItemMapper;
    @Autowired
    public StorageStoreHouseDao sshDao;
    @Autowired
    public QualitySampleMapper qsDao;
    @Autowired
    private SysRoleService sysRoleService;
    @Autowired
    private StorageWarehouseService storeWarehouseService;
    @Autowired
    private SysUserService sysUserService;
    @Autowired
    SysDictService sysService;
    @Autowired
    private StorageWarehouseDao storageWarehouseDao;
    @Autowired
    public QualityTempletMapper qualityTempletMapper;
    @Autowired
    public QualityTempletItemMapper qualityTempletItemDao;
    @Autowired
    private StorageStoreHouseDao storageStoreHouseDao;
    @Autowired
    StoreEnterpriseDao storeEnterpriseDao;
    @Autowired
    private RotateConcluteDao rotateConcluteDao;
    @Override
    public List query(HttpServletRequest request) {
        // TODO Auto-generated method stub
        HashMap map = QueryUtil.pageHashMap(request);
        String reportUnit;
        String sampleNo;
        String variety=request.getParameter("variety");
        String creator;
        String testDate;
        String checkType;
        try {
            reportUnit = new String(URLDecoder.decode(request.getParameter("reportUnit"), "utf-8"));
            sampleNo = new String(URLDecoder.decode(request.getParameter("sampleNo"), "utf-8"));
            variety = new String(URLDecoder.decode(request.getParameter("variety"), "utf-8"));
            creator = new String(URLDecoder.decode(request.getParameter("creator"), "utf-8"));
            testDate = new String(URLDecoder.decode(request.getParameter("testDate"), "utf-8"));
            checkType = new String(URLDecoder.decode(request.getParameter("checkType"), "utf-8"));

            SysUser user = TokenManager.getToken();

            // 权限判断
            if(!StringUtils.equals("cbl",user.getOriginCode().toLowerCase())){
                StorageWarehouse storageWarehouse = storageWarehouseDao.getStorageWarehouse(user.getOriginCode().toUpperCase());
                if(storageWarehouse!=null)
                    map.put("reportUnit",storageWarehouse.getWarehouseShort());
            }else{
                map.put("reportUnit", reportUnit);
            }

                /*String company = TokenManager.getToken().getCompany();
                String nickname = TokenManager.getNickname();
				 if (!company.equals("浙江省储备粮管理有限公司")) {
					 map.put("creator", nickname);
				}*/
            map.put("variety", variety);
            map.put("sampleNo", sampleNo);
            map.put("creator", creator);
            map.put("testDate", testDate);
            map.put("checkType", checkType);

        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return dao.list(map);
    }

    @Override
    public LayPage<QualityResult> list(HttpServletRequest request) {
        // TODO Auto-generated method stub
        LayPage<QualityResult> page = new LayPage<>();
        HashMap map = QueryUtil.pageHashMap(request);

        String export = request.getParameter("export");
        String reportUnit = null;
        String acceptedUnit = null;
        String sampleNo = null;
        String mainTester = null;
        String storeEncode = null;
        String variety = null;
        String testDateStr = null;
        String warehouseType = null;
        String origin = null;
        String harvestYear = null;
        String validType = null;
        if ("all".equals(export)) {
            reportUnit = StringUtils.urlcodeToStr(request.getParameter("reportUnit"));
            acceptedUnit = StringUtils.urlcodeToStr(request.getParameter("acceptedUnit"));
            sampleNo = StringUtils.urlcodeToStr(request.getParameter("sampleNo"));
            mainTester = StringUtils.urlcodeToStr(request.getParameter("mainTester"));
            storeEncode = StringUtils.urlcodeToStr(request.getParameter("storeEncode"));
            variety = StringUtils.urlcodeToStr(request.getParameter("variety"));
            testDateStr = StringUtils.urlcodeToStr(request.getParameter("testDate"));
        } else {
            reportUnit = request.getParameter("reportUnit");
            acceptedUnit = request.getParameter("acceptedUnit");
            sampleNo = request.getParameter("sampleNo");
            mainTester = request.getParameter("mainTester");
            storeEncode = request.getParameter("storeEncode");
            variety = request.getParameter("variety");
            testDateStr = request.getParameter("testDate");
            warehouseType = request.getParameter("warehouseType");
            origin = request.getParameter("origin");
            harvestYear = request.getParameter("harvestYear");
            validType = request.getParameter("validType");

        }

        String sampleName = request.getParameter("sampleName");
        String reportSerial = request.getParameter("reportSerial");
        String templetNo = request.getParameter("templetNo");
        String isLike = request.getParameter("isLike"); // 是否进行模糊查询
        String[] testDate = new String[]{null, null};
        if (testDateStr != null && !testDateStr.isEmpty()) {
            testDate = testDateStr.split(" - ");
            map.put("testDate_s", testDate[0]);
            map.put("testDate_e", testDate[1]);
        }
        map.put("sampleName", sampleName);
        map.put("acceptedUnit",acceptedUnit);
        map.put("checkType", request.getParameter("checkType"));
        map.put("sampleNo", sampleNo);
        map.put("reportUnit", reportUnit);
        map.put("reportSerial", reportSerial);
        if (!sysRoleService.findRoleNameByUserId(TokenManager.getToken().getId()).contains("中心化验室")) {
            if (!(TokenManager.getToken().getOriginCode() != null && TokenManager.getToken().getOriginCode().equals("CBL"))) {
                if (TokenManager.getToken().getNote() != null && !TokenManager.getToken().getNote().isEmpty()) {
                    List<StorageWarehouse> wareHouseList = storeWarehouseService.listWareHouseByType(TokenManager.getToken().getCompany());
                    map.put("type", "dc");
                    map.put("company", wareHouseList);
                } else {
                    String nickname = TokenManager.getToken().getShortName();
                    String warehouseCode = TokenManager.getToken().getOriginCode().toUpperCase();
                    map.put("warehouseCode", warehouseCode);
                }
            }
        }
       /* if (mainTester!=null&&mainTester.length()>0){
            HashMap map1=new HashMap();
            map1.put("name",mainTester);
            List<SysUser> list = sysUserService.getUserIds(map1);
            String str="";
            for (int i=0;i<list.size();i++){
                if (str.length()>0){
                    str+=",'"+ list.get(i).getId()+"'";
                }else{
                    str+= "'"+list.get(i).getId()+"'";
                }

            }
            map.put("mainTester", str);
        }*/
        map.put("mainTester", mainTester);
//        map.put("creator", creator);
        map.put("templetNo", templetNo);
        map.put("storeEncode", storeEncode==null?null:storeEncode.toUpperCase());
        map.put("variety", variety);
        map.put("warehouseType", warehouseType);
        map.put("origin", origin);
        map.put("harvestYear", harvestYear);
        map.put("isLike",isLike);
//        质量档案信息中用到
        map.put("validType", validType);
        int count = dao.count(map);
        if (count <= 0) {
            return page;
        }
        List<QualityResult> data = null;
        if (StringUtils.equals("all", export)) {
            data = dao.list1(map);
        } else {
            data = dao.list(map);
        }
        for (int i = 0; i < data.size(); i++) {
            String type = data.get(i).getCheckType();
            if("2".equals(type)){
                if(data.get(i).getStoreDate()!=null) {
                    if (data.get(i).getStoreDate().length() > 0) {
                        //兼容日期字段
                        data.get(i).setStoreDate(data.get(i).getStoreDate().substring(0, data.get(i).getStoreDate().length() - 3));
                    }
                }
            }
        }
        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
        return page;
    }



    @Override
    public QualityResult getByID(String id) {
        // TODO Auto-generated method stub
        return dao.getById(id);
    }

    @Override
    public int remove(String id) {
        // TODO Auto-generated method stub
        return dao.delete(id);
    }

    @Override
    public int add(QualityResult entity) {
        // TODO Auto-generated method stub
        return dao.add(entity);
    }

    @Override
    public int update(QualityResult entity) {
        // TODO Auto-generated method stub
        return dao.update(entity);
    }

    @Override
    public List<StorageStoreHouse> getStoreEncode() {
        // TODO Auto-generated method stub
        return sshDao.getStoreEncode();
    }

    @Override
    public List<QualityResult> getResultBySampleNo(Map<String, Object> param) {
        return dao.getResultBySampleNo(param);
    }

    @Override
    public LayPage<QualityResult> selectQualityResult(HashMap<String, Object> map) {
        // TODO Auto-generated method stub
        LayPage<QualityResult> page = new LayPage<>();
        int count = dao.selectQualityResultcount(map);
        if (count <= 0) {
            return page;
        }
        List<QualityResult> data = dao.selectQualityResultlist(map);
        /*for (int i = 0; i < data.size(); i++) {
            String creatorid = data.get(i).getCreator();
            SysUser boolUser = sysUserService.selectByPrimaryKey(creatorid);
            if (boolUser != null) {
                data.get(i).setCreator(boolUser.getName());
            }
        }*/
        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("succes");
        return page;
    }

    @Override
    public List<QualityResult> exportAlllist(HttpServletRequest request) {
        HashMap map = new HashMap();

        String export = request.getParameter("export");
        String creator = request.getParameter("creator");
//
        String reportUnit = null;
        String acceptedUnit = null;
        String sampleNo = null;
        String mainTester = null;
        String storeEncode = null;
        String variety = null;
        String testDateStr = null;
        String warehouseType = null;
        String origin = null;
        String harvestYear = null;
        String checkType = null;

        reportUnit = request.getParameter("reportUnit");
        map.put("reportUnit", reportUnit);
        acceptedUnit = request.getParameter("acceptedUnit");
        map.put("acceptedUnit", acceptedUnit);
        sampleNo = request.getParameter("sampleNo");
        map.put("sampleNo", sampleNo);
        mainTester = request.getParameter("mainTester");
        map.put("mainTester", mainTester);
        storeEncode = request.getParameter("storeEncode");
        map.put("storeEncode", storeEncode);
        variety = request.getParameter("variety");
        map.put("variety", variety);
        warehouseType = request.getParameter("warehouseType");
        map.put("warehouseType", warehouseType);
        origin = request.getParameter("origin");
        map.put("origin", origin);
        harvestYear = request.getParameter("harvestYear");
        map.put("harvestYear", harvestYear);
        checkType = request.getParameter("checkType");
        map.put("checkType",checkType);
        String validType = request.getParameter("validType");
        map.put("validType",validType);
        String sampleName = request.getParameter("sampleName");
        map.put("sampleName", sampleName);
        String reportSerial = request.getParameter("reportSerial");
        map.put("reportSerial", reportSerial);
        String templetNo = request.getParameter("templetNo");
        map.put("templetNo", templetNo);
        String isLike = request.getParameter("isLike");
        map.put("isLike",isLike);
        String[] testDate = new String[]{null, null};
        testDateStr = request.getParameter("testDate");
        if (testDateStr != null && !testDateStr.isEmpty()) {
            testDate = testDateStr.split(" - ");
            map.put("testDate_s", testDate[0]);
            map.put("testDate_e", testDate[1]);
        }

        if (!sysRoleService.findRoleNameByUserId(TokenManager.getToken().getId()).contains("中心化验室")) {
            if (!(TokenManager.getToken().getOriginCode() != null && TokenManager.getToken().getOriginCode().equals("CBL"))) {
                if (TokenManager.getToken().getNote() != null && !TokenManager.getToken().getNote().isEmpty()) {
                    List<StorageWarehouse> wareHouseList = storeWarehouseService.listWareHouseByType(TokenManager.getToken().getCompany());
                    map.put("type", "dc");
                    map.put("company", wareHouseList);
                } else {
                    String nickname = TokenManager.getToken().getShortName();
                    map.put("reportUnit", nickname);
                }
            }
        }

        List<QualityResult> data = dao.exportAlllist(map);
        return data;
    }

    @Override
    public int countSampleNo(String str) {
        HashMap<String,String> map = new HashMap<String, String>();
        map.put("sampleNo", str);
        return dao.countSampleNo(map);
    }


    @Override
    public Map<String,QualityResult> queryBySampleNo(List<String> sampleNoList) {
        return dao.queryBySampleNo(sampleNoList);
    }

    @Override
    public void saveFileHistory(QualityResultFile qrf) {
        dao.saveFileHistory(qrf);
    }

    @Override
    public void saveTempResult(Map<String,Object> map) {
        dao.saveTempResult(map);
    }
    @Override
    public void updateTempQualityResult(ResultDataTemp rdt){
        dao.updateTempResult(rdt);
    }

    @Override
    public LayPage<ResultDataTemp> tempResultlist(HttpServletRequest request) {
        // TODO Auto-generated method stub
        LayPage<ResultDataTemp> page = new LayPage<>();
        Map<String,Object> map = new HashMap<String,Object>();
       // String templateNo = request.getParameter("templateNo");
        String resultFileId = request.getParameter("resultFileId");
        String status = request.getParameter("status");
        QualityResultFile qualityResultFile = dao.getResultFileById(resultFileId);
        map.put("resultFileId", resultFileId);
        map.put("status",status);//未生成正式结果的数据
        /*int count = dao.count(map);
        if (count <= 0) {
            return page;
        }*/
        List<ResultDataTemp> data = null;

        data = dao.tempResultlist(map);

        //page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
        return page;
    }

    @Override
    public ActionResultModel importResult (HttpServletRequest request){
        ActionResultModel actionResultModel = new ActionResultModel();
        String templateId = request.getParameter("templateId");

        //各种日期格式（校验扦样日期，检测开始日期，检测结束日期使用）
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat sdfd1 = new SimpleDateFormat("yyyy-M-dd");
        SimpleDateFormat sdfd2 = new SimpleDateFormat("yyyy-MM-d");
        SimpleDateFormat sdfd3 = new SimpleDateFormat("yyyy-M-d");



        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM");
        SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy");
        List<SysDict> acceptedUnit=sysService.getSysDictListByType("承检单位");
        List<SysDict> storeTypes=sysService.getSysDictListByType("粮油存储方式");
        List<String> acceptedUnitName = new ArrayList<String>();
        List<String> storyTypeName = new ArrayList<String>();
        for(int i =0;i<acceptedUnit.size();i++){
            acceptedUnitName.add(acceptedUnit.get(i).getValue());
        }
        for(int i =0;i<storeTypes.size();i++){
            storyTypeName.add(storeTypes.get(i).getValue());
        }
        //1、校验，2校验成功插入并更新临时表的状态，失败则更新临时表的备注（为何校验失败）
        int successNum = 0;
        int faultNum = 0;
        String ids = request.getParameter("ids");
        String id[]=ids.split("-");
        int totalNum = id.length;
        //根据模板id查询
        String setValidType = request.getParameter("validType");
        List<String> resultIds = null;//导入成功的质检结果id
        for (int i =0;i<id.length;i++){
            String remark = "";
            //根据id查出临时表数据
            ResultDataTemp resultDataTemp = dao.getTempResultById(id[i]);
            resultDataTemp.setValidType(setValidType);//入库、出库、库存质检
            //受检单位：即样品来源，需要判断是否存在，如果存在则再判断抽样地点：即仓号是否在对应库点
            remark = checkInspectUnit(resultDataTemp, remark);
            //判断粮食品种是否存在
            remark = checkGrainType(resultDataTemp, remark);
            //样品编号视为报告编号，如果同种质检类型（即：第三方或内部质检）报告编号重复则不能保存，给remark赋值
            Map<String ,Object> map = new HashMap<String ,Object>();
            map.put("checkType", "2" );
            map.put("reportSerial",resultDataTemp.getSampleNo());
            List<QualityResult> qualityResults = dao.getResultByReportSerial(map);
            if(qualityResults.size()>0){
                remark = remark+"[报告编号重复]";
            }
            //判断样品编号是否重复，如果重复则不能保存
            HashMap<String,String> map2 = new HashMap<String,String>();
            map2.put("sampleNo",resultDataTemp.getSampleNo());
            int countCheck = qsDao.countCheck(map2);
            if(countCheck>0){
                remark = remark+"[样品编号重复]";
            }


            String basicNumber = resultDataTemp.getBasicNumber();//抽样基数
            try{
                Double d =Double.parseDouble(basicNumber);
                if(d>0){

                }else{

                }
            }
            catch(Exception e){
                //判断抽样基数是否数字格式
                remark = remark+"[抽样基数不是数字格式或小于0]";
            }
           /* if(!StringUtils.isNumeric(basicNumber)){
                //判断抽样基数是否数字格式
                remark = remark+"[抽样基数不是数字格式]";
            }*/
            //考虑非第三方质检情况（如果是内部质检则checkType = 1）
            //storeWarehouseService.
            //1、根据检测单位全称去库点表查询
            HashMap<String,Object> fullNameConditionMap = new HashMap<String ,Object>();
            fullNameConditionMap.put("warehouseName",resultDataTemp.getAcceptedUnit());
            List<StorageWarehouse> storageWarehouses = storageWarehouseDao.listWareHouseByCondition(fullNameConditionMap);
            if(storageWarehouses != null &&storageWarehouses.size()>0){
                //如果有值，则取出
                resultDataTemp.setAcceptedUnit(storageWarehouses.get(0).getWarehouseShort());
                resultDataTemp.setAcceptedUnitId(storageWarehouses.get(0).getId());
                resultDataTemp.setCheckType("1");
            }else{
                //如果没值，则根据简称查询
                HashMap<String,Object> shortNameConditionMap = new HashMap<String ,Object>();
                shortNameConditionMap.put("warehouseShort",resultDataTemp.getAcceptedUnit());
                storageWarehouses = storageWarehouseDao.listWareHouseByCondition(shortNameConditionMap);
                if(storageWarehouses != null && storageWarehouses.size()>0){
                    //如果有值，则取出
                    resultDataTemp.setAcceptedUnit(storageWarehouses.get(0).getWarehouseShort());
                    resultDataTemp.setAcceptedUnitId(storageWarehouses.get(0).getId());
                    resultDataTemp.setCheckType("1");
                }else{
                    if(!acceptedUnitName.contains(resultDataTemp.getAcceptedUnit())){
                        remark = remark+"[承检单位名称有误]";
                    }else{
                        resultDataTemp.setCheckType("2");
                    }
                }
            }
            //上面设置checkType，主要是对历史数据生成时做的处理（历史数据中无checkType）
            String checkType = request.getParameter("checkType");
            if(StringUtils.isNotEmpty(checkType)){
                resultDataTemp.setCheckType(checkType);
            }
            String samplingDate = resultDataTemp.getSamplingDate();
            String testDate = resultDataTemp.getTestDate();
            String testEndDate = resultDataTemp.getTestEndDate();

            samplingDate =  StringUtils.replace(samplingDate,".","-");
            testDate =  StringUtils.replace(testDate,".","-");
            testEndDate =  StringUtils.replace(testEndDate,".","-");
            resultDataTemp.setTestDate(samplingDate);
            resultDataTemp.setTestDate(testDate);
            resultDataTemp.setTestEndDate(testEndDate);

            remark = checkSampleDate(resultDataTemp,samplingDate,remark,"samplingDate");
            //校验各种日期格式
            remark = checkSampleDate(resultDataTemp,testDate,remark,"testDate");
            remark = checkSampleDate(resultDataTemp,testEndDate,remark,"testEndDate");
            String inspectedUnit = resultDataTemp.getInspectedUnit();
            //受检单位根据库点简称判断
           /* String warehouseName = storageWarehouseDao.getWarehouseName(inspectedUnit);
            if(StringUtils.isEmpty(warehouseName)){
                remark = remark+"[受检单位名称有误]";
            }*/
            String storeType = resultDataTemp.getStoreType();
            if(!storyTypeName.contains(storeType)){
                remark = remark+"[储存方式有误]";
            }

            String inStoreDate = resultDataTemp.getInStoreDate();
            //过滤中文
            inStoreDate = excludeChinese(inStoreDate);
            boolean isInStoreDate = true;
            try{
                if(StringUtils.isNotEmpty(inStoreDate)) {
                    if(inStoreDate.length()==4){
                        inStoreDate = inStoreDate+"-01";
                    }
                    inStoreDate =  StringUtils.replace(inStoreDate,".","-");
                    inStoreDate = inStoreDate.substring(0, 7);//为了暂时解决Excel中自定义日期格式的问题
                }
                resultDataTemp.setInStoreDate(inStoreDate);
            }catch (Exception e){
                //避免上面截取字符串数组越界异常中出现例如2019-5的正常数据
                SimpleDateFormat sdfm = new SimpleDateFormat("yyyy-M");
                boolean isMonthFormat = DateUtil.checkDateTime(inStoreDate,sdfm);
                if (isMonthFormat) {
                    try {
                        Date date = (Date) sdfm.parse(inStoreDate);
                        inStoreDate = sdf1.format(date);
                        resultDataTemp.setSamplingDate(inStoreDate);
                    }catch (Exception e1){
                        e1.printStackTrace();
                    }
                }else {
                    remark = remark + "[入库年月格式有误]";
                    isInStoreDate = false;
                }
            }
            if(isInStoreDate) {
                boolean isMonthFormat = DateUtil.checkDateTime(inStoreDate, sdf1);
                if (!isMonthFormat) {
                    remark = remark + "[入库年月格式有误]";
                }
            }
            String harvestYear = resultDataTemp.getHarvestYear();

            if(null != harvestYear && harvestYear.length()>=4) {
                harvestYear = harvestYear.substring(0, 4);//过滤掉比如1990年这种格式
                boolean isYearFormat = DateUtil.checkDateTime(harvestYear,sdf2);
                if(!isYearFormat){
                    remark = remark+"[收获年份格式有误]";
                }else{
                    resultDataTemp.setHarvestYear(harvestYear);
                }
            }else{
                remark = remark+"[收获年份格式有误]";
            }

            //如果校验无误则保存到正式的三个表中并更新临时表状态，如果有误则更新临时表remark

            if(StringUtil.isEmpty(remark)){

                //1、保存样品表
                saveSample(resultDataTemp);
                //2、保存结果主表和字表
                String resultId = saveResult(resultDataTemp,templateId);
                //3、保存结果字表
                //saveResultItem(resultDataTemp,templateId);
                //更新临时表状态
                resultDataTemp.setRemark("");
                updateTempResult(resultDataTemp);
                successNum = ++successNum;
                resultIds = new ArrayList<String>();
                resultIds.add(resultId);

            }else{
                //校验有误
                //1.更新临时表（remark）
                ResultDataTemp rdt = new ResultDataTemp();
                rdt.setStatus("0");//导入失败/首次上传状态
                rdt.setId(resultDataTemp.getId());
                rdt.setRemark(remark);
                dao.updateTempResult(rdt);
                faultNum = ++faultNum;
            }
        }
        actionResultModel.setData(resultIds);
        actionResultModel.setMsg("共:"+totalNum+"个,其中成功:"+successNum+"个,失败:"+faultNum+"个");
        return actionResultModel;
    }
    //保存样品数据
    public void saveSample(ResultDataTemp resultDataTemp) {
        QualitySample qualitySample = new QualitySample();
        //id在sql中用序列自动生成
        /*成交明细号，扦样日期，任务执行人,扦样人*/
        qualitySample.setSamplingPeople(resultDataTemp.getSamplingPeople());
        qualitySample.setSamplingDate(resultDataTemp.getSamplingDate());
        qualitySample.setSampleNo(resultDataTemp.getSampleNo());//样品编号
        qualitySample.setQuantity(resultDataTemp.getBasicNumber());//数量
        qualitySample.setSampleSouce(resultDataTemp.getInspectedUnit());//样品来源即：受检单位
        //样品来源id在校验受检单位时set了
        qualitySample.setWarehouseId(resultDataTemp.getWarehouseId());
        qualitySample.setStorehouse(resultDataTemp.getSamplePlace());//仓号，即：抽样地点
        qualitySample.setVariety(resultDataTemp.getSampleName());//粮食品种,即：样品名称
        qualitySample.setVarietyType(resultDataTemp.getVarietyType());//粮or油
        //qualitySample.setValidType("入库质检"); //检验类型
        qualitySample.setValidType(resultDataTemp.getValidType());
        qualitySample.setHarvestYear(resultDataTemp.getHarvestYear());//收获年份
        qualitySample.setOrigin(resultDataTemp.getOrigin());//产地
        qualitySample.setTestDate(resultDataTemp.getTestDate());
        qualitySample.setTestEndDate(resultDataTemp.getTestEndDate());

        qualitySample.setInStoreYear(resultDataTemp.getInStoreDate());
        //todo
        //样品储备性质要吗？
        qualitySample.setStoreNature("省级储备");
        qualitySample.setStoreType(resultDataTemp.getStoreType());  //储存方式

        //样品封存时间：模板需要吗？
        String testEndDate = resultDataTemp.getTestEndDate();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date dt = null;
        try {
             dt = sdf.parse(testEndDate);
        }catch (Exception e){

        }
        if(null != dt) {
            Calendar rightNow = Calendar.getInstance();
            rightNow.setTime(dt);
            rightNow.add(Calendar.MONTH, 3);
        /*String storeTime = sdf.format(rightNow.getTime());//封存时间
        Date date = sdf.parse(storeTime);*/
            Date storeTime = rightNow.getTime();
            qualitySample.setStoreTime(storeTime);//封存时间
        }
        qualitySample.setTestStatus("未检");
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        String date=df.format(new Date());
        qualitySample.setCreateDate(date);//创建时间
        String checkType = resultDataTemp.getCheckType();
        qualitySample.setCheckType(Integer.parseInt(checkType));//第三方质检还是内部质检
        SimpleDateFormat tempDate = new SimpleDateFormat("yyyy-MM-dd");
        String importDate = tempDate.format(new java.util.Date());
        qualitySample.setRemark(importDate+"导入的");
        //set入成交子明细号
        setDealSerial(qualitySample);
        qsDao.insert(qualitySample);
    }

    //保存结果主表
    public String saveResult(ResultDataTemp resultDataTemp,String templateId){
        QualityResult qualityResult = new QualityResult();
        String resultId = UUID.randomUUID().toString().replace("-", "");
        qualityResult.setId(resultId);
        qualityResult.setAcceptedUnit(resultDataTemp.getAcceptedUnit());
        qualityResult.setAcceptedUnitId(resultDataTemp.getAcceptedUnitId());
        qualityResult.setSampleNo(resultDataTemp.getSampleNo());
        qualityResult.setVariety(resultDataTemp.getSampleName());
        //判断是粮还是油，在校验时已经判断
        qualityResult.setVarietyType(resultDataTemp.getVarietyType());
        qualityResult.setReportUnit(resultDataTemp.getInspectedUnit());//受检单位
        //校验时set了
        qualityResult.setWarehouseId(resultDataTemp.getWarehouseId());//受检单位id

        //储备性质，
        qualityResult.setStoreNature("省级储备");

        //第三方质检有检验类型，无主检人
        //qualityResult.setValidType("入库质检");
        qualityResult.setValidType(resultDataTemp.getValidType());
        qualityResult.setTestDate(resultDataTemp.getTestDate());
        qualityResult.setTestEndDate(resultDataTemp.getTestEndDate());
        qualityResult.setQuantity(resultDataTemp.getBasicNumber());
        qualityResult.setProGrade(resultDataTemp.getGrade());
        qualityResult.setStoreType(resultDataTemp.getStoreType());
        qualityResult.setStoreEncode(resultDataTemp.getSamplePlace());//抽样地点即：仓号
        qualityResult.setOrigin(resultDataTemp.getOrigin());
        qualityResult.setStoreDate(resultDataTemp.getInStoreDate()+"01");//入库年月
        qualityResult.setHarvestYear(resultDataTemp.getHarvestYear());
        qualityResult.setTempletNo(resultDataTemp.getTemplateNo());


        //判断第三方还是内部质检
        qualityResult.setCheckType(resultDataTemp.getCheckType());//第三方还是内部质检
        qualityResult.setReportSerial(resultDataTemp.getSampleNo());
        qualityResult.setRemark(resultDataTemp.getQualityJudge());
        qualityResult.setStoreJudge(resultDataTemp.getStoreJudge());
        qualityResult.setHygieneJudge(resultDataTemp.getHygieneJudge());
        SimpleDateFormat tempDate = new SimpleDateFormat("MM-dd");
        String importDate = tempDate.format(new java.util.Date());
        qualityResult.setReportType(importDate+"导入");//只是为了区分是才导入的数据
        qualityResult.setStatus("待提交");
        dao.add(qualityResult);
        //保存结果子项
        saveResultItem(resultDataTemp,templateId,resultId);
        return resultId;
    }


    //保存结果子表
    public void saveResultItem(ResultDataTemp resultDataTemp,String templateId,String resultId){
        String id = templateId;
        List<QualityTempletItem> qualityTempletItem = qualityTempletItemDao.getById(id);
        for(int i = 0;i<qualityTempletItem.size();i++){
            QualityTempletItem  templetItem = qualityTempletItem.get(i);
            QualityResultItem qualityResultItem = new QualityResultItem();
            String itemId = UUID.randomUUID().toString().replace("-", "");
            qualityResultItem.setId(itemId);
            qualityResultItem.setResultId(resultId);
            qualityResultItem.setItemName(templetItem.getItemName());//检测项
            qualityResultItem.setGrade(templetItem.getGrade());
            qualityResultItem.setStandard(templetItem.getStandard());
            //利用反射根据属性名称获取属性值
            String result = getFieldValueByFieldName("column"+(i+1),resultDataTemp);
            qualityResultItem.setResult(result);
            qualityResultItem.setRemark(StringUtils.equals(result, "/")? "/" : "合格");
            qualityResultItem.setOrderNo(new BigDecimal(i));
            //保存字表
            qualityResultItemMapper.add(qualityResultItem);
        }
    }

    public void updateTempResult(ResultDataTemp resultDataTemp){
        ResultDataTemp rdt = new ResultDataTemp();
        rdt.setStatus("1");//导入成功
        rdt.setId(resultDataTemp.getId());
        dao.updateTempResult(rdt);
    }
    //检验受检单位是否存在，如果存在则校验仓号是否在该受检单位
    public String checkInspectUnit(ResultDataTemp resultDataTemp , String remark){
        String inspectedUnit = resultDataTemp.getInspectedUnit();
        String samplePlace = resultDataTemp.getSamplePlace();
        String str = "";
        //1、根据inspectedUnit去库点表根据简称字段查询，如果能查到，则不用更新ResultDataTemp,如果查不到则根据库点全称查询，
        //如果能查到，则把库点简称更新到ResultDataTemp，如果查不到，则去公司表查询，如果在公司表可以查到则去把抽样地点仓号前面的内容
        //截取出来，然后用截取出来的内容去库点表根据简称字段或全称查询，如果能查到，则更新ResultDataTemp，如果查不到，则用给remark赋值
        //
        StorageWarehouse storageWarehouse = storageWarehouseDao.findConnectorByShortName(inspectedUnit);
        if(null != storageWarehouse){
            //如果能查到，则不用更新ResultDataTemp
            resultDataTemp.setWarehouseId(storageWarehouse.getId());
        }else{
            //如果根据简称查不到，则根据全称查
            HashMap<String,Object> map = new HashMap<String ,Object>();
            map.put("warehouseName",inspectedUnit);
            List<StorageWarehouse> storageWarehouses = storageWarehouseDao.listWareHouseByCondition(map);
            if(null != storageWarehouses && storageWarehouses.size()>0){
                //如果根据全称可以查到
                resultDataTemp.setInspectedUnit(storageWarehouses.get(0).getWarehouseShort());
                resultDataTemp.setWarehouseId(storageWarehouses.get(0).getId());
            }else {
                //如果根据库点全称查不到，则去公司表根据公司全称查询
                StoreEnterprise StoreEnterprise = storeEnterpriseDao.getStoreEnterpriseByEnterpriseName(inspectedUnit);
                if(null != StoreEnterprise){
                    //如果查到公司，截取仓号前面的内容（即：有可能为对应公司下的库点）
                    Matcher matcher = Pattern.compile("[A-Za-z0-9]").matcher(samplePlace);
                    if(matcher.find()) {
                        int endIndex = matcher.start();
                        String warehouseName = samplePlace.substring(0,endIndex);
                        map = new HashMap<String, Object>();
                        map.put("enterpriseId",StoreEnterprise.getId());
                        map.put("warehouseName",warehouseName);
                        storageWarehouses = storageWarehouseDao.getWarehouseByCondition(map);
                        if(null != storageWarehouses && storageWarehouses.size()>0){
                            //如果根据公司id和库点名称可以查到则
                            resultDataTemp.setInspectedUnit(storageWarehouses.get(0).getWarehouseShort());
                            resultDataTemp.setWarehouseId(storageWarehouses.get(0).getId());
                        }else{
                            //如果查不到则给remark赋值
                            str = str+"[库点简称有误]";
                        }
                    } else {

                    }
                }else{
                    //公司表也没有查到
                    str = str+"[库点简称有误]";
                }
            }
        }
        if(StringUtil.isEmpty(str)){
            HashMap<String,String> map = new HashMap<String,String>();
            //samplePlace = samplePlace.replaceAll("[^a-z^A-Z^0-9]", "");
            map.put("warehouseId",resultDataTemp.getWarehouseId());
            map.put("encode",samplePlace);
            int count = storageStoreHouseDao.count1(map);
            int countOil = storageStoreHouseDao.countOil(map);
            if(0==count&& 0==countOil){
                str = str+"[抽样地点有误]";
            }else{
                resultDataTemp.setSamplePlace(samplePlace);
            }
        }
        remark = remark +str;
        return remark;
    }
    //判断粮食品种是否存在
    public String checkGrainType(ResultDataTemp resultDataTemp,String remark){
        List<SysDict> varietyList = sysService.getSysDictListByType("粮油品种");
        List<String> varietyNames = new ArrayList<String>();
        for(int i =0 ;i < varietyList.size();i++){
            varietyNames.add(varietyList.get(i).getValue());
        }
        if(!varietyNames.contains(resultDataTemp.getSampleName())){
            remark = remark+"[样品名称有误]";
        }
        //判断粮油
        if(resultDataTemp.getSampleName().indexOf('油')!=-1){
            resultDataTemp.setVarietyType("油");
        }else{
            resultDataTemp.setVarietyType("粮");
        }
        return remark;
    }

    /**
     * 根据属性名获取属性值
     *
     * @param fieldName
     * @param object
     * @return
     */
    private String getFieldValueByFieldName(String fieldName, Object object) {
        try {
            Field field = object.getClass().getDeclaredField(fieldName);
            //设置对象的访问权限，保证对private的属性的访问
            field.setAccessible(true);
            return  (String)field.get(object);
        } catch (Exception e) {

            return null;
        }
    }
    @Override
    public ResultDataTemp getTempResultByID(String id){

        return dao.getTempResultById(id);
    }
    @Override
    public  QualityResultFile getResultFileById(String id){
        return  dao.getResultFileById(id);
    }
    @Override
    public LayPage<QualityResultFile> resultFileList(HttpServletRequest request){
        // TODO Auto-generated method stub
        LayPage<QualityResultFile> page = new LayPage<>();
        HashMap map = QueryUtil.pageHashMap(request);
        String templateNo = request.getParameter("templateNo");
        map.put("templateNo", templateNo);
        int count = dao.resultFileCount(map);
        if (count <= 0) {
            return page;
        }
        List<QualityResultFile> data = dao.resultFileList(map);
        page.setCount(count);
        page.setData(data);
        page.setCode(0);
        page.setMsg("");
        return page;
    }

    @Override
    public int delImportData(List<String> ids) {
        return dao.delImportData(ids);
    }

    @Override
    public int countImportData(Map<String, Object> params) {
        return dao.countImportData(params);
    }

    @Override
    public int delImportFile(String id) {
        return dao.delImportFile(id);
    }
    @Override
    public  LayEntity addResultfileAndTempResult(MultipartFile file, HttpServletRequest request){
        //第三方质检表头
        String[] excelMainHeader = {"样品编号", "样品名称","受检单位","库点简称", "产品等级","抽样基数(吨)","储存方式","抽样地点","粮食产地","入库年月","收获年份","承检单位","检验开始日期","检验结束日期","质量指标判定","储存品质指标判定","卫生指标判定"};
        //内部质检表头
        String[] excelInnerMainHeader = {"样品编号", "样品名称","受检单位","库点简称", "产品等级","抽样基数(吨)","储存方式","抽样地点","粮食产地","入库年月","收获年份","承检单位","扦样人","扦样日期","检验开始日期","检验结束日期","质量指标判定","储存品质指标判定","卫生指标判定"};
        String templateId = request.getParameter("templateId");
        String templateName = request.getParameter("templateName");
        String templateNo = request.getParameter("templateNo");
        String checkType = request.getParameter("checkType");
        if("1".equals(checkType)){
            excelMainHeader = excelInnerMainHeader;
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        LayEntity layFileEntity = new LayEntity();
        if(org.apache.commons.lang.StringUtils.isEmpty(templateId)){
            //如果没有选择模板，则不能上传
            layFileEntity.setCode(1);
            layFileEntity.setMsg("请选择模板！");
            return layFileEntity;
        }
        if(org.apache.commons.lang.StringUtils.isEmpty(checkType)){
            //如果没有选择质检类型，则不能上传
            layFileEntity.setCode(1);
            layFileEntity.setMsg("请选择质检类型！");
            return layFileEntity;
        }


        List<QualityTempletItem> qualityTempletItem = qualityTempletItemDao.getById(templateId);
        try {
            InputStream is = file.getInputStream();
            Workbook wb = WorkbookFactory.create(is);
            Sheet sheet = wb.getSheetAt(0);
            //模板检测项的个数
            int itemNum = qualityTempletItem.size();
            //获得总表头列数
            int cellsOfSheet=sheet.getRow(0).getPhysicalNumberOfCells();
            //获取表头列，校验传入的列表表头动态列是否和传入检测项对应
            Row row0 = sheet.getRow(0);
            //动态列开始索引：即固定列最后一个索引也就是固定列的个数
            int index = excelMainHeader.length;
            for(int i=index;i<cellsOfSheet;i++){
                Cell cell = row0.getCell(i);
                String cellValue = cell.getStringCellValue();
                String itemName =null;
                try {
                    //有可能下标越界
                    itemName = qualityTempletItem.get(i - index).getItemName();//检测项
                }catch (Exception e){
                    layFileEntity.setCode(1);
                    layFileEntity.setMsg("上传的数据和选择的质检模板不能对应");
                    e.printStackTrace();
                }
                //判断动态表头和检测项是否对应，如果不能对应则说明上传的数据或选择的质检模板有误
                if(!cellValue.equals(itemName)){
                    layFileEntity.setCode(1);
                    layFileEntity.setMsg("上传的数据和选择的质检模板不能对应");
                    return layFileEntity;
                }
            }
            //保存文件
            String resultFileId = uploadFile(request,  file, templateName,checkType);
            // 获取当前Sheet的总行数
            int rowsOfSheet = sheet.getPhysicalNumberOfRows();

            for (int r = 1; r < rowsOfSheet; r++) {
                //当前行
                Row row = sheet.getRow(r);
                String id = UUID.randomUUID().toString().replace("-", "");
                Map<String,Object> map = new HashMap<String,Object>();
                List<String> list = new ArrayList<String>();
                map.put("id",id);
                map.put("resultFileId",resultFileId);
                map.put("templateId",templateId);
                map.put("templateNo",templateNo);
                if (row == null) {
                    continue;
                }else{
                    int templateLength = qualityTempletItem.size();//模板的表头长度
                    //int mainLength = cellsOfSheet-templateLength;//主表列长
                    int mainLength = excelMainHeader.length;//主表列长
                    int numberOfCells = row.getPhysicalNumberOfCells();//当前行的列数
                    for (int c = 0; c < cellsOfSheet; c++) {
                        Cell cell = row.getCell(c);
                        if(c<mainLength){
                            //如果是主表：主表表头顺序固定
                            String stringCellValue = "";
                            if (cell == null) {
                                if(0==c){
                                    map.put("sampleNo",stringCellValue);
                                }else if(1==c){
                                    map.put("sampleName",stringCellValue);
                                }else if(2==c){
                                    map.put("enterpriseName",stringCellValue);
                                }else if(3==c){
                                    map.put("inspectedUnit",stringCellValue);
                                }

                                else if(4==c){
                                    map.put("grade",stringCellValue);
                                }else if(5==c){
                                    map.put("basicNumber",stringCellValue);
                                }else if(6==c){
                                    map.put("storeType",stringCellValue);
                                }else if(7==c){
                                    map.put("samplePlace",stringCellValue);
                                }else if(8==c){
                                    map.put("origin",stringCellValue);
                                }else if(9==c){
                                    map.put("inStoreDate",stringCellValue);
                                }else if(10==c){
                                    map.put("harvestYear",stringCellValue);
                                }else if(11==c){
                                    map.put("acceptedUnit",stringCellValue);
                                }
                                else if(12==c){
                                    if("1".equals(checkType)){
                                        map.put("samplingPeople",stringCellValue);
                                    }
                                    map.put("testDate",stringCellValue);
                                }else if(13==c){
                                    if("1".equals(checkType)){
                                        map.put("samplingDate",stringCellValue);
                                    }
                                    map.put("testEndDate",stringCellValue);
                                }else if(14==c){
                                    if("1".equals(checkType)){
                                        map.put("testDate",stringCellValue);
                                    }
                                    map.put("qualityJudge",stringCellValue);
                                }else if(15==c){
                                    if("1".equals(checkType)){
                                        map.put("testEndDate",stringCellValue);
                                    }
                                    map.put("storeJudge",stringCellValue);
                                }else if(16==c){
                                    if("1".equals(checkType)){
                                        map.put("qualityJudge",stringCellValue);
                                    }
                                    map.put("hygieneJudge",stringCellValue);
                                }
                                if("1".equals(checkType)){
                                    if(17==c){
                                        map.put("storeJudge",stringCellValue);
                                    }else if(18==c){
                                        map.put("hygieneJudge",stringCellValue);
                                    }
                                }


                                continue;
                            }else{
                                int cellType = cell.getCellType();
                                switch (cellType) {
                                    case Cell.CELL_TYPE_STRING: // 代表文本
                                        stringCellValue = cell.getStringCellValue();
                                        break;
                                    case Cell.CELL_TYPE_BLANK: // 空白格
                                        stringCellValue = cell.getStringCellValue();
                                        break;
                                    case Cell.CELL_TYPE_BOOLEAN: // 布尔型
                                        boolean booleanCellValue = cell.getBooleanCellValue();
                                        stringCellValue = booleanCellValue+"";
                                        break;
                                    case Cell.CELL_TYPE_NUMERIC: // 数字||日期
                                        int a = cell.getCellStyle().getDataFormat();
                                        boolean cellDateFormatted = org.apache.poi.ss.usermodel.DateUtil.isCellDateFormatted(cell);
                                        if (cellDateFormatted) {
                                            Date dateCellValue = cell.getDateCellValue();
                                            stringCellValue = sdf.format(dateCellValue);

                                        } else {
                                            double numericCellValue = cell.getNumericCellValue();
                                            //处理数字后加.0的情况
                                            NumberFormat nf = NumberFormat.getInstance();
                                            stringCellValue = nf.format(numericCellValue);
                                            //stringCellValue = String.valueOf(numericCellValue);
                                            //但如果是科学计数法的数字就转换成了带逗号的，例如：12345678912345的科学计数法是1.23457E+13，经过这个格式化后就变成了字符串“12,345,678,912,345”，这也并不是想要的结果，所以要将逗号去掉
                                            if (stringCellValue.indexOf(",") >= 0) {
                                                stringCellValue = stringCellValue.replace(",", "");
                                            }
                                        }
                                        break;
                                    case Cell.CELL_TYPE_ERROR: // 错误
                                        byte errorCellValue = cell.getErrorCellValue();
                                        System.out.print(errorCellValue + "\t");
                                        break;
                                    case Cell.CELL_TYPE_FORMULA: // 公式
                                        int cachedFormulaResultType = cell.getCachedFormulaResultType();
                                        System.out.print(cachedFormulaResultType + "\t");
                                        break;
                                }

                                if(0==c){
                                    map.put("sampleNo",stringCellValue);
                                }else if(1==c){
                                    map.put("sampleName",stringCellValue);
                                }else if(2==c){
                                    map.put("enterpriseName",stringCellValue);
                                } else if(3==c){
                                    map.put("inspectedUnit",stringCellValue);
                                }
                                else if(4==c){
                                    map.put("grade",stringCellValue);
                                }else if(5==c){
                                    map.put("basicNumber",stringCellValue);
                                }else if(6==c){
                                    map.put("storeType",stringCellValue);
                                }else if(7==c){
                                    map.put("samplePlace",stringCellValue);
                                }else if(8==c){
                                    map.put("origin",stringCellValue);
                                }else if(9==c){
                                    map.put("inStoreDate",stringCellValue);
                                }else if(10==c){
                                    map.put("harvestYear",stringCellValue);
                                }else if(11==c){
                                    map.put("acceptedUnit",stringCellValue);
                                }else if(12==c){
                                    if("1".equals(checkType)){
                                        map.put("samplingPeople",stringCellValue);
                                    }
                                    map.put("testDate",stringCellValue);
                                }else if(13==c){
                                    if("1".equals(checkType)){
                                        map.put("samplingDate",stringCellValue);
                                    }
                                    map.put("testEndDate",stringCellValue);
                                }else if(14==c){
                                    if("1".equals(checkType)){
                                        map.put("testDate",stringCellValue);
                                    }
                                    map.put("qualityJudge",stringCellValue);
                                }else if(15==c){
                                    if("1".equals(checkType)){
                                        map.put("testEndDate",stringCellValue);
                                    }
                                    map.put("storeJudge",stringCellValue);
                                }else if(16==c){
                                    if("1".equals(checkType)){
                                        map.put("qualityJudge",stringCellValue);
                                    }
                                    map.put("hygieneJudge",stringCellValue);
                                }
                                if("1".equals(checkType)){
                                    if(17==c){
                                        map.put("storeJudge",stringCellValue);
                                    }else if(18==c){
                                        map.put("hygieneJudge",stringCellValue);
                                    }
                                }
                            }
                        }else{
                            //检验结果子表
                            String stringCellValue = "";
                            if (cell == null) {
                                list.add(stringCellValue);
                                continue;
                            }else{

                                int cellType = cell.getCellType();
                                switch (cellType) {
                                    case Cell.CELL_TYPE_STRING: // 代表文本
                                        stringCellValue = cell.getStringCellValue();
                                        break;
                                    case Cell.CELL_TYPE_BLANK: // 空白格
                                        stringCellValue = cell.getStringCellValue();
                                        break;
                                    case Cell.CELL_TYPE_BOOLEAN: // 布尔型
                                        boolean booleanCellValue = cell.getBooleanCellValue();
                                        stringCellValue = booleanCellValue+"";
                                        break;
                                    case Cell.CELL_TYPE_NUMERIC: // 数字||日期
                                        boolean cellDateFormatted = org.apache.poi.ss.usermodel.DateUtil.isCellDateFormatted(cell);
                                        if (cellDateFormatted) {
                                            Date dateCellValue = cell.getDateCellValue();
                                            stringCellValue = sdf.format(dateCellValue);
                                        } else {
                                            double numericCellValue = cell.getNumericCellValue();
                                            //处理数字后加.0的情况
                                            NumberFormat nf = NumberFormat.getInstance();
                                            stringCellValue = nf.format(numericCellValue);
                                            //stringCellValue = String.valueOf(numericCellValue);
                                            //但如果是科学计数法的数字就转换成了带逗号的，例如：12345678912345的科学计数法是1.23457E+13，经过这个格式化后就变成了字符串“12,345,678,912,345”，这也并不是想要的结果，所以要将逗号去掉
                                            if (stringCellValue.indexOf(",") >= 0) {
                                                stringCellValue = stringCellValue.replace(",", "");
                                            }
                                        }
                                        break;
                                    case Cell.CELL_TYPE_ERROR: // 错误
                                        byte errorCellValue = cell.getErrorCellValue();
                                        System.out.print(errorCellValue + "\t");
                                        break;
                                    case Cell.CELL_TYPE_FORMULA: // 公式
                                        int cachedFormulaResultType = cell.getCachedFormulaResultType();
                                        System.out.print(cachedFormulaResultType + "\t");
                                        break;
                                }

                            }
                            list.add(stringCellValue);
                        }

                    }
                }
                map.put("columns",list);
                if(!StringUtil.isEmpty((String)map.get("sampleNo"))) {
                    dao.saveTempResult(map);
                }
            }
            layFileEntity.setCode(0);
            layFileEntity.setMsg("上传成功");
        }catch (Exception e) {
            layFileEntity.setCode(1);
            layFileEntity.setMsg("上传失败");
            e.printStackTrace();
        }

        return layFileEntity;
    }
    //去掉字符串中的中文
    public String excludeChinese(String str) {
        // 去除中文
        String REGEX_CHINESE = "[\u4e00-\u9fa5]";// 中文正则
        Pattern pat = Pattern.compile(REGEX_CHINESE);
        Matcher mat = pat.matcher(str);
        return mat.replaceAll("");
    }

    public String uploadFile(HttpServletRequest request,MultipartFile file, String folderName,String checkType){
        String id = null;
        QualityResultFile qrf = null;
        String userId = TokenManager.getSysUserId();
        if("".equals(file)){
            System.err.println("文件为空！");
            return null;
        }
        StringBuilder filePath = new StringBuilder();
        filePath.append(request.getSession().getServletContext().getRealPath("/")).append("uploadFiles/").append(folderName).append("/");
        String templateNo = request.getParameter("templateNo");
        String templateId = request.getParameter("templateId");
        FileUtil.isExist(filePath.toString());		//路径不存在，创建路径
//获取文件名称
        String fileName = file.getOriginalFilename();
        String prefix=fileName.substring(fileName.lastIndexOf(".")+1);//获取文件后缀
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        String reName=df.format(new Date())+"."+prefix;
        filePath.append(reName);
        try {
            //保存文件
            file.transferTo(new File(filePath.toString()));
            //保存文件歷史
            id = UUID.randomUUID().toString().replace("-", "");
            qrf = new QualityResultFile();
            qrf.setId(id);
            qrf.setFileName(fileName);
            qrf.setFileType(prefix);
            Long size =(file.getSize()/1024);
            qrf.setFileSize(size);
            qrf.setCreator(userId);
            qrf.setCreateDate(new Date());
            qrf.setFileRename(reName);
            qrf.setPhysicalPath(filePath.toString());		//物理路径
            qrf.setDownloadUrl("/uploadFiles/"+folderName+"/"+reName);
            qrf.setTemplateNo(templateNo);
            qrf.setTemplateId(templateId);
            qrf.setCheckType(checkType);
            dao.saveFileHistory(qrf);
        }catch (IllegalStateException e) {
            e.printStackTrace();
            return null;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }

        return id ;
    }

    protected String checkSampleDate(ResultDataTemp resultDataTemp, String sampleingDate, String remark, String field) {
        //各种日期格式（校验扦样日期，检测开始日期，检测结束日期使用）
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat sdfd1 = new SimpleDateFormat("yyyy-M-dd");
        SimpleDateFormat sdfd2 = new SimpleDateFormat("yyyy-MM-d");
        SimpleDateFormat sdfd3 = new SimpleDateFormat("yyyy-M-d");

        //校验各种日期格式
        boolean isDateFormat = DateUtil.checkDateTime(sampleingDate, sdf);
        boolean isDateFormat1 = DateUtil.checkDateTime(sampleingDate, sdfd1);
        boolean isDateFormat2 = DateUtil.checkDateTime(sampleingDate, sdfd2);
        boolean isDateFormat3 = DateUtil.checkDateTime(sampleingDate, sdfd3);
        try {
            if (isDateFormat1) {
                Date date = (Date) sdfd1.parse(sampleingDate);
                sampleingDate = sdf.format(date);
            } else if (isDateFormat2) {
                Date date = (Date) sdfd2.parse(sampleingDate);
                sampleingDate = sdf.format(date);
            } else if (isDateFormat3) {
                Date date = sdfd3.parse(sampleingDate);
                sampleingDate = sdf.format(date);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (StringUtil.isEmpty(sampleingDate)) {
            isDateFormat = true;
        }
        if (!isDateFormat && !isDateFormat1 && !isDateFormat2 && !isDateFormat3) {
            if ("samplingDate".equals(field)) {
                remark = remark + "[扦样日期格式有误]";
            } else if ("testDate".equals(field)) {
                remark = remark + "[检测开始日期格式有误]";
            } else if ("testEndDate".equals(field)) {
                remark = remark + "[检测结束日期格式有误]";
            }
        } else {
            if ("samplingDate".equals(field)) {
                resultDataTemp.setSamplingDate(sampleingDate);
            } else if ("testDate".equals(field)) {
                resultDataTemp.setTestDate(sampleingDate);
            } else if ("testEndDate".equals(field)) {
                resultDataTemp.setTestEndDate(sampleingDate);
            }
        }
        return remark;
    }


    @Override
    public void sendMessage(String resultId, String operateType) throws Exception {
        QualityResult qualityResult = dao.getById(resultId);

        if(!StringUtils.equals(qualityResult.getReportUnit(), "中穗库")){
            return;
        }

        List<QualityResultItem> qualityResultItemList = qualityResultItemDao.getById(resultId);
        Map<String, Object> dataMap = new HashMap<>();
        dataMap.put("graindepot","ZHS");
        dataMap.put("businessid", resultId);
        dataMap.put("zjlx",qualityResult.getValidType());
        dataMap.put("granarycode", qualityResult.getStoreEncode());  // 仓房编号
        dataMap.put("graincode", qualityResult.getVariety());   // 粮食品种
        dataMap.put("inspetiontime", qualityResult.getTestDate());  // 质检年月 yyyy-mm
        dataMap.put("tester", qualityResult.getMainTester());   // 主检人
        dataMap.put("operatetype", operateType);    // 硬编码了 操作类型，1：新增、2：修改、3：删除


        for (QualityResultItem qualityResultItem : qualityResultItemList) {
            if (StringUtils.indexOf(qualityResultItem.getItemName(), "杂质") != -1) {
                dataMap.put("impurity", qualityResultItem.getResult());
            } else if (StringUtils.indexOf(qualityResultItem.getItemName(), "水分") != -1) {
                dataMap.put("water", qualityResultItem.getResult());
            } else {
                if (StringUtils.indexOf(qualityResult.getVariety(), "小麦") != -1) {
                    if (StringUtils.indexOf(qualityResultItem.getItemName(), "容重") != -1) {
                        dataMap.put("rz", qualityResultItem.getResult());
                    } else if (StringUtils.indexOf(qualityResultItem.getItemName(), "不完善") != -1) {
                        dataMap.put("bwsl", qualityResultItem.getResult());
                    } else if (StringUtils.indexOf(qualityResultItem.getItemName(), "矿物质") != -1) {
                        dataMap.put("面筋吸水量", qualityResultItem.getResult());
                    }
                } else if (StringUtils.indexOf(qualityResult.getVariety(), "早籼稻谷") != -1 || StringUtils.indexOf(qualityResult.getVariety(), "晚粳稻") != -1) {
                    if (StringUtils.indexOf(qualityResultItem.getItemName(), "出糙率") != -1) {
                        dataMap.put("ccl", qualityResultItem.getResult());
                    } else if (StringUtils.indexOf(qualityResultItem.getItemName(), "整精米率") != -1) {
                        dataMap.put("zjml", qualityResultItem.getResult());
                    } else if (StringUtils.indexOf(qualityResultItem.getItemName(), "谷外糙米") != -1) {
                        dataMap.put("gwcm", qualityResultItem.getResult());
                    } else if (StringUtils.indexOf(qualityResultItem.getItemName(), "脂肪酸值") != -1) {
                        dataMap.put("zfsz", qualityResultItem.getResult());
                    }
                } else if (StringUtils.indexOf(qualityResult.getVariety(), "玉米") != -1) {
                    if (StringUtils.indexOf(qualityResultItem.getItemName(), "脂肪酸值") != -1) {
                        dataMap.put("zfsz", qualityResultItem.getResult());
                    } else if (StringUtils.indexOf(qualityResultItem.getItemName(), "容量") != -1) {
                        dataMap.put("rl", qualityResultItem.getResult());
                    } else if (StringUtils.indexOf(qualityResultItem.getItemName(), "不完善粒总量") != -1) {
                        dataMap.put("bwslzl", qualityResultItem.getResult());
                    } else if (StringUtils.indexOf(qualityResultItem.getItemName(), "霉变粒") != -1) {
                        dataMap.put("mbl", qualityResultItem.getResult());
                    }
                } else if (StringUtils.indexOf(qualityResult.getVariety(), "大豆") != -1) {
                    if (StringUtils.indexOf(qualityResultItem.getItemName(), "完整粒率") != -1) {
                        dataMap.put("wzll", qualityResultItem.getResult());
                    } else if (StringUtils.indexOf(qualityResultItem.getItemName(), "损伤粒率") != -1) {
                        dataMap.put("ssll", qualityResultItem.getResult());
                    } else if (StringUtils.indexOf(qualityResultItem.getItemName(), "粗脂肪含量") != -1) {
                        dataMap.put("czfhl", qualityResultItem.getResult());
                    } else if (StringUtils.indexOf(qualityResultItem.getItemName(), "粗蛋白含量") != -1) {
                        dataMap.put("cdbhl", qualityResultItem.getResult());
                    }
                }
            }
        }

        Map<String, Object> tempData = new HashMap<>();
        tempData.put("qualitytest", dataMap);
        // 此处硬编码 如需修改 请确认ac的值
        Properties wsUrl = new Properties();
        try {
            wsUrl.load(this.getClass().getResourceAsStream("/OATable.properties"));
        } catch (IOException e) {
            e.printStackTrace();
        }
        //获取国外产地
        String wsUrlstr = (String)wsUrl.get("WS_HOST");
        String result = HttpUtil.postJson(wsUrlstr+"services/qualitytest/postQualityTest?ac=a9af0d32-ee5d-4576-ad2e-de50033f1a8e", JSONObject.toJSONString(tempData));
        Map<String, Object> resultData = JSONObject.parseObject(result);
        if(!(boolean)((Map<String, Object>)resultData.get("actionResultModel")).get("success")){
            throw new Exception((String)((Map<String, Object>)resultData.get("actionResultModel")).get("msg"));
        }
    }

    public void setDealSerial(QualitySample qualitySample) {
        /*Properties foreignOrgin = new Properties();
        try {
            foreignOrgin.load(new InputStreamReader(this.getClass().getResourceAsStream("/origin.properties"),"UTF-8"));
        } catch (IOException e) {
            e.printStackTrace();
        }
        //获取国外产地
        String originStrs = foreignOrgin.get("FOREIGN_ORIGIN").toString();*/
        String originStrs = "澳大利亚,巴西";
        String[] originArr = StringUtils.split(originStrs,",");
        boolean isForeigin = ArrayUtils.contains(originArr,qualitySample.getOrigin());
        //qualitySample.setForeign(isForeigin);
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("foreign",isForeigin);
        if(isForeigin){
            //如果是进口粮
            map.put("grainType",qualitySample.getVariety());
            map.put("harvestYear",qualitySample.getHarvestYear());
            map.put("origin",qualitySample.getOrigin());
            //先去样品表中查询对应条件入库质检的样品
            List<QualitySample> qualitySamples = qsDao.getInSampleList(map);
            if(qualitySamples != null && qualitySamples.size()==1){
                qualitySample.setDealSerial(qualitySamples.get(0).getDealSerial());
            }else{
                //如果在样品表中没有查到或查到多个样品，则去成交子明细中查询
                List<RotateConcluteDetail> rotateConcluteDetails = rotateConcluteDao.getDealSerialFromConcluteDetail(map);
                if(rotateConcluteDetails != null && rotateConcluteDetails.size()==1){
                    qualitySample.setDealSerial(rotateConcluteDetails.get(0).getDealSerial());
                }
            }
        }else{
            //如果非进口粮
            map.put("receiveId",qualitySample.getWarehouseId());
            map.put("encode",qualitySample.getStorehouse());
            map.put("harvestYear",qualitySample.getHarvestYear());
            map.put("grainType",qualitySample.getVariety());
            map.put("origin",qualitySample.getOrigin());
            //先去样品表中查询对应条件入库质检的样品
            List<QualitySample> qualitySamples = qsDao.getInSampleList(map);
            if(qualitySamples != null && qualitySamples.size()==1){
                qualitySample.setDealSerial(qualitySamples.get(0).getDealSerial());
            }else{
                //如果在样品表中没有查到或查到多个样品，则去成交子明细中查询
                List<RotateConcluteDetail> rotateConcluteDetails = rotateConcluteDao.getDealSerialFromConcluteDetail(map);
                if(rotateConcluteDetails != null && rotateConcluteDetails.size()==1){
                    qualitySample.setDealSerial(rotateConcluteDetails.get(0).getDealSerial());
                }
            }
        }

    }
}
