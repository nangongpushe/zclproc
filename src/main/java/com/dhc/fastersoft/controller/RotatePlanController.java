package com.dhc.fastersoft.controller;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.ExcelImportUtil;
import cn.afterturn.easypoi.excel.annotation.Excel;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import cn.afterturn.easypoi.excel.entity.ImportParams;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.Constant;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.constants.BusinessConstants;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.*;
import com.dhc.fastersoft.entity.report.ReportSwtz;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysFile;
import com.dhc.fastersoft.entity.system.SysProcessMapper;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.*;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysFileService;
import com.dhc.fastersoft.service.system.SysLogService;
import com.dhc.fastersoft.service.system.SysOAService;
import com.dhc.fastersoft.utils.LayPage;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.type.TypeFactory;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
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
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Proxy;
import java.math.BigDecimal;
import java.util.*;




/**declare
 * 轮换计划
 * @author lay
 *
 */
@Controller
@RequestMapping("/rotatePlan")
public class RotatePlanController {
	private static Logger log = Logger.getLogger(RotatePlanController.class);
	
	@Autowired
	private RotatePlanService service;
	@Autowired
	private SysDictService sysDictService;
	@Autowired
	private QualityQuotaService quotaService;
	@Autowired
	private ReportSwtzService swtzService;
	@Autowired
	private QualityQuotaItemService quotaItemService;
	@Autowired
	private SysFileService fileService;
	@Autowired
	private SysOAService sysOAService;
	@Autowired
	private HttpServletRequest request;
	@Autowired
	private StorageWarehouseService storageWarehouseService;
	@Autowired
	private QualitySampleService qualitySampleService;
	@Autowired
	private QualityResultService qualityResultService;
	@Autowired
	private QualityThirdService qualityThirdService;
	@Autowired
	private ReportMonthService reportMonthService;
	@Autowired
	private SysLogService sysLogService;

	@Autowired
	private RotatePlanmainService rotatePlanmainService;

	@Autowired
	private SysFileService sysFileService;

	@Autowired
	private RotateSchemeService rotateSchemeService;


	@RequestMapping("/add")
	public String NewRotatePlan(Model model) {
		SysUser user=TokenManager.getToken();
		RotatePlan rotatePlan =new RotatePlan();
		rotatePlan.setDepartment(user.getDepartment());
		rotatePlan.setColletor(user.getName());
		rotatePlan.setModifier(user.getName());
		Date now =new Date();
		rotatePlan.setColletorDate(now);
		rotatePlan.setModifyDate(now);
		//仓房类型
		List<SysDict> types = sysDictService.getSysDictListByType("仓房类型");
		//仓房状态
		List<SysDict> status = sysDictService.getSysDictListByType("仓房状态");
		//油罐类型
		List<SysDict> oilcanTypes = sysDictService.getSysDictListByType("油罐类型");
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		//粮油等级
		List<SysDict> qualityLevel = sysDictService.getSysDictListByType("粮油等级");
		List<SysDict> grainLevel = new ArrayList<SysDict>();
		List<SysDict> oilLevel = new ArrayList<SysDict>();
		for(int i = 0,size=qualityLevel.size(); i < size; i++){
			if(qualityLevel.get(i).getValue().contains("等")){
				grainLevel.add(qualityLevel.get(i));
			}else{
				oilLevel.add(qualityLevel.get(i));
			}
		}

//		List<SysDict> grainQuantity = sysDictService.getSysDictListByType("粮油等级");
//		List<QualityQuota> quotas=quotaService.listQualityQuota();
		//库点、代储点
		List<StorageWarehouse> wareHouse = storageWarehouseService.limitList();
		List<String> warehouseNames = new ArrayList<>();
		for(StorageWarehouse item : wareHouse)
			warehouseNames.add(item.getWarehouseShort());
		model.addAttribute("rotatePlan", rotatePlan);
		model.addAttribute("isEdit", false);
		model.addAttribute("types", types);
		model.addAttribute("oilcanTypes", oilcanTypes);
		model.addAttribute("status", status);
		model.addAttribute("grainTypes", grainTypes);
		model.addAttribute("grainLevel",grainLevel);
		model.addAttribute("oilLevel",oilLevel);
		model.addAttribute("warehouses", warehouseNames);
		return "RotatePlan/rotateplan_add";
	}
	
	@RequestMapping(value="/edit",params="sid")
	public String EditRotatePlan(Model model,@RequestParam("sid") String sid) {
		//仓房类型
		List<SysDict> types = sysDictService.getSysDictListByType("仓房类型");
		//仓房状态
		List<SysDict> status = sysDictService.getSysDictListByType("仓房状态");
		//油罐类型
		List<SysDict> oilcanTypes = sysDictService.getSysDictListByType("油罐类型");
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		//粮油等级
		List<SysDict> qualityLevel = sysDictService.getSysDictListByType("粮油等级");
		List<SysDict> grainLevel = new ArrayList<SysDict>();
		List<SysDict> oilLevel = new ArrayList<SysDict>();
		for(int i = 0,size=qualityLevel.size(); i < size; i++){
			if(qualityLevel.get(i).getValue().contains("等")){
				grainLevel.add(qualityLevel.get(i));
			}else{
				oilLevel.add(qualityLevel.get(i));
			}
		}

//		List<QualityQuota> quotas=quotaService.listQualityQuota();
		//库点、代储点
		List<StorageWarehouse> wareHouse = storageWarehouseService.limitList();
		List<String> warehouseNames = new ArrayList<>();
		for(StorageWarehouse item : wareHouse)
			warehouseNames.add(item.getWarehouseShort());
		RotatePlan rotatePlan = service.getPlan(sid);
		String planmainId = rotatePlan.getPlanmainID();
		RotatePlanmain rotatePlanmain = rotatePlanmainService.getPlan(planmainId);
		model.addAttribute("types", types);
		model.addAttribute("oilcanTypes", oilcanTypes);
		model.addAttribute("status", status);
		model.addAttribute("grainTypes", grainTypes);
		model.addAttribute("grainLevel",grainLevel);
		model.addAttribute("oilLevel",oilLevel);
		model.addAttribute("warehouses", warehouseNames);
		model.addAttribute("rotatePlan", rotatePlan);
		model.addAttribute("detailList", rotatePlan.getPlanDetail());
		model.addAttribute("myFile", fileService.selectById(rotatePlan.getAttachment()));
		model.addAttribute("isEdit", true);
		model.addAttribute("rotatePlanmain", rotatePlanmain);
		return "RotatePlan/rotateplan_add";
	}

	@SysLogAn("访问：轮换业务-轮换计划-计划申报")
	@RequestMapping("/main")
	public String RotatePlanList(Model model,
			@RequestParam(value="type",required=false)String type) {
		if(BusinessConstants.CBL_CODE.equals(TokenManager.getToken().getOriginCode().toLowerCase())) {
			type=BusinessConstants.CBL;
		}else {
			type=BusinessConstants.BASE;
		}
		model.addAttribute("type",type);
		return "RotatePlan/rotateplan_main";
	}

	@SysLogAn("访问：轮换业务-轮换计划-计划清单")
	@RequestMapping("/main2")
	public String RotatePlanList2(Model model,
			@RequestParam(value="type",required=false)String type) {
		if(TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")) {
			type="ProviceUnit";
		}else {
			type="Base";
		}
		model.addAttribute("type",type);
		return "RotatePlan/rotateplan_main2";
	}
	
	@RequestMapping(value="/view",params="sid")
	public String RotatePlanDetail(Model model,@RequestParam("sid") String sid
			,@RequestParam("rotatetype") String rotatetype,
			@RequestParam("type") String type) {
		HashMap<String, String> map = new HashMap<>();
		map.put("planId", sid);
		map.put("rotateType", rotatetype);
		RotatePlan rotatePlan = service.getPlan(sid);
		List<RotatePlanDetail> details = service.listDetailByCondition(map);
		String reportMonth = "";
		if(details.size() > 0) {
			if(details.get(0).getSwtzId() == null)
				reportMonth = String.valueOf(Integer.parseInt(rotatePlan.getYear())-1)+"-12";
			else
				reportMonth = reportMonthService.getReportMonthById(details.get(0).getSwtzId()).getReportMonth();
		}
		//对数据进行权限上的控制
		List<String> wareHouseIds = new ArrayList<>();
		if(type!=null && type.toLowerCase().equals("proviceunit")) {
			//可查看所有数据 所以不需要对数据做过滤操作

		}else if(type != null && type.toLowerCase().equals("base")) {
			SysUser user = TokenManager.getToken();
			String baseName = user.getShortName(); //获取到用户的库点信息

			//---------Jovan--------------------------------------//
			String wareHouseId = user.getWareHouseId();
			wareHouseIds.add(wareHouseId);
			for(StorageWarehouse base : storageWarehouseService.listSuperviseOfWarehouse(wareHouseId))
				wareHouseIds.add(base.getId());
			//---------Jovan--------------------------------------//
		}
		for(int i=0;i<details.size();i++) {
			if(null!=wareHouseIds&&wareHouseIds.size()>0&&!wareHouseIds.contains(details.get(i).getWarehouseid())) {
				details.remove(i--);
				continue;
			}
			if("轮出".equals(details.get(i).getRotateType())) {
				ReportSwtz reportSwtz = swtzService.getReportSwtzByOther(reportMonth, details.get(i).getLibraryName(), details.get(i).getBarnNumber(), 
						details.get(i).getFoodType(), details.get(i).getOrign(), details.get(i).getYieldTime());
				details.get(i).setSwtz(reportSwtz);
			}else {
				List<QualityQuotaItem> quotaItems = quotaItemService.getByID(details.get(i).getQualityId());
				HashMap<String, String> quotaItemMap = new HashMap<>();
				for(QualityQuotaItem quotaItem:quotaItems) {
					quotaItemMap.put(quotaItem.getItemName(), quotaItem.getStandard());
				}
				details.get(i).setQuotaItemMap(quotaItemMap);
			}
		}
		model.addAttribute("rotateType", rotatetype);
		model.addAttribute("rotatePlanDetail", details);
		return "RotatePlan/rotateplandetail_view";
	}
	/**
	 * 清单页的查看
	 * @param model
	 * @param sid
	 * @param type
	 * @return
	 */
	@RequestMapping(value="/view2",params="sid")
	public String RotatePlanDetail2(Model model,@RequestParam("sid") String sid,
			@RequestParam("type") String type) {
		HashMap<String, String> map = new HashMap<>();
		map.put("planId", sid);
		RotatePlan rotatePlan = service.getPlan(sid);
		List<RotatePlanDetail> details = service.listDetailByCondition(map);
		String reportMonth = "";
		if(details.size() > 0) {
			if(details.get(0).getSwtzId() == null)
				reportMonth = String.valueOf(Integer.parseInt(rotatePlan.getYear())-1)+"-12";
			else
				reportMonth = reportMonthService.getReportMonthById(details.get(0).getSwtzId()).getReportMonth();
		}
		//对数据进行权限上的控制
		List<String> baseNames = new ArrayList<>();
		List<String> wareHouseIds = new ArrayList<>();
		if(type!=null && type.toLowerCase().equals("proviceunit")) {
			//可查看所有数据 所以不需要对数据做过滤操作

		}else if(type != null && type.toLowerCase().equals("base")) {
			SysUser user = TokenManager.getToken();
			//---------Jovan--------------------------------------//
			String wareHouseId = user.getWareHouseId();
			wareHouseIds.add(wareHouseId);
			for(StorageWarehouse base : storageWarehouseService.listSuperviseOfWarehouse(wareHouseId))
				wareHouseIds.add(base.getId());
			//---------Jovan--------------------------------------//
		}
		for(int i=0;i<details.size();i++) {
			BigDecimal unDealDetailNumber = details.get(i).getRotateNumber().subtract(details.get(i).getDealDetailNumber());
			details.get(i).setUnDealDetailNumber(unDealDetailNumber);
			if(null!=wareHouseIds&&wareHouseIds.size()>0&&!wareHouseIds.contains(details.get(i).getWarehouseid())) {
				details.remove(i--);
				continue;
			}
			if("轮出".equals(details.get(i).getRotateType())) {
				ReportSwtz reportSwtz = swtzService.getReportSwtzByOther(reportMonth, details.get(i).getLibraryName(), details.get(i).getBarnNumber(), 
						details.get(i).getFoodType(), details.get(i).getOrign(), details.get(i).getYieldTime());
				details.get(i).setSwtz(reportSwtz);
			}else {
				List<QualityQuotaItem> quotaItems = quotaItemService.getByID(details.get(i).getQualityId());
				HashMap<String, String> quotaItemMap = new HashMap<>();
				for(QualityQuotaItem quotaItem:quotaItems) {
					quotaItemMap.put(quotaItem.getItemName(), quotaItem.getStandard());
				}
				details.get(i).setQuotaItemMap(quotaItemMap);
			}
		}
		rotatePlan.setPlanDetail(details);
		model.addAttribute("type", type);
		model.addAttribute("rotatePlan", rotatePlan);
		model.addAttribute("myFile", fileService.selectById(rotatePlan.getAttachment()));
		return "RotatePlan/rotateplandetail_view2";
	}
	/**
	 * 
	 * @param file
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	@RequestMapping(value = "/importExcel",method=RequestMethod.POST)
	@ResponseBody
	public Object importExcel(@RequestParam(value="file") MultipartFile file,
			@RequestParam(value="reportMonth") String reportMonth) throws IOException, Exception {
		
		ActionResultModel actionResultModel = new ActionResultModel();
		ImportParams params = new ImportParams();
		List<RotatePlanDetail> list=null;
		try {
			list = ExcelImportUtil.importExcel(file.getInputStream(), RotatePlanDetail.class, params);
		}catch (Exception e) {
			// TODO: handle exception
			actionResultModel.setMsg("数据导入失败:请核对excel模板!");
			actionResultModel.setSuccess(false);
			return actionResultModel;
		}
		
		for(RotatePlanDetail detail:list) {
			if("轮出".equals(detail.getRotateType())) {
				ReportSwtz reportSwtz = swtzService.getReportSwtzByOther(reportMonth, detail.getLibraryName(), detail.getBarnNumber(), 
						detail.getFoodType(), detail.getOrign(), detail.getYieldTime());
				if(null==reportSwtz) {
					actionResultModel.setSuccess(false);
					actionResultModel.setMsg(String.format("库点:%s,仓号:%s,品种:%s,产地:%s,生产年份:%s,未找到相对的台账记录,请核对数据!",
							detail.getLibraryName(),detail.getBarnNumber(),
							detail.getFoodType(),detail.getOrign(),detail.getYieldTime()));
					return actionResultModel;
				}
				detail.setSwtzId(reportSwtz.getReportId());
			}else {
				QualityQuota quota = quotaService.getQualityQuotaByOther(detail.getFoodType(), detail.getQuality());
				if(null==quota) {
					actionResultModel.setSuccess(false);
					actionResultModel.setMsg(String.format("品种:%s,等级:%s,还未录入到数据库中,请核对数据!",
							detail.getFoodType(),detail.getQuality()));
					return actionResultModel;
				}
				detail.setQualityId(quota.getId());
			}
		}
		actionResultModel.setData(list);

		actionResultModel.setSuccess(true);
		
		return actionResultModel;
	}
	/**
	 * excel导出
	 * @param request
	 * @param response
	 * @param id
	 * @throws IOException
	 */
	@SysLogAn("轮换业务-计划申报-导出")
	@RequestMapping(value="/exportExcel")
	@ResponseBody
	public void ExportExcel(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value="id")String id,
			@RequestParam(value="type",required=false) String type) throws Exception {
	    String dataScope = request.getParameter("dataScope");
		List<RotatePlan> list = new ArrayList<>();
		RotatePlan rotatePlan = service.getPlan(id);
		List<RotatePlanDetail> details = service.listDetail(id);
		String reportMonth;
		if(details.size() > 0) {
			if(details.get(0).getSwtzId() == null)
				reportMonth = String.valueOf(Integer.parseInt(rotatePlan.getYear())-1)+"-12";
			else
				reportMonth = reportMonthService.getReportMonthById(details.get(0).getSwtzId()).getReportMonth();
		}
		else
			return;
		
		List<RotatePlanDetailForExcel> detailForExcels = new ArrayList<>();
		//对数据进行权限上的控制
		List<String> wareHouseIds = new ArrayList<>();
		if(type!=null && type.toLowerCase().equals("proviceunit")) {
			//可查看所有数据 所以不需要对数据做过滤操作

		}else if(type != null && type.toLowerCase().equals("base")) {
			SysUser user = TokenManager.getToken();
			String baseName = user.getShortName();  //获取到用户的库点信息
			//---------Jovan--------------------------------------//
			String wareHouseId = user.getWareHouseId();
			wareHouseIds.add(wareHouseId);
			for(StorageWarehouse base : storageWarehouseService.listSuperviseOfWarehouse(wareHouseId))
				wareHouseIds.add(base.getId());
			//---------Jovan--------------------------------------//
		}
		/*根据条件动态修改RotatePlanDetailForExcel中dealDetailNumber、unDealDetailNumber
		中注解属性key,value  当条件为全部时，不改变注解；当条件为已成交时
		给unDealDetailNumber注解添加width = 0.0,当条件为未成交时给dealDetailNumber
		注解添加width = 0.0*/
		if("deal".equals(dataScope) || "undeal".equals(dataScope)) {
            RotatePlanDetailForExcel rotatePlanDetailForExcel = new RotatePlanDetailForExcel();
            if("undeal".equals(dataScope)) {
                Field field = RotatePlanDetailForExcel.class.getDeclaredField("dealDetailNumber");
                //Field unField = RotatePlanDetailForExcel.class.getDeclaredField("unDealDetailNumber");
                Excel excel = field.getAnnotation(Excel.class);
                InvocationHandler h = Proxy.getInvocationHandler(excel);
                Field hField = h.getClass().getDeclaredField("memberValues");
                hField.setAccessible(true);
                Map memberValues = (Map) hField.get(h);
                memberValues.put("width", 0.0);//注意这个width必须为double类型，不能为int


				Field unfield = RotatePlanDetailForExcel.class.getDeclaredField("unDealDetailNumber");
				Excel unexcel = unfield.getAnnotation(Excel.class);
				InvocationHandler unh = Proxy.getInvocationHandler(unexcel);
				Field unhField = unh.getClass().getDeclaredField("memberValues");
				unhField.setAccessible(true);
				Map unmemberValues = (Map) unhField.get(unh);
				unmemberValues.put("width", 10.0);//注意这个width必须为double类型，不能为int

            }else if("deal".equals(dataScope)){
                Field unfield = RotatePlanDetailForExcel.class.getDeclaredField("unDealDetailNumber");
                Excel unexcel = unfield.getAnnotation(Excel.class);
                InvocationHandler unh = Proxy.getInvocationHandler(unexcel);
                Field unhField = unh.getClass().getDeclaredField("memberValues");
				unhField.setAccessible(true);
                Map unmemberValues = (Map) unhField.get(unh);
				unmemberValues.put("width", 0.0);//注意这个width必须为double类型，不能为int


				Field field = RotatePlanDetailForExcel.class.getDeclaredField("dealDetailNumber");
				Excel excel = field.getAnnotation(Excel.class);
				InvocationHandler h = Proxy.getInvocationHandler(excel);
				Field hField = h.getClass().getDeclaredField("memberValues");
				hField.setAccessible(true);
				Map memberValues = (Map) hField.get(h);
				memberValues.put("width", 10.0);//注意这个width必须为double类型，不能为int
            }else if("all".equals(dataScope)){
				Field field = RotatePlanDetailForExcel.class.getDeclaredField("dealDetailNumber");
				//Field unField = RotatePlanDetailForExcel.class.getDeclaredField("unDealDetailNumber");
				Excel excel = field.getAnnotation(Excel.class);
				InvocationHandler h = Proxy.getInvocationHandler(excel);
				Field hField = h.getClass().getDeclaredField("memberValues");
				hField.setAccessible(true);
				Map memberValues = (Map) hField.get(h);
				memberValues.put("width", 10.0);//注意这个width必须为double类型，不能为int


				Field unfield = RotatePlanDetailForExcel.class.getDeclaredField("unDealDetailNumber");
				Excel unexcel = unfield.getAnnotation(Excel.class);
				InvocationHandler unh = Proxy.getInvocationHandler(unexcel);
				Field unhField = unh.getClass().getDeclaredField("memberValues");
				unhField.setAccessible(true);
				Map unmemberValues = (Map) unhField.get(unh);
				unmemberValues.put("width", 10.0);//注意这个width必须为double类型，不能为int
			}
        }else{

		}

		for(int i=0;i<details.size();i++) {
			if(null!=wareHouseIds&&wareHouseIds.size()>0&&!wareHouseIds.contains(details.get(i).getWarehouseid())) {
				details.remove(i--);
				continue;
			}
            if("undeal".equals(dataScope)){
			    //把成交数量=轮换数量的数据过滤掉
                BigDecimal rotateNumber = details.get(i).getRotateNumber();
                BigDecimal dealDetailNumber = details.get(i).getDealDetailNumber();
                if(rotateNumber.compareTo(dealDetailNumber)==0){
                    details.remove(i--);
                    continue;
                }
            }
            if("deal".equals(dataScope)){
                //把成交数量=0的数据过滤掉
                BigDecimal dealDetailNumber = details.get(i).getDealDetailNumber();
                if(BigDecimal.ZERO.compareTo(dealDetailNumber)==0){
                    details.remove(i--);
                    continue;
                }
            }
			//计算未成交数量
			BigDecimal dealDetailNumber = details.get(i).getDealDetailNumber();
            BigDecimal unDealDetailNumber = details.get(i).getRotateNumber().subtract(dealDetailNumber);
			details.get(i).setUnDealDetailNumber(unDealDetailNumber);
            if("轮出".equals(details.get(i).getRotateType())) {
				ReportSwtz reportSwtz = swtzService.getReportSwtzByOther(reportMonth, details.get(i).getLibraryName(), details.get(i).getBarnNumber(), 
						details.get(i).getFoodType(), details.get(i).getOrign(), details.get(i).getYieldTime());
				detailForExcels.add(new RotatePlanDetailForExcel(details.get(i),reportSwtz));
			}else {
				List<QualityQuotaItem> quotaItems = quotaItemService.getByID(details.get(i).getQualityId());
				detailForExcels.add(new RotatePlanDetailForExcel(details.get(i),quotaItems));
			}
		}
		rotatePlan.setPlanDetailForExcels(detailForExcels);
		list.add(rotatePlan);
		String title = rotatePlan.getPlanName();
		
		response.setHeader("content-Type", "application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;filename=" +  java.net.URLEncoder.encode(title,"UTF-8") + ".xls");
		response.setCharacterEncoding("UTF-8");
		Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams(title, title),
				RotatePlan.class, list);

		workbook.write(response.getOutputStream());
	}
	
	@RequestMapping(value="/DetailList",method= {RequestMethod.POST})
	@ResponseBody
	public List<RotatePlanDetail> RotatePlanDetail(@RequestParam("sid") String sid) {
		return service.getPlan(sid).getPlanDetail();
	}
	/*根据计划申报id获取计划详情明细*/
	@RequestMapping(value="/mainDetailList",method= {RequestMethod.POST})
	@ResponseBody
	public List<RotatePlanDetail> mainDetailList(@RequestParam("sid") String sid) {
		 List<RotatePlanDetail> rotatePlanDetails = service.listPlanDetailByMainId(sid);
		//遍历，set入剩余计划数量
		if(null != rotatePlanDetails && rotatePlanDetails.size()>0){
			for(int i = 0;i<rotatePlanDetails.size();i++){
				RotatePlanDetail rotatePlanDetail = rotatePlanDetails.get(i);
				//如果没有终结，则计划余量算法如下：
				//剩余计划数量= 计划数量-已加入方案的计划数量+交易失败的数量
				//计划数量
				BigDecimal planRotateNumber = rotatePlanDetail.getRotateNumber();
				//已加入方案的计划数量
				BigDecimal planTotalCount = rotateSchemeService.PlanTotalCount(rotatePlanDetail.getId());
				//交易失败的数量
				BigDecimal unDealNumber = rotateSchemeService.unDealTotalCountByPlanDetailId(rotatePlanDetail.getId());
				BigDecimal restNumber = planRotateNumber.subtract(planTotalCount).add(unDealNumber);
				rotatePlanDetail.setRestNumber(restNumber);
				if(restNumber.compareTo(new BigDecimal(0))<1){
					//如果计划余量小于等于0则不显示该计划
					rotatePlanDetails.remove(i--);
				}
			}
		}
		return rotatePlanDetails;
	}
	
	/**
	 * 
	 * @param rotatePlan
	 * @param detailList
	 * @param isedit
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Object  saveOrUpdate(RotatePlan rotatePlan,
			@RequestParam(value="detailList") String detailList,
			@RequestParam(value="isedit") Boolean isedit, HttpServletRequest request) throws IOException {
		SysUser user = TokenManager.getToken();
		rotatePlan.setColletor(user.getId());
		ActionResultModel actionResultModel = new ActionResultModel();
		//统计每个计划年份每个粮食品种的轮换数量
		List<RotatePlanDetail> detailList1 = (List<RotatePlanDetail>) JSONArray.parseArray(detailList,RotatePlanDetail.class);
		Map<String,Double> map = new HashMap<>();
		for(RotatePlanDetail rotatePlanDetail:detailList1){
			Boolean isexist = false;
			if(map.keySet().size()==0){
				map.put(rotatePlanDetail.getPlanmaindetailId(),Double.valueOf(rotatePlanDetail.getRotateNumber().toString()));
				continue;
			}else{
				for(String key:map.keySet()){
					if(rotatePlanDetail.getPlanmaindetailId().equals(key)){
						isexist = true;
						continue;
					}
				}
				if(isexist){
					Double rotateNumber = map.get(rotatePlanDetail.getPlanmaindetailId())+Double.valueOf(rotatePlanDetail.getRotateNumber().toString());
					map.put(rotatePlanDetail.getPlanmaindetailId(),rotateNumber);
				}else{
					map.put(rotatePlanDetail.getPlanmaindetailId(),Double.valueOf(rotatePlanDetail.getRotateNumber().toString()));
				}
			}
		}
		if(isedit) {
			String id = rotatePlan.getId();
			List<RotatePlanDetail> rotatePlanDetaillist = service.getSumRotatenumberByPlanmaindetailId(id);
			HashMap<String,String> map1 = new HashMap();
			for(RotatePlanDetail rotatePlanDetail:rotatePlanDetaillist){
				map1.put(rotatePlanDetail.getPlanmaindetailId(),rotatePlanDetail.getRotateNumber().toString());
			}
			for(String key:map1.keySet()){
				RotatePlanmainDetail rotatePlanmainDetail = rotatePlanmainService.findById(key);
				Double rotateNumberi = 0.0;
				String rotateNumbers = rotatePlanmainDetail.getRotateNumber().toString();
				if(rotateNumbers!=null){
					rotateNumberi = Double.valueOf(rotateNumbers);
				}
				Double detailNumberi = 0.0;
				String detailNumbers = rotatePlanmainDetail.getDetailNumber();
				if(detailNumbers!=null){
					detailNumberi = Double.valueOf(detailNumbers);
				}
				Double rotateNumber1 = detailNumberi-Double.valueOf((String)map1.get(key));
				Double rotateNumber2 = rotateNumberi-rotateNumber1;
				for(String key1:map.keySet()){
					if(key.equals(key1)){
						if(map.get(key)>rotateNumber2){
							actionResultModel.setSuccess(false);
							actionResultModel.setMsg(rotatePlanmainDetail.getRotateType()+rotatePlanmainDetail.getYieldTime()+rotatePlanmainDetail.getFoodType()+"的轮换数量超过计划轮换数量");
							return actionResultModel;
						}
					}
				}
			}
			for(String key:map1.keySet()){
				RotatePlanmainDetail rotatePlanmainDetail = rotatePlanmainService.findById(key);
				Double detailNumberi = 0.0;
				String detailNumbers = rotatePlanmainDetail.getDetailNumber();
				if(detailNumbers!=null){
					detailNumberi = Double.valueOf(detailNumbers);
				}
				Double rotateNumber1 = detailNumberi-Double.valueOf((String)map1.get(key));
				rotatePlanmainDetail.setDetailNumber(String.valueOf(rotateNumber1));
				rotatePlanmainService.updatedetailNumberByid(rotatePlanmainDetail);
			}
		}
		//判断每个计划年份每个粮食品种的轮换数量是否大于计划总数量
		for(String key:map.keySet()){
			RotatePlanmainDetail rotatePlanmainDetail = rotatePlanmainService.findById(key);
			Double rotateNumberi = 0.0;
			Double detailNumberi = 0.0;
			String rotateNumbers = rotatePlanmainDetail.getRotateNumber().toString();
			String detailNumbers = rotatePlanmainDetail.getDetailNumber();
			if(rotateNumbers!=null){
				rotateNumberi = Double.valueOf(rotateNumbers);
			}
			if(detailNumbers!=null){
				detailNumberi = Double.valueOf(detailNumbers);
			}
			Double rotateNumber2 = rotateNumberi-detailNumberi;
			Double rotateNumber1 = map.get(key);
			if(rotateNumber1>rotateNumber2){
				actionResultModel.setSuccess(false);
				actionResultModel.setMsg(rotatePlanmainDetail.getRotateType()+rotatePlanmainDetail.getYieldTime()+rotatePlanmainDetail.getFoodType()+"的轮换数量超过计划轮换数量");
				return actionResultModel;
			}
		}
		for(String key:map.keySet()){
			RotatePlanmainDetail rotatePlanmainDetail = rotatePlanmainService.findById(key);
			Double detailNumberi = 0.0;
			String detailNumbers = rotatePlanmainDetail.getDetailNumber();
			if(detailNumbers!=null){
				detailNumberi = Double.valueOf(detailNumbers);
			}
			Double rotateNumber1 = map.get(key);
			rotatePlanmainDetail.setDetailNumber(String.valueOf(rotateNumber1+detailNumberi));
			rotatePlanmainService.updatedetailNumberByid(rotatePlanmainDetail);
		}
		ObjectMapper mapper = new ObjectMapper();
		List<RotatePlanDetail> plan_Detail = mapper.readValue(detailList,TypeFactory.defaultInstance().constructCollectionType(List.class,RotatePlanDetail.class));
		for(RotatePlanDetail planDetail : plan_Detail){
			if(StringUtils.isEmpty(planDetail.getWarehouseid())){
				planDetail.setWarehouseid(storageWarehouseService.getWarehouseIdByShortname(planDetail.getLibraryName()));
			}
		}
		
		rotatePlan.setPlanDetail(plan_Detail);

		if(null == isedit || !isedit) {
			sysLogService.add(request, "轮换业务-计划详情-新增");
			rotatePlan.setColletor(user.getName());
			service.save(rotatePlan);
		}else{
			rotatePlan.setColletor(user.getName());
			sysLogService.add(request, "轮换业务-计划详情-修改");
			service.update(rotatePlan);
		}
		//OA
		if(rotatePlan.getState() != null && rotatePlan.getState().contains("OA")) {
			String fileCode = exprotAnyExcel(rotatePlan.getId());
			sysOAService.LaunchedAudit(
					rotatePlan.getId(), 
					TokenManager.getToken().getId(), 
					rotatePlan.getPlanName(),
					String.format("http://%s:%s%s/", request.getServerName(),request.getServerPort(),request.getContextPath()) + "files/code/" + fileCode,
					new SysProcessMapper("T_ROTATE_PLAN", "STATE", "审核通过:"));
		}
		
		actionResultModel.setSuccess(true);
		
		return actionResultModel;
	}
	
	/**
	 *
	 * @param sid
	 * @return
	 */
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel remove(@RequestParam(value="sid") String sid) {
		ActionResultModel actionResultModel = new ActionResultModel();
		HashMap<String, Object> map1=new HashMap<>();
		map1.put("planId",sid);
		int total = rotateSchemeService.count(map1);
		if(total>0){
			actionResultModel.setSuccess(false);
			actionResultModel.setMsg("该计划详情下有轮换方案，无法删除！");
			return actionResultModel;
		}
		List<RotatePlanDetail> rotatePlanDetaillist = service.getSumRotatenumberByPlanmaindetailId(sid);
		HashMap<String,String> map = new HashMap();
		for(RotatePlanDetail rotatePlanDetail:rotatePlanDetaillist){
			map.put(rotatePlanDetail.getPlanmaindetailId(),rotatePlanDetail.getRotateNumber().toString());
		}
		for(String key:map.keySet()){
			RotatePlanmainDetail rotatePlanmainDetail = rotatePlanmainService.findById(key);
			Double detailNumberi = 0.0;
			String detailNumbers = rotatePlanmainDetail.getDetailNumber();
			if(detailNumbers!=null){
				detailNumberi = Double.valueOf(detailNumbers);
			}
			Double rotateNumber1 = detailNumberi-Double.valueOf((String)map.get(key));
			rotatePlanmainDetail.setDetailNumber(String.valueOf(rotateNumber1));
			rotatePlanmainService.updatedetailNumberByid(rotatePlanmainDetail);
		}

		int row=service.remove(sid);
		int row2=service.removeDetail(sid);
		if(row>0&&row2>0) {
			actionResultModel.setSuccess(true);
			actionResultModel.setMsg("删除成功");
		}else {
			actionResultModel.setSuccess(false);
			actionResultModel.setMsg("删除失败");
		}
		//actionResultModel.setSuccess(true);
		return actionResultModel;
	}

	/**
	 * 删除轮换计划
	 * @param sid
	 * @return
	 */
	@RequestMapping(value="/removePlan",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel removePlan(@RequestParam(value="sid") String sid) {
		ActionResultModel actionResultModel = new ActionResultModel();
		HashMap<String, Object> map=new HashMap<>();
		map.put("planMainId",sid);
		int total =service.count(map);
		if(total>0){
			actionResultModel.setSuccess(false);
			actionResultModel.setMsg("该计划下有计划详情，无法删除！");
			return actionResultModel;
		}

		int row=rotatePlanmainService.remove(sid);
		int row2=rotatePlanmainService.removeDetail(sid);
		if(row>0&&row2>0) {
			actionResultModel.setSuccess(true);
			actionResultModel.setMsg("删除成功");
		}else {
			actionResultModel.setSuccess(false);
			actionResultModel.setMsg("删除失败");
		}
		//actionResultModel.setSuccess(true);
		return actionResultModel;
	}
	/**
	 * 
	 * @param sid
	 * @return
	 */
	@RequestMapping(value="/removeDetail",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel deleteDetail(String sid) {
		ActionResultModel actionResultModel = new ActionResultModel();
		int row=service.removeDetail(sid);
		if(row>0) {
			actionResultModel.setSuccess(true);
			actionResultModel.setMsg("删除成功");
		}else {
			actionResultModel.setSuccess(false);
			actionResultModel.setMsg("删除失败");
		}
		return actionResultModel;
	}
	/**
	 * 
	 * @param pageIndex
	 * @param pageSize
	 * @param planName
	 * @param documentNumber
	 * @param year
	 * @param colletor
	 * @param colletorDate
	 * @param state
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value="/list")
	@ResponseBody
	public LayPage<RotatePlan> list(
			@RequestParam(value="pageIndex") int pageIndex,
			@RequestParam(value="pageSize") int pageSize,
			@RequestParam(value="planName",required=false) String planName,
			@RequestParam(value="documentNumber",required=false) String documentNumber,
			@RequestParam(value="year",required=false) String year,
			@RequestParam(value="colletor",required=false) String colletor,
			@RequestParam(value="colletorDate",required=false) String colletorDate,
			@RequestParam(value="state",required=false) String state,
			@RequestParam(value="type",required=false)String type,
			@RequestParam(value="completeDate",required=false)String completeDate) throws UnsupportedEncodingException {
		
		HashMap<String, Object> map=new HashMap<>();
		map.put("pageIndex", String.valueOf(pageIndex));
		map.put("pageSize", String.valueOf(pageSize));
		map.put("planName", planName);
		map.put("documentNumber", documentNumber);
		map.put("colletor", colletor);
		map.put("year", year);
		map.put("colletorDate",colletorDate);
		map.put("completeDate",completeDate);
		map.put("state", state);
		//对数据进行权限上的控制
		if(type!=null && type.toLowerCase().equals("proviceunit")) {
			//可查看所有数据 所以不需要对数据做过滤操作

		}else if(type != null && type.toLowerCase().equals("base")) {
			SysUser user = TokenManager.getToken();
			//---------Jovan--------------------------------------//
			List<String> wareHouseIds = new ArrayList<>();
			String wareHouseId = user.getWareHouseId();
			wareHouseIds.add(wareHouseId);
			for(StorageWarehouse base : storageWarehouseService.listSuperviseOfWarehouse(wareHouseId))
				wareHouseIds.add(base.getId());
			map.put("wareHouseIds", wareHouseIds);
			//---------Jovan--------------------------------------//
		}
		int total =service.count(map);
		List<RotatePlan> list=null;
		if(total>0)
			list = service.list(map);
		for (int i = 0; i < list.size() ; i++) {
			BigDecimal stockIn = list.get(i).getStockIn();
			BigDecimal stockOut = list.get(i).getStockOut();
			//计算该计划已成交的轮入轮出数量
			Map<String,Object> conditionMap = new HashMap<String,Object>();
			conditionMap.put("planId",list.get(i).getId());
			conditionMap.put("rotateType","轮入");
			BigDecimal inDealDetailNumber = service.getSumDealDetailNumberByRotateType(conditionMap);
			list.get(i).setInDealQuantiy(inDealDetailNumber);
			list.get(i).setInUnDealQuantiy(stockIn.subtract(inDealDetailNumber));

			conditionMap.put("rotateType","轮出");
			BigDecimal outDealDetailNumber = service.getSumDealDetailNumberByRotateType(conditionMap);
			list.get(i).setOutDealQuantiy(outDealDetailNumber);
			list.get(i).setOutUnDealQuantiy(stockOut.subtract(outDealDetailNumber));
		}
		LayPage<RotatePlan> pageUtil=new LayPage<>(list, total);

		return pageUtil;
	}
	/**
	 * 更新状态
	 * @param id
	 * @param state
	 * @return
	 */
	@RequestMapping(value="/updateState",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel updateState(HttpServletRequest request,
			@RequestParam(value="id")String id,
			@RequestParam(value="state")String state) {
		service.updateState(id, state);
		sysLogService.add(request, "轮换业务-计划申报-" + state);
		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}
	
	@RequestMapping(value="/GetQualityInfo",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel GetQualityInfo(@RequestParam(value="planDetailid")String planDetailid,@RequestParam(value = "storehouse", required = false) String storehouse) {
		ActionResultModel actionResultModel = new ActionResultModel();
		Map<String,Object> result = new HashMap<>();
//		RotatePlanDetail rotatePlan2=service.getPlanDetail(planDetailid);
		RotatePlanDetail rotatePlanDetail = service.getPlanDetail(planDetailid);

		if(null !=rotatePlanDetail) {

			String dealSerial = null;	// 成交明细号
			dealSerial = rotatePlanDetail.getDealSerial();
			if(StringUtils.isNotEmpty(dealSerial)){
				Map<String,Object> paramSample = new HashMap<>();
				paramSample.put("dealSerial", dealSerial);

				// 入库质检
				paramSample.put("sort", "ASC");
				paramSample.put("validType", "入库质检");
				// 查询对应样品信息	 入库只取第一条数据
				String sampleNo = qualitySampleService.getQualityInfo(paramSample);
				Map<String,Object> param = new HashMap<>();
				if(StringUtils.isNotEmpty(sampleNo)) {
					param.put("sampleNo", sampleNo);
					param.put("validType", "入库质检");
					List<QualityResult> qualityResult_in = qualityResultService.getResultBySampleNo(param);	// 实际上一个样品信息只对应一条质检
					result.put("In",qualityResult_in==null||qualityResult_in.size()==0?null:qualityResult_in.get(0));
				}else{
					result.put("In",null);
				}

				// 出库质检
				paramSample.put("validType", "出库质检");
				paramSample.put("storehouse", org.apache.commons.lang.StringUtils.deleteWhitespace(storehouse));
				paramSample.put("sort", "DESC");
				// 出库查询最后一条
				sampleNo = qualitySampleService.getQualityInfo(paramSample);
				if(StringUtils.isNotEmpty(sampleNo)) {
					param.put("sampleNo", sampleNo);
					param.put("validType", "出库质检");
					List<QualityResult> qualityResult_out = qualityResultService.getResultBySampleNo(param);	// 实际上一个样品信息只对应一条质检
					result.put("Out",qualityResult_out==null||qualityResult_out.size()==0?null:qualityResult_out.get(0));
				}else{
					result.put("Out",null);
				}
			}else{
				result.put("In",null);
				result.put("Out",null);
			}
		}else{
			result.put("In",null);
			result.put("Out",null);
		}
		actionResultModel.setData(result);
		actionResultModel.setSuccess(true);
		
		return actionResultModel;
	}
	
	public String exprotAnyExcel(String id) {
		SysUser user = TokenManager.getToken();
		String fileCode = null;
		
		RotatePlan plan = service.getPlan(id);
		if(plan != null) {
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
			HttpGet get = new HttpGet(host + String.format("rotatePlan/exportExcel.shtml?%s", param.toString()));
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

	@SysLogAn("访问：轮换业务-轮换计划-计划申报")
	@RequestMapping("/declare")
	public String RotatePlandeclare(Model model,@RequestParam(value="type",required=false)String type) {
		if(TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")) {
			type="ProviceUnit";
		}else {
			type="Base";
		}
		model.addAttribute("type",type);
		return "RotatePlan/rotateplan_declare";
	}

	/**
	 * 查询轮换计划列表
	 * @param pageIndex
	 * @param pageSize
	 * @param planName
	 * @param documentNumber
	 * @param year
	 * @param colletor
	 * @param colletorDate
	 * @param state
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value="/declarelist")
	@ResponseBody
	public LayPage<RotatePlanmain> declarelist(
			@RequestParam(value="pageIndex") int pageIndex,
			@RequestParam(value="pageSize") int pageSize,
			@RequestParam(value="planName",required=false) String planName,
			@RequestParam(value="documentNumber",required=false) String documentNumber,
			@RequestParam(value="year",required=false) String year,
			@RequestParam(value="colletor",required=false) String colletor,
			@RequestParam(value="colletorDate",required=false) String colletorDate,
			@RequestParam(value="state",required=false) String state,
			@RequestParam(value="type",required=false)String type,
			@RequestParam(value="completeDate",required=false)String completeDate) throws UnsupportedEncodingException {

		HashMap<String, Object> map=new HashMap<>();
		map.put("pageIndex", String.valueOf(pageIndex));
		map.put("pageSize", String.valueOf(pageSize));
		map.put("planName", planName);
		map.put("documentNumber", documentNumber);
		map.put("colletor", colletor);
		map.put("year", year);
		map.put("colletorDate",colletorDate);
		map.put("completeDate",completeDate);
		map.put("state", state);
		//对数据进行权限上的控制
		/*if(type!=null && type.toLowerCase().equals("proviceunit")) {
			//可查看所有数据 所以不需要对数据做过滤操作

		}else if(type != null && type.toLowerCase().equals("base")) {
			SysUser user = TokenManager.getToken();
			String baseName = user.getShortName(); //获取到用户的库点信息
			List<String> baseNames = new ArrayList<>();
			baseNames.add(baseName);
			for(StorageWarehouse base : storageWarehouseService.listSuperviseOfWarehouse(baseName))
				baseNames.add(base.getWarehouseShort());
			map.put("baseNames", baseNames);
		}*/
		int total =rotatePlanmainService.count(map);
		List<RotatePlanmain> list=null;
		List<RotatePlanmain> list1=new ArrayList<>();
		if(total>0)
			list = rotatePlanmainService.list(map);
		if(list!=null){
			for(RotatePlanmain rotatePlanmain:list){
				if(rotatePlanmain.getPlanType().equals("01")){
					rotatePlanmain.setPlanType("年度计划");
				}else if(rotatePlanmain.getPlanType().equals("02")){
					rotatePlanmain.setPlanType("超标粮食处置计划");
				}else{
					rotatePlanmain.setPlanType("补充计划");
				}
				list1.add(rotatePlanmain);
			}
		}
		LayPage<RotatePlanmain> pageUtil=new LayPage<>(list1, total);

		return pageUtil;
	}

	/**
	 * 跳转轮换计划新增页面
	 * @param model
	 * @return String
	 */
	@RequestMapping("/adddeclare")
	public String addRotatePlanDeclare(Model model) {
		SysUser user=TokenManager.getToken();

		RotatePlan rotatePlan =new RotatePlan();
		rotatePlan.setDepartment(user.getDepartment());
		rotatePlan.setColletor(user.getName());
		rotatePlan.setModifier(user.getName());
		Date now =new Date();
		rotatePlan.setColletorDate(now);
		rotatePlan.setModifyDate(now);

		//仓房类型
		List<SysDict> types = sysDictService.getSysDictListByType("仓房类型");
		//仓房状态
		List<SysDict> status = sysDictService.getSysDictListByType("仓房状态");
		//油罐类型
		List<SysDict> oilcanTypes = sysDictService.getSysDictListByType("油罐类型");
		//粮油品种
		List<SysDict> grainType = sysDictService.getSysDictListByType("粮油品种");
		List<String>  grainTypes = new ArrayList<String>();
		for(int i = 0 ;i<grainType.size();i++){
			grainTypes.add(grainType.get(i).getValue());
		}
		//粮油等级
		List<SysDict> grainQuantity = sysDictService.getSysDictListByType("粮油等级");
		List<SysDict> grainLevel = new ArrayList<SysDict>();
		List<SysDict> oilLevel = new ArrayList<SysDict>();
		for(int i = 0;i<grainQuantity.size();i++){
			if(grainQuantity.get(i).getValue().contains("等")){
				grainLevel.add(grainQuantity.get(i));
			}else{
				oilLevel.add(grainQuantity.get(i));
			}
		}

		List<QualityQuota> quotas=quotaService.listQualityQuota();
		//库点、代储点
		List<StorageWarehouse> wareHouse = storageWarehouseService.limitList();
		List<String> warehouseNames = new ArrayList<>();
		for(StorageWarehouse item : wareHouse)
			warehouseNames.add(item.getWarehouseShort());
		model.addAttribute("rotatePlan", rotatePlan);
		model.addAttribute("isEdit", false);
		model.addAttribute("types", types);
		model.addAttribute("oilcanTypes", oilcanTypes);
		model.addAttribute("status", status);
		model.addAttribute("grainTypes", grainTypes);
		model.addAttribute("quotas", quotas);
		model.addAttribute("grainLevel", grainLevel);
		model.addAttribute("oilLevel", oilLevel);
		model.addAttribute("warehouses", warehouseNames);
		return "RotatePlan/rotateplan_adddeclare";
	}

	/**
	 * 轮换计划新增
	 * @param rotatePlanmain
	 * @param detailList
	 * @param isedit
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/declareSaveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Object  declareSaveOrUpdate(RotatePlanmain rotatePlanmain,
								@RequestParam(value="detailList") String detailList,
								@RequestParam(value="isedit") Boolean isedit, HttpServletRequest request) throws IOException {
		SysUser user = TokenManager.getToken();
		ActionResultModel actionResultModel = new ActionResultModel();
		if(null == isedit || !isedit) {
			String planName = rotatePlanmain.getPlanName();
			boolean isPrimary = rotatePlanmainService.checkPrimary(planName);
			if(!isPrimary) {
				actionResultModel.setSuccess(false);
				actionResultModel.setMsg("名称为:'"+planName+"'的年度计划已存在!");
				return actionResultModel;
			}
		}
		ObjectMapper mapper = new ObjectMapper();
		List<RotatePlanmainDetail> plan_Detail = mapper.readValue(detailList,TypeFactory.defaultInstance().constructCollectionType(List.class,RotatePlanmainDetail.class));


		rotatePlanmain.setPlanmainDetail(plan_Detail);

		if(null == isedit || !isedit) {
			sysLogService.add(request, "轮换业务-计划申报-新增");
			rotatePlanmain.setColletor(user.getName());
			rotatePlanmainService.save(rotatePlanmain);
		}else{
			rotatePlanmain.setColletor(user.getName());
			sysLogService.add(request, "轮换业务-计划申报-修改");
			rotatePlanmainService.update(rotatePlanmain);
		}
		//OA
//		if(rotatePlanmain.getState() != null && rotatePlanmain.getState().contains("OA")) {
//			String fileCode = exprotAnyExcelPlan(rotatePlanmain.getId());
//			sysOAService.LaunchedAudit(
//					rotatePlanmain.getId(),
//					TokenManager.getToken().getId(),
//					rotatePlanmain.getPlanName(),
//					String.format("http://%s:%s%s/", request.getServerName(),request.getServerPort(),request.getContextPath()) + "files/code/" + fileCode,
//					new SysProcessMapper("T_ROTATE_PLAN", "STATE", "审核通过:"));
//		}

		actionResultModel.setSuccess(true);

		return actionResultModel;
	}

	/**
	 *
	 * @param id
	 * @return
	 */
	public String exprotAnyExcelPlan(String id) {
		SysUser user = TokenManager.getToken();
		String fileCode = null;

		RotatePlanmain planmain = rotatePlanmainService.getPlan(id);
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
			HttpGet get = new HttpGet(host + String.format("rotatePlan/exportExcelPlan.shtml?%s", param.toString()));
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

	/**
	 *  轮换计划列表点击显示详细轮入、轮出信息
	 * @param model
	 * @param sid
	 * @param rotatetype
	 * @return String
	 */
	@RequestMapping(value="detailview",params="sid")
	public String RotatePlanmainDetail(Model model,@RequestParam("sid") String sid
			,@RequestParam("rotatetype") String rotatetype) {
		HashMap<String, String> map = new HashMap<>();
		map.put("planId", sid);
		map.put("rotateType", rotatetype);
		RotatePlanmain rotatePlanmain = rotatePlanmainService.getPlan(sid);
		List<RotatePlanmainDetail> details = rotatePlanmainService.listDetailByCondition(map);
		/*//对数据进行权限上的控制
		List<String> baseNames = new ArrayList<>();
		if(type!=null && type.toLowerCase().equals("proviceunit")) {
			//可查看所有数据 所以不需要对数据做过滤操作

		}else if(type != null && type.toLowerCase().equals("base")) {
			SysUser user = TokenManager.getToken();
			String baseName = user.getShortName(); //获取到用户的库点信息
			baseNames.add(baseName);
			for(StorageWarehouse base : storageWarehouseService.listSuperviseOfWarehouse(baseName))
				baseNames.add(base.getWarehouseShort());

		}*/
		for(int i=0;i<details.size();i++) {
			/*if(null!=baseNames&&baseNames.size()>0&&!baseNames.contains(details.get(i).getLibraryName())) {
				details.remove(i--);
				continue;
			}*/
			/*QualityQuota qualityQuota=quotaService.getByID(details.get(i).getQualityId());
			details.get(i).setQualityQuota(qualityQuota);
			List<QualityQuotaItem> quotaItems = quotaItemService.getByID(details.get(i).getQualityId());
			HashMap<String, String> quotaItemMap = new HashMap<>();
			for(QualityQuotaItem quotaItem:quotaItems) {
				quotaItemMap.put(quotaItem.getItemName(), quotaItem.getStandard());
				details.get(i).setQuotaItemMap(quotaItemMap);
			}*/
			if(StringUtils.isNotEmpty(details.get(i).getQualityId())) {
				SysDict sysDict = sysDictService.selectById(details.get(i).getQualityId());
				if (null != sysDict) {
					details.get(i).setGrade(sysDict.getValue());
				}
			}
		}
		model.addAttribute("rotateType", rotatetype);
		model.addAttribute("rotatePlanmainDetail", details);
		return "RotatePlan/rotateplanmaindetail_view";
	}

	/**
	 * 进入轮换计划修改页面
	 * @param model
	 * @param sid
	 * @return
	 */
	@RequestMapping(value="/editRotatePlanmain",params="sid")
	public String EditRotatePlanmain(Model model,@RequestParam("sid") String sid) {
		//仓房类型
		List<SysDict> types = sysDictService.getSysDictListByType("仓房类型");
		//仓房状态
		List<SysDict> status = sysDictService.getSysDictListByType("仓房状态");
		//油罐类型
		List<SysDict> oilcanTypes = sysDictService.getSysDictListByType("油罐类型");
		//粮油品种
		List<SysDict> grainType = sysDictService.getSysDictListByType("粮油品种");
		List<String>  grainTypes = new ArrayList<String>();
		for(int i = 0 ;i<grainType.size();i++){
			grainTypes.add(grainType.get(i).getValue());
		}
		//粮油等级
		List<SysDict> grainQuantity= sysDictService.getSysDictListByType("粮油等级");
		List<SysDict> grainLevel = new ArrayList<SysDict>();
		List<SysDict> oilLevel = new ArrayList<SysDict>();
		for(int i = 0;i<grainQuantity.size();i++){
			if(grainQuantity.get(i).getValue().contains("等")){
				grainLevel.add(grainQuantity.get(i));
			}else{
				oilLevel.add(grainQuantity.get(i));
			}
		}
		List<QualityQuota> quotas=quotaService.listQualityQuota();
		//库点、代储点
		List<StorageWarehouse> wareHouse = storageWarehouseService.limitList();
		List<String> warehouseNames = new ArrayList<>();
		for(StorageWarehouse item : wareHouse)
			warehouseNames.add(item.getWarehouseShort());
		RotatePlanmain rotatePlanmain = rotatePlanmainService.getPlan(sid);
		System.err.println(">>>"+ JSON.toJSONString(rotatePlanmain.getPlanmainDetail()));
		model.addAttribute("types", types);
		model.addAttribute("oilcanTypes", oilcanTypes);
		model.addAttribute("status", status);
		model.addAttribute("grainTypes", grainTypes);
		model.addAttribute("quotas", quotas);
		model.addAttribute("grainLevel", grainLevel);
		model.addAttribute("oilLevel", oilLevel);
		model.addAttribute("warehouses", warehouseNames);
		model.addAttribute("rotatePlan", rotatePlanmain);
		model.addAttribute("detailList", JSON.toJSONString(rotatePlanmain.getPlanmainDetail()));
		SysFile sysFile = fileService.selectById(rotatePlanmain.getAttachment());
		model.addAttribute("myFile", sysFile);
		model.addAttribute("isEdit", true);
		if(sysFile!=null){
			String downloadUrl = sysFile.getDownloadUrl();
			String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
			model.addAttribute("suffix", suffix);
		}
		return "RotatePlan/rotateplan_adddeclare";
	}

	/**
	 * excel导出
	 * @param request
	 * @param response
	 * @param id
	 * @throws IOException
	 */
	@SysLogAn("轮换业务-计划申报-导出")
	@RequestMapping(value="/exportExcelPlan")
	@ResponseBody
	public void ExportExcelPlan(HttpServletRequest request, HttpServletResponse response,
							@RequestParam(value="id")String id,
							@RequestParam(value="type",required=false) String type) throws IOException {
		List<RotatePlanmain> list = new ArrayList<>();
		RotatePlanmain rotatePlanmain = rotatePlanmainService.getPlan(id);
		List<RotatePlanmainDetail> details = rotatePlanmainService.listDetail(id);
		String reportMonth;
		if(details.size() > 0) {
			reportMonth = String.valueOf(Integer.parseInt(rotatePlanmain.getYear())-1)+"-12";
		}
		else
			return;

		List<RotatePlanmainDetailForExcel> detailForExcels = new ArrayList<>();
		//对数据进行权限上的控制
		/*List<String> baseNames = new ArrayList<>();
		if(type!=null && type.toLowerCase().equals("proviceunit")) {
			//可查看所有数据 所以不需要对数据做过滤操作

		}else if(type != null && type.toLowerCase().equals("base")) {
			SysUser user = TokenManager.getToken();
			String baseName = user.getShortName();  //获取到用户的库点信息
			baseNames.add(baseName);
			for(StorageWarehouse base : storageWarehouseService.listSuperviseOfWarehouse(baseName))
				baseNames.add(base.getWarehouseShort());

		}*/
		for(int i=0;i<details.size();i++) {
			List<QualityQuotaItem> quotaItems = quotaItemService.getByID(details.get(i).getQualityId());
			//QualityQuota qualityQuota = new QualityQuota();
			SysDict sysDict = new SysDict();
			String grade = "";
			if(details.get(i).getQualityId()!=null&&!details.get(i).getQualityId().equals("")){
				//qualityQuota=quotaService.getByID(details.get(i).getQualityId());
				sysDict = sysDictService.selectById(details.get(i).getQualityId());
				grade = sysDict.getValue();
			}
			detailForExcels.add(new RotatePlanmainDetailForExcel(details.get(i),quotaItems,grade));
		}
		rotatePlanmain.setPlanDetailForExcels(detailForExcels);
		list.add(rotatePlanmain);
		String title = rotatePlanmain.getPlanName();

		response.setHeader("content-Type", "application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;filename=" +  java.net.URLEncoder.encode(title,"UTF-8") + ".xls");
		response.setCharacterEncoding("UTF-8");
		Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams(title, title),
				RotatePlanmain.class, list);

		workbook.write(response.getOutputStream());
	}

	/**
	 * 更新轮换计划OA流程状态
	 * @param id
	 * @param state
	 * @return
	 */
	@RequestMapping(value="/updateOAState",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel updateOAState(HttpServletRequest request,
										 @RequestParam(value="id")String id,
										 @RequestParam(value="state")String state) {
		rotatePlanmainService.updateState(id, state);
		sysLogService.add(request, "轮换业务-计划申报-" + state);
		if(state.contains("OA")) {
			RotatePlanmain planmain = rotatePlanmainService.getPlan(id);
			String fileCode = exprotAnyExcelPlan(id);
			sysOAService.LaunchedAudit(
					id,
					TokenManager.getToken().getId(),
					planmain.getPlanName(),
					String.format("http://%s:%s%s/", request.getServerName(),request.getServerPort(),request.getContextPath()) + "files/code/" + fileCode,
					new SysProcessMapper("T_ROTATE_PLAN", "STATE", "审核通过:"));
		}
		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}

	/**
	 * 轮换计划清单查看
	 * @param model
	 * @param sid
	 * @param type
	 * @return
	 */
	@RequestMapping(value="/detailview2",params="sid")
	public String RotatePlanmainDetail2(Model model,@RequestParam("sid") String sid,
									@RequestParam("type") String type) {
		HashMap<String, String> map = new HashMap<>();
		map.put("planId", sid);
		RotatePlanmain rotatePlanmain = rotatePlanmainService.getPlan(sid);
		List<RotatePlanmainDetail> details = rotatePlanmainService.listDetailByCondition(map);

		/*//对数据进行权限上的控制
		List<String> baseNames = new ArrayList<>();
		if(type!=null && type.toLowerCase().equals("proviceunit")) {
			//可查看所有数据 所以不需要对数据做过滤操作

		}else if(type != null && type.toLowerCase().equals("base")) {
			SysUser user = TokenManager.getToken();
			String baseName = user.getShortName();//获取到用户的库点信息
			baseNames.add(baseName);
			for(StorageWarehouse base : storageWarehouseService.listSuperviseOfWarehouse(baseName))
				baseNames.add(base.getWarehouseShort());

		}*/
		for(int i=0;i<details.size();i++) {
			/*QualityQuota qualityQuota=quotaService.getByID(details.get(i).getQualityId());
			details.get(i).setQualityQuota(qualityQuota);
			List<QualityQuotaItem> quotaItems = quotaItemService.getByID(details.get(i).getQualityId());
			HashMap<String, String> quotaItemMap = new HashMap<>();
			for(QualityQuotaItem quotaItem:quotaItems) {
				quotaItemMap.put(quotaItem.getItemName(), quotaItem.getStandard());
				details.get(i).setQuotaItemMap(quotaItemMap);
			}*/
			if(StringUtils.isNotEmpty(details.get(i).getQualityId())) {
				SysDict sysDict = sysDictService.selectById(details.get(i).getQualityId());
				if (null != sysDict) {
					details.get(i).setGrade(sysDict.getValue());
				}
			}
		}
		rotatePlanmain.setPlanmainDetail(details);
		model.addAttribute("type", type);
		model.addAttribute("rotatePlan", rotatePlanmain);
		SysFile sysFile = fileService.selectById(rotatePlanmain.getAttachment());
		model.addAttribute("myFile", sysFile);
		model.addAttribute("isEdit", true);
		if(sysFile!=null){
			String downloadUrl = sysFile.getDownloadUrl();
			String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
			model.addAttribute("suffix", suffix);
		}
		return "RotatePlan/rotateplanmaindetail_view2";
	}

	/**
	 * 查询"审核通过"轮换计划列表
	 * @param pageIndex
	 * @param pageSize
	 * @param planName1
	 * @param year1
	 * @param colletor1
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value="/declareCompletelist")
	@ResponseBody
	public LayPage<RotatePlanmain> declareCompletelist(
			@RequestParam(value="pageIndex") int pageIndex,
			@RequestParam(value="pageSize") int pageSize,
			@RequestParam(value="planName1",required=false) String planName1,
			@RequestParam(value="planyear1",required=false) String year1,
			@RequestParam(value="colletor1",required=false) String colletor1) throws UnsupportedEncodingException {

		HashMap<String, Object> map=new HashMap<>();
		map.put("pageIndex", String.valueOf(pageIndex));
		map.put("pageSize", String.valueOf(pageSize));
		map.put("planName", planName1);
		map.put("colletor", colletor1);
		map.put("year", year1);
		int total =rotatePlanmainService.tablecount(map);
		List<RotatePlanmain> list=null;
		if(total>0)
			list = rotatePlanmainService.tablelist(map);
		LayPage<RotatePlanmain> pageUtil=new LayPage<>(list, total);
		return pageUtil;
	}

	/**
	 * 通过计划ID查询轮换计划明细
	 * @param model
	 * @param sid
	 * @return
	 */
	@RequestMapping(value="/plandetail",params="sid")
	@ResponseBody
	public LayPage<RotatePlanmainDetail> RotatePlanmainDetailById(Model model,
										   @RequestParam(value="pageIndex") int pageIndex,
										   @RequestParam(value="pageSize") int pageSize,
										   @RequestParam("sid") String sid,
										  HttpServletRequest request) {
		String excludeInIds = request.getParameter("excludeInIds");
		HashMap<String, String> map=new HashMap<>();
		map.put("excludeInIds",excludeInIds);
		map.put("planId", sid);
		map.put("rotateType", "轮入");
		map.put("pageIndex", String.valueOf(pageIndex));
		map.put("pageSize", String.valueOf(pageSize));
		int total =rotatePlanmainService.detailcount(map);
		List<RotatePlanmainDetail> list=null;
		if(total>0)
			list = rotatePlanmainService.listDetailByCondition(map);
		LayPage<RotatePlanmainDetail> pageUtil=new LayPage<>(list, total);

		return pageUtil;
	}

	@RequestMapping("/deleteFile")
	@ResponseBody
	public Map<String,Object> deleteFile(@RequestParam("id") String id,@RequestParam("sid") String sid){
		Map<String, Object> result = new HashMap<>();
		try {
			SysFile sf = sysFileService.getByID(id);    // 根据文件ID 查询文件相关信息
			File file = new File(sf.getPhysicalPath());
			if (file.isFile() && file.exists()) {
				if (file.delete()) {    // 进行文件删除操作
					RotatePlanmain rotatePlanmain = new RotatePlanmain(sid);
//					RotatePlanmain rotatePlanmain = rotatePlanmainService.getPlan(sid);
					rotatePlanmain.setAttachment("");
					if (sysFileService.delete(id) > 0 && rotatePlanmainService.updateAttachment(rotatePlanmain) > 0) {
						result.put("success", true);
					} else {
						result.put("success", false);
					}

				} else {
					result.put("success", false);
				}
			} else {
				result.put("success", false);
			}
		}catch (Exception e){
			e.printStackTrace();
			result.put("success",false);
		}
		return result;
	}

	@RequestMapping(value="/getPlanname",method=RequestMethod.POST)
	@ResponseBody
	public List<RotatePlan> getPlanname () {
		List<RotatePlan> list = service.getPlanname();
		return list;
	}
}
