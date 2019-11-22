package com.dhc.fastersoft.controller;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import com.dhc.fastersoft.common.Constant;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.constants.BusinessConstants;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.*;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysFile;
import com.dhc.fastersoft.entity.system.SysProcessMapper;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.*;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysFileService;
import com.dhc.fastersoft.service.system.SysLogService;
import com.dhc.fastersoft.service.system.SysOAService;
import com.dhc.fastersoft.utils.JsonUtil;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.utils.PageUtil;
import com.dhc.fastersoft.utils.UpdateUtil;
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
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.server.PathParam;
import java.io.*;
import java.math.BigDecimal;
import java.util.*;

@Controller
@RequestMapping("/RotateScheme")
public class RotateSchemeController {

    @Autowired
    private HttpServletRequest request;
    @Autowired
    private RotateSchemeService rotateSchemeService;
    @Autowired
    private RotatePlanService rotatePlanService;
    @Autowired
    private RotatePlanmainService rotatePlanmainService;
    @Autowired
    private SysFileService fileService;
    @Autowired
    private StorageWarehouseService storageWarehouseService;
    @Autowired
    private SysOAService sysOAService;
    @Autowired
    private SysLogService sysLogService;
    @Autowired
    private HttpServletRequest httpServletRequest;
    @Autowired
    private StorageStoreHouseService storageStoreHouseService;
    @Autowired
    private SysDictService sysDictService;

    Properties prop = new Properties();

    private Map<String, String> TableMapper = new HashMap<>();

    {
        TableMapper.put("Scheme", "T_ROTATE_SCHEME");
        TableMapper.put("SchemeDetail", "T_ROTATE_SCHEME_DETAIL");
        TableMapper.put("Notice", "T_ROTATE_NOTICE");
        TableMapper.put("NoticeDetail", "T_ROTATE_NOTICE_DETAIL");
        TableMapper.put("Take", "T_ROTATE_TAKE");
        TableMapper.put("TakeMain", "T_ROTATE_TAKE_MAIN");
        TableMapper.put("Process", "T_ROTATE_PROCESS");
        TableMapper.put("ProcessDetail", "T_ROTATE_PROCESS_DETAIL");
        TableMapper.put("Performance", "T_ROTATE_PERFORMANCE");

        try {
            prop.load(this.getClass().getResourceAsStream("/OATable.properties"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/Create", method = RequestMethod.GET)
    public String createSchema(Model model) {
        SysUser user = TokenManager.getToken();
        RotateScheme scheme = new RotateScheme();
        scheme.setCreater(user.getName());
        scheme.setCreateTime(Calendar.getInstance().getTime());
        scheme.setDepartment(user.getDepartment());
        scheme.setState("已完成");
        //获取年度方案列表
        scheme.setSchemeType("年度轮换方案");
        PageUtil<RotateScheme> pageUtil = new PageUtil<>();
        pageUtil.setPageIndex(1);
        pageUtil.setPageSize(Integer.MAX_VALUE);
        pageUtil.setEntity(scheme);
        List<RotateScheme> yearScheme = rotateSchemeService.LisLimitScheme(pageUtil);

        //获取已完成计划详情列表
        /*RotatePlan plan = new RotatePlan();
        plan.setState("已分发");
        List<RotatePlan> completePlanList = rotatePlanService.listAll(plan);*/
        //获取审核通过计划申报列表
        RotatePlanmain rotatePlanmain = new RotatePlanmain();
        rotatePlanmain.setState("审核通过");
        List<RotatePlanmain> completePlanList = rotatePlanmainService.listAll(rotatePlanmain);
        List<String> warehouse = new ArrayList<>();
        for (StorageWarehouse item : storageWarehouseService.limitList()) {
            warehouse.add(item.getWarehouseShort());
        }

        List<StorageStoreHouse> storeHouse = storageStoreHouseService.listStorehouseOfWarehouse(null);

        Map<String, String> souce = new LinkedHashMap<>();
        /*for (RotatePlan rp : completePlanList)
            souce.put(rp.getId(), rp.getPlanName());

        for (RotateScheme rs : yearScheme)
            souce.put(rs.getId(), rs.getSchemeName().concat("(年度方案)"));*/
        for (RotatePlanmain rp : completePlanList)
            souce.put(rp.getId(), rp.getPlanName());

        Map<String, String> year = new HashMap<>();
        /*for (RotatePlan rp : completePlanList)
            year.put(rp.getId(), rp.getYear());

        for (RotateScheme rs : yearScheme)
            year.put(rs.getId(), rs.getYear());*/
        for (RotatePlanmain rp : completePlanList)
            year.put(rp.getId(), rp.getYear());

        List<SysDict> dictType = sysDictService.getSysDictListByType("粮油品种");

        model.addAttribute("basepoint", warehouse);
        model.addAttribute("souce", souce);
        model.addAttribute("yearmapper", year);
        model.addAttribute("scheme", scheme);
        model.addAttribute("storehouse", storeHouse);
        model.addAttribute("dictType", dictType);    // 粮油品种
        return "/RotateScheme/createrotatescheme_add";
    }

    @RequestMapping(value = "/List", params = {"view"})
    public String LimitSchemeList(Model model, @RequestParam("view") String view, HttpServletRequest request,
                                  @RequestParam(value = "type", required = false) String type) {

        SysUser sysUser = TokenManager.getToken();

        if ("create".equals(view)) {
            sysLogService.add(request, "访问：轮换业务-轮换方案-创建方案");
        } else {
            sysLogService.add(request, "访问：轮换业务-轮换方案-方案列表");
        }

        PageUtil<RotateScheme> pageUtil = new PageUtil<>();
        pageUtil.setPageIndex(1);
        pageUtil.setPageSize(10);

        RotateScheme scheme = new RotateScheme();
        if ("".equals(view)) {
            scheme.setState("已完成");
        } else {
            scheme.setExecuteState(null);
        }

        if ("cbl".equals(sysUser.getOriginCode().toLowerCase())) {
            type = BusinessConstants.CBL;
            pageUtil.setEntity(scheme);
            pageUtil.setResult(rotateSchemeService.LisLimitScheme(pageUtil));
        } else {
            type = BusinessConstants.BASE;
            String wareHouseId = sysUser.getWareHouseId();

            List<String> wareHouseIds = new ArrayList<>();
            wareHouseIds.add(wareHouseId);
            for (StorageWarehouse base : storageWarehouseService.listSuperviseOfWarehouse(wareHouseId))
                wareHouseIds.add(base.getId());
            Set<String> SchemeIds = rotateSchemeService.ListSchemeIDBase(wareHouseIds);
            if (SchemeIds.size() > 0) {
                scheme.setState("已完成");
                Map<String, Object> param = new HashMap<>();
                param.put("schemeIds", SchemeIds);
                pageUtil.setEntity(scheme);
                pageUtil.setOtherPram(param);
                pageUtil.setResult(rotateSchemeService.ListSchemeByBase(pageUtil));
            } else {
                pageUtil.setResult(new ArrayList());
            }
        }

        Map<String, String> originMapper = new HashMap<>();
        for (int i = 0, _size = pageUtil.getResult().size(); i < _size; i++) {
            RotateScheme _temp = pageUtil.getResult().get(i);

            if (_temp.getOriginType() == RotateSchemeService.PLAN) {
                RotatePlan rotatePlan = rotatePlanService.getPlan(_temp.getOriginId());
                if (rotatePlan != null) {
                    originMapper.put(_temp.getOriginId(), rotatePlan.getPlanName());
                } else {
                    originMapper.put(_temp.getOriginId(), "");
                }
            } else {
                originMapper.put(_temp.getOriginId(), rotateSchemeService.getSchemeNameById(_temp.getOriginId()));
            }
        }

        model.addAttribute("type", type);
        model.addAttribute("originMapper", originMapper);
        model.addAttribute("schemelist", pageUtil);
        return "/RotateScheme/" + view + "rotatescheme_view";
    }

    @SysLogAn("轮换业务-轮换方案-创建方案-新增")
    @RequestMapping(value = "/Create", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> CreateRotateScheme(RotateScheme scheme, @RequestParam(value = "file", required = false) MultipartFile file,
                                                  @RequestParam(value = "detailList", required = false) String detailList) throws IOException {
        Calendar calendar = Calendar.getInstance();
        calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH), calendar.get(Calendar.DATE), 0, 0, 0);

        SysUser user = TokenManager.getToken();
        scheme.setCreater(user.getId());
        scheme.setDepartment(user.getDepartment());
        scheme.setCreateTime(calendar.getTime());
        scheme.setExecuteState("未执行");

        List<RotateSchemeDetail> list = JsonUtil.toObject(detailList, RotateSchemeDetail.class);
        if (list != null && list.size() > 0) {
            for (RotateSchemeDetail detail : list) {
                detail.setdId(UUID.randomUUID().toString().replace("-", ""));
                detail.setYieldTime(detail.getYieldTime() == null ? String.valueOf(Calendar.getInstance().get(Calendar.YEAR)) : detail.getYieldTime());
                if (StringUtils.isNotEmpty(detail.getLibraryId()))
                    detail.setWarehouseId(storageWarehouseService.getWarehouseIdByShortname(
                            detail.getLibraryId()));

                if (!scheme.getSchemeType().equals("年度轮换方案")) {
                    long timestmp = detail.getEndTime().getTime() - detail.getStartTime().getTime();
                    int week = (int) Math.ceil(timestmp / (24 * 60 * 60 * 1000) / 7);
                    detail.setExpectedCycle(week + "周");
                    if(!scheme.getSchemeType().equals("出入库")) {
                        detail.setRotateType(scheme.getRotateType());
                    }
                }

            }
            scheme.setSchemeDetail(list);
        }

        String fileId = null;
        if (file != null) {
            fileId = UUID.randomUUID().toString().replace("-", "");
            if (!fileService.uploadFile(httpServletRequest, fileId, file, null).equals("上传成功！")) {
                Map<String, Object> result = new HashMap<>();
                result.put("msg", "文件上传失败");
                result.put("success", false);
                return result;
            } else
                scheme.setAnnex(fileId);
        }
//		for ( RotateSchemeDetail rotateSchemeDetail :scheme.getSchemeDetail()
//				) {
//			//先判断是否是否总数是否超出计划数
//			HashMap  map  = new HashMap();
//			map.put("schemeType",rotateSchemeDetail.getSchemeType());
//			map.put("libraryId",rotateSchemeDetail.getLibraryId());
//			map.put("branNumber",rotateSchemeDetail.getBranNumber());
//			map.put("foodType",rotateSchemeDetail.getFoodType());
//			map.put("yieldTime",rotateSchemeDetail.getYieldTime());
//			Double  allNum=0.0;
//			List<RotateSchemeDetail> list1=rotateSchemeService.listDetail(map);
//			for (RotateSchemeDetail rotateSchemeDetail1:list1
//					) {
//				if(!rotateSchemeDetail1.getdId().equals(rotateSchemeDetail.getdId())){
//					allNum=allNum+rotateSchemeDetail1.getRotateNumber();
//				}
//
//			}
//			allNum=allNum+rotateSchemeDetail.getRotateNumber();
//			//获取计划数
//			RotatePlanDetail  rotatePlanDetail=rotatePlanService.getPlanDetail(rotateSchemeDetail.getPlanDetailId());
//
//			if(allNum>Double.valueOf(rotatePlanDetail.getRotateNumber())){
//				Map<String,Object> result = new HashMap<String, Object>();
//				result.put("success", false);
//				result.put("msg", "轮入/轮出数量不能超出计划数");
//				return result;
//			}
//		}
        String id = rotateSchemeService.SaveScheme(scheme);
        if (scheme.getState().equals(rotateSchemeService.OA)) {
            //附件
            String fileCode = this.exprotAnyExcelPlan(scheme.getId());
            String files = "";
            if (scheme.getAnnex() != null) {
                SysFile sysFile = fileService.getByID(scheme.getAnnex());
                files = String.format("http://%s:%s%s/", request.getServerName(), request.getServerPort(), request.getContextPath()) + "files/code/" + scheme.getAnnex()
                        + "." + sysFile.getFileType();
            }
            sysOAService.LaunchedAuditAndFileAndParam(
                    "1",
                    scheme.getId(),
                    user.getId(),
                    scheme.getSchemeName(),
                    String.format("http://%s:%s%s/", request.getServerName(), request.getServerPort(), request.getContextPath()) + "files/code/" + fileCode,
                    files,
                    new SysProcessMapper("T_ROTATE_SCHEME", "STATE", "审核通过:"));

        }

        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("host", prop.get("OA_HOST").toString());
        result.put("id", id);
        return result;
    }

    @RequestMapping(value = "/Detail", params = "sid", method = RequestMethod.GET)
    public String SchemeDetail(Model model, @PathParam("sid") String sid, @RequestParam("type") String type) {
        RotateScheme baseScheme = rotateSchemeService.GetSchemeInfo(sid);

        if (TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl"))
            type = "proviceunit";
        else
            type = "base";

        if (type != null && type.toLowerCase().equals("proviceunit")) {
            //可查看所有数据 所以不需要对数据做过滤操作
        } else if (type != null && type.toLowerCase().equals("base")) {
            SysUser user = TokenManager.getToken();
//            String baseName = user.getShortName(); //获取到用户的库点信息
            String wareHouseId = user.getWareHouseId(); //获取到用户的库点信息----我的

            List<String> wareHouseIds = new ArrayList<>();
            wareHouseIds.add(wareHouseId);
            for (StorageWarehouse base : storageWarehouseService.listSuperviseOfWarehouse(wareHouseId))
                wareHouseIds.add(base.getId());
//                baseNames.add(base.getId());//----我的
            for (int i = 0; i < baseScheme.getSchemeDetail().size(); i++) {
                if (!wareHouseIds.contains(baseScheme.getSchemeDetail().get(i).getWarehouseId())) {
//                if (!baseNames.contains(baseScheme.getSchemeDetail().get(i).getWarehouseId())) {  //我的---
                    baseScheme.getSchemeDetail().remove(i--);
                }
            }
        }

        /*SysFile filename = null;*/
        SysFile myFile = fileService.selectById(baseScheme.getAnnex());
        model.addAttribute("type", type);
        /*model.addAttribute("filename",(filename = fileService.selectById(baseScheme.getAnnex())) == null?null:filename.getFileName());*/
        model.addAttribute("scheme", baseScheme);
        model.addAttribute("myFile", myFile);
        if (myFile != null) {
            String downloadUrl = myFile.getDownloadUrl();
            String suffix = downloadUrl.substring(downloadUrl.indexOf(".") + 1);
            model.addAttribute("suffix", suffix);
        }
        return "/RotateScheme/rotateschemedetail_view";
    }

    @RequestMapping(value = "/Create", params = "sid")
    public String EditRotateScheme(Model model, @PathParam("sid") String sid) {
        RotateScheme scheme = new RotateScheme();
        /*获取年度方案列表*/
        scheme.setSchemeType("年度轮换方案");
        scheme.setState("已完成");
        PageUtil<RotateScheme> pageUtil = new PageUtil<>();
        pageUtil.setPageIndex(1);
        pageUtil.setPageSize(Integer.MAX_VALUE);
        pageUtil.setEntity(scheme);
        List<RotateScheme> yearScheme = rotateSchemeService.LisLimitScheme(pageUtil);

        List<String> warehouse = new ArrayList<>();
        for (StorageWarehouse item : storageWarehouseService.limitList())
            warehouse.add(item.getWarehouseShort());
        List<StorageStoreHouse> storeHouse = storageStoreHouseService.listStorehouseOfWarehouse(null);

        //获取已完成计划详情列表
        /*RotatePlan plan = new RotatePlan();
        plan.setState("已分发");
        List<RotatePlan> completePlanList = rotatePlanService.listAll(plan);*/
        //获取审核通过计划申报列表
        RotatePlanmain rotatePlanmain = new RotatePlanmain();
        rotatePlanmain.setState("审核通过");
        List<RotatePlanmain> completePlanList = rotatePlanmainService.listAll(rotatePlanmain);

        Map<String, String> souce = new HashMap<>();
        /*for (RotatePlan rp : completePlanList)
            souce.put(rp.getId(), rp.getPlanName());
        for (RotateScheme rs : yearScheme)
            souce.put(rs.getId(), rs.getSchemeName().concat("(年度方案)"));*/
        for (RotatePlanmain rp : completePlanList)
            souce.put(rp.getId(), rp.getPlanName());
        Map<String, String> year = new HashMap<>();
        /*for (RotatePlan rp : completePlanList)
            year.put(rp.getId(), rp.getYear());
        for (RotateScheme rs : yearScheme)
            year.put(rs.getId(), rs.getYear());*/
        for (RotatePlanmain rp : completePlanList)
            year.put(rp.getId(), rp.getYear());
        RotateScheme baseScheme = rotateSchemeService.GetSchemeInfo(sid);

        SysFile filename = fileService.selectById(baseScheme.getAnnex());
        List<SysDict> dictType = sysDictService.getSysDictListByType("粮油品种");
        model.addAttribute("filename", filename == null ? null : filename);
        model.addAttribute("basepoint", warehouse);
        model.addAttribute("dictType", dictType);    // 粮油品种
        model.addAttribute("souce", souce);
        model.addAttribute("yearmapper", year);
        model.addAttribute("scheme", baseScheme);
        model.addAttribute("storehouse", storeHouse);
        if (filename != null) {
            String downloadUrl = filename.getDownloadUrl();
            String suffix = downloadUrl.substring(downloadUrl.indexOf(".") + 1);
            model.addAttribute("suffix", suffix);
        }
        return "/RotateScheme/createrotatescheme_add";
    }

    @RequestMapping(value = "/Edit", method = {RequestMethod.POST})
    @ResponseBody
    public Map Edit(RotateScheme scheme, @RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest request,
                    @RequestParam(value = "detailList", required = false) String detailList) throws IOException {
        RotateScheme baseScheme = rotateSchemeService.GetSchemeInfo(scheme.getId());

        sysLogService.add(request, "轮换业务-轮换方案-创建方案-" + scheme.getState());

        SysUser user = TokenManager.getToken();
        baseScheme.setModifier(user.getId());
        baseScheme.setModifyTime(Calendar.getInstance().getTime());
        if (detailList != null) {
            List<RotateSchemeDetail> list = JsonUtil.toObject(detailList, RotateSchemeDetail.class);
            if (list != null && list.size() > 0) {
                for (RotateSchemeDetail detail : list) {
                    detail.setdId(UUID.randomUUID().toString().replace("-", ""));
                    detail.setYieldTime(detail.getYieldTime() == null ? String.valueOf(Calendar.getInstance().get(Calendar.YEAR)) : detail.getYieldTime());

                    if (StringUtils.isNotEmpty(detail.getLibraryId()))
                        detail.setWarehouseId(storageWarehouseService.getWarehouseIdByShortname(
                                detail.getLibraryId()));

                    if (!scheme.getSchemeType().equals("年度轮换方案")) {
                        long timestmp = detail.getEndTime().getTime() - detail.getStartTime().getTime();
                        int week = (int) Math.ceil(timestmp / (24 * 60 * 60 * 1000) / 7);
                        detail.setExpectedCycle(week + "周");
                        if (!scheme.getSchemeType().equals("出入库")) {
                            detail.setRotateType(scheme.getRotateType());
                        }
                    }
                }
                baseScheme.setSchemeDetail(list);
            }
        }
        try {
            UpdateUtil.UpdateField(scheme, baseScheme, new String[]{"id"});
        } catch (IllegalArgumentException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        String fileId = null;
        if (file != null) {
            fileId = UUID.randomUUID().toString().replace("-", "");
            if (!fileService.uploadFile(httpServletRequest, fileId, file, null).equals("上传成功！")) {
                Map<String, Object> result = new HashMap<>();
                result.put("msg", "文件上传失败");
                result.put("success", false);
                return result;
            } else
                baseScheme.setAnnex(fileId);
        }

        if (baseScheme.getState().equals("已完成")) {
            baseScheme.setCompleteDate(Calendar.getInstance().getTime());
        }
//		for ( RotateSchemeDetail rotateSchemeDetail :baseScheme.getSchemeDetail()
//				) {
//			//先判断是否是否总数是否超出计划数
//			HashMap  map  = new HashMap();
//			map.put("schemeType",rotateSchemeDetail.getSchemeType());
//			map.put("libraryId",rotateSchemeDetail.getLibraryId());
//			map.put("branNumber",rotateSchemeDetail.getBranNumber());
//			map.put("foodType",rotateSchemeDetail.getFoodType());
//			map.put("yieldTime",rotateSchemeDetail.getYieldTime());
//			Double  allNum=0.0;
//			List<RotateSchemeDetail> list=rotateSchemeService.listDetail(map);
//			for (RotateSchemeDetail rotateSchemeDetail1:list
//					) {
//				if(!rotateSchemeDetail1.getdId().equals(rotateSchemeDetail.getdId())){
//					allNum=allNum+rotateSchemeDetail1.getRotateNumber();
//				}
//
//			}
//			allNum=allNum+rotateSchemeDetail.getRotateNumber();
//			//获取计划数
//			RotatePlanDetail  rotatePlanDetail=rotatePlanService.getPlanDetail(rotateSchemeDetail.getPlanDetailId());
//
//			if(allNum>Double.valueOf(rotatePlanDetail.getRotateNumber())){
//				Map<String,Object> result = new HashMap<String, Object>();
//				result.put("success", false);
//				result.put("msg", "轮入/轮出数量不能超出计划数");
//				return result;
//			}
//		}


        rotateSchemeService.UpdateScheme(baseScheme);

        if (baseScheme.getState().equals(rotateSchemeService.OA) && scheme.getState() != null) {
            //附件
            String fileCode = this.exprotAnyExcelPlan(baseScheme.getId());
            String files = "";

            if (baseScheme.getAnnex() != null) {
                SysFile sysFile = fileService.getByID(baseScheme.getAnnex());
                files = String.format("http://%s:%s%s/", request.getServerName(), request.getServerPort(), request.getContextPath()) + "files/code/" + baseScheme.getAnnex()
                        + "." + sysFile.getFileType();

            }
            sysOAService.LaunchedAuditAndFileAndParam(
                    "1",
                    baseScheme.getId(),
                    user.getId(),
                    baseScheme.getSchemeName(),
                    String.format("http://%s:%s%s/", request.getServerName(), request.getServerPort(), request.getContextPath()) + "files/code/" + fileCode
                    , files,
                    new SysProcessMapper("T_ROTATE_SCHEME", "STATE", "审核通过:"));

        }

        Map<String, Object> result = new HashMap<String, Object>();
        result.put("success", true);
        result.put("id", baseScheme.getId());
        return result;
    }

    @RequestMapping(value = "/{type}/List", method = {RequestMethod.POST})
    @ResponseBody
    public PageUtil SearchScheme(RotateScheme rotateScheme, @RequestParam(value = "pageindex") int pageindex,
                                 @RequestParam(value = "pagesize") int pagesize, @PathVariable("type") String type) {

        SysUser sysUser = TokenManager.getToken();
        PageUtil<RotateScheme> pageutil = new PageUtil<>();

//		System.err.println(">>>"+rotateScheme.toString());

        if (rotateScheme.getOriginId() != null && rotateScheme.getOriginId().indexOf("(年度方案)") != -1) {
            RotateScheme originScheme = rotateSchemeService.GetSchemeInfo(rotateScheme.getOriginId());
            rotateScheme.setOriginId(originScheme != null ? rotateScheme.getOriginId() : originScheme.getId());
        }

        if (!type.contains("create")) {
            rotateScheme.setState("已完成");
        } else {
            rotateScheme.setExecuteState(null);
        }

        pageutil.setPageIndex(pageindex);
        pageutil.setPageSize(pagesize);


        if (BusinessConstants.CBL_CODE.equals(sysUser.getOriginCode().toLowerCase())) {
            type = BusinessConstants.CBL;

            //可查看所有数据 所以不需要对数据做过滤操作
            pageutil.setEntity(rotateScheme);
            pageutil.setResult(rotateSchemeService.LisLimitScheme(pageutil));
        } else {
            type = BusinessConstants.BASE;
            //---------Jovan--------------------------------------//
            List<String> wareHouseIds = new ArrayList<>();
            String wareHouseId = sysUser.getWareHouseId();
            wareHouseIds.add(wareHouseId);
            for(StorageWarehouse base : storageWarehouseService.listSuperviseOfWarehouse(wareHouseId))
                wareHouseIds.add(base.getId());
            Set<String> schemeIds = rotateSchemeService.ListSchemeIDBase(wareHouseIds);
            //---------Jovan--------------------------------------//
            if (schemeIds != null && schemeIds.size() > 0) {
                rotateScheme.setState("已完成");
                Map<String, Object> param = new HashMap<>();
                param.put("schemeIds", schemeIds);
                pageutil.setOtherPram(param);
                pageutil.setEntity(rotateScheme);
                pageutil.setResult(rotateSchemeService.ListSchemeByBase(pageutil));
            } else {
                pageutil.setResult(new ArrayList());
            }
        }

        Map<String, String> originMapper = new HashMap<>();
        for (int i = 0; i < pageutil.getResult().size(); i++) {
            RotateScheme _temp = pageutil.getResult().get(i);
            String _value = "";
            if (_temp.getOriginType() == RotateSchemeService.PLAN) {
                //RotatePlan rotatePlan = rotatePlanService.getPlan(_temp.getOriginId());
                RotatePlanmain rotatePlan = rotatePlanmainService.getPlan(_temp.getPlanMainId());
                if (rotatePlan != null) {
//					originMapper.put(_temp.getOriginId(),rotatePlan.getPlanName());
                    _value = rotatePlan.getPlanName();
                } else {
//					originMapper.put(_temp.getOriginId(),"");
                    _value = "";
                }
            } else {
//				originMapper.put(_temp.getOriginId(),rotateSchemeService.getSchemeNameById(_temp.getOriginId()));
                _value = rotateSchemeService.getSchemeNameById(_temp.getOriginId());
            }
            if(StringUtils.isNotEmpty(_temp.getPlanMainId())) {
                originMapper.put(_temp.getPlanMainId(), _value);
            }
        }

        pageutil.setOtherPram(originMapper);
        return pageutil;
    }

    @RequestMapping(value = "/listDetailPagination", method = RequestMethod.POST)
    @ResponseBody
    public LayPage<RotateSchemeDetail> listDetailPagination(
            @RequestParam(value = "pageIndex", required = false) int pageIndex,
            @RequestParam(value = "pageSize", required = false) int pageSize,
            @RequestParam(value = "schemeBatch", required = false) String schemeBatch,
            @RequestParam(value = "schemeType", required = false) String schemeType,
            @RequestParam(value = "rotateType", required = false) String rotateType,
            @RequestParam(value = "mainSchemeName", required = false) String mainSchemeName,
            @RequestParam(value = "foodType", required = false) String foodType,
            @RequestParam(value = "warehouseType", required = false) String warehouseType,
            @RequestParam(value = "libraryId", required = false) String libraryId,
            @RequestParam(value = "branNumber", required = false) String branNumber
    ) throws UnsupportedEncodingException {

        HashMap<String, String> map = new HashMap<>();
        map.put("pageIndex", String.valueOf(pageIndex));
        map.put("pageSize", String.valueOf(pageSize));
        map.put("schemeBatch", schemeBatch);
        map.put("schemeType", schemeType);
        map.put("rotateType", rotateType);
        map.put("mainSchemeName", mainSchemeName);
        map.put("foodType", foodType);
        map.put("mainSchemeState", "已完成");
        map.put("warehouseType", warehouseType);
        map.put("libraryId", libraryId);
        map.put("branNumber", branNumber);
        map.put("yieldTime", request.getParameter("yieldTime"));
        int count = rotateSchemeService.countDetail(map);
        List<RotateSchemeDetail> details = null;
        if (count > 0)
            details = rotateSchemeService.listDetail(map);

        LayPage<RotateSchemeDetail> page = new LayPage<>();
        page.setCount(count);
        page.setData(details);
        page.setCode(0);
        page.setMsg("");
        return page;

    }

    @RequestMapping(value = "/listDetail")
    @ResponseBody
    public PageUtil<RotateSchemeDetail> listDetail(
            @RequestParam(value = "pageIndex", required = false) int pageIndex,
            @RequestParam(value = "pageSize", required = false) int pageSize,
            @RequestParam(value = "schemeId", required = false) String schemeId,
            @RequestParam(value = "libraryId", required = false) String libraryId,
            @RequestParam(value = "branNumber", required = false) String branNumber,
            @RequestParam(value = "foodType", required = false) String foodType,
            @RequestParam(value = "rotateType", required = false) String rotateType,
            @RequestParam(value = "yieldTime", required = false) String yieldTime,
            @RequestParam(value = "ogirin", required = false) String ogirin,
            @RequestParam(value = "state", required = false) String state,
            @RequestParam(value = "quantity", required = false) String quantity,
            @RequestParam(value = "enterprise", required = false) String enterprise,
            @RequestParam(value = "isEnd", required = false) String isEnd) {
        HashMap<String, String> map = new HashMap<>();
        map.put("enterprise",enterprise);
        map.put("pageIndex", String.valueOf(pageIndex));
        map.put("pageSize", String.valueOf(pageSize));
        map.put("schemeId", schemeId);
        map.put("libraryId", libraryId);
        map.put("branNumber", branNumber);
        map.put("foodType", foodType);
        map.put("rotateType", rotateType);
        map.put("quantity", quantity);
        if (rotateType.equals("内部销售")) {
            map.put("rotateType", "内部招标");
        }
        map.put("yieldTime", yieldTime);
        map.put("ogirin", ogirin);
        map.put("mainSchemeState", state);
        map.put("isEnd",isEnd);
        int count = rotateSchemeService.countDetail(map);
        List<RotateSchemeDetail> list = null;
        if (count > 0)
            list = rotateSchemeService.listDetail(map);
        PageUtil<RotateSchemeDetail> pageUtil = new PageUtil<>();
        pageUtil.setResult(list);
        pageUtil.setTotalCount(count);
        pageUtil.setPageSize(pageSize);
        pageUtil.setPageIndex(pageIndex);
        return pageUtil;

    }

    @RequestMapping(value = "/listScheme", method = RequestMethod.POST)
    @ResponseBody
    public List<RotateScheme> listScheme(
            @RequestParam(value = "schemeType", required = false) String schemeType,
            @RequestParam(value = "rotateType", required = false) String rotateType,
            @RequestParam(value = "year", required = false) String year) throws UnsupportedEncodingException {

        HashMap<String, String> map = new HashMap<>();
        map.put("schemeType", schemeType);
        map.put("rotateType", rotateType);
        map.put("year", year);
        return rotateSchemeService.listScheme(map);
    }

    @RequestMapping(value = "/Detail", method = {RequestMethod.POST})
    @ResponseBody
    public List<RotateSchemeDetail> SchemeDetail(@PathParam("sid") String sid) {
        RotateScheme baseScheme = rotateSchemeService.GetSchemeInfo(sid);
        return baseScheme.getSchemeDetail();
    }

    @SysLogAn("轮换业务-轮换方案-创建方案-导出")
    @RequestMapping(value = "/ExportExcel")
    @ResponseBody
    public void ExportExcel(HttpServletResponse response, @RequestParam("sid") String sid, @RequestParam("type") String type) throws IOException {

        RotateScheme scheme = rotateSchemeService.GetSchemeInfo(sid);

        if (TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl"))
            type = "proviceunit";
        else
            type = "base";

        if (type != null && type.toLowerCase().equals("proviceunit")) {
            //可查看所有数据 所以不需要对数据做过滤操作
        } else if (type != null && type.toLowerCase().equals("base")) {
            SysUser user = TokenManager.getToken();
            //---------Jovan--------------------------------------//
            List<String> wareHouseIds = new ArrayList<>();
            String wareHouseId = user.getWareHouseId();
            wareHouseIds.add(wareHouseId);
            for(StorageWarehouse base : storageWarehouseService.listSuperviseOfWarehouse(wareHouseId))
                wareHouseIds.add(base.getId());
            for (int i = 0; i < scheme.getSchemeDetail().size(); i++) {
                if (!wareHouseIds.contains(scheme.getSchemeDetail().get(i).getWarehouseId())) {
                    scheme.getSchemeDetail().remove(i--);
                }
            }
        }

        String title = scheme.getSchemeName();

        List<RotateScheme> list = new ArrayList<>();
        list.add(scheme);
//		String str1=URLEncoder.encode(StringEscapeUtils.unescapeXml(title),"UTF-8");
//		String str=URLDecoder.decode(str1, "UTF-8");
        response.setHeader("content-Type", "application/vnd.ms-excel");
//		response.setHeader("Content-Disposition", "attachment;filename=" + str1  + ".xls");
        response.setHeader("Content-Disposition", "attachment;filename=" + java.net.URLEncoder.encode(title, "UTF-8") + ".xls");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/octet-stream;charset=utf-8");
        response.setHeader("Content-Disposition", "attachment;filename="
                + new String(title.getBytes(), "iso-8859-1") + ".xls");


        Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams(title, title), RotateScheme.class, list);

        workbook.write(response.getOutputStream());
    }


    /**
     * @param id
     * @return
     */
    public String exprotAnyExcelPlan(String id) {
        SysUser user = TokenManager.getToken();
        String fileCode = null;

        RotateScheme planmain = rotateSchemeService.GetSchemeInfo(id);
        if (planmain != null) {
            String host = String.format("http://%s:%s%s/", request.getServerName(), request.getServerPort(), request.getContextPath());
            HttpClient client = HttpClients.createDefault();
            //模拟进行一次登陆以绕过验证
            HttpPost post = new HttpPost(host + "sign/submitLogin.shtml");
            List<NameValuePair> list = new ArrayList<>();
            list.add(new BasicNameValuePair("account", user.getAccount()));
            list.add(new BasicNameValuePair("password", user.getPassword()));
            UrlEncodedFormEntity entity = null;
            try {
                entity = new UrlEncodedFormEntity(list, "UTF-8");
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
            if (response != null) {
                HttpEntity httpEntity = response.getEntity();
                try {
                    JSONObject returnData = JSONObject.fromObject(EntityUtils.toString(httpEntity, "utf-8"));
                    if (!(returnData.get("message").equals("登录成功"))) {
                        return fileCode;
                    }
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }

            StringBuilder param = new StringBuilder();
            param.append("sid=" + id);
            param.append("&type=");
            HttpGet get = new HttpGet(host + String.format("RotateScheme/ExportExcel.shtml?%s", param.toString()));
            try {
                response = client.execute(get);
            } catch (IOException e) {
                e.printStackTrace();
            }
            if (response != null) {
                HttpEntity httpEntity = response.getEntity();
                try {
                    if (response.getStatusLine().getStatusCode() == HttpStatus.OK.value()) {
                        InputStream in = httpEntity.getContent();
                        File file = new File(request.getSession().getServletContext().getRealPath("/") + Constant.EXPORT_PATH);
                        if (!file.exists())
                            file.mkdirs();
                        fileCode = UUID.randomUUID().toString().replace("-", "") + ".xls";
                        FileOutputStream fos = new FileOutputStream(file.getPath() + "/" + fileCode);
                        byte[] buffer = new byte[4096];
                        int readLength = 0;
                        while ((readLength = in.read(buffer)) > 0) {
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


    @SysLogAn("轮换业务-轮换方案-创建方案-删除")
    @RequestMapping(value = "/Delete/{tableName}/{mainId}", method = RequestMethod.POST)
    @ResponseBody
    public Map DeleteConstructionData(@PathVariable("tableName") String tableName, @PathVariable("mainId") String mainId,
                                      @RequestParam(value = "childTable", required = false) String childTable, @RequestParam(value = "forignKey", required = false) String forignKey) {

        Map<String, String> deleteConf = new HashMap<>();
        deleteConf.put("tableName", TableMapper.get(tableName));
        deleteConf.put("mainId", mainId);
        if (childTable != null) {
            deleteConf.put("childTable", TableMapper.get(childTable));
            deleteConf.put("forignKey", forignKey);
        }

        rotateSchemeService.DeleteData(deleteConf);

        Map<String, Object> result = new HashMap<String, Object>();
        result.put("success", true);
        return result;
    }

    @RequestMapping(value = "/PlanTotalCount", method = RequestMethod.GET)
    @ResponseBody
    public BigDecimal PlanTotalCount(@RequestParam("pd_id") String pd_id) {
        BigDecimal i = null;
        return ((i = rotateSchemeService.PlanTotalCount(pd_id)) == null ? new BigDecimal(0) : i);
    }
    @RequestMapping(value = "/unDealTotalCountByPlanDetailId", method = RequestMethod.POST)
    @ResponseBody

    public BigDecimal unDealTotalCountByPlanDetailId(@RequestParam("pd_id") String pd_id) {
        BigDecimal i = rotateSchemeService.unDealTotalCountByPlanDetailId(pd_id);
        if(i == null){
            i = new BigDecimal(0);
        }
        return i;

    }

    /**
    * @Author : xy_pengsk
    * @Description: 方案子列表
    * @Date: Created 14:18 2019/3/7
    */
    @RequestMapping(value = "detailList",method = RequestMethod.GET)
    public String detailList(Model model){

        List<SysDict> varietyList = sysDictService.getSysDictListByType("粮油品种");
        model.addAttribute("varietyList",varietyList);
        return "/RotateScheme/rotateSchemeDetailList";
    }
    /**
    * @Author : xy_pengsk
    * @Description:查询子方案列表数据
    * @Date: Created 16:20 2019/3/8
    */
    @RequestMapping(value = "getDetailList",method = RequestMethod.POST)
    @ResponseBody
    public LayPage<RotateSchemeDetail> getDetailList(HttpServletRequest request){

        LayPage<RotateSchemeDetail> list = rotateSchemeService.list(request);
        return list;
    }

    @RequestMapping(value = "getSchemeDetailByCondition",method = RequestMethod.POST)
    @ResponseBody
    public RotateSchemeDetail getSchemeDetailByCondition(
                                                         @RequestParam(value = "schemeId", required = false) String schemeId,
                                                         @RequestParam(value = "libraryId", required = false) String libraryId,
                                                         @RequestParam(value = "branNumber", required = false) String branNumber,
                                                         @RequestParam(value = "foodType", required = false) String foodType,
                                                         @RequestParam(value = "rotateType", required = false) String rotateType,
                                                         @RequestParam(value = "yieldTime", required = false) String yieldTime,
                                                         @RequestParam(value = "ogirin", required = false) String ogirin,
                                                         @RequestParam(value = "state", required = false) String state,
                                                         @RequestParam(value = "quantity", required = false) String quantity,
                                                         @RequestParam(value = "enterprise", required = false) String enterprise){
        HashMap<String, String> map = new HashMap<>();
        map.put("enterprise",enterprise);
        map.put("schemeId", schemeId);
        map.put("libraryId", libraryId);
        map.put("branNumber", branNumber);
        map.put("foodType", foodType);
        map.put("rotateType", rotateType);
        map.put("quantity", quantity);
        if (rotateType.equals("内部销售")) {
            map.put("rotateType", "内部招标");
        }
        map.put("yieldTime", yieldTime);
        map.put("ogirin", ogirin);
        map.put("mainSchemeState", state);
        RotateSchemeDetail rotateSchemeDetail = null;
        List<RotateSchemeDetail> list = rotateSchemeService.getSchemeDetailByCondition(map);
        if(null != list &&list.size()==1){
            rotateSchemeDetail = list.get(0);
        }
        return rotateSchemeDetail;
    }
}
