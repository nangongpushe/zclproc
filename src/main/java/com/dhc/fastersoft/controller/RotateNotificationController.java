package com.dhc.fastersoft.controller;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import cn.afterturn.easypoi.excel.entity.TemplateExportParams;
import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.constants.BusinessConstants;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.RotateConcluteDao;
import com.dhc.fastersoft.entity.*;
import com.dhc.fastersoft.entity.enumdata.NoticeTypeEnum;
import com.dhc.fastersoft.entity.store.StoreEnterprise;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysFile;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.*;
import com.dhc.fastersoft.service.store.StoreEnterpriseService;
import com.dhc.fastersoft.service.system.*;
import com.dhc.fastersoft.utils.JsonUtil;
import com.dhc.fastersoft.utils.PageUtil;
import com.dhc.fastersoft.utils.UpdateUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;

@Controller
@RequestMapping("/RotateNotif")
public class RotateNotificationController extends BaseController {

    @Autowired
    private RotateNoticeService rotateNoticeService;
    @Autowired
    private RotateConcluteService rotateConcluteService;
    @Autowired
    private RotateTakeService rotateTakeService;
    @Autowired
    private RotateTakeMainService rotateTakeMainService;
    @Autowired
    private StorageWarehouseService storageWarehouseService;
    @Autowired
    private StorageStoreHouseService StorageStoreHouseService;
    @Autowired
    private SysOAService sysOAService;
    @Autowired
    private SysUserService sysUserService;
    @Autowired
    private SysFileService sysFileService;
    @Autowired
    private HttpServletRequest httpServletRequest;
    @Autowired
    private SysDictService sysDictService;
    @Autowired
    private StoreEnterpriseService storeEnterpriseService;
    @Autowired
    private SysOutinrepoNoticeService sysOutinrepoNoticeService;
    @Autowired
    private SysLadingReceiptService sysLadingReceiptService;
    @Autowired
    private RotateScheduleService rotateScheduleService;
    @Autowired
    private RotateTakeTotalService rotateTakeTotalService;

    @Autowired
    private RotateConcluteDao dao;

    public final static char[] upper = "○一二三四五六七八九十".toCharArray();


    Properties prop = new Properties();

    private Map<String, String> mapper = new HashMap<>();

    {
        mapper.put("In", NoticeTypeEnum.IN_BOUMD.getValue());
        mapper.put("Out", NoticeTypeEnum.OUT_BOUND.getValue());
        mapper.put("Move", NoticeTypeEnum.MOVE_BOUND.getValue());

        try {
            prop.load(this.getClass().getResourceAsStream("/limitPage.properties"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/{way}", method = {RequestMethod.GET})
    public String BoundIndex(Model model, @PathVariable("way") String way, @RequestParam("type") String type) {
        PageUtil<RotateNotice> pageUtil = new PageUtil<>();
        pageUtil.setPageIndex(1);
        pageUtil.setPageSize(Integer.valueOf(prop.get("PageSize").toString()));
        RotateNotice notice = new RotateNotice();
        notice.setNoticeType(mapper.get(way));

        if (TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl"))
            type = "warehouse";
        else
            type = "base";

        if (type != null && type.toLowerCase().equals("warehouse")) {
            pageUtil.setEntity(notice);
        } else if (type != null && type.toLowerCase().equals("base")) {
            notice.setStatus("已完成");
            SysUser user = TokenManager.getToken();
            String company = user.getShortName();//获取当前用户的公司;
            String wareHouseId = user.getWareHouseId();//获取当前用户的公司;

            String warehouseCode = user.getOriginCode().toUpperCase();    // 获取当前用户库点CODE

            pageUtil.setEntity(notice);
            notice.setAccepteUnit(company);
            Map<String, Object> otherPram = new HashMap<>();

//			List<String> acceptUnit = new ArrayList<>();
//			acceptUnit.add(notice.getAccepteUnit());
//			for(StorageWarehouse base : storageWarehouseService.listSuperviseOfWarehouse(company))
//				acceptUnit.add(base.getWarehouseShort());
//			otherPram.put("acceptUnit", acceptUnit);

            List<String> enterpriseidList = new ArrayList<>();
            // 根据公司名称获取公司信息
            StoreEnterprise storeEnterprise = storeEnterpriseService.findStroeEnterpriseByWarehouseCode(warehouseCode);
            enterpriseidList.add(storeEnterprise.getEnterpriseID());
            for (StorageWarehouse base : storageWarehouseService.listSuperviseOfWarehouse(wareHouseId))
                enterpriseidList.add(base.getEnterpriseId());
            otherPram.put("enterpriseidList", enterpriseidList);

            if (way.toLowerCase().equals("in") || way.toLowerCase().equals("out")) {
                //do nothing
            } else {
                otherPram.put("storageWarehouse", user.getCompany());
            }
            pageUtil.setOtherPram(otherPram);
        }

//		List<String> warehouse = new ArrayList<>();
//		for (StorageWarehouse item : storageWarehouseService.limitList()) {
//			warehouse.add(item.getWarehouseShort());
//		}
//		int count = rotateNoticeService.GetTotalCount(pageUtil);
        PageHelper.startPage(1, Integer.valueOf(prop.get("PageSize").toString()));
        List<RotateNotice> list = rotateNoticeService.ListLimitNotice(pageUtil);

        HashMap<String, Object> params = new HashMap<>();
        params.put("findAll", true);
        // 判断此通知书是否在进度上报中存在
        for (RotateNotice rotateNotice : list) {
            params.put("noticeId", rotateNotice.getId());
            int count = rotateScheduleService.count(params);
            if (count > 0)
                rotateNotice.setReportProgress(true);
            else
                rotateNotice.setReportProgress(false);
        }

        PageInfo pageInfo = new PageInfo(list);
        pageUtil.setTotalCount((int) pageInfo.getTotal());
        pageUtil.setResult(list);

        if (!TokenManager.getToken().getOriginCode().equals("CBL"))
            model.addAttribute("targetIdentity", "warehouse");
        else
            model.addAttribute("targetIdentity", "company");

        List<StoreEnterprise> storeEnterpriseList = storeEnterpriseService.getEnterpriseList();
        model.addAttribute("type", type);
        model.addAttribute("basepoints", storeEnterpriseList);
        model.addAttribute("noticelist", pageUtil);

        String funName = "";
        if ("out".equals(way.toLowerCase())) {
            funName = "出库通知书";
        } else if ("in".equals(way.toLowerCase())) {
            funName = "入库通知书";
        } else if ("move".equals(way.toLowerCase())) {
            funName = "移库通知书";
        }
        sysLogService.add(request, "访问：轮换业务-通知书管理-" + funName);

        return "RotateNotification/" + way.toLowerCase() + "boundnotif_view";
    }

    @RequestMapping(value = "/{type}/{way}/List", method = {RequestMethod.POST})
    @ResponseBody
    public PageUtil ListBound(Model model, RotateNotice notice, @PathVariable("way") String way, @PathVariable("type") String type,
                              @RequestParam("pageindex") int pageindex, @RequestParam("pagesize") int pagesize) {
        PageUtil<RotateNotice> pageUtil = new PageUtil<>();
        pageUtil.setPageIndex(pageindex);
        pageUtil.setPageSize(pagesize == 0 ? Integer.MAX_VALUE : pagesize);
        notice.setAccepteUnit(notice.getAccepteUnit().equals("全部") ? null : notice.getAccepteUnit());
        notice.setStatus(notice.getStatus().equals("全部") ? null : notice.getStatus());
        notice.setNoticeType(mapper.get(way));
        pageUtil.setEntity(notice);

        if (TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl"))
            type = "warehouse";
        else
            type = "base";

        if (type != null && type.toLowerCase().equals("warehouse")) {
            //查看全部不做任何操作
        } else if (type != null && type.toLowerCase().equals("base")) {
            notice.setStatus("已完成");
            SysUser user = TokenManager.getToken();
            String company = user.getShortName();//获取当前用户的公司;
            String wareHouseId = user.getWareHouseId();//获取当前用户的公司;
            String warehouseCode = user.getOriginCode().toUpperCase();    // 获取当前用户库点CODE

            pageUtil.setEntity(notice);
            notice.setAccepteUnit(company);
            Map<String, Object> otherPram = new HashMap<>();
//			List<String> acceptUnit = new ArrayList<>();
//			acceptUnit.add(notice.getAccepteUnit());
//			for(StorageWarehouse base : storageWarehouseService.listSuperviseOfWarehouse(company))
//				acceptUnit.add(base.getWarehouseShort());
//			otherPram.put("acceptUnit", acceptUnit);

            List<String> enterpriseidList = new ArrayList<>();
            // 根据公司名称获取公司信息
            StoreEnterprise storeEnterprise = storeEnterpriseService.findStroeEnterpriseByWarehouseCode(warehouseCode);
            enterpriseidList.add(storeEnterprise.getEnterpriseID());
            for (StorageWarehouse base : storageWarehouseService.listSuperviseOfWarehouse(wareHouseId))
                enterpriseidList.add(base.getEnterpriseId());
            otherPram.put("enterpriseidList", enterpriseidList);

            if (way.toLowerCase().equals("in") || way.toLowerCase().equals("out")) {
                //do nothing
            } else {
                otherPram.put("storageWarehouse", user.getCompany());
            }
            pageUtil.setOtherPram(otherPram);
        }
//		int count = rotateNoticeService.GetTotalCount(pageUtil);
        PageHelper.startPage(pageindex, pagesize);
        List<RotateNotice> list = rotateNoticeService.ListLimitNotice(pageUtil);

        HashMap<String, Object> params = new HashMap<>();
        params.put("findAll", true);
        // 判断此通知书是否在进度上报中存在
        for (RotateNotice rotateNotice : list) {
            params.put("noticeId", rotateNotice.getId());
            int count = rotateScheduleService.count(params);
            if (count > 0)
                rotateNotice.setReportProgress(true);
            else
                rotateNotice.setReportProgress(false);
        }

        PageInfo pageInfo = new PageInfo(list);
        pageUtil.setTotalCount((int) pageInfo.getTotal());
        pageUtil.setResult(list);
        model.addAttribute("noticelist", pageUtil);
        return pageUtil;
    }

    @RequestMapping(value = "/{way}/Add", method = {RequestMethod.GET})
    public String AddBound(Model model, @PathVariable("way") String way) {
        // 获取库点单位列表
        List<StorageWarehouse> warehouse = storageWarehouseService.getWarehouseList();

        //粮油品种
        List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");


        List<StoreEnterprise> storeEnterpriseList = storeEnterpriseService.getEnterpriseList();

        HashMap<String, Object> param = new HashMap<>();
        /*获取标的物明细*/
        if (way.equals("In")) {
            param.put("inviteType", "采购");
        } else if (way.equals("Out")) {
            param.put("inviteType", "销售");
        }
        // 获取成交明细列表
        List<RotateConclute> concluteList = rotateConcluteService.list(param);

        int maxNoticeSerialNumber = Integer.MIN_VALUE;
        int finalNoticeSerialNumber = 0;
        int  currentYear = Integer.valueOf(new SimpleDateFormat("yyyy").format(new Date()));

        List<String> noticeSerialList = null;
        if ("out".equals(way.toLowerCase())) {
            noticeSerialList = rotateNoticeService.findOutNoticeSerial();
        }else if ("in".equals(way.toLowerCase())){
            noticeSerialList = rotateNoticeService.findInNoticeSerial();
        }else if("move".equals(way.toLowerCase())){
            noticeSerialList = rotateNoticeService.findMoveNoticeSerial();
        }

        //从数据库中查出通知书编号后进行拼接，找出其中最大的通知书编号

        for(String attribute : noticeSerialList) {
            if(attribute.length() > 7){
                int noticeSerialYear = Integer.valueOf(attribute.substring(1,5));
                int noticeSerialNumber = Integer.valueOf(attribute.substring(6,attribute.length() - 1));
                if (noticeSerialYear == currentYear) {
                    maxNoticeSerialNumber = maxNoticeSerialNumber > noticeSerialNumber ? maxNoticeSerialNumber : noticeSerialNumber;
                }
            }
        }



        finalNoticeSerialNumber = maxNoticeSerialNumber + 1;

        String finalNoticeSerial = "〔" + currentYear + "〕" + finalNoticeSerialNumber + "号";


        RotateNotice notice = new RotateNotice();
        notice.setNoticeSerial(finalNoticeSerial);
        notice.setCreater(TokenManager.getNickname());
        notice.setCreateTime(Calendar.getInstance().getTime());

        SysUser temp;
        notice.setSender((temp = sysUserService.getUserByPosition("总经理")) == null ? "" : temp.getName());

        Map<String, Object> tempMap = new HashMap<>();
        tempMap.put("originCode", "CBL");
        tempMap.put("position", "仓储部经理");
        List<SysUser> users = sysUserService.getUserByExample(tempMap);
        if (users != null && users.size() > 0) {
            notice.setAudit(users.get(0).getName());
        }
//		notice.setAudit((temp = sysUserService.getUserByPosition("仓储部经理"))==null?"":temp.getName());
        if (!TokenManager.getToken().getOriginCode().equals("CBL"))
            model.addAttribute("targetIdentity", "warehouse");
        else
            model.addAttribute("targetIdentity", "company");

        model.addAttribute("warehouse", warehouse);
        model.addAttribute("concluteList", concluteList);
        model.addAttribute("basepoint", storeEnterpriseList);
        model.addAttribute("notice", notice);
        model.addAttribute("grainTypes", grainTypes);
        model.addAttribute("varietyList",grainTypes);

        return "RotateNotification/" + way.toLowerCase() + "boundnotif_add";
    }

    @RequestMapping(value = "/Add", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> AddInBound(RotateNotice notice, @RequestParam(value = "detailList", required = false) String detailList, @RequestParam(value = "file", required = false) MultipartFile file) throws IOException {
        SysUser user = TokenManager.getToken();

        notice.setCreater(user.getName());
        notice.setCreateTime(new Date());
        notice.setYear(String.valueOf(Calendar.getInstance().get(Calendar.YEAR)));
        notice.setSendStatus(RotateNoticeService.UN_SEND);
        notice.setCreaterId(user.getId());

        List<RotateNoticeDetail> list = JsonUtil.toObject(detailList, RotateNoticeDetail.class);
        for (RotateNoticeDetail detail : list) {
            detail.setId(UUID.randomUUID().toString().replace("-", ""));
        }
        if (file != null) {
            String fileId = UUID.randomUUID().toString().replace("-", "");
            if (sysFileService.uploadFile(httpServletRequest, fileId, file, null).equals("上传成功！")) {
                notice.setAnnex(fileId);
            } else {
                Map<String, Object> returnVal = new HashMap<>();
                returnVal.put("success", false);
                returnVal.put("msg", "文件上传失败");
                return returnVal;
            }
        }

        String batchNumber =  list.get(0).getBatchNumber();
        String identifMark = "";
        if (batchNumber != null && batchNumber != ""){
            //封装手工填报库点的ID值
            identifMark = batchNumber.substring(0,3);
        }

        if (identifMark.equals("CWD")){
            for (int i = 0; i < list.size(); i++){
                List<ManuReportData> manuReportDataList = storageWarehouseService.findWareId(list.get(i).getEnterpriseId());
                for (ManuReportData manuReportData : manuReportDataList){
                    if (list.get(i).getStorageWarehouse().equals(manuReportData.getStorageShortName())){
                        list.get(i).getWarehouse().setId(manuReportData.getId());
                    }
                }
            }
        }


        if (identifMark.equals("CWD")){
            RotateConclute rotateConclute = new RotateConclute();
            rotateConclute.setId(UUID.randomUUID().toString().replaceAll("-", ""));
            List<RotateConcluteDetail> concluteDetails= new ArrayList<>();
            for (RotateNoticeDetail detail : list){
                RotateConcluteDetail concluteDetail = new RotateConcluteDetail();
                concluteDetail.setId(UUID.randomUUID().toString().replaceAll("-", ""));
                concluteDetail.setGrainType(detail.getVariety());
                concluteDetail.setDealSerial(detail.getDealSerial());
                concluteDetail.setStorehouse(detail.getStorehouse());
                concluteDetail.setQuantity(String.valueOf(detail.getPlanNumber()));
                concluteDetails.add(concluteDetail);
            }
            rotateConclute.setDetailList(concluteDetails);
            dao.save(rotateConclute);
        }

        notice.setNoticeDetail(list);
        rotateNoticeService.SaveNotic(notice);
        sysLogService.add(request, "轮换业务-通知书管理-" + notice.getNoticeType() + "通知书-新增");

        Map<String, Object> returnVal = new HashMap<>();
        returnVal.put("success", true);
        return returnVal;
    }

    @RequestMapping(value = "/{way}/Edit", params = {"nId"})
    public String EditBound(Model model, @PathVariable("way") String way, @RequestParam("nId") String nId) {
        List<StorageWarehouse> warehouse = storageWarehouseService.getWarehouseList();
        List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
        model.addAttribute("grainTypes", grainTypes);
        List<StoreEnterprise> storeEnterpriseList = storeEnterpriseService.getEnterpriseList();

        /*获取成交物明细*/
        HashMap<String, Object> param = new HashMap<String, Object>();
        /*获取标的物明细*/
        if (way.equals("In")) {
            param.put("inviteType", "采购");
        } else if (way.equals("Out")) {
            param.put("inviteType", "销售");
        }
        List<RotateConclute> concluteList = rotateConcluteService.list(param);

        RotateNotice notice = rotateNoticeService.GetNoticeDetail(nId);

        List<RotateNoticeDetail> rotateNoticeDetailList  = notice.getNoticeDetail();
        String manuRemark = rotateNoticeDetailList.get(0).getManuReport();
        if ("手工填报".equals(manuRemark)){
            notice.setManuReport("手工填报");
        }


        if (!TokenManager.getToken().getOriginCode().equals("CBL"))
            model.addAttribute("targetIdentity", "warehouse");
        else
            model.addAttribute("targetIdentity", "company");

        SysFile filename = sysFileService.selectById(notice.getAnnex());
        model.addAttribute("filename", filename == null ? null : filename);
        model.addAttribute("warehouse", warehouse);
        model.addAttribute("concluteList", concluteList);
        model.addAttribute("basepoint", storeEnterpriseList);
        model.addAttribute("notice", notice);
        if (filename != null) {
            String downloadUrl = filename.getDownloadUrl();
            String suffix = downloadUrl.substring(downloadUrl.indexOf(".") + 1);
            model.addAttribute("suffix", suffix);
        }
        return "RotateNotification/" + way.toLowerCase() + "boundnotif_add";
    }

    @RequestMapping(value = "/newIn/newEdit", params = {"nId"})
    public String newEditBound(Model model, @RequestParam("nId") String nId) {
        String editView = "RotateNotification/inboundnotif_add";

        List<StorageWarehouse> warehouse = storageWarehouseService.getWarehouseList();
        List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
        model.addAttribute("grainTypes", grainTypes);
        List<StoreEnterprise> storeEnterpriseList = storeEnterpriseService.getEnterpriseList();

        /*获取成交物明细*/
        HashMap<String, Object> param = new HashMap<>();

        /*获取标的物明细*/
        param.put("inviteType", "采购");

        List<RotateConclute> concluteList = rotateConcluteService.list(param);

        RotateNotice notice = rotateNoticeService.GetNoticeDetail(nId);

        List<RotateNoticeDetail> noticeDetailList = notice.getNoticeDetail();

        String batchNumber = noticeDetailList.get(0).getBatchNumber();


        if (batchNumber != null && batchNumber != ""){

            String identifRemark = batchNumber.substring(0,3);

            if (identifRemark.equals("CWD")){
                editView = "RotateNotification/inNewboundnotif_add";
                for (RotateNoticeDetail noticeDetail : noticeDetailList){
                    List<String> enterpriseWarehouseNameList = new ArrayList<>();
                    //查出对应企业下的所有库点
                    List<EnterpriseWarehouse> enterWareHouseList = storageWarehouseService.findAllWareHouseByEnterpriseId(noticeDetail.getEnterpriseId());
                    for (EnterpriseWarehouse enterpriseWarehouse : enterWareHouseList){
                        //查出对应库点下的所有仓号
                        List<String> wareHouseNumberList = storageWarehouseService.findWareNumberByStorage(enterpriseWarehouse.getId());
                        //封装仓号到对应的库点中
                        enterpriseWarehouse.setStoreHouseList(wareHouseNumberList);
                    }

                    for (EnterpriseWarehouse enterpriseWarehouse : enterWareHouseList){
                        if (noticeDetail.getWarehouse().getWarehouseShort().equals(enterpriseWarehouse.getEnterpriseWareHouseName())){
                            List<String> storeHouseList = enterpriseWarehouse.getStoreHouseList();
                            for (String store : storeHouseList){
                                //把所有仓号转移到noticeDetail对应的属性中进行封装
                                enterpriseWarehouseNameList.add(store);
                            }
                        }
                    }
                    //封装仓号
                    noticeDetail.setEnterpriseWarehouseNames(enterpriseWarehouseNameList);
                    noticeDetail.setEnterpriseWarehouses(enterWareHouseList);
                }
            }
        }
        if (!TokenManager.getToken().getOriginCode().equals("CBL"))
            model.addAttribute("targetIdentity", "warehouse");
        else
            model.addAttribute("targetIdentity", "company");

        SysFile filename = sysFileService.selectById(notice.getAnnex());
        model.addAttribute("filename", filename == null ? null : filename);
        model.addAttribute("warehouse", warehouse);
        model.addAttribute("concluteList", concluteList);
        model.addAttribute("basepoint", storeEnterpriseList);
        model.addAttribute("notice", notice);
        if (filename != null) {
            String downloadUrl = filename.getDownloadUrl();
            String suffix = downloadUrl.substring(downloadUrl.indexOf(".") + 1);
            model.addAttribute("suffix", suffix);
        }
        return editView;
    }



    @RequestMapping(value = "/{way}/Edit", method = {RequestMethod.POST})
    @ResponseBody
    public Map EditBound(RotateNotice notice, @PathVariable("way") String way,
                         @RequestParam(value = "detailList", required = false) String detailList,
                         @RequestParam(value = "file", required = false) MultipartFile file) throws IOException {
        RotateNotice noticeBase = rotateNoticeService.GetNoticeDetail(notice.getId());

        Date tempDate = notice.getCompleteDate();
        notice.setCompleteDate(null);
        try {
            UpdateUtil.UpdateField(notice, noticeBase, new String[]{"id", "noticeType", "creater", "creatTime"});
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
        if (detailList != null) {
            List<RotateNoticeDetail> list = JsonUtil.toObject(detailList, RotateNoticeDetail.class);
            for (RotateNoticeDetail detail : list) {
                detail.setId(UUID.randomUUID().toString().replace("-", ""));
            }
            noticeBase.setNoticeDetail(list);
        }
        if (noticeBase.getStatus().equals("已完成")) {
            if (noticeBase.getCompleteDate() == null) {
                if (tempDate == null) {
                    noticeBase.setCompleteDate(Calendar.getInstance().getTime());
                } else {
                    // 判断签发时间是否大于截止时间
                    if (noticeBase.getStorageDate().before(tempDate)) {
                        Map<String, Object> result = new HashMap<>();
                        result.put("success", false);
                        result.put("msg", "签发日期大于截至日期(" + new SimpleDateFormat("yyyy-MM-dd").format(noticeBase.getStorageDate()) + ")");
                        return result;
                    }
                    noticeBase.setCompleteDate(tempDate);    // 签发时间
                }
            }
            noticeBase.setCompleteHumen(TokenManager.getNickname());
            try {
                //签发成功后 出入库通知书推送到库平台
                try {
                    sysOutinrepoNoticeService.sendMessage(noticeBase);
                    sysOutinrepoNoticeService.sendMessageToLangchao(noticeBase);
                } catch (Exception e) {
                    e.printStackTrace();
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (noticeBase.getStatus().equals("驳回")) {
            sysOAService.SendMessage(
                    noticeBase.getCreaterId(),
                    "msg",
                    "通知书被驳回",
                    "您创建的依据为" + noticeBase.getDocumentNumber() + "的通知书被驳回了",
                    "");
        }
        if (file != null) {
            String fileId = UUID.randomUUID().toString().replace("-", "");
            if (sysFileService.uploadFile(httpServletRequest, fileId, file, null).equals("上传成功！")) {
                noticeBase.setAnnex(fileId);
            } else {
                Map<String, Object> returnVal = new HashMap<>();
                returnVal.put("success", false);
                returnVal.put("msg", "文件上传失败");
                return returnVal;
            }
        }
        rotateNoticeService.UpdateNotice(noticeBase);

        String funName = "";
        if ("out".equals(way.toLowerCase())) {
            funName = "出库通知书";
        } else if ("in".equals(way.toLowerCase())) {
            funName = "入库通知书";
        } else if ("move".equals(way.toLowerCase())) {
            funName = "移库通知书";
        }
        sysLogService.add(request, "轮换业务-通知书管理-" + funName + "-" + noticeBase.getStatus());

        Map<String, Object> result = new HashMap<>();
        result.put("success", true);

        return result;
    }

//	@RequestMapping(value="/{way}/ExportExcel",params="nId")
//	@ResponseBody
//	public void ExportNoticeExcel(HttpServletResponse response,@PathVariable("way")String way,@RequestParam("nId")String nId) throws IOException {
//		RotateNotice notice = rotateNoticeService.GetNoticeDetail(nId);
//
//		int totalPlanNumber = 0,totalActualNumber = 0;
//		for(RotateNoticeDetail detail : notice.getNoticeDetail()) {
//			totalPlanNumber += Integer.valueOf(detail.getPlanNumber());
//			totalActualNumber += Integer.valueOf(detail.getActualNumber() == null?"0":detail.getActualNumber());
//		}
//		if(way.equals("In")||way.equals("Out")) {
//			RotateNoticeDetail detail = new RotateNoticeDetail();
//			detail.setVariety("合计");
//			detail.setPipeAttribute("———");
//			detail.setHarvestYear("———");
//			detail.setStorageWarehouse("———");
//			detail.setStorehouse("———");
//			detail.setPlanNumber(String.valueOf(totalPlanNumber));
//			detail.setActualNumber(String.valueOf(totalActualNumber));
//			notice.getNoticeDetail().add(0, detail);
//		}
//
//		String title = notice.getNoticeSerial();
//
//		List<RotateNotice> list = new ArrayList<>();
//		list.add(notice);
//
//		response.setHeader("content-Type", "application/vnd.ms-excel");
//		response.setHeader("Content-Disposition", "attachment;filename=" +  java.net.URLEncoder.encode(title,"UTF-8") + ".xls");
//		response.setCharacterEncoding("UTF-8");
//		Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams(title, title),RotateNotice.class, list);
//
//		workbook.write(response.getOutputStream());
//	}

    @RequestMapping(value = "/{way}/ExportExcel", params = "nId")
    public String ExportNoticeExcel(HttpServletResponse response, @PathVariable("way") String way, @RequestParam("nId") String nId, Model model) throws IOException {
        RotateNotice notice = rotateNoticeService.GetNoticeDetail(nId);

        if (notice.getNoticeType().equals("入库") || notice.getNoticeType().equals("出库")) {
            BigDecimal planCount = new BigDecimal(0);
            BigDecimal realCount = new BigDecimal(0);
            BigDecimal totalCost = new BigDecimal(0);

            for (RotateNoticeDetail item : notice.getNoticeDetail()) {
                planCount = planCount.add(item.getPlanNumber() == null ? BigDecimal.ZERO : item.getPlanNumber());
                realCount = realCount.add(item.getActualNumber() == null ? BigDecimal.ZERO : item.getActualNumber());
                totalCost = totalCost.add(item.getCost() == null ? BigDecimal.ZERO : item.getCost());
            }
            if (notice.getAnnex() != null) {
                model.addAttribute("filename", sysFileService.getByID(notice.getAnnex()).getFileName());
            }
            model.addAttribute("totalCost", totalCost == BigDecimal.ZERO ? "" : totalCost);
            model.addAttribute("planCount", planCount == BigDecimal.ZERO ? "" : planCount);
            model.addAttribute("realCount", realCount == BigDecimal.ZERO ? "" : realCount);
        }

        Map<String, Object> data = new HashMap<>();
        data.put("id", notice.getId());
        data.put("year", notice.getYear());
        model.addAttribute("RN", rotateNoticeService.getRownum(data));
        model.addAttribute("notice", notice);


        String path = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
        request.setAttribute("path", path);

        String title = notice.getNoticeSerial();
        response.setHeader("Content-Disposition", "attachment;fileName=" + java.net.URLEncoder.encode(title, "UTF-8") + ".xls");
        response.setCharacterEncoding("UTF-8");

        return "RotateNotification/notification_export";
    }

    /*@RequestMapping(value = "/{way}/ExportPDF", params = "nId")
    public void ExportNoticePDF(HttpServletResponse response, HttpServletRequest request,
                                @PathVariable("way") String way,
                                @RequestParam("nId") String nId) throws Exception {
        RotateNotice notice = rotateNoticeService.GetNoticeDetail(nId);
        Map<String, Object> data = new HashMap<>();
        data.put("noticeType", notice.getNoticeType());
        data.put("documentNumber", notice.getDocumentNumber());
        data.put("noticeSerial", notice.getNoticeSerial());
        data.put("enterpriseName", notice.getStoreEnterprise() == null || notice.getStoreEnterprise().getEnterpriseName() == null ? "" : notice.getStoreEnterprise().getEnterpriseName());
        data.put("storageDate", new SimpleDateFormat("yyyy年MM月dd日").format(notice.getStorageDate()));
        data.put("sender", notice.getSender() == null ? "" : notice.getSender());
        data.put("audit", notice.getAudit() == null ? "" : notice.getAudit());
        //data.put("audit","");
        data.put("creater", notice.getCreater() == null ? "" : notice.getCreater());
        data.put("completeDate", notice.getCompleteDate() == null ? "未签发" : new SimpleDateFormat("yyyy年MM月dd日").format(notice.getCompleteDate()));
        data.put("remark", notice.getRemark() == null ? "无" : notice.getRemark());
        //data.put("remark", " ");

        BigDecimal planCount = new BigDecimal(0);
        BigDecimal realCount = new BigDecimal(0);
        BigDecimal totalCost = new BigDecimal(0);
        if (notice.getNoticeType().equals("入库") || notice.getNoticeType().equals("出库")) {
            for (RotateNoticeDetail item : notice.getNoticeDetail()) {
                planCount = planCount.add(item.getPlanNumber() == null ? BigDecimal.ZERO : item.getPlanNumber());
                realCount = realCount.add(item.getActualNumber() == null ? BigDecimal.ZERO : item.getActualNumber());
                totalCost = totalCost.add(item.getCost() == null ? BigDecimal.ZERO : item.getCost());
            }
        }


        String realPath = request.getSession().getServletContext().getRealPath("/");
        String path = realPath + "templates/通知书模板.docx";    //	模板内容无法直接更改

        try {

            XWPFDocument doc = WordExportUtil.exportWord07(path, data);
            List<XWPFTable> tables = doc.getTables();
            XWPFTable table = tables.get(0);    // 取第一个表格
            XWPFTableRow rowTemp = table.getRow(1);
            rowTemp.getTableCells().get(1).setText(totalCost == BigDecimal.ZERO ? "" : totalCost.toString());
            rowTemp.getTableCells().get(7).setText(planCount == BigDecimal.ZERO ? "" : planCount.toString());
            rowTemp.getTableCells().get(8).setText(realCount == BigDecimal.ZERO ? "" : realCount.toString());
            for (RotateNoticeDetail noticeDetail : notice.getNoticeDetail()) {
                XWPFTableRow row = table.createRow();
                List<XWPFTableCell> cells = row.getTableCells();
                XWPFTableCell cell1 = cells.get(0);    // 第1个单元格;
                cell1.setText(noticeDetail.getVariety());    //	粮食品种
                XWPFTableCell cell2 = cells.get(1);    // 第2个单元格;
                cell2.setText(noticeDetail.getCost() == null || noticeDetail.getCost() == BigDecimal.ZERO ? "" : noticeDetail.getCost().toString());    //	成本
                XWPFTableCell cell3 = cells.get(2);    // 第3个单元格;
                cell3.setText(noticeDetail.getPipeAttribute());    //	直管属性
                XWPFTableCell cell4 = cells.get(3);    // 第4个单元格;
                cell4.setText(noticeDetail.getHarvestYear());    //	收获年份
                XWPFTableCell cell5 = cells.get(4);    // 第5个单元格;
                cell5.setText(noticeDetail.getEnterpriseName());    //	企业
                XWPFTableCell cell6 = cells.get(5);    // 第6个单元格;
                cell6.setText(noticeDetail.getStorehouse());    //	仓号
                XWPFTableCell cell7 = cells.get(6);    // 第7个单元格;
                cell7.setText(noticeDetail.getWarehouse().getWarehouseShort());    //	库点
                XWPFTableCell cell8 = cells.get(7);    // 第8个单元格;
                cell8.setText(noticeDetail.getPlanNumber().toString());    //	计划数
                XWPFTableCell cell9 = cells.get(8);    // 第9个单元格;
                cell9.setText(noticeDetail.getActualNumber() == null || noticeDetail.getActualNumber() == BigDecimal.ZERO ? "" : noticeDetail.getActualNumber().toString());    //	实际数
                // 表格内容居中
                for (int j = 0; j < cells.size(); j++) {
                    XWPFTableCell cell = cells.get(j);
                    CTTc cttc = cell.getCTTc();
                    CTTcPr ctPr = cttc.addNewTcPr();
                    ctPr.addNewVAlign().setVal(STVerticalJc.CENTER);
                    cttc.getPList().get(0).addNewPPr().addNewJc().setVal(STJc.CENTER);
                }
            }
            table.createRow();

            String prefixPath = realPath + UUID.randomUUID().toString().replace("-", "");
            File file = new File(prefixPath + ".docx");
            FileOutputStream fileOutputStream = new FileOutputStream(file);
            doc.write(fileOutputStream);    // 写出成WORD
            fileOutputStream.flush();
            WordToPdf.word2pdf(prefixPath + ".docx", prefixPath + ".pdf");
            File fileTemp = new File(prefixPath + ".pdf");
            FileUtil.writeFileToResponse(fileTemp, response, notice.getNoticeSerial() + ".pdf", request);
            file.delete();
            fileTemp.delete();
            fileOutputStream.close();
        } catch (Exception e) {
            e.printStackTrace();
        }


//		response.setHeader("content-Type", "application/vnd.ms-excel");
//		response.setHeader("Content-Disposition", "attachment;filename=" +  java.net.URLEncoder.encode(title,"UTF-8") + ".");
//		response.setCharacterEncoding("UTF-8");
    }*/


    @RequestMapping(value = "/{way}/ExportPDFNew", params = "nId")
    public void ExportPDFNew(HttpServletResponse response, HttpServletRequest request,
                             @PathVariable("way") String way,
                             @RequestParam("nId") String nId) throws Exception {
        String html = request.getParameter("html");
        RotateNotice notice = rotateNoticeService.GetNoticeDetail(nId);
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "must-revalidate, no-transform");
        response.setDateHeader("Expires", 0L);
        response.setHeader("Content-Disposition",
                "attachment;filename=\"text.pdf\"");
        Document document = null;
        BufferedOutputStream outStream = null;
        ByteArrayInputStream inputStream = null;
        ServletOutputStream ut = null;
        StringBuffer htmlBuffer = new StringBuffer();

        htmlBuffer
                .append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">");
        htmlBuffer
                .append("<html xmlns=\"http://www.w3.org/1999/xhtml\">")
                .append("<head>")
                .append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />")
                //.append("<style type=\"text/css\" mce_bogus=\"1\">body {font-family: SimSun;}</style>")
                .append("<style type=\"text/css\" mce_bogus=\"1\">body {font-family: SimSun;}" +
                        "*{margin: 0;padding: 0}" +
                        "html,body{width: 100%;height: 100%}\n" +
                        "body {font-family: SimSun;font-size:12px}" +
                        "@media print{\n" +
                        "\t\tinput,.noprint{\n" +
                        "\t\t\tdisplay:none\n" +
                        "\t\t}\n" +
                        "\t\t.printonly{\n" +
                        "\t\t\tdisplay:block;\n" +
                        "\t\t\twidth:100%\n" +
                        "\t\t}\n" +
                        "\t}\n" +
                        "\t@page {\n" +
                        "\t\tsize: auto;\n" +
                        "\t\tmargin: 0mm;\n" +
                        "\t}\n" +
                        "\t#outside {\n" +
                        "\t\tpadding: 1%;\n" +
                        "\t}\n" +
                        "\t#userInfo{\n" +
                        "\t\tpadding:10px 0;\n" +
                        "\t}\n" +
                        "\t#userInfo>span{\n" +
                        "\t\tdisplay: inline-block;\n" +
                        "\t    width: 25%;\n" +
                        "\t    margin: 2px 0;\n" +
                        "\t}\n" +
                        "\t#data-view table{\n" +
                        "\t\twidth:100%;\n" +
                        "\t\ttext-align: center;\n" +
                        "border: 1px solid #000;\n" +
                        "border-collapse: collapse;" +
                        "\t}\n" +
                        "\t#data-view td{\n" +
                        "\t\tpadding:10px 5px;\n" +
                        "border: 1px solid #000;" +
                        "\t}\n" +
                        "\t#data-view tbody tr:hover{\n" +
                        "\t\tbackground:#eee;\n" +
                        "\t}" +
                        "</style>")
                .append("</head>").append("<body>").append(html);
        htmlBuffer.append("</body></html>");


        try {

            document = new Document(PageSize.A4.rotate());
            ut = response.getOutputStream();
            PdfWriter writer = PdfWriter.getInstance(document, ut);
            document.open();
            inputStream = new ByteArrayInputStream(htmlBuffer.toString().getBytes());

            XMLWorkerHelper.getInstance().parseXHtml(writer, document,
                    inputStream, Charset.forName("UTF-8"));

        } catch (Exception startEx) {
            startEx.printStackTrace();
        } finally {
            try {
                if (inputStream != null) {
                    inputStream.close();
                }
                if (outStream != null) {
                    outStream.close();
                }
                if (document != null) {
                    document.close();
                }
            } catch (Exception endEx) {
                endEx.printStackTrace();
            }

        }
    }

    public static String getUpperDate(String date) {

        //支持yyyy-MM-dd、yyyy/MM/dd、yyyyMMdd等格式
        if(date == null) return null;
        //非数字的都去掉
        date = date.replaceAll("\\D", "");
        if(date.length() != 8) return null;
        StringBuilder sb = new StringBuilder();
        for (int i=0;i<4;i++) {//年
            sb.append(upper[Integer.parseInt(date.substring(i, i+1))]);
        }
        sb.append("年");//拼接年
        int month = Integer.parseInt(date.substring(4, 6));
        if(month <= 10) {
            sb.append(upper[month]);
        } else {
            sb.append("十").append(upper[month%10]);
        }
        sb.append("月");//拼接月

        int day = Integer.parseInt(date.substring(6));
        if (day <= 10) {
            sb.append(upper[day]);
        } else if(day < 20) {
            sb.append("十").append(upper[day % 10]);
        } else {
            sb.append(upper[day / 10]).append("十");
            int tmp = day % 10;
            if (tmp != 0) sb.append(upper[tmp]);
        }
        sb.append("日");//拼接日
        return sb.toString();
    }

    @RequestMapping(value = "/{way}/ExportPDFNew1", params = "nId")
    public void ExportPDFNew1(HttpServletResponse response, HttpServletRequest request,
                              @PathVariable("way") String way,
                              @RequestParam("nId") String nId) throws Exception {
        RotateNotice notice = rotateNoticeService.GetNoticeDetail(nId);
        List<RotateNoticeDetail> rotateNoticeDetails = notice.getNoticeDetail();
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "must-revalidate, no-transform");
        response.setDateHeader("Expires", 0L);
        response.setHeader("Content-Disposition",
                "attachment;filename=" + notice.getNoticeSerial() + ".pdf");
        // 1.新建document对象，设定纸张大小，并限定其为横向打印1
        Document document = new Document(PageSize.A4);
        // 2.建立一个书写器(Writer)与document对象关联，通过书写器(Writer)可以将文档写入到磁盘中。
        // 创建 PdfWriter 对象 第一个参数是对文档对象的引用，第二个参数是文件的实际名称，在该名称中还会给出其输出路径。
        PdfWriter writer = PdfWriter.getInstance(document, response.getOutputStream());
        String[] str = {};
        String[] str1 = {"第", "一", "联", "：", "省", "储", "备", "粮", "管", "理", "公", "司", "存", "根"};
        String[] str2 = {"第", "二", "联", "：", "出", "库", "单", "位", "凭", "证"};
        String[] str22 = {"第", "二", "联", "：", "入", "库", "单", "位", "凭", "证"};
        String[] str3 = {"第", "三", "联", "：", "出", "库", "单", "位", "完", "成", "实", "绩", "回", "单"};
        String[] str33 = {"第", "三", "联", "：", "入", "库", "单", "位", "完", "成", "实", "绩", "回", "单"};
        String[] str4 = {"第", "四", "联", "：", "省", "农", "发", "行", "监", "管"};
        String[] str5 = {"第", "五", "联", "：", "省", "储", "备", "粮", "管", "理", "公", "司", "统", "计"};

        List<String[]> strList = new ArrayList();
        strList.add(str1);

        if ("In".equals(way)){
            strList.add(str22);
            strList.add(str33);
        }else {
            strList.add(str2);
            strList.add(str3);
        }

        strList.add(str4);
        strList.add(str5);


        // 3.打开文档
        document.open();
        for (int z = 1; z < 6; z++) {
            PdfContentByte cd = writer.getDirectContent();
            //中文字体,解决中文不能显示问题
            BaseFont bfChinese = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", BaseFont.NOT_EMBEDDED);
            //加粗字体
            Font font = new Font(bfChinese, 20, Font.BOLD);
            Font secondFont = new Font(bfChinese, 18, Font.BOLD);
            //正文字体
            Font zwfont = new Font(bfChinese, 10, Font.NORMAL);
            // 4.添加一个内容段落
            Paragraph chapterTitle = new Paragraph("浙江省省级储备粮油", font);
            //设置段落前后间距
            chapterTitle.setSpacingBefore(10);
            chapterTitle.setSpacingAfter(5);
            //设置居中
            chapterTitle.setAlignment(Element.ALIGN_CENTER);
            document.add(chapterTitle);
            //入库通知书
            Paragraph sectionTitle = new Paragraph(notice.getNoticeType() + "通知书", secondFont);
            //设置段落前后间距
            sectionTitle.setSpacingAfter(5);
            sectionTitle.setAlignment(Element.ALIGN_CENTER);
            document.add(sectionTitle);
            //通知书文号
            Paragraph noticeSerial = new Paragraph(notice.getNoticeSerial(), secondFont);
            //设置段落前后间距
            noticeSerial.setSpacingAfter(5);
            noticeSerial.setAlignment(Element.ALIGN_CENTER);
            document.add(noticeSerial);
            //库点名
            Paragraph thirdTitle = new Paragraph(notice.getStoreEnterprise().getEnterpriseName() + "：", new Font(bfChinese, 16, Font.NORMAL));
            thirdTitle.setAlignment(Element.ALIGN_LEFT);
            thirdTitle.setSpacingAfter(5);

            document.add(thirdTitle);
            //正文

            String documentNumber = notice.getDocumentNumber();
            Paragraph fourTitle;
            if (documentNumber.contains("号文件精神")){
                 fourTitle = new Paragraph("  依据" + documentNumber + "6，安排你单位下列省级储备粮" +
                        "（油）" + notice.getNoticeType() + "，请严格按省定品种、数量、收获年份和承储库点等要求，抓紧做好各项" + notice.getNoticeType() +
                        "工作。出库完成时间截止" + new SimpleDateFormat("yyyy年MM月dd日").format(notice.getStorageDate()) + "。其他有关事项按上述文件精神办理。对拒不执行" + notice.getNoticeType() +
                        "计划的，将按《浙江省地方储备粮管理办法》严肃查处。", zwfont);
            }else {
                fourTitle = new Paragraph("  依据" + documentNumber + "号文件精神，安排你单位下列省级储备粮" +
                        "（油）" + notice.getNoticeType() + "，请严格按省定品种、数量、收获年份和承储库点等要求，抓紧做好各项" + notice.getNoticeType() +
                        "工作。出库完成时间截止" + new SimpleDateFormat("yyyy年MM月dd日").format(notice.getStorageDate()) + "。其他有关事项按上述文件精神办理。对拒不执行" + notice.getNoticeType() +
                        "计划的，将按《浙江省地方储备粮管理办法》严肃查处。", zwfont);
            }

            fourTitle.setFirstLineIndent(20);//首行缩进
            fourTitle.setSpacingAfter(5);
            document.add(fourTitle);

            Paragraph fiveTitle = new Paragraph("单位：成本，元/吨；数量，吨            ", zwfont);
            fiveTitle.setAlignment(Element.ALIGN_RIGHT);
            document.add(fiveTitle);

            //单位

            cd.beginText();
            cd.setTextRenderingMode(0);
            cd.setFontAndSize(bfChinese, 10);

            for (int i = 0; i < strList.get(z - 1).length; i++) {
                str = strList.get(z - 1);
                if((z & 1) == 0){
                    cd.setTextMatrix(539, 562 - 18 * i);
                }else {
                    cd.setTextMatrix(539, 597 - 18 * i);
                }
                cd.showText(str[i]);
            }

            cd.endText();
            //插入动态表格
            // 7列的表.
            PdfPTable table = new PdfPTable(7);
            table.setWidthPercentage(95); // 宽度100%填充
            table.setSpacingBefore(5f); // 前间距
            table.setSpacingAfter(10f); // 后间距
            table.setHorizontalAlignment(Element.ALIGN_LEFT);

            List<PdfPRow> listRow = table.getRows();

            BigDecimal planCount = new BigDecimal(0);
            BigDecimal realCount = new BigDecimal(0);
            BigDecimal totalCost = new BigDecimal(0);
            // 统计成本，计划数，实际数
            if (notice.getNoticeType().equals("入库") || notice.getNoticeType().equals("出库")) {
                for (RotateNoticeDetail item : notice.getNoticeDetail()) {
                    planCount = planCount.add(item.getPlanNumber() == null ? BigDecimal.ZERO : item.getPlanNumber());
                    realCount = realCount.add(item.getActualNumber() == null ? BigDecimal.ZERO : item.getActualNumber());
                    totalCost = totalCost.add(item.getCost() == null ? BigDecimal.ZERO : item.getCost());
                }
            }


            String[] thead = {"品种", "成本", "直管属性", "收获年份", "储存库点及仓号", "计划数", "实绩数"};
            for (int i = 0; i < 7; i++) {
                PdfPCell cells[] = new PdfPCell[7];
                PdfPRow row = new PdfPRow(cells);
                if (i == 0) {
                    for (int j = 0; j < thead.length; j++) {
                        cells[j] = new PdfPCell(new Paragraph(thead[j], zwfont));
                        cells[j].setHorizontalAlignment(Element.ALIGN_CENTER);
                        cells[j].setVerticalAlignment(Element.ALIGN_MIDDLE);
                        cells[j].setMinimumHeight(36);
                    }
                } else if (i == 1) {
                    for (int j = 0; j < thead.length; j++) {
                        if (j == 0) {
                            cells[j] = new PdfPCell(new Paragraph("合计", zwfont));
                        } else if (j == 1) {
                            cells[j] = new PdfPCell(new Paragraph(totalCost.toString(), zwfont));        // 成本
                        } else if (j == 5) {
                            cells[j] = new PdfPCell(new Paragraph(planCount.toString(), zwfont));    // 计划数
                        } else if (j == 6) {
                            cells[j] = new PdfPCell(new Paragraph("", zwfont));    // 实绩数
                        } else {
                            cells[j] = new PdfPCell(new Paragraph("---", zwfont));
                        }
                        cells[j].setHorizontalAlignment(Element.ALIGN_CENTER);
                        cells[j].setVerticalAlignment(Element.ALIGN_MIDDLE);
                        cells[j].setMinimumHeight(36);
                    }
                } else if (i > 1 && i < rotateNoticeDetails.size() + 2) {
                    for (int j = 0; j < thead.length; j++) {
                        RotateNoticeDetail rotateNoticeDetail = rotateNoticeDetails.get(i - 2);
                        if (j == 0) {
                            //品种
                            cells[j] = new PdfPCell(new Paragraph(rotateNoticeDetail.getVariety(), zwfont));
                        } else if (j == 1) {
                            //成本
                            cells[j] = new PdfPCell(new Paragraph(rotateNoticeDetail.getCost() == null || rotateNoticeDetail.getCost() == BigDecimal.ZERO ? "" : rotateNoticeDetail.getCost().toString(), zwfont));
                        } else if (j == 2) {
                            //直管属性
                            cells[j] = new PdfPCell(new Paragraph(rotateNoticeDetail.getPipeAttribute(), zwfont));
                        } else if (j == 3) {
                            //收获年份
                            cells[j] = new PdfPCell(new Paragraph(rotateNoticeDetail.getHarvestYear(), zwfont));
                        } else if (j == 4) {
                            //储存库点及仓号
                            cells[j] = new PdfPCell(new Paragraph(rotateNoticeDetail.getWarehouse() == null ? rotateNoticeDetail.getStorehouse() : rotateNoticeDetail.getWarehouse().getWarehouseShort() + rotateNoticeDetail.getStorehouse() + "仓", zwfont));
                        } else if (j == 5) {
                            //计划数
                            cells[j] = new PdfPCell(new Paragraph(rotateNoticeDetail.getPlanNumber().toString(), zwfont));
                        } else if (j == 6) {
                            //实绩数
                            cells[j] = new PdfPCell(new Paragraph("", zwfont));
                        }
                        cells[j].setHorizontalAlignment(Element.ALIGN_CENTER);
                        cells[j].setVerticalAlignment(Element.ALIGN_MIDDLE);
                        cells[j].setMinimumHeight(36);
                    }
                } else if (i > rotateNoticeDetails.size() + 1 && i < 6) {
                    for (int j = 0; j < thead.length; j++) {
                        cells[j] = new PdfPCell(new Paragraph("", zwfont));
                        cells[j].setHorizontalAlignment(Element.ALIGN_CENTER);
                        cells[j].setVerticalAlignment(Element.ALIGN_MIDDLE);
                        cells[j].setMinimumHeight(36);
                    }
                } else {
                    for (int j = 0; j < thead.length; j++) {
                        if (j == 0) {
                            cells[j] = new PdfPCell(new Paragraph("备注", zwfont));
                        } else {
                            cells[j] = new PdfPCell(new Paragraph("", zwfont));
                            cells[j].setColspan(6);
                        }
                        cells[j].setHorizontalAlignment(Element.ALIGN_CENTER);
                        cells[j].setVerticalAlignment(Element.ALIGN_MIDDLE);
                        cells[j].setMinimumHeight(36);
                    }
                }
                listRow.add(row);
            }
            //把表格添加到文件中
            document.add(table);
            //签发单位负责人(居左)
            String sender = notice.getSender() == null ? "" : notice.getSender();
            String audit = notice.getAudit() == null ? "" : notice.getAudit();
            String creater = notice.getCreater() == null ? "" : notice.getCreater();
            Paragraph auditPerson = new Paragraph("签发单位负责人:     "
                    + sender + "                                                                    "
                    +  "审核:     "
                    + audit + "                                                                " + "经办人:     " +
                    creater, zwfont);
            //设置段落前后间距
            //        auditPerson.setSpacingBefore(5);
            //设置居中
            auditPerson.setAlignment(Element.ALIGN_LEFT);
            auditPerson.setSpacingBefore(10);
            document.add(auditPerson);

            //签发时间居右
            String date = notice.getCompleteDate() == null ? "" : getUpperDate(new SimpleDateFormat("yyyy-MM-dd").format(notice.getCompleteDate()));
            Paragraph auditDate = new Paragraph("签发时间(盖章) :   " + date + "  ", zwfont);
            //设置段落前后间距
            //设置居右
            auditDate.setAlignment(Element.ALIGN_RIGHT);
            auditDate.setSpacingBefore(90);
            document.add(auditDate);
            document.newPage();
        }
        // 5.关闭文档
        document.close();
        //关闭书写器
        writer.close();
    }

    @RequestMapping(value = "/Move/ExportExcel", params = "nId")
    @ResponseBody
    public void ExportMoveNoticeExcel(HttpServletResponse response, @RequestParam("nId") String nId) throws IOException {
        RotateNotice notice = rotateNoticeService.GetNoticeDetail(nId);

        List<MoveBound> list = new ArrayList<>();

        for (RotateNoticeDetail item : notice.getNoticeDetail()) {
            MoveBound moveBound = new MoveBound();
            moveBound.setActualNumber(item.getActualNumber());
            moveBound.setImmigrationUnit(item.getImmigrationUnit());
            moveBound.setPlanNumber(item.getPlanNumber());
            moveBound.setRemovalUnit(item.getRemovalUnit());
            moveBound.setStorageWarehouse(item.getStorageWarehouse());
            moveBound.setVariety(item.getVariety());
            list.add(moveBound);
        }

        String title = notice.getNoticeSerial();

        response.setHeader("content-Type", "application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename=" + java.net.URLEncoder.encode(title, "UTF-8") + ".xls");
        response.setCharacterEncoding("UTF-8");
        Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams(title, title), MoveBound.class, list);

        workbook.write(response.getOutputStream());
    }

    @RequestMapping(value = "/Detail", params = {"nId"})
    public String NotificationDetail(Model model, @RequestParam("nId") String nId) {
        RotateNotice notice = rotateNoticeService.GetNoticeDetail(nId);

        if (notice.getNoticeType().equals("入库") || notice.getNoticeType().equals("出库")) {
            BigDecimal realCount = new BigDecimal(0);
            BigDecimal planCount = new BigDecimal(0);
            BigDecimal totalCost = new BigDecimal(0);
            for (RotateNoticeDetail item : notice.getNoticeDetail()) {
                planCount = planCount.add(item.getPlanNumber() == null ? BigDecimal.ZERO : item.getPlanNumber());
                realCount = realCount.add(item.getActualNumber() == null ? BigDecimal.ZERO : item.getActualNumber());
                totalCost = totalCost.add(item.getCost() == null ? BigDecimal.ZERO : item.getCost());
            }
            if (notice.getAnnex() != null) {
                SysFile filename = sysFileService.getByID(notice.getAnnex());
                model.addAttribute("filename", filename);
                if (filename != null) {
                    String downloadUrl = filename.getDownloadUrl();
                    String suffix = downloadUrl.substring(downloadUrl.indexOf(".") + 1);
                    model.addAttribute("suffix", suffix);
                }
            }
            model.addAttribute("totalCost", totalCost == BigDecimal.ZERO ? "" : totalCost);
            model.addAttribute("planCount", planCount == BigDecimal.ZERO ? "" : planCount);
            model.addAttribute("realCount", realCount == BigDecimal.ZERO ? "" : realCount);
        }

        Map<String, Object> data = new HashMap<>();
        data.put("id", notice.getId());
        data.put("year", notice.getYear());
        model.addAttribute("RN", rotateNoticeService.getRownum(data));
        model.addAttribute("notice", notice);
        return "RotateNotification/notification_detail";
    }

    @RequestMapping(value = "/GetNotice", method = RequestMethod.POST)
    @ResponseBody
    public RotateNotice NotificationDetail(@RequestParam("nId") String nId) {
        return rotateNoticeService.GetNoticeDetail(nId);
    }

    @SysLogAn("访问：轮换业务-通知书管理-提货单汇总")
    @RequestMapping(value = "/TakeTotal", method = RequestMethod.GET)
    public String RotateTakeTotal(Model model) {
        List<RotateTakeTotal> rotateTakeTotalList = rotateTakeTotalService.listRotateTakeTotal();
        model.addAttribute("takeTotalList",rotateTakeTotalList);
        return "RotateNotification/rotatetaketotal_view";
    }

    @RequestMapping(value = "/TakeTotal/Index", method = RequestMethod.POST)
    @ResponseBody
    public List<RotateTakeTotal> RotateTakeTotalIndex(@RequestBody RotateTakeTotal rotateTakeTotal) {

        String beginDistributionDate = rotateTakeTotal.getBeginDistributionDate();
        String endDistributionDate = rotateTakeTotal.getEndDistributionDate();
        if(beginDistributionDate != null && beginDistributionDate.trim() != "") {
            beginDistributionDate = rotateTakeTotal.getBeginDistributionDate() + " " + "00:00:00";
        }
        if (endDistributionDate != null && endDistributionDate.trim() != "") {
            endDistributionDate = rotateTakeTotal.getEndDistributionDate() + " " + "23:59:59";
        }
        rotateTakeTotal.setBeginDistributionDate(beginDistributionDate);
        rotateTakeTotal.setEndDistributionDate(endDistributionDate);
        List<RotateTakeTotal> rotateTakeTotalList = rotateTakeTotalService.limitByParams(rotateTakeTotal);
        return  rotateTakeTotalList;
    }

    @SysLogAn("访问：轮换业务-通知书管理-提货单")
    @RequestMapping(value = "/Take", method = RequestMethod.GET)
    public String RotateTakeIndex(Model model, @RequestParam(value = "type") String type) {
        PageUtil<RotateTakeMain> pageUtil = new PageUtil<>();
        pageUtil.setPageIndex(1);
        pageUtil.setPageSize(Integer.valueOf(prop.get("PageSize").toString()));
        RotateTakeMain rotateTakeMain = new RotateTakeMain();
        pageUtil.setEntity(rotateTakeMain);

        if (TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl"))
            type = "warehouse";
        else
            type = "base";

        if (type != null && type.toLowerCase().equals("warehouse")) {
            //查看全部不做任何操作
        } else if (type != null && type.toLowerCase().equals("base")) {
            SysUser user = TokenManager.getToken();
            String warehouseCode = user.getOriginCode().toUpperCase();
            Map<String, Object> map = new HashMap<>();
            map.put("warehouseCode", warehouseCode);
            pageUtil.setOtherPram(map);
            //rotateTakeMain.setStatus("已完成");
            rotateTakeMain.setStatus("");
        }

        pageUtil.setResult(rotateTakeMainService.limitByParams(pageUtil));

        model.addAttribute("type", type);
        model.addAttribute("takelist", pageUtil);
        return "RotateNotification/rotatetake_view";
    }

    @RequestMapping(value = "/Take/{pageindex}", method = RequestMethod.POST)
    @ResponseBody
    public PageUtil RotateTakeIndex(@RequestBody RotateTakeMain rotateTakeMain, @PathVariable("pageindex") Integer pageindex) {
        PageUtil<RotateTakeMain> pageUtil = new PageUtil<>();
        pageUtil.setPageIndex(pageindex);
        pageUtil.setPageSize(10);
        pageUtil.setEntity(rotateTakeMain);
        String type = null;
        if (TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl"))
            type = "warehouse";
        else
            type = "base";

        if (type != null && type.toLowerCase().equals("warehouse")) {
            //查看全部不做任何操作
        } else if (type != null && type.toLowerCase().equals("base")) {
            SysUser user = TokenManager.getToken();
            String warehouseCode = user.getOriginCode().toUpperCase();
            Map<String, Object> map = new HashMap<>();
            map.put("warehouseCode", warehouseCode);
            pageUtil.setOtherPram(map);
            //rotateTakeMain.setStatus("已完成");
            if(rotateTakeMain.getStatus()=="全部"){
                rotateTakeMain.setStatus("");
            }
        }

        pageUtil.setResult(rotateTakeMainService.limitByParams(pageUtil));
        //pageUtil.setTotalCount(list.size());
        return pageUtil;
    }

    @RequestMapping(value = "/Take", method = RequestMethod.POST)
    @ResponseBody
    public PageUtil RotateTakeIndex(RotateTake rotateTake, @RequestParam("pageindex") int pageindex, @RequestParam("pagesize") int pagesize) {
        PageUtil<RotateTake> pageUtil = new PageUtil<>();
        pageUtil.setPageIndex(pageindex);
        pageUtil.setPageSize(pagesize);
        pageUtil.setEntity(rotateTake);
        String type = "";
        if (TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl"))
            type = "warehouse";
        else
            type = "base";

        if (type != null && type.toLowerCase().equals("warehouse")) {
            //查看全部不做任何操作
        } else if (type != null && type.toLowerCase().equals("base")) {
            SysUser user = TokenManager.getToken();
            String company = user.getShortName();
            rotateTake.setReserveUnit(company);
            rotateTake.setStatus("已完成");
        }
        List<RotateTake> list = rotateTakeService.ListLimitTake(pageUtil);
        pageUtil.setResult(list);
        return pageUtil;
    }

    @RequestMapping(value = "/Take/Add", method = RequestMethod.GET)
    public String AddRotateTake(Model model, @RequestParam(value = "id", required = false) String id) {
        List<SysDict> varietyList = sysDictService.getSysDictListByType("粮油品种");
        model.addAttribute("varietyList", varietyList);
        List<SysDict> storeType = sysDictService.getSysDictListByType("粮油存储方式");
        model.addAttribute("storeType", storeType);
        RotateTakeMain rotateTakeMain = null;
        if (id != null) {
            rotateTakeMain = rotateTakeMainService.getById(id);
        } else {
            SysUser user = TokenManager.getToken();
            rotateTakeMain = new RotateTakeMain(Calendar.getInstance().getTime());
            rotateTakeMain.setCreater(user.getName());
            /*自动生成提货单编号（年份+001）（取出最大的一个，取出前4位，判断当前年份是否等于
            前四位，如果等于则后三位+1，如果不等于则年份+001）*/
            String maxSerial = rotateTakeMainService.getMaxSerial();
            if(maxSerial.length() == 7){
                //获取当前年份
                Calendar calendar = Calendar.getInstance();
                String nowYear = String.valueOf(calendar.get(Calendar.YEAR));
                String year = maxSerial.substring(0,4);
                String flowNum = maxSerial.substring(4,maxSerial.length());
                String serial = null;
                if(!nowYear.equals(year)){
                    serial = nowYear+"001";
                }else{
                    int length = String.valueOf(Integer.parseInt(flowNum) + 1).length();
                    if(length==1) {
                        serial = year + "00"+(Integer.parseInt(flowNum) + 1);
                    }else if(length == 2){
                        serial = year + "0"+(Integer.parseInt(flowNum) + 1);
                    }else if(length == 3){
                        serial = year + (Integer.parseInt(flowNum) + 1);
                    }
                }
                rotateTakeMain.setSerial(serial);
            }

        }

        HashMap<String, Object> param = new HashMap<>();
        param.put("inviteType", "销售");

        List<RotateConclute> concluteList = rotateConcluteService.list(param);

        //公司给所有库点添加、直属库点给监管库点添加
        SysUser user = TokenManager.getToken();
        List kudianCodes = storageWarehouseService.listKudianCode();
        boolean isKudian = kudianCodes.contains(user.getOriginCode());
        List<StorageWarehouse> storageWarehouses = new ArrayList<StorageWarehouse>();
        if (user.getOriginCode() != null
                && BusinessConstants.CBL_CODE.equals(user.getOriginCode().toLowerCase())) {
            //公司人员登录
            storageWarehouses = storageWarehouseService.getWarehouseList();
        } else if (isKudian) {
            //直属库点人员登录
            storageWarehouses = storageWarehouseService.limitList();
        }
        SysUser user1=new SysUser();
        String name=rotateTakeMain.getCreater();
        if(id!=null){
            user1=sysUserService.selectById(rotateTakeMain.getCreater());
            model.addAttribute("name",user1.getName());
        }
        else{
            model.addAttribute("name",name);
        }
        //SysUser user1=sysUserService.selectById(rotateTakeMain.getCreater());
        //String name=rotateNoticeService.getName(rotateTakeMain.getCreater().toString());
        model.addAttribute("basepoint", storageWarehouses);
        model.addAttribute("concluteList", concluteList);
        model.addAttribute("take", rotateTakeMain);
       // model.addAttribute("name",user1.getName());
        return "RotateNotification/rotatetake_add_new";
    }

    @RequestMapping(value = "/judge", method = RequestMethod.GET)
    @ResponseBody
    public Map judgeAmount( @RequestParam(value = "deal_serial", required = false)String deal_serial,
                            @RequestParam(value = "number", required = false)String number,
                             @RequestParam(value = "id", required = false)String id) {
        double number_pick=0;
        double weight=0;
        List<String> rotateTakes=rotateTakeMainService.getAmount(deal_serial);
        List<String> rotateClaims=rotateTakeMainService.getWeight(deal_serial);
        if(id!=""){
            String number_pick2=rotateTakeMainService.getAmountById(id);
            weight=weight+Double.parseDouble(number_pick2);
        }
        if(!rotateClaims.isEmpty()){
           if(rotateClaims.size()==1){
              weight=Double.parseDouble(rotateClaims.get(0).toString());
           }
           else{
               for(int i=0;i<rotateClaims.size();i++){
                   weight=weight+Double.parseDouble(rotateClaims.get(i).toString());
               }
           }
        }

        if(!rotateTakes.isEmpty()){
            if(rotateTakes.size()==1){
                number_pick=Double.parseDouble(rotateTakes.get(0).toString());
            }
            else{
                for(int i=0;i<rotateTakes.size();i++){
                    number_pick=number_pick+Double.parseDouble(rotateTakes.get(i).toString());
                }
            }
        }
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
//        System.out.print(Double.parseDouble(number));
//        System.out.print(number_pick);
//        System.out.print(weight);
        if(Double.parseDouble(number)+number_pick>weight){
            result.put("success",false);
        }else {
           result.put("success",true);
        }
        return  result;
    }

    @SysLogAn("轮换业务-通知书管理-提货单-新增")
    @RequestMapping(value = "/Take/Add", method = RequestMethod.POST)
    @ResponseBody
    public Map AddRotateTake(@RequestBody RotateTakeMain rotateTakeMain) {
        SysUser user = TokenManager.getToken();
//先判断，格式是否正确，编号是否重复，如果重复自动生成，如果不重复则判断大小，如果小于最大值，则重新生成
        String serial = rotateTakeMain.getSerial();

        /*RotateTakeMain bySerial = rotateTakeMainService.getBySerial(serial);
        if(bySerial != null){
            //
        }*/
        String maxSerial = rotateTakeMainService.getMaxSerial();
        //判断是否需要重新生成

        boolean flag = checkSerial(serial,maxSerial);
        if(!flag){
            //自动生成
           String newSerial =  generateFlowNum(maxSerial);
            rotateTakeMain.setSerial(newSerial);
        }
        rotateTakeMain.setCreater(user.getId());

        rotateTakeMainService.save(rotateTakeMain);
//		rotateTakeService.AddRotateTake(rotateTake);

        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        return result;
    }

    @RequestMapping(value = "/Take/Edit", method = RequestMethod.POST)
    @ResponseBody
    public Map EditRotateTake(@RequestBody RotateTakeMain rotateTakeMain) {
//		RotateTake takeBase = rotateTakeService.GetRotateTake(rotateTake.getId());
        RotateTakeMain takeBaseMain=rotateTakeMainService.getById(rotateTakeMain.getId());
        takeBaseMain.setRotateTakes(rotateTakeService.getByMainId(rotateTakeMain.getId()));

		try {
			UpdateUtil.UpdateField(rotateTakeMain, takeBaseMain, new String[] {"id"});
		} catch (IllegalArgumentException | IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


        // 中穗库提货单接口
//		if(takeBase.getStatus().equals("已完成")) {
//			takeBase.setCompleteDate(Calendar.getInstance().getTime());
//            sysLadingReceiptService.sendMessage(takeBase);
//		}
        if(takeBaseMain.getStatus().equals("已完成")){
            takeBaseMain.setCompleteDate(Calendar.getInstance().getTime());
            sysLadingReceiptService.sendMessage(takeBaseMain);
        }


        if ("已完成".equals(rotateTakeMain.getStatus())) {
            rotateTakeMain.setCompleteDate(Calendar.getInstance().getTime());
        }
        rotateTakeMainService.update(rotateTakeMain);
        sysLogService.add(request, "轮换业务-通知书管理-提货单-" + rotateTakeMain.getStatus());

        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        return result;
    }

    @RequestMapping(value = "/Take/Detail", method = RequestMethod.GET)
    public String RotateTakeDetail(Model model, @RequestParam(value = "id") String id) {
        RotateTakeMain rotateTakeMain = rotateTakeMainService.getById(id);
//		RotateTake rotateTake = rotateTakeService.GetRotateTake(id);

        StringBuffer title = new StringBuffer();
        // 查询接收库点所属公司
        StorageWarehouse storageWarehouse = storageWarehouseService.getWarehouseById(rotateTakeMain.getReceiveWarehouseId());
        StoreEnterprise storeEnterprise = storeEnterpriseService.getStoreEnterpriseByID(storageWarehouse.getEnterpriseId());
        Map<String, StringBuffer> titleMap = new HashMap<>();
        for (RotateTake rotateTake : rotateTakeMain.getRotateTakes()) {
            if (!titleMap.containsKey(rotateTake.getAcceptanceUnitId())) {
                StringBuffer sb = new StringBuffer();
                sb.append(rotateTake.getAcceptanceUnit());
                sb.append("省级储备");
                sb.append(rotateTake.getVariety());
                sb.append(rotateTake.getThisShipment());
                sb.append("吨(");
                sb.append(rotateTakeMain.getReceiveWarehouse());
                sb.append(rotateTake.getStoreEncode());
                sb.append("号仓)");
                titleMap.put(rotateTake.getAcceptanceUnitId(), sb);
            } else {
                StringBuffer sb = titleMap.get(rotateTake.getAcceptanceUnitId());
                sb.append("、");
                sb.append(rotateTake.getVariety());
                sb.append(rotateTake.getThisShipment());
                sb.append("吨(");
                sb.append(rotateTakeMain.getReceiveWarehouse());
                sb.append(rotateTake.getStoreEncode());
                sb.append("号仓)");
            }
        }

        for (StringBuffer stringBuffer : titleMap.values()) {
            title.append(stringBuffer);
            title.append("，");
        }

        for (int i = rotateTakeMain.getRotateTakes().size(); i < 5; i++) {
            rotateTakeMain.getRotateTakes().add(new RotateTake());
        }

        model.addAttribute("take", rotateTakeMain);
        model.addAttribute("title", title.toString());
        model.addAttribute("storeEnterprise", storeEnterprise);
        return "RotateNotification/rotatetake_detail";
    }

    @SysLogAn("轮换业务-通知书管理-提货单汇总-导出")
    @RequestMapping(value = "/exportExcel", method = RequestMethod.GET)
    public String ExportTakeTotalExcel(HttpServletResponse response,HttpServletRequest request) throws IOException{
        RotateTakeTotal rotateTakeTotal=new RotateTakeTotal();
        String wareHouseShort=request.getParameter("wareHouseShort");
        String beginDistributionDate = request.getParameter("beginDistributionDate");
        String endDistributionDate = request.getParameter("endDistributionDate");
        if(beginDistributionDate != null && beginDistributionDate.trim() != "") {
            beginDistributionDate = beginDistributionDate + " " + "00:00:00";
        }
        if (endDistributionDate != null && endDistributionDate.trim() != "") {
            endDistributionDate = endDistributionDate + " " + "23:59:59";
        }
        rotateTakeTotal.setBeginDistributionDate(beginDistributionDate);
        rotateTakeTotal.setEndDistributionDate(endDistributionDate);
        rotateTakeTotal.setWareHouseShort(wareHouseShort);
        List<RotateTakeTotal> rotateTakeTotalList = rotateTakeTotalService.limitByParams(rotateTakeTotal);
        String fileName = "提货单汇总.xls";
        try {
            fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
        request.setAttribute("exportList", rotateTakeTotalList);
        return "/RotateNotification/export";

    }

    @RequestMapping(value = "/Take/ExportExcel", params = "id")
    @ResponseBody
    public void ExportTakeExcel(HttpServletResponse response, @RequestParam("id") String id) throws IOException {
        RotateTake rotateTake = rotateTakeService.GetRotateTake(id);

        String title = "提货单";

        List<RotateTake> list = new ArrayList<>();
        list.add(rotateTake);

        response.setHeader("content-Type", "application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename=" + java.net.URLEncoder.encode(title, "UTF-8") + ".xls");
        response.setCharacterEncoding("UTF-8");
        Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams(title, title), RotateTake.class, list);

        workbook.write(response.getOutputStream());
    }

    @RequestMapping(value = "/Take/ExportExcelByJsp", params = "id")
    public String ExportExcelByJsp(HttpServletResponse response, @RequestParam("id") String id) {
        String fileName = "提货单.xls";
        StringBuffer title = new StringBuffer();
        try {
            fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        RotateTakeMain rotateTakeMain = rotateTakeMainService.getById(id);
        // 查询接收库点所属公司
        StorageWarehouse storageWarehouse = storageWarehouseService.getWarehouseById(rotateTakeMain.getReceiveWarehouseId());
        StoreEnterprise storeEnterprise = storeEnterpriseService.getStoreEnterpriseByID(storageWarehouse.getEnterpriseId());
        Map<String, StringBuffer> titleMap = new HashMap<>();
        for (RotateTake rotateTake : rotateTakeMain.getRotateTakes()) {
            if (!titleMap.containsKey(rotateTake.getAcceptanceUnitId())) {
                StringBuffer sb = new StringBuffer();
                sb.append(rotateTake.getAcceptanceUnit());
                sb.append("省级储备");
                sb.append(rotateTake.getVariety());
                sb.append(rotateTake.getThisShipment());
                sb.append("吨(");
                sb.append(rotateTakeMain.getReceiveWarehouse());
                sb.append(rotateTake.getStoreEncode());
                sb.append("号仓)");
                titleMap.put(rotateTake.getAcceptanceUnitId(), sb);
            } else {
                StringBuffer sb = titleMap.get(rotateTake.getAcceptanceUnitId());
                sb.append("、");
                sb.append(rotateTake.getVariety());
                sb.append(rotateTake.getThisShipment());
                sb.append("吨(");
                sb.append(rotateTakeMain.getReceiveWarehouse());
                sb.append(rotateTake.getStoreEncode());
                sb.append("号仓)");
            }
        }

        for (StringBuffer stringBuffer : titleMap.values()) {
            title.append(stringBuffer);
            title.append("，");
        }

        response.setHeader("Content-Disposition", "attachment;fileName=" + fileName);
        request.setAttribute("take", rotateTakeMain);
        request.setAttribute("title", title.toString());
        request.setAttribute("storeEnterprise", storeEnterprise);
        return "RotateNotification/exportTakeOrder";
    }

    @RequestMapping(value = "/Take/ExportExcelByTemplate", params = "id")
    @ResponseBody
    public void ExportExcelByTemplate(HttpServletRequest request, HttpServletResponse response, @RequestParam("id") String id) throws Exception {
        TemplateExportParams params = new TemplateExportParams(request.getSession().getServletContext().getRealPath("\\") + "\\templates\\提货单模板.xlsx");
        Map<String, Object> excelEntity = new HashMap();
        String fileName = "提货单";
        try {
            //fileName = new String(fileName.getBytes("UTF-8"), "iso-8859-1");
//			fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
            String userAgent = request.getHeader("USER-AGENT");
            //String finalFileName = null;
            if (StringUtils.contains(userAgent, "MSIE")) {//IE浏览器
                fileName = URLEncoder.encode(fileName, "UTF8");
            } else if (StringUtils.contains(userAgent, "Mozilla")) {//google,火狐浏览器
                fileName = new String(fileName.getBytes(), "ISO8859-1");
            } else {
                fileName = URLEncoder.encode(fileName, "UTF8");//其他浏览器
            }
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        StringBuffer title = new StringBuffer();
        RotateTakeMain rotateTakeMain = rotateTakeMainService.getById(id);
        // 查询接收库点所属公司
        StorageWarehouse storageWarehouse = storageWarehouseService.getWarehouseById(rotateTakeMain.getReceiveWarehouseId());
        StoreEnterprise storeEnterprise = storeEnterpriseService.getStoreEnterpriseByID(storageWarehouse.getEnterpriseId());
        Map<String, StringBuffer> titleMap = new HashMap<>();
        for (RotateTake rotateTake : rotateTakeMain.getRotateTakes()) {
            if (!titleMap.containsKey(rotateTake.getAcceptanceUnitId())) {
                StringBuffer sb = new StringBuffer();
                sb.append(rotateTake.getAcceptanceUnit());
                sb.append("省级储备");
                sb.append(rotateTake.getVariety());
                sb.append(rotateTake.getThisShipment());
                sb.append("吨(");
                sb.append(rotateTakeMain.getReceiveWarehouse());
                sb.append(rotateTake.getStoreEncode());
                sb.append("号仓)");
                titleMap.put(rotateTake.getAcceptanceUnitId(), sb);
            } else {
                StringBuffer sb = titleMap.get(rotateTake.getAcceptanceUnitId());
                sb.append("、");
                sb.append(rotateTake.getVariety());
                sb.append(rotateTake.getThisShipment());
                sb.append("吨(");
                sb.append(rotateTakeMain.getReceiveWarehouse());
                sb.append(rotateTake.getStoreEncode());
                sb.append("号仓)");
            }
        }

        for (StringBuffer stringBuffer : titleMap.values()) {
            title.append(stringBuffer);
            title.append("，");
        }
        Date a = rotateTakeMain.getCompleteDate();
        DateFormat format = new SimpleDateFormat("yyyy年MM月dd日");
        String completeDate = format.format(a);
        excelEntity.put("storeEnterprise", storeEnterprise == null ? "" : storeEnterprise);
        excelEntity.put("take", rotateTakeMain == null ? "" : rotateTakeMain);
        excelEntity.put("completeDate", completeDate == null ? "" : completeDate);
        excelEntity.put("title", title == null ? "" : title);
        response.setHeader("content-Type", "application/vnd.ms-excel");
        response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".xlsx");
        response.setCharacterEncoding("UTF-8");
        Workbook workbook = ExcelExportUtil.exportExcel(params, excelEntity);
        workbook.write(response.getOutputStream());
    }

    @RequestMapping(value = "/GetNoticeByDealSerial")
    @ResponseBody
    public ActionResultModel GetNoticeByDealSerial(@RequestParam("dealSerial") String dealSerial) throws IOException {
        SysUser user = TokenManager.getToken();
        HashMap<String, Object> map = new HashMap<>();
        map.put("dealSerial", dealSerial);
        map.put("status", "已完成");
        if (null != user.getShortName() || !"".equals(user.getShortName()))
            map.put("acceptUnit", user.getShortName());
        ActionResultModel resultModel = new ActionResultModel();
        RotateNotice notice = rotateNoticeService.GetNoticeByDealSerial(map);
        if (null == notice) {
            resultModel.setSuccess(false);
            resultModel.setMsg("该交易明细没有对应的出入库通知单");
        } else {
            resultModel.setSuccess(true);
            resultModel.setData(notice);
        }


        return resultModel;
    }


    /**
     * 通知书编号是否存在
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/isRotateNotif")
    public ActionResultModel rotateNotifIsExistence(@RequestBody Map<String, Object> map) {
        ActionResultModel actionResultModel = new ActionResultModel();
        try {
            if (rotateNoticeService.rotateNotifIsExistence(map)) {
                actionResultModel.setData(true);
            } else {
                actionResultModel.setData(false);
            }
            actionResultModel.setSuccess(true);
        } catch (Exception e) {
            actionResultModel.setSuccess(false);
            actionResultModel.setMsg(e.getMessage());
        }
        return actionResultModel;
    }


    /**
     * 提货单查询已开提货数量
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/takecount/{id}")
    public ActionResultModel selectTakeCountByDealSerial(@PathVariable("id") String id) {
        ActionResultModel actionResultModel = new ActionResultModel();
        actionResultModel.setSuccess(true);
        BigDecimal count = rotateTakeService.selectTakeCountByDealSerial(id);
        actionResultModel.setData(count);
        return actionResultModel;
    }
    public boolean checkSerial(String serial,String maxSerial){
        //1、判断格式是否正确
        //长度是否合格
        if(serial.length() !=7){
            return false;
        }
        //是否当年
        String year = serial.substring(0,4);
        String flowNum = serial.substring(4,serial.length());//当前需要保存的序号
        Calendar calendar = Calendar.getInstance();
        String nowYear = String.valueOf(calendar.get(Calendar.YEAR));
        if(!year.equals(nowYear)){
            return false;
        }
        //判断是否大于等于最大流水号
        String maxFlowNum = maxSerial.substring(4,maxSerial.length());
        if(Integer.parseInt(flowNum)<=Integer.parseInt(maxFlowNum)){
            return false;
        }
        //判断是否有重复
        RotateTakeMain bySerial = rotateTakeMainService.getBySerial(serial);
        if(bySerial != null){
            return false;
        }
        return true;
    }

    public String generateFlowNum(String maxSerial){
        //获取当前年份
        Calendar calendar = Calendar.getInstance();
        String nowYear = String.valueOf(calendar.get(Calendar.YEAR));
        String year = maxSerial.substring(0,4);
        String flowNum = maxSerial.substring(4,maxSerial.length());
        String serial = null;
        if(!nowYear.equals(year)){
            serial = nowYear+"001";
        }else{
            int length = String.valueOf(Integer.parseInt(flowNum) + 1).length();
            if(length==1) {
                serial = year + "00"+(Integer.parseInt(flowNum) + 1);
            }else if(length == 2){
                serial = year + "0"+(Integer.parseInt(flowNum) + 1);
            }else if(length == 3){
                serial = year + (Integer.parseInt(flowNum) + 1);
            }
        }
        return serial;
    }
}
