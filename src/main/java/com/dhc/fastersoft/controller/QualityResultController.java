package com.dhc.fastersoft.controller;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.TemplateExportParams;
import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.Constant;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.*;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysFile;
import com.dhc.fastersoft.entity.system.SysProcessMapper;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.*;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysFileService;
import com.dhc.fastersoft.service.system.SysOAService;
import com.dhc.fastersoft.service.system.SysUserService;
import com.dhc.fastersoft.utils.LayEntity;
import com.dhc.fastersoft.utils.LayPage;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

@RequestMapping("QualityResult")
@Controller
public class QualityResultController extends BaseController {
    //第三方质检表头
    //private String[] excelMainHeader = {"样品编号", "样品名称","受检单位", "产品等级","抽样基数(吨)","储存方式","抽样地点","粮食产地","入库年月","收获年份","承检单位","检验开始日期","检验结束日期","质量指标判定","储存品质指标判定","卫生指标判定"};
    //内部质检表头
    //private String[] excelInnerMainHeader = {"样品编号", "样品名称","受检单位", "产品等级","抽样基数(吨)","储存方式","抽样地点","粮食产地","入库年月","收获年份","承检单位","扦样人","扦样日期","检验开始日期","检验结束日期","质量指标判定","储存品质指标判定","卫生指标判定"};
    @Autowired
    QualityResultService service;
    @Autowired
    QualityResultItemService serviceItem;
    @Autowired
    SysDictService sysService;
    @Autowired
    SysUserService sysUserService;
    @Autowired
    private StorageWarehouseService storageWarehouseService;
    @Autowired
    private QualitySampleService qualitySampleService;
    @Autowired
    private SysFileService sysFileService;
    @Autowired
    private SysOAService sysOAservice;
    @Autowired
    private SysDictService sysDictService;
    @Autowired
    QualityTempletService qualityTempletService;

    @Autowired
    QualityTempletItemService qualityTempletItemService;
    
    // 导出excel方法
    @SysLogAn("质量检测报告-导出")
    @RequestMapping("/exportExcel")
    @ResponseBody
    public void export(HttpServletRequest request, HttpServletResponse response, String id) throws Exception {
        TemplateExportParams params = new TemplateExportParams(request.getSession().getServletContext().getRealPath("\\") + "\\templates\\报告模板.xlsx");
        QualityResult entity = service.getByID(id);
        List<QualityResultItem> entityItem = serviceItem.getByID(id);

        Map<String, Object> excelEntity = new HashMap();

        Map<String, Object> param = new HashMap();
        param.put("sampleNo", entity.getSampleNo());
        List list = qualitySampleService.query(param);
        QualitySample sample = new QualitySample();
        if(list.size()>0){
            sample = qualitySampleService.query(param).get(0);
        }
        String warehouseShort = entity.getReportUnit();
        String warehouseName = storageWarehouseService.getWarehouseName(warehouseShort);
        excelEntity.put("warehouseName", warehouseName == null ? "" : warehouseName);
        excelEntity.put("variety", entity.getVariety() == null ? "" : entity.getVariety());
        excelEntity.put("storeNature", entity.getStoreEncode() == null ? "" : entity.getStoreEncode());
        String origin =  StringUtils.deleteWhitespace(entity.getOrigin());
        excelEntity.put("origin", entity.getOrigin() == null ? "" : StringUtils.deleteWhitespace(entity.getOrigin()));
        excelEntity.put("storeType", entity.getStoreType() == null ? "" : entity.getStoreType());
        excelEntity.put("quantity", entity.getQuantity() == null ? "" : entity.getQuantity());
        excelEntity.put("level", entityItem.get(0).getGrade() == null ? "" : entityItem.get(0).getGrade());
        excelEntity.put("harvestYear", entity.getHarvestYear() == null ? "" : entity.getHarvestYear());
        excelEntity.put("samplingDate", sample.getSamplingDate() == null ? "" : sample.getSamplingDate());
        excelEntity.put("samplingPeople", sample.getSamplingPeople() == null ? "" : sample.getSamplingPeople());
        excelEntity.put("testDate", entity.getTestDate() == null ? "" : entity.getTestDate());
        excelEntity.put("testEndDate", entity.getTestEndDate() == null ? "" : entity.getTestEndDate());
        excelEntity.put("remark", entity.getRemark() == null ? "" : entity.getRemark());
        excelEntity.put("sampleNo", entity.getSampleNo());
        excelEntity.put("varietyType", entity.getValidType() == null ? "" :entity.getValidType());
        excelEntity.put("vList", entityItem);
        excelEntity.put("storeJudge",entity.getStoreJudge() == null ? "":entity.getStoreJudge());
        String fileName = "检验结果";
        try {
            //fileName = new String(fileName.getBytes("UTF-8"), "iso-8859-1");
//			fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
            String userAgent = request.getHeader("USER-AGENT");
            //String finalFileName = null;
            if(StringUtils.contains(userAgent, "MSIE")){//IE浏览器
                fileName = URLEncoder.encode(fileName,"UTF8");
            }else if(StringUtils.contains(userAgent, "Mozilla")){//google,火狐浏览器
                fileName = new String(fileName.getBytes(), "ISO8859-1");
            }else{
                fileName = URLEncoder.encode(fileName,"UTF8");//其他浏览器
            }
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        response.setHeader("content-Type", "application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".xlsx");
        response.setCharacterEncoding("UTF-8");

        Workbook workbook = ExcelExportUtil.exportExcel(params, excelEntity);
        int merges = 0;
        if (entityItem != null) {
            int items = entityItem.size();
            if (items >= 3) {
                merges = 2;
            } else if (items == 2) {
                merges = 1;
            }
        }

        for (int i = 0; i < merges; i++) {
            Sheet sheet = workbook.getSheetAt(0);
            Row row = sheet.getRow(13 + i);
            row.getSheet().addMergedRegion(new CellRangeAddress(row.getRowNum(), row.getRowNum(), 2, 3));
        }

        workbook.write(response.getOutputStream());
    }

    @RequestMapping("/exportAllExcel")
    public String exportAll(HttpServletRequest request, HttpServletResponse response) {
        List<QualityResult> entity = new ArrayList();
        Map<String, List<String>> testItem = new HashMap();
        try {
            entity = service.exportAlllist(request);
            List<String> resultIds = new ArrayList();
            for (QualityResult item : entity) {
                resultIds.add(item.getId());
            }
            List<QualityResultItem> testData = serviceItem.queryByResultId(resultIds);
            for (QualityResult item : entity) {
                for (QualityResultItem cItem : testData) {
                    if (cItem.getResultId().equals(item.getId())) {
                        if (item.getQualityResultItems() == null)
                            item.setQualityResultItems(new ArrayList<QualityResultItem>());
                        item.getQualityResultItems().add(cItem);
                    }
                }
            }
            //检索出所有属性
            for (QualityResult item : entity) {
                for (QualityResultItem cItem : item.getQualityResultItems()) {
                    if (cItem.getItemName() != null && !testItem.containsKey(cItem.getItemName())) {
                        List<String> values = new ArrayList<>();
                        testItem.put(cItem.getItemName(), values);
                    }
                }
            }
            for (QualityResult item : entity) {
                for (String testKey : testItem.keySet()) {
                    if (!item.getQualityResultItems().contains(new QualityResultItem(testKey)))
                        testItem.get(testKey).add("");//补齐空串
                }
                for (QualityResultItem cItem : item.getQualityResultItems()) {
                    if (cItem.getItemName() != null)
                        testItem.get(cItem.getItemName()).add(cItem.getResult());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        String fileName = "检验结果.xls";
        try {
            fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        response.setHeader("Content-Disposition", "attachment;fileName=" + fileName);
        request.setAttribute("exportList", entity);
        request.setAttribute("testItes", testItem);
        return "/QualityResult/exportAll";
    }

    /**
     * 跳转到列表页面
     *
     * @return
     */
    @RequestMapping()
    public String index(ModelMap map, String type, Model model) {
        List<SysDict> varietyList = sysDictService.getSysDictListByType("粮油品种");
        List<SysUser> userList = sysUserService.getList();
        model.addAttribute("varietyList",varietyList);
        model.addAttribute("userList",userList);
        if (type != null) {
            map.addAttribute("type", type);
            sysLogService.add(request, "访问：代储监管-报表台账-质量检测报告");
        } else {
            map.addAttribute("type", "");
            sysLogService.add(request, "访问：质量管理-检验任务-检验结果");
        }
        model.addAttribute("checkType","1");
        return "QualityResult/list";
    }

    /**
     * 跳转到选择页面
     *
     * @return
     */
    @RequestMapping("/listChoice")
    public String listChoice(ModelMap map) {
        List<SysDict> oilcanTypeDict = sysService.getSysDictListByType("油罐类型");
        map.addAttribute("oilcanTypeDict", oilcanTypeDict);
        List<SysDict> oilcanStatusDict = sysService.getSysDictListByType("仓房状态");
        map.addAttribute("oilcanStatusDict", oilcanStatusDict);
        return "QualityResult/listChoice";
    }

    /**
     * 列表页面信息
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/list")
    @ResponseBody
    private LayPage<QualityResult> list(HttpServletRequest request) {
        LayPage<QualityResult> list = service.list(request);
        return list;
    }

    /**
     * 跳转到查看
     *
     * @param request
     * @param map
     * @param id
     * @return
     */
    @RequestMapping("/detailPage")
    public String detailPage(HttpServletRequest request, ModelMap map, String id,  @RequestParam(value="type",required=false, defaultValue="")String type, String Projectile) {
        QualityResult entity = service.getByID(id);
        map.addAttribute("entity", entity);
        List<QualityResultItem> entityItem = serviceItem.getByID(id);
        map.addAttribute("entityItem", entityItem);
        List<StorageStoreHouse> storageStoreHouses = service.getStoreEncode();
        map.addAttribute("storageStoreHouses", storageStoreHouses);

        HashMap<String, Object> searchMap = new HashMap<>();
        List<QualitySample> qualitySamples = qualitySampleService.getMessage(searchMap);
        map.put("qualitySamples", qualitySamples);

        List<SysDict> origin = sysService.getSysDictListByType("产地");
        map.addAttribute("origin", origin);
        List<SysUser> distinctList = sysUserService.distinctList();
        map.addAttribute("distinctList", distinctList);
        List<SysDict> storeType = sysService.getSysDictListByType("粮油存储方式");
        map.addAttribute("storeType", storeType);
        map.put("auvp", "v");
        map.addAttribute("type", type);

        /*List<SysFile> files = sysFileService.getFilesByGroupId(entity.getFileName());*/
        List<SysFile> files = null;
        if(entity.getFileName() != null) {
            files = sysFileService.getFilesByGroupId(entity.getFileName());
            if(files!=null){
                Map filemap = new HashMap();
                for (SysFile file:files){
                    String downloadUrl = file.getDownloadUrl();
                    String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
                    filemap.put(file.getId(),suffix);
                    map.addAttribute("suffixMap", filemap);
                }
            }
        }
        map.addAttribute("files", files);
        map.addAttribute("isEdit",false);
        //return "QualityResult/add";
        return Projectile.equals("Projectile")?"QualityResult/add_dialog":"QualityResult/add";

    }

    /**
     * 跳转到编辑
     *
     * @param request
     * @param map
     * @param id
     * @return
     */
    @RequestMapping("/editPage")
    public String editPage(HttpServletRequest request, ModelMap map, String id, String type) {
        QualityResult entity = service.getByID(id);

        map.addAttribute("entity", entity);
        List<QualityResultItem> entityItem = serviceItem.getByID(id);
        map.addAttribute("entityItem", entityItem);
        List<StorageStoreHouse> storageStoreHouses = service.getStoreEncode();
        map.addAttribute("storageStoreHouses", storageStoreHouses);

        HashMap<String, Object> searchMap = new HashMap<>();
        searchMap.put("checkType",1);   // 内部质检
        List<QualitySample> qualitySamples = qualitySampleService.getMessage(searchMap);
        map.put("qualitySamples", qualitySamples);

        List<SysDict> origin = sysService.getSysDictListByType("产地");
        map.addAttribute("origin", origin);
        List<SysUser> distinctList = sysUserService.distinctList();
        map.addAttribute("distinctList", distinctList);
        List<SysDict> storeType = sysService.getSysDictListByType("粮油存储方式");
        map.addAttribute("storeType", storeType);

        /*List<SysFile> files = sysFileService.getFilesByGroupId(entity.getFileName());
        if(files!=null && files.size()==0){
            files = null;
        }*/

        List<SysFile> files = null;
        if(entity.getFileName() != null) {
            files = sysFileService.getFilesByGroupId(entity.getFileName());
            if(files!=null){
                Map filemap = new HashMap();
                for (SysFile file:files){
                    String downloadUrl = file.getDownloadUrl();
                    String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
                    filemap.put(file.getId(),suffix);
                    map.addAttribute("suffixMap", filemap);
                }
            }
        }
        map.addAttribute("files", files);

        map.put("auvp", "u");
        map.addAttribute("type", type);
        map.addAttribute("isEdit",true);
        return "QualityResult/add";
    }

    /***
     * 跳转到登记页面
     * @param
     * @return
     */
    @RequestMapping("/addPage")
    public String addPage(ModelMap map, String type) {
        List<StorageStoreHouse> storageStoreHouses = service.getStoreEncode();
        map.addAttribute("storageStoreHouses", storageStoreHouses);
        SysUser user = TokenManager.getToken();

        map.addAttribute("user",user);
        HashMap<String, Object> searchMap = new HashMap<>();
        searchMap.put("checkType",1);   // 内部质检
        List<QualitySample> qualitySamples = qualitySampleService.getMessage(searchMap);
        map.put("qualitySamples", qualitySamples);

        List<SysDict> origin = sysService.getSysDictListByType("产地");
        map.addAttribute("origin", origin);
        List<SysUser> distinctList = sysUserService.distinctList();
        map.addAttribute("distinctList", distinctList);
        List<SysDict> storeType = sysService.getSysDictListByType("粮油存储方式");
        map.addAttribute("storeType", storeType);
        QualityResult entity = new QualityResult();
        StorageWarehouse warehouse = storageWarehouseService.getWarehouseById(TokenManager.getToken().getWareHouseId());
        entity.setReportUnit(warehouse==null?"":warehouse.getWarehouseShort());
        map.addAttribute("entity", entity);
        map.addAttribute("auvp", "a");
        map.addAttribute("type", type);
        map.addAttribute("isEdit",true);
        return "QualityResult/add";
    }

    /**
     * 打印
     *
     * @param map
     * @param id
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("/print")
    public String print(ModelMap map, String id, String name /*String Projectile*/) throws UnsupportedEncodingException {
        QualityResult entity = service.getByID(id);
        String warehouseShort = entity.getReportUnit();
        String warehouseName = storageWarehouseService.getWarehouseName(warehouseShort);
        map.addAttribute("warehouseName",warehouseName);
        String origin =  StringUtils.deleteWhitespace(entity.getOrigin());
        entity.setOrigin(origin);
        map.addAttribute("entity", entity);
        Map<String, Object> param = new HashMap();
        param.put("sampleNo", entity.getSampleNo());
        List<QualitySample> sample1 =  qualitySampleService.query(param);
        QualitySample sample = new QualitySample();
        if (sample1.size()>0){
            sample = sample1.get(0);
        }
        map.addAttribute("sample", sample);
        List<QualityResultItem> entityItem = serviceItem.getByID(id);
        map.addAttribute("entityItem", entityItem);
        map.put("auvp", "p");
        map.put("name", new String(URLDecoder.decode(name, "utf-8")));
        return "QualityResult/print";
        //return Projectile.equals("Projectile")?"QualityResult/print_dialog":"QualityResult/print";
    }

    @RequestMapping("/excel")
    public String excel(ModelMap map, String id) {
        QualityResult entity = service.getByID(id);
        map.addAttribute("entity", entity);
        List<QualityResultItem> entityItem = serviceItem.getByID(id);
        map.addAttribute("entityItem", entityItem);
        map.put("auvp", "p");
        return "QualityResult/text";
    }

    /**
     * 删除
     *
     * @param id
     * @return
     */
    @SysLogAn("质量检测报告-删除")
    @RequestMapping(value = "/remove", method = RequestMethod.POST)
    @ResponseBody
    public ActionResultModel delete(String id) {
        ActionResultModel actionResultModel = new ActionResultModel();
        int row = service.remove(id);
        int countItem = serviceItem.count(id);
        if (countItem > 0) {
            int row2 = serviceItem.deleteItem(id);
            if (row > 0 && row2 > 0) {
                actionResultModel.setSuccess(true);
                actionResultModel.setMsg("删除成功");
            } else {
                actionResultModel.setSuccess(false);
                actionResultModel.setMsg("删除失败");
            }
        } else {
            if (row > 0) {
                actionResultModel.setSuccess(true);
                actionResultModel.setMsg("删除成功");
            } else {
                actionResultModel.setSuccess(false);
                actionResultModel.setMsg("删除失败");
            }
        }
        return actionResultModel;
    }


    /**
     *
     * @param id
     * @return
     */
    public String exportExcelToOa(String id) {
        SysUser user = TokenManager.getToken();
        String fileCode = null;

        QualityResult planmain = service.getByID(id);
        if(planmain != null) {
            String host = String.format("http://%s:%s%s/", request.getServerName(),request.getServerPort(),request.getContextPath());
            HttpClient client = HttpClients.createDefault();
            //模拟进行一次登陆以绕过验证
            HttpPost post = new HttpPost(host + "sign/submitLogin.shtml");
            List<NameValuePair> list = new ArrayList<>();
            list.add(new BasicNameValuePair("account",user.getAccount()));
            list.add(new BasicNameValuePair("password",user.getPassword()));
            UrlEncodedFormEntity entity = null;
            try {
                entity = new UrlEncodedFormEntity(list,"UTF-8");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            post.setEntity(entity);
            HttpResponse response = null;
            try {
                response = client.execute(post);
            } catch (IOException e) {
                e.printStackTrace();
            }
            if(response != null) {
                HttpEntity httpEntity = response.getEntity();
                try {
                    JSONObject returnData = JSONObject.fromObject(EntityUtils.toString(httpEntity,"utf-8"));
                    if(!(returnData.get("message").equals("登录成功"))) {
                        return fileCode;
                    }
                }  catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }

            StringBuilder param = new StringBuilder();
            param.append("id="+id);

            HttpGet get = new HttpGet(host + String.format("QualityResult/exportExcel.shtml?%s", param.toString()));
            try {
                response = client.execute(get);
            } catch (IOException e) {
                e.printStackTrace();
            }
            if(response != null) {
                HttpEntity httpEntity = response.getEntity();
                try {
                    if(response.getStatusLine().getStatusCode() == HttpStatus.OK.value()) {
                        InputStream in = httpEntity.getContent();
                        File file = new File(request.getSession().getServletContext().getRealPath("/") + Constant.EXPORT_PATH);
                        if(!file.exists())
                            file.mkdirs();
                        fileCode = UUID.randomUUID().toString().replace("-", "") + ".xls";
                        FileOutputStream fos = new FileOutputStream(file.getPath() + "/" + fileCode);
                        byte[] buffer = new byte[4096];
                        int readLength = 0;
                        while ((readLength=in.read(buffer)) > 0) {
                            byte[] bytes = new byte[readLength];
                            System.arraycopy(buffer, 0, bytes, 0, readLength);
                            fos.write(bytes);
                        }
                        fos.flush();
                        in.close();
                        fos.close();
                        return fileCode;
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return fileCode;
    }



    @RequestMapping(value = "/submit", method = RequestMethod.POST)
    @ResponseBody
    public ActionResultModel submit(String id) {
        ActionResultModel actionResultModel = new ActionResultModel();
        QualityResult result = service.getByID(id);
        String type = request.getParameter("type");
        result.setStatus("审核中");
        service.update(result);
        String  fileCode=this.exportExcelToOa(id);

        sysOAservice.LaunchedAudit(
                id,
                TokenManager.getToken().getId(),
                 "质检报告审批",
                String.format("http://%s:%s%s/", request.getServerName(),request.getServerPort(),request.getContextPath()) + "files/code/" + fileCode,
                new SysProcessMapper("T_QUALITY_RESULT", "STATUS", "已通过:"));
        actionResultModel.setSuccess(true);
        actionResultModel.setMsg("提交成功");
        if ("dc".equals(type)) {
            sysLogService.add(request, "代储监管-报表台账-质量检测报告-提交");
        } else {
            sysLogService.add(request, "质量管理-检验任务-检验结果-提交");
        }
        return actionResultModel;
    }

    /**
     * 添加或修改
     *
     * @param auvp
     * @param
     * @return
     */
    @RequestMapping(value = "/save", method = {RequestMethod.POST})
    @ResponseBody
    public ActionResultModel save(@RequestParam(value = "auvp") String auvp, QualityResult entity, @RequestParam(value = "file", required = false) MultipartFile[] file, HttpServletRequest request, ModelMap modelMap) {
        ActionResultModel actionResultModel = new ActionResultModel();

        String type = request.getParameter("type");

        String sqlId = "";
        try {
            String id = request.getParameter("id");
            String[] grade = request.getParameterValues("grade");
            String[] itemName = request.getParameterValues("itemName");
            String[] standard = request.getParameterValues("standard");
            String[] result = request.getParameterValues("result");
            String[] remark = request.getParameterValues("remarkItem");
            String[] resultId = request.getParameterValues("resultId");
            String[] orderNo = request.getParameterValues("orderNo");
            if (auvp.equals("a")) {

                SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
                String date = df.format(new Date());
                entity.setCreator(TokenManager.getSysUserId());
                entity.setCreateDate(date);
                entity.setCompany(TokenManager.getToken().getShortName() != null ? TokenManager.getToken().getShortName() : "");
                int random = (int) (Math.random() * 9 + 1) * 1000;
                entity.setReportSerial(new SimpleDateFormat("yyyyMMdd").format(new Date()) + random);
                entity.setStatus("待提交");
                sqlId = UUID.randomUUID().toString().replace("-", "");
                entity.setId(sqlId);

                entity.setFileName(sysFileService.uploadFiles(request, null, file, "QualityResult"));
              /*  QualitySample qs=new QualitySample();
                String sampleNoId = entity.getSampleNoId();
                qs.setId(sampleNoId);
                qs.setTestPeople(TokenManager.getNickname());
                qualitySampleService.update(qs);*/
                int add = service.add(entity);
                if ("dc".equals(type)) {
                    sysLogService.add(request, "代储监管-报表台账-质量检测报告-新增");
                } else {
                    sysLogService.add(request, "质量管理-检验任务-检验结果-新增");
                }
            } else if (auvp.equals("u")) {
                entity.setId(id);
                if (entity.getCreator() == "" || entity.getCreator() == null) {
                    entity.setCreator(TokenManager.getSysUserId());
                }
                if (entity.getCreateDate() == "" || entity.getCreateDate() == null) {
                    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
                    String date = df.format(new Date());
                    entity.setCreateDate(date);
                }
                if (entity.getCompany() == "" || entity.getCompany() == null) {
                    entity.setCompany(TokenManager.getToken().getShortName() != null ? TokenManager.getToken().getShortName() : "");
                }

                if(file!=null && file.length > 0)
                    entity.setFileName(sysFileService.uploadFiles(request, entity.getFileName(), file, "QualityResult"));

                int update = service.update(entity);
                serviceItem.deleteItem(id);
                sqlId = id;
                if ("dc".equals(type)) {
                    sysLogService.add(request, "代储监管-报表台账-质量检测报告-修改");
                } else {
                    sysLogService.add(request, "质量管理-检验任务-检验结果-修改");
                }
            }

            if (id.length() == 0) {


            } else {


            }

            QualityResultItem qtiItem = new QualityResultItem();
            Set<String> setNew = new HashSet<String>();
            int count = 0;
            if (resultId != null) {
                for (int i = 0; i < resultId.length; i++) {
                    qtiItem = new QualityResultItem();
                    boolean b = setNew.add(itemName[i]);
                    qtiItem.setResultId(sqlId);
                    qtiItem.setGrade(grade[i]);
                    qtiItem.setItemName(itemName[i]);
                    qtiItem.setResult(result[i]);
                    qtiItem.setStandard(standard[i]);
                    qtiItem.setRemark(remark[i]);
                    int a = Integer.parseInt(orderNo[i]);
                    BigDecimal c = new BigDecimal(a);
                    qtiItem.setOrderNo(c);
                    if (!b) {
                        count++;
                        qtiItem.setCount(count + "");
                    }
                    qtiItem.setId(UUID.randomUUID().toString().replace("-", ""));
                    int addItem = serviceItem.add(qtiItem);

                }
                if(entity.getCheckType().equals("1")){
                    Set<String> set = new HashSet<String>();
                    for (int i = 0; i < itemName.length; i++) {
                        boolean b = set.add(itemName[i]);
                        if (!b) {
                            qtiItem = new QualityResultItem();
                            qtiItem.setResultId(sqlId);
                            qtiItem.setItemName(itemName[i - 1]);
                            qtiItem.setResult(result[i - 1]);
                            qtiItem.setRemark(remark[i - 1]);
                            int countItemName = serviceItem.countItemName(qtiItem);
                            qtiItem.setRepetition(countItemName + "");
                            int update = serviceItem.update(qtiItem);
                        }
                    }
                }

            }
            actionResultModel.setSuccess(true);
        } catch (Exception e) {
            actionResultModel.setSuccess(false);
            int row = service.remove(sqlId);
            int row2 = serviceItem.deleteItem(sqlId);
            e.printStackTrace();
        }
        return actionResultModel;
    }

    /**
     * 质检结果查询
     * @param pageIndex
     * @param pageSize
     * @param variety1
     * @param harvestYear
     * @param storeEncode
     * @param origin1
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping("/selectQualityResult")
    @ResponseBody
    public LayPage<QualityResult> selectQualityResult(@RequestParam(value="pageIndex") int pageIndex,
                                                      @RequestParam(value="pageSize") int pageSize,
                                                      @RequestParam(value="variety1",required=false) String variety1,
                                                      @RequestParam(value="harvestYear",required=false) String harvestYear,
                                                      @RequestParam(value="storeEncode",required=false) String storeEncode,
                                                      @RequestParam(value="origin1",required=false) String origin1) throws UnsupportedEncodingException {
        HashMap<String, Object> map=new HashMap<>();
        map.put("pageIndex", String.valueOf(pageIndex));
        map.put("pageSize", String.valueOf(pageSize));
        map.put("storeEncode", storeEncode);
        map.put("variety", variety1);
        map.put("harvestYear", harvestYear);
        map.put("origin", origin1);
        LayPage<QualityResult> page = service.selectQualityResult(map);
        return page;
    }

    //进入质检结果导入页面
    @RequestMapping(value="/ImportQualityResult")
    public String list(HttpServletRequest request,ModelMap modelMap) {
        String resultFileId = request.getParameter("id");
        QualityResultFile qualityResultFile = service.getResultFileById(resultFileId);
        modelMap.addAttribute("qualityResultFile",qualityResultFile);
        String fileName = request.getParameter("fileName");
        String templateId = request.getParameter("templateId");
        String createDate = request.getParameter("createDate");
        List<SysDict> validTypes=sysService.getSysDictListByType("质检类型");
        modelMap.addAttribute("validTypes",validTypes);
        modelMap.addAttribute("resultFileId",resultFileId);
        modelMap.addAttribute("fileName",fileName);
        modelMap.addAttribute("templateId",templateId);
        modelMap.addAttribute("createDate",createDate);
        return "QualityResult/import_result_list";
    }

    /**
     * 删除导入文件
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("delImportFile")
    public ActionResultModel delImportFile(@RequestParam String id){
        ActionResultModel actionResultModel = new ActionResultModel();
        if(StringUtils.isEmpty(id)){
            actionResultModel.setSuccess(false);
            actionResultModel.setMsg("参数异常");
            return actionResultModel;
        }
        Map<String, Object> params = new HashMap<>();
        params.put("resultFileId",id);
        int count = service.countImportData(params);
        if(count > 0){
            actionResultModel.setSuccess(false);
            actionResultModel.setMsg("存在质检数据无法删除");
            return actionResultModel;
        }

        try{
            service.delImportFile(id);
            actionResultModel.setSuccess(true);
            actionResultModel.setMsg("删除成功");
        }catch (Exception e){
            actionResultModel.setSuccess(false);
            actionResultModel.setMsg("服务器异常");
            e.printStackTrace();
        }
        return actionResultModel;
    }

    /**
     * 批量删除导入数据
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping("/delImportData")
    public Map<String,Object> delImportData(@RequestBody List<String> ids) {
        Map<String,Object> map = new HashMap<>();
        // 参数为空
        if(ids == null || ids.size() <= 0){
            map.put("code",1);
            map.put("msg","请选择要删除的数据");
            return map;
        }
        // 进行删除条件判断
        Map<String,Object> params = new HashMap<>();
        params.put("ids",ids);
        params.put("status",1);
        int countImportData = service.countImportData(params);
        if(countImportData > 0){
            map.put("code",1);
            map.put("msg","存在已导入数据，无法删除");
            return map;
        }

        try{
            int count = service.delImportData(ids);
            map.put("code",0);
            map.put("data",count);
        }catch (Exception e){
            map.put("code",1);
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping("/downloadResultTemplate")
    public void downloadResultTemplate(HttpServletRequest request, HttpServletResponse response)throws Exception {
        //第三方质检表头
        String[] excelMainHeader = {"样品编号", "样品名称","受检单位","库点简称", "产品等级","抽样基数(吨)","储存方式","抽样地点","粮食产地","入库年月","收获年份","承检单位","检验开始日期","检验结束日期","质量指标判定","储存品质指标判定","卫生指标判定"};
        //内部质检表头
        String[] excelInnerMainHeader = {"样品编号", "样品名称","受检单位","库点简称", "产品等级","抽样基数(吨)","储存方式","抽样地点","粮食产地","入库年月","收获年份","承检单位","扦样人","扦样日期","检验开始日期","检验结束日期","质量指标判定","储存品质指标判定","卫生指标判定"};
        String templateId = request.getParameter("templateId");
        String checkType = request.getParameter("checkType");
        QualityTemplet qualityTemplet = qualityTempletService.getByID(templateId);
        List<QualityTempletItem> qualityTempletItem = qualityTempletItemService.getByID(templateId);
        if("1".equals(checkType)){
            excelMainHeader = excelInnerMainHeader;
        }
        int mainLength = excelMainHeader.length;
        int templateLength = qualityTempletItem.size();
        int excelTitleLenght = mainLength+templateLength;
        String excelHeader[] = new String[excelTitleLenght];
        for(int i= 0;i<mainLength;i++){
            //插入主表表头
            excelHeader[i] =excelMainHeader[i];
        }
        for(int i=mainLength;i<excelTitleLenght;i++){
            //插入检验结果表头
            excelHeader[i] = qualityTempletItem.get(i-mainLength).getItemName();
        }
        //这里需要说明一个问题：如果是 Offices 2007以前的Excel版本，new的对象是：**HSSFWorkbook** ，Offices 2007以后的Excel版本new的对象才是
        XSSFWorkbook wb = new XSSFWorkbook();
        //生成一个工作表（解析不了名称中带‘/’的）
        Sheet sheet = wb.createSheet("质量模板");
        Row row = sheet.createRow((int) 0);
        //sheet.autoSizeColumn((short)0);
        XSSFCellStyle style = wb.createCellStyle();
        //style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setAlignment(XSSFCellStyle.ALIGN_CENTER); //水平布局：居中
        style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
        style.setWrapText(true);

        for (int i = 0; i < excelHeader.length; i++) {

            Cell cell = row.createCell(i);
            cell.setCellValue(excelHeader[i]);
            cell.setCellStyle(style);
            //sheet.autoSizeColumn((short)i);
        }
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("Content-disposition", "attachment;filename="+new String(qualityTemplet.getTempletName().getBytes(),"ISO8859-1")+".xlsx");
        OutputStream ouputStream = response.getOutputStream();
        wb.write(ouputStream);
        ouputStream.flush();
        ouputStream.close();
    }




    //导入质检结果
    @RequestMapping(value="/uploadExcel")
    @ResponseBody
    public LayEntity uploadExcel(MultipartFile file, HttpServletRequest request){
        LayEntity layFileEntity =  service.addResultfileAndTempResult(file,request);

        return layFileEntity;
    }



    /**
     * 列表页面信息
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/tempResultlist")
    @ResponseBody
    private LayPage<ResultDataTemp> tempResultlist(HttpServletRequest request) {
        LayPage<ResultDataTemp> list = service.tempResultlist(request);
        return list;
    }


    @RequestMapping("/importResult")
    @ResponseBody
    public ActionResultModel importResult(HttpServletRequest request) {
        ActionResultModel actionResultModel = new ActionResultModel();
        actionResultModel = service.importResult(request);
        actionResultModel.setSuccess(true);
        //推送中穗库质检数据
        List<String> resultIds = (List<String>)actionResultModel.getData();
        // 下发给库平台
        try {
            if (resultIds != null && resultIds.size() > 0) {
                for (int i = 0; i < resultIds.size(); i++) {
                    service.sendMessage(resultIds.get(i), "1");
                }
            }
        }catch (Exception e){

        }
        return actionResultModel;
    }


    /**
     * 跳转到编辑
     *
     * @param request
     * @param map
     * @param id
     * @return
     */
    @RequestMapping("/editTempResultPage")
    public String editTempResultPage(HttpServletRequest request, ModelMap map, String id) {
        ResultDataTemp entity = service.getTempResultByID(id);
        map.addAttribute("entity", entity);

        String resultFileId = request.getParameter("resultFileId");
        QualityResultFile qualityResultFile = service.getResultFileById(resultFileId);
        map.addAttribute("qualityResultFile",qualityResultFile);
        //根据模板编号查询
        Map<String,Object> templateMap = new HashMap<String,Object>();
        templateMap.put("templateNo",entity.getTemplateNo());
        List<QualityTemplet> qualityTemplets =  qualityTempletService.getTemplateByNo(templateMap);
        List<QualityTempletItem> qualityTempletItems = new ArrayList<QualityTempletItem>();
        if(qualityTemplets.size()==1){
           qualityTempletItems = qualityTempletItemService.getByID(qualityTemplets.get(0).getId());
        }
        if(qualityTempletItems.size()>0){
            map.addAttribute("qualityTempletItems", qualityTempletItems);
        }
        //把结果项放入map中，方便在前台遍历获取
        Map<String ,Object> itemMap = new LinkedHashMap<String, Object>();
        for(int i=0;i<qualityTempletItems.size();i++){
            //通过反射获取临时表中动态的属性值
            String column = getFieldValueByFieldName("column"+(i+1),entity);
            itemMap.put(qualityTempletItems.get(i).getItemName(),column);
        }
        map.addAttribute("itemMap",itemMap);
        List<SysDict> storeType = sysService.getSysDictListByType("粮油存储方式");
        map.addAttribute("storeType", storeType);
        map.put("auvp", "u");
        return "QualityResult/editTempResult";
    }


    /**
     * 添加或修改
     *
     * @param auvp
     * @param
     * @return
     */
    @RequestMapping(value = "/saveTempResult", method = {RequestMethod.POST})
    @ResponseBody
    public ActionResultModel saveTempResult(@RequestParam(value = "auvp") String auvp, ResultDataTemp entity, HttpServletRequest request, ModelMap modelMap) {
        ActionResultModel actionResultModel = new ActionResultModel();
        String sqlId = "";
        try {
            String id = request.getParameter("id");
            if (auvp.equals("a")) {

            } else if (auvp.equals("u")) {
                entity.setId(id);
                service.updateTempQualityResult(entity);
            }
            actionResultModel.setSuccess(true);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return actionResultModel;
    }

//进入结果文件页面
    @RequestMapping(value="/QualityResultFile")
    public String QualityResultFile(ModelMap modelMap) {
        //Map<String,String> map = new HashMap<String, String>();
        //qualityTempletService.selectTemplate(map);

        return "QualityResult/result_file_list";
    }
    //访问文件列表
    @RequestMapping(value = "/resultFileList")
    @ResponseBody
    private LayPage<QualityResultFile> resultFileList(HttpServletRequest request) {
        LayPage<QualityResultFile> list = service.resultFileList(request);
        return list;
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


    // 自适应宽度(中文支持)
    private void setSizeColumn(Sheet sheet) {
        for (int columnNum = 0; columnNum <= 8; columnNum++) {
            int columnWidth = sheet.getColumnWidth(columnNum) / 256;
            for (int rowNum = 0; rowNum < sheet.getLastRowNum(); rowNum++) {
                Row currentRow;
                //当前行未被使用过
                if (sheet.getRow(rowNum) == null) {
                    currentRow = sheet.createRow(rowNum);
                } else {
                    currentRow = sheet.getRow(rowNum);
                }

                if (currentRow.getCell(columnNum) != null) {
                    Cell currentCell = currentRow.getCell(columnNum);
                    if (currentCell.getCellType() == Cell.CELL_TYPE_STRING) {
                        int length = currentCell.getStringCellValue().getBytes().length;
                        if (columnWidth < length) {
                            columnWidth = length;
                        }
                    }
                }
            }
            sheet.setColumnWidth(columnNum, columnWidth * 256);
        }
    }
}
