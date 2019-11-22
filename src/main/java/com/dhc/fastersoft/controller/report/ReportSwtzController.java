package com.dhc.fastersoft.controller.report;

import cn.afterturn.easypoi.excel.ExcelImportUtil;
import cn.afterturn.easypoi.excel.entity.ImportParams;
import com.alibaba.fastjson.JSON;
import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.Constant;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dto.ReportMonthSwtzDTO;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.enumdata.ReportNameEnum;
import com.dhc.fastersoft.entity.enumdata.ReportStatusEnum;
import com.dhc.fastersoft.entity.report.ReportMonth;
import com.dhc.fastersoft.entity.report.ReportSwtz;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.ReportMonthService;
import com.dhc.fastersoft.service.ReportSwtzService;
import com.dhc.fastersoft.service.StorageStoreHouseService;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysUserService;
import net.sf.json.JSONArray;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.util.*;

 @RequestMapping("/reportSwtz")
@Controller
public class ReportSwtzController {

	@Autowired
	private ReportSwtzService service;
	@Autowired
	private ReportMonthService monthService;
	@Autowired
	private SysDictService sysDictService;
	@Autowired
	private SysUserService userService;
	@Autowired
	private SysDictService sysService;
	@Autowired
	private StorageWarehouseService storageWarehouseService;

	@Autowired
	private StorageStoreHouseService storageStoreHouseService;
	
	/**
	 * 实物台账填报
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("fillSwtz")
	public String fillSwtz(ModelMap modelMap, String reportMonth) {
		SysUser user = TokenManager.getToken();
		//无法根据某个字段判断是否为代储用户 根据流程 代储用户需自行创建账户 即根据Note判断
		List<StorageWarehouse> list;
		if (user.getNote() != null) {
			list = storageWarehouseService.listWareHouseByType(user.getCompany());
			if(list != null && list.size() > 0){
				modelMap.put("extendsWarehouse", list);
				modelMap.put("extendsWarehouseJson",JSONArray.fromObject(list));
			}else{
				modelMap.put("extendsWarehouse", Collections.emptyList());
				modelMap.put("extendsWarehouseJson","");
			}
		} else {
			// 所有代储点+当前登录人所在库点+舟山库
			HashMap<String,Object> param = new HashMap();
			param.put("warehouseType", "代储库");
			list = storageWarehouseService.listValidWarehouse(param);	// 所有代储点
			list.add(0, new StorageWarehouse(user.getWareHouseId(),user.getCompany(),user.getShortName()));	// 当前登录人所在库点
			if(!StringUtils.equals(user.getOriginCode().toUpperCase(),"ZSK")){
				list.add(1,storageWarehouseService.findConnectorByShortName("舟山库"));
			}

			modelMap.put("extendsWarehouse", list);
			modelMap.put("extendsWarehouseJson",JSONArray.fromObject(list));
		}
		
		String status = "未保存";
		String reportWarehouseId = user.getWareHouseId();;
		if(StringUtils.isNotEmpty(reportMonth) && StringUtils.isNotEmpty(reportWarehouseId)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportName(ReportNameEnum.SWTZ.getValue());
			param.setReportWarehouseId(reportWarehouseId);
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				List<ReportSwtz> swtzList = service.listSwtzByReportId(report.getId());
				status = report.getReportStatus();
				modelMap.put("reportId", report.getId());
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("swtzList", swtzList);
				modelMap.put("reportMain", report);
				modelMap.put("manager", report.getManager());
				modelMap.put("reserveProperty", report.getReserveProperty());
			}
		}
		List<String> warehouse = new ArrayList<>();
		for (StorageWarehouse item : list)//list --> storageWarehouseService.limitList()
			warehouse.add(item.getWarehouseShort());
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		modelMap.addAttribute("grainTypes", JSONArray.fromObject(grainTypes));
//		modelMap.put("reportWarehouse", reportWarehouse);
		modelMap.put("status", status);
		List<SysDict> validTypes=sysService.getSysDictListByType("质检类型");
		modelMap.addAttribute("basepoint",warehouse);
		modelMap.addAttribute("validTypes",validTypes);
		modelMap.addAttribute("currentPoint",TokenManager.getToken().getShortName());

		// 获取仓罐列表信息
		Map<String,Object> storeAndOrilMap = service.getStoreAndOilMap();
		modelMap.addAttribute("storeAndOrilMap",storeAndOrilMap);

		return "report/monthReport/fill_swtz";
	}

	/**
	 * 保存储备粮油
	 *
	 * @param jsonlist
	 * @return
	 */
	@SysLogAn("报表台账-报表管理-填报-保存")
	@RequestMapping("/saveSwtz")
	@ResponseBody
	public ActionResultModel saveSwtz(String reportId, String reportMonth, String jsonlist, String manager, String reserveProperty) {
		ActionResultModel actionResultModel = new ActionResultModel();
		SysUser user = TokenManager.getToken();
		String reportWarehouse = user.getShortName();

		if (StringUtils.isEmpty(user.getOriginCode()) || Constant.HOME_WAREHOUSE.equals(reportWarehouse)) {
			actionResultModel.setSuccess(false);
			actionResultModel.setMsg("您没有该权限！！");
		}else{
			List<ReportSwtz> swtzList = JSON.parseArray(jsonlist, ReportSwtz.class);
			Set<String> distinctSet = new HashSet();//用来过滤是否存在重复的库点和[仓房||油罐]
			for (ReportSwtz swtz : swtzList) {
			    String formatStr = swtz.getExtendsWarehouseId() + "##" + swtz.getStorehouse();
			    if(distinctSet.contains(formatStr)){
                    actionResultModel.setSuccess(false);
                    actionResultModel.setMsg("储存库点与仓号不能存在相同填报记录");
                    return actionResultModel;
                }
                distinctSet.add(formatStr);
            }

			reportId = service.addSwtz(reportId, reportMonth, swtzList, manager, reserveProperty);
			actionResultModel.setSuccess(true);
			actionResultModel.setMsg(reportId);
		}

		return actionResultModel;
	}

	@SysLogAn("报表台账-报表管理-导出")
	@RequestMapping("/exportSwtz")
	public String exportSwtz(HttpServletRequest request, HttpServletResponse response, String title) {
		String reportId = request.getParameter("reportId").toString();
		String fileName = ReportNameEnum.SWTZ.getValue() + ".xls";
		if (StringUtils.isNotEmpty(title)){
			fileName = title + ".xls";
		}
		try {
			fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		ReportMonth reportMain = monthService.getReportMonthById(reportId);
		SysUser userInfo = monthService.getUserInfoByAccount(reportMain.getCreator());
		request.setAttribute("userInfo", userInfo);
		List<ReportSwtz> swtzList = service.listSwtzByReportId(reportId);
		response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
		/*response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		response.setHeader("Content-Disposition", "inline; filename="
				+ fileName);*/

		request.setAttribute("swtzList", swtzList);
		request.setAttribute("reportMain", reportMain);
		return "report/monthReport/export_swtz";
	}
	@SysLogAn("报表台账-报表管理-导出")
	@RequestMapping("/exportSwtzSum1")
	public String exportSwtzSum1(HttpServletRequest request, HttpServletResponse response) {
		String reportMonth = request.getParameter("reportMonth");
		String reportWarehouse = Constant.HOME_WAREHOUSE;
		String reportId = "";
		String status = "";
		if(StringUtils.isNotEmpty(reportMonth)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			if (request.getParameter("state").equals("HZTG")) {
				status = ReportStatusEnum.HZTG.getValue();//"汇总通过"
				//status = ReportStatusEnum.SBTG.getValue();
				param.setReportStatus(ReportStatusEnum.HZTG.getValue());//已审
			} else {
				status=ReportStatusEnum.HZDS.getValue();//"汇总待审"
				param.setReportStatus(ReportStatusEnum.HZDS.getValue());//待审
			}
			param.setReportName(ReportNameEnum.SWTZ.getValue());
			param.setReportWarehouse(reportWarehouse);
			ReportMonth report = monthService.getReport(param);
			if (report == null) {
				//暂无数据
				return "report/monthReport/export_swtz_sum3";
			} else {
				reportId = report.getId();
			}
		}

		List<ReportSwtz> swtzList = service.listSumSwtz(reportId);

		Map<String,Map<String,Double>> dataList = new LinkedHashMap<>();
		Map<String,List<String>> fields = new HashMap();
		Map<String,Double> sumData = new HashMap();
		fields.put("早籼",new ArrayList<String>());
		fields.put("粳稻谷",new ArrayList<String>());
		fields.put("稻谷",new ArrayList<String>());
		fields.put("小麦",new ArrayList<String>());
		fields.put("玉米",new ArrayList<String>());
		fields.put("粮食",new ArrayList<String>(1));
		fields.put("油类",new ArrayList<String>());


		//遍历出所有类型和单位
		for(ReportSwtz item : swtzList) {
			String year = item.getHarvestYear();
			String type = item.getVariety();
			String enterpriseName = item.getEnterpriseShortName();

			String field = "";
			if(year == null || year.trim().length() < 4){
				continue;
			}

			field= String.format("%s%s", year.trim().substring(2),type);

			if(Arrays.asList(new String[] {"晚籼稻谷","早籼稻谷"}).contains(type)) {
				if(!fields.get("早籼").contains(field))
					fields.get("早籼").add(field);
			}else if(Arrays.asList(new String[] {"粳稻谷"}).contains(type)) {
				if(!fields.get("粳稻谷").contains(field))
					fields.get("粳稻谷").add(field);
			}else if(Arrays.asList(new String[] {"晚籼稻谷","早籼稻谷","粳稻谷"}).contains(type)) {
				if(!fields.get("稻谷").contains(field))
					fields.get("稻谷").add(field);
			}else if(Arrays.asList(new String[] {"小麦"}).contains(type)) {
				if(!fields.get("小麦").contains(field))
					fields.get("小麦").add(field);
			}else if(Arrays.asList(new String[] {"玉米"}).contains(type)) {
				if(!fields.get("玉米").contains(field))
					fields.get("玉米").add(field);
			}else if(Arrays.asList(new String[] {"葵花油","菜籽油","其他油","花生油","大豆油"}).contains(type)) {
				if(!fields.get("油类").contains(field))
					fields.get("油类").add(field);
			}

			if(dataList.get(enterpriseName) == null){
				dataList.put(enterpriseName,new HashMap<String, Double>());
			}
		}

		for(String key : fields.keySet()) {
			Collections.sort(fields.get(key), new Comparator<String>() {
				@Override
				public int compare(String o1, String o2) {
					o1 = o1.substring(0, 2);
					o2 = o2.substring(0, 2);
					if(Integer.valueOf(o1) >= Integer.valueOf(o2))
						return 1;
					else
						return -1;
				}
			});
		}

		fields.get("早籼").add("早籼合计");
		fields.get("粳稻谷").add("粳稻谷合计");
		fields.get("稻谷").add("稻谷合计");
		fields.get("小麦").add("小麦合计");
		fields.get("玉米").add("玉米合计");
		fields.get("油类").add("油类合计");
		fields.get("粮食").add("粮食合计");


		//构建表格架构
		for(String key : dataList.keySet()) {
			for(String type : fields.keySet()) {
				for(String field : fields.get(type))
					dataList.get(key).put(field, 0D);
			}
		}

		for(String type : fields.keySet()) {
			for(String field : fields.get(type))
				sumData.put(field, 0D);
		}

		//注入值
		for(ReportSwtz item : swtzList) {
			String year = item.getHarvestYear();
			String type = item.getVariety();
			String enterpriseName = item.getEnterpriseShortName();

			String field ="";
			if(year == null || year.trim().length() < 4){
				continue;
			}

			field= String.format("%s%s", year.trim().substring(2),type);


			Map<String,Double> rowMap = dataList.get(enterpriseName);
			if(rowMap.containsKey(field)) {
				rowMap.put(field, rowMap.get(field) + Double.valueOf(item.getQuantity().toString()));

				if(Arrays.asList(new String[] {"早籼稻谷"}).contains(type)) {
					rowMap.put("早籼合计", rowMap.get("早籼合计") + Double.valueOf(item.getQuantity().toString()));
					sumData.put("早籼合计", sumData.get("早籼合计") + Double.valueOf(item.getQuantity().toString()));
					rowMap.put("粮食合计", rowMap.get("粮食合计") + Double.valueOf(item.getQuantity().toString()));
					sumData.put("粮食合计", sumData.get("粮食合计") + Double.valueOf(item.getQuantity().toString()));
				}else if(Arrays.asList(new String[] {"粳稻谷"}).contains(type)) {
					rowMap.put("粳稻谷合计",rowMap.get("粳稻谷合计") + Double.valueOf(item.getQuantity().toString()));
					sumData.put("粳稻谷合计", sumData.get("粳稻谷合计") + Double.valueOf(item.getQuantity().toString()));
					rowMap.put("粮食合计", rowMap.get("粮食合计") + Double.valueOf(item.getQuantity().toString()));
					sumData.put("粮食合计", sumData.get("粮食合计") + Double.valueOf(item.getQuantity().toString()));
				}else if(Arrays.asList(new String[] {"晚籼稻谷","早籼稻谷","粳稻谷"}).contains(type)) {
					rowMap.put("稻谷合计",rowMap.get("稻谷合计") + Double.valueOf(item.getQuantity().toString()));
					sumData.put("稻谷合计", sumData.get("稻谷合计") + Double.valueOf(item.getQuantity().toString()));
					rowMap.put("粮食合计", rowMap.get("粮食合计") + Double.valueOf(item.getQuantity().toString()));
					sumData.put("粮食合计", sumData.get("粮食合计") + Double.valueOf(item.getQuantity().toString()));
				}else if(Arrays.asList(new String[] {"小麦"}).contains(type)) {
					rowMap.put("小麦合计",rowMap.get("小麦合计") + Double.valueOf(item.getQuantity().toString()));
					sumData.put("小麦合计", sumData.get("小麦合计") + Double.valueOf(item.getQuantity().toString()));
					rowMap.put("粮食合计", rowMap.get("粮食合计") + Double.valueOf(item.getQuantity().toString()));
					sumData.put("粮食合计", sumData.get("粮食合计") + Double.valueOf(item.getQuantity().toString()));
				}else if(Arrays.asList(new String[] {"玉米"}).contains(type)) {
					rowMap.put("玉米合计",rowMap.get("玉米合计") + Double.valueOf(item.getQuantity().toString()));
					sumData.put("玉米合计", sumData.get("玉米合计") + Double.valueOf(item.getQuantity().toString()));
					rowMap.put("粮食合计", rowMap.get("粮食合计") + Double.valueOf(item.getQuantity().toString()));
					sumData.put("粮食合计", sumData.get("粮食合计") + Double.valueOf(item.getQuantity().toString()));
				}else if(Arrays.asList(new String[] {"葵花油","菜籽油","其他油","花生油","大豆油"}).contains(type)) {
					rowMap.put("油类合计",rowMap.get("油类合计") + Double.valueOf(item.getQuantity().toString()));
					sumData.put("油类合计", sumData.get("油类合计") + Double.valueOf(item.getQuantity().toString()));
				}

				sumData.put(field, sumData.get(field) + Double.valueOf(item.getQuantity().toString()));
			}
		}

		for(ReportSwtz item : swtzList) {
			String year = item.getHarvestYear();
			String type = item.getVariety();
			String enterpriseName = item.getEnterpriseShortName();
			String field ="";
			if(year == null || year.trim().length() < 4){
				continue;
			}

			field= String.format("%s%s", year.trim().substring(2),type);
			if(dataList.get(enterpriseName).containsKey(field)) {
				dataList.get(enterpriseName).put("稻谷合计",dataList.get(enterpriseName).get("早籼合计") +dataList.get(enterpriseName).get("粳稻谷合计"));
				sumData.put("稻谷合计", Double.valueOf(sumData.get("粳稻谷合计")) + Double.valueOf(sumData.get("早籼合计")));

			}
		}

		ReportMonth reportMain = monthService.getReportMonthById(reportId);
		SysUser userInfo = monthService.getUserInfoByAccount(reportMain.getCreator());
		request.setAttribute("userInfo", userInfo);
//		response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
		request.setAttribute("swtzList", swtzList);
		request.setAttribute("reportMonth", reportMonth);
		request.setAttribute("reportMain", reportMain);
		request.setAttribute("dataList", dataList);
		request.setAttribute("sumData", sumData);
		request.setAttribute("fields", fields);
		request.setAttribute("reportId", reportId);
		request.setAttribute("status", status);

		return "report/monthReport/export_swtz_sum3";
	}

	@SysLogAn("报表台账-报表管理-导出")
	@RequestMapping("/exportSwtzSum")
	public String exportSwtzSum(HttpServletRequest request, HttpServletResponse response, String title) {
		String reportMonth = request.getParameter("reportMonth");
		String reportId = request.getParameter("reportId");
		String fileName = ReportNameEnum.SWTZ.getValue() + ".xls";
		if (StringUtils.isNotEmpty(title)){
			fileName = title + ".xls";
		}

		try {
			fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		List<ReportSwtz> swtzList = service.listSumSwtz(reportId);

		Map<String,Map<String,Double>> dataList = new LinkedHashMap<>();
		Map<String,List<String>> fields = new HashMap();
		Map<String,Double> sumData = new HashMap();
		fields.put("早籼",new ArrayList());
		fields.put("粳稻谷",new ArrayList());
		fields.put("稻谷",new ArrayList());
		fields.put("小麦",new ArrayList());
		fields.put("玉米",new ArrayList());
		fields.put("粮食",new ArrayList<String>(1));
		fields.put("油类",new ArrayList());


		//遍历出所有类型和单位
		for(ReportSwtz item : swtzList) {
			String year = item.getHarvestYear();
			String type = item.getVariety();
			String enterpriseName = item.getEnterpriseShortName();
			//String warehouse = item.getExtendsWarehouse() == null?item.getReportWarehouse():item.getExtendsWarehouse();


			String field ="";
			if(year == null || year.trim().length() < 4){
				continue;
			}

			field= String.format("%s%s", year.trim().substring(2),type);

			if(Arrays.asList(new String[] {"晚籼稻谷","早籼稻谷"}).contains(type)) {
				if(!fields.get("早籼").contains(field))
					fields.get("早籼").add(field);
			}else if(Arrays.asList(new String[] {"粳稻谷"}).contains(type)) {
				if(!fields.get("粳稻谷").contains(field))
					fields.get("粳稻谷").add(field);
			}else if(Arrays.asList(new String[] {"晚籼稻谷","早籼稻谷","粳稻谷"}).contains(type)) {
				if(!fields.get("稻谷").contains(field))
					fields.get("稻谷").add(field);
			}else if(Arrays.asList(new String[] {"小麦"}).contains(type)) {
				if(!fields.get("小麦").contains(field))
					fields.get("小麦").add(field);
			}else if(Arrays.asList(new String[] {"玉米"}).contains(type)) {
				if(!fields.get("玉米").contains(field))
					fields.get("玉米").add(field);
			}else if(Arrays.asList(new String[] {"葵花油","菜籽油","其他油","花生油","大豆油"}).contains(type)) {
				if(!fields.get("油类").contains(field))
					fields.get("油类").add(field);
			}
			if(dataList.containsKey(enterpriseName))
				continue;
			dataList.put(enterpriseName,new HashMap());
		}
		for(String key : fields.keySet()) {
			Collections.sort(fields.get(key), new Comparator<String>() {
				@Override
				public int compare(String o1, String o2) {
					o1 = o1.substring(0, 2);
					o2 = o2.substring(0, 2);
					if(Integer.valueOf(o1) >= Integer.valueOf(o2))
						return 1;
					else
						return -1;
				}
			});
		}
		fields.get("早籼").add("早籼合计");
		fields.get("粳稻谷").add("粳稻谷合计");
		fields.get("稻谷").add("稻谷合计");
		fields.get("小麦").add("小麦合计");
		fields.get("玉米").add("玉米合计");
		fields.get("油类").add("油类合计");
		fields.get("粮食").add("粮食合计");


		//构建表格架构
		for(String key : dataList.keySet()) {
			for(String type : fields.keySet()) {
				for(String field : fields.get(type))
					dataList.get(key).put(field, 0d);
			}
		}
		for(String type : fields.keySet()) {
			for(String field : fields.get(type))
				sumData.put(field, 0d);
		}

		//注入值
		for(ReportSwtz item : swtzList) {
			String year = item.getHarvestYear();
			String type = item.getVariety();
			String enterpriseName = item.getEnterpriseShortName();
			String field ="";
			if(year == null || year.trim().length() < 4){
				continue;
			}

			field= String.format("%s%s", year.trim().substring(2),type);

			Map<String,Double> rowMap = dataList.get(enterpriseName);
			if(rowMap.containsKey(field)) {
				rowMap.put(field, rowMap.get(field) + Double.valueOf(item.getQuantity().toString()));
				if(Arrays.asList(new String[] {"早籼稻谷"}).contains(type)) {
					rowMap.put("早籼合计",rowMap.get("早籼合计") + Double.valueOf(item.getQuantity().toString()));
					sumData.put("早籼合计", sumData.get("早籼合计") + Double.valueOf(item.getQuantity().toString()));
					rowMap.put("粮食合计", rowMap.get("粮食合计") + Double.valueOf(item.getQuantity().toString()));
					sumData.put("粮食合计", sumData.get("粮食合计") + Double.valueOf(item.getQuantity().toString()));
				}else if(Arrays.asList(new String[] {"粳稻谷"}).contains(type)) {
					rowMap.put("粳稻谷合计",rowMap.get("粳稻谷合计") + Double.valueOf(item.getQuantity().toString()));
					sumData.put("粳稻谷合计", sumData.get("粳稻谷合计") + Double.valueOf(item.getQuantity().toString()));
					rowMap.put("粮食合计", rowMap.get("粮食合计") + Double.valueOf(item.getQuantity().toString()));
					sumData.put("粮食合计", sumData.get("粮食合计") + Double.valueOf(item.getQuantity().toString()));
				}else if(Arrays.asList(new String[] {"晚籼稻谷","早籼稻谷","粳稻谷"}).contains(type)) {
					rowMap.put("稻谷合计",rowMap.get("稻谷合计") + Double.valueOf(item.getQuantity().toString()));
					sumData.put("稻谷合计", sumData.get("稻谷合计") + Double.valueOf(item.getQuantity().toString()));
					rowMap.put("粮食合计", rowMap.get("粮食合计") + Double.valueOf(item.getQuantity().toString()));
					sumData.put("粮食合计", sumData.get("粮食合计") + Double.valueOf(item.getQuantity().toString()));
				}else if(Arrays.asList(new String[] {"小麦"}).contains(type)) {
					rowMap.put("小麦合计",rowMap.get("小麦合计") + Double.valueOf(item.getQuantity().toString()));
					sumData.put("小麦合计", sumData.get("小麦合计") + Double.valueOf(item.getQuantity().toString()));
					rowMap.put("粮食合计", rowMap.get("粮食合计") + Double.valueOf(item.getQuantity().toString()));
					sumData.put("粮食合计", sumData.get("粮食合计") + Double.valueOf(item.getQuantity().toString()));
				}else if(Arrays.asList(new String[] {"玉米"}).contains(type)) {
					rowMap.put("玉米合计",rowMap.get("玉米合计") + Double.valueOf(item.getQuantity().toString()));
					sumData.put("玉米合计", sumData.get("玉米合计") + Double.valueOf(item.getQuantity().toString()));
					rowMap.put("粮食合计", rowMap.get("粮食合计") + Double.valueOf(item.getQuantity().toString()));
					sumData.put("粮食合计", sumData.get("粮食合计") + Double.valueOf(item.getQuantity().toString()));
				}else if(Arrays.asList(new String[] {"葵花油","菜籽油","其他油","花生油","大豆油"}).contains(type)) {
					rowMap.put("油类合计",rowMap.get("油类合计") + Double.valueOf(item.getQuantity().toString()));
					sumData.put("油类合计", sumData.get("油类合计") + Double.valueOf(item.getQuantity().toString()));
				}
				sumData.put(field, sumData.get(field) + Double.valueOf(item.getQuantity().toString()));
			}
		}

		for(ReportSwtz item : swtzList) {
			String year = item.getHarvestYear();
			String type = item.getVariety();
			String enterpriseName = item.getEnterpriseShortName();

			String field ="";
			if(year == null || year.trim().length() < 4){
				continue;
			}

			field= String.format("%s%s", year.trim().substring(2),type);

			if(dataList.get(enterpriseName).containsKey(field)) {
				dataList.get(enterpriseName).put("稻谷合计",dataList.get(enterpriseName).get("早籼合计") +dataList.get(enterpriseName).get("粳稻谷合计"));
				sumData.put("稻谷合计", Double.valueOf(sumData.get("粳稻谷合计")) + Double.valueOf(sumData.get("早籼合计")));
			}
		}

		ReportMonth reportMain = monthService.getReportMonthById(reportId);
		SysUser userInfo = monthService.getUserInfoByAccount(reportMain.getCreator());
		request.setAttribute("userInfo", userInfo);
		response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
		request.setAttribute("swtzList", swtzList);
		request.setAttribute("reportMonth", reportMonth);
		request.setAttribute("reportMain", reportMain);
		request.setAttribute("dataList", dataList);
		request.setAttribute("sumData", sumData);
		request.setAttribute("fields", fields);
		request.setAttribute("reportId", reportId);
		return "report/monthReport/export_swtz_sum2";
	}

	/**
	 * 实物台账审核
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("appSwtz")
	public String appSwtz(ModelMap modelMap, String reportMonth) {
		SysUser user = TokenManager.getToken();
		String reportWarehouse = user.getShortName();

		String status = "";
		if(StringUtils.isNotEmpty(reportMonth) && StringUtils.isNotEmpty(reportWarehouse)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportStatus(ReportStatusEnum.DSH.getValue());
			param.setReportName(ReportNameEnum.SWTZ.getValue());
			param.setReportWarehouseId(user.getWareHouseId());
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				List<ReportSwtz> swtzList = service.listSwtzByReportId(report.getId());
				status = report.getReportStatus();
				modelMap.put("reportId", report.getId());
				modelMap.put("swtzList", swtzList);
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("reportMain", report);
			}
		}
		modelMap.put("reportWarehouse", reportWarehouse);
		modelMap.put("status", status);
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		modelMap.addAttribute("grainTypes", JSONArray.fromObject(grainTypes));
		return "report/monthReport/fill_swtz";
	}

	/**
	 * 查询已审核
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("querySwtz")
	public String querySwtz(ModelMap modelMap, String reportMonth) {
		SysUser user = TokenManager.getToken();
		String reportWarehouse = user.getShortName();

		//无法根据某个字段判断是否为代储用户 根据流程 代储用户需自行创建账户 即根据Note判断
		List<StorageWarehouse> list;
		if(user.getNote()!=null) {
			list = storageWarehouseService.listWareHouseByType(user.getCompany());
			modelMap.put("extendsWarehouse", list);
		}else {
			HashMap<String,Object> param = new HashMap();
			param.put("warehouseType", "代储");
			list = storageWarehouseService.listValidWarehouse(param);
			list.add(0, new StorageWarehouse(user.getWareHouseId(),user.getCompany(),user.getShortName()));
			modelMap.put("extendsWarehouse", list);
		}
		
		String status = "";
		if(StringUtils.isNotEmpty(reportMonth) && StringUtils.isNotEmpty(reportWarehouse)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportStatus("YS");//已审
			param.setReportName(ReportNameEnum.SWTZ.getValue());
			param.setReportWarehouseId(user.getWareHouseId());
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				List<ReportSwtz> swtzList = service.listSwtzByReportId(report.getId());
				status = report.getReportStatus();
				modelMap.put("reportId", report.getId());
				modelMap.put("swtzList", swtzList);
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("reportMain", report);
				modelMap.put("manager", report.getManager());
				modelMap.put("reserveProperty", report.getReserveProperty());
			}
		}
		modelMap.put("reportWarehouse", reportWarehouse);
		modelMap.put("status", status);
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		modelMap.addAttribute("grainTypes", JSONArray.fromObject(grainTypes));
		return "report/monthReport/fill_swtz";
	}

	/**
	 * 查询已审核(高级)
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("querySwtzSearch")
	public String querySwtzSearch(ModelMap modelMap, HttpServletRequest request ,String reportWarehouse) {
//		if(StringUtils.isEmpty(reportWarehouse))
//			reportWarehouse = TokenManager.getToken().getShortName();
//		String reportMonth = request.getParameter("reportMonth");
//
//		SysUser user = TokenManager.getToken();
//		//无法根据某个字段判断是否为代储用户 根据流程 代储用户需自行创建账户 即根据Note判断
//		List<StorageWarehouse> list;
//		if(user.getNote()!=null) {
//			list = storageWarehouseService.listWareHouseByType(user.getCompany());
//			modelMap.put("extendsWarehouse", list);
//		}else {
//			HashMap<String,Object> param = new HashMap();
//			param.put("warehouseType", "代储");
//			list = storageWarehouseService.listValidWarehouse(param);
//			list.add(0, new StorageWarehouse(user.getWareHouseId(),user.getCompany(),user.getShortName()));
//			modelMap.put("extendsWarehouse", list);
//		}
//
//		String status = "";
//		if(StringUtils.isNotEmpty(reportMonth) && !StringUtils.isEmpty(reportWarehouse)){
//			ReportMonth param = new ReportMonth();
//			param.setReportMonth(reportMonth);
//			param.setReportStatus("YS");//已审
//			param.setReportName(ReportNameEnum.SWTZ.getValue());
//			param.setReportWarehouseId(reportWarehouse);
//			ReportMonth report = monthService.getReport(param);
//			if (report != null){
//				List<ReportSwtz> swtzList = service.listSwtz(request, reportWarehouse);
//				status = report.getReportStatus();
//				modelMap.put("reportId", report.getId());
//				modelMap.put("swtzList", swtzList);
//				modelMap.put("fillTime", report.getCreateDate());
//				modelMap.put("reportMain", report);
//			}
//		}
//		modelMap.put("reportWarehouse", reportWarehouse);
//
//		modelMap.put("status", status);
//		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
//		modelMap.addAttribute("grainTypes", JSONArray.fromObject(grainTypes));
//		return "report/monthReport/fill_swtz";
		String reportMonth = request.getParameter("reportMonth");
		SysUser user = TokenManager.getToken();
		//无法根据某个字段判断是否为代储用户 根据流程 代储用户需自行创建账户 即根据Note判断
		List<StorageWarehouse> list;
//		if(user.getNote()!=null) {
		list = storageWarehouseService.getAllWarehouseOrderBy();
		modelMap.put("extendsWarehouse", list);
//		}else {
//			HashMap<String,Object> param = new HashMap();
//			param.put("warehouseType", "代储");
//			list = storageWarehouseService.listValidWarehouse(param);
//			list.add(0, new StorageWarehouse(user.getOriginCode(),user.getCompany(),user.getShortName()));
//			modelMap.put("extendsWarehouse", list);
//		}

		String status = "";
		if (StringUtils.isNotEmpty(reportMonth)) {
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportStatus("YS");//已审
			param.setReportName(ReportNameEnum.SWTZ.getValue());
			param.setReportWarehouseId(reportWarehouse);
			ReportMonth report = monthService.getReport(param);
			if (report != null) {
				List<ReportSwtz> swtzList = service.listSwtz(request, reportWarehouse);
				status = report.getReportStatus();
				modelMap.put("reportId", report.getId());
				modelMap.put("swtzList", swtzList);
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("reportMain", report);
				modelMap.put("manager", report.getManager());
				modelMap.put("reserveProperty", report.getReserveProperty());

			}
		}
		modelMap.put("reportWarehouse", reportWarehouse);
		modelMap.put("status", status);
		modelMap.put("reportMonth", reportMonth);
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		modelMap.addAttribute("grainTypes", JSONArray.fromObject(grainTypes));
		return "report/monthReport/fill_swtz";

	}

	/**
	 * 分库查询已审核
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("queryKuSwtz")
	public String queryKuSwtz(ModelMap modelMap, String reportMonth, String reportWarehouseId, String reportWarehouse) {
		SysUser user = TokenManager.getToken();
		//无法根据某个字段判断是否为代储用户 根据流程 代储用户需自行创建账户 即根据Note判断
		List<StorageWarehouse> list;
//		if(user.getNote()!=null) {
			list = storageWarehouseService.getAllWarehouseOrderBy();
			modelMap.put("extendsWarehouse", list);
//		}else {
//			HashMap<String,Object> param = new HashMap();
//			param.put("warehouseType", "代储");
//			list = storageWarehouseService.listValidWarehouse(param);
//			list.add(0, new StorageWarehouse(user.getOriginCode(),user.getCompany(),user.getShortName()));
//			modelMap.put("extendsWarehouse", list);
//		}
		
		String status = "";
		if(StringUtils.isNotEmpty(reportMonth)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportStatus("YS");//已审
			param.setReportName(ReportNameEnum.SWTZ.getValue());
			param.setReportWarehouseId(reportWarehouseId);
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				List<ReportSwtz> swtzList = service.listSwtzByReportId(report.getId());
				status = report.getReportStatus();
				modelMap.put("reportId", report.getId());
				modelMap.put("swtzList", swtzList);
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("reportMain", report);
				modelMap.put("manager", report.getManager());
				modelMap.put("reserveProperty", report.getReserveProperty());

			}
		}
		modelMap.put("reportWarehouse", reportWarehouse);
		modelMap.put("status", status);
		modelMap.put("reportMonth", reportMonth);
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		modelMap.addAttribute("grainTypes", JSONArray.fromObject(grainTypes));
		// 获取仓罐列表信息
		Map<String,Object> storeAndOrilMap = service.getStoreAndOilMap();
		modelMap.addAttribute("storeAndOrilMap",storeAndOrilMap);
		return "report/monthReport/fill_swtz";
	}

	/**
	 * 实物台账审核
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("appKuSwtz")
	public String appKuSwtz(ModelMap modelMap, String reportMonth, String reportWarehouseId) {

		String status = "";
		if(StringUtils.isNotEmpty(reportMonth)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportStatus("DHZ");
			param.setReportName(ReportNameEnum.SWTZ.getValue());
			param.setReportWarehouseId(reportWarehouseId);
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				//查询月报是否已汇总
				param.setReportWarehouse(Constant.HOME_WAREHOUSE);
				param.setReportWarehouseId("0");
				param.setReportStatus(null);
				ReportMonth reportMain = monthService.getReport(param);
				modelMap.put("reportMain", reportMain);
				modelMap.put("manager", report.getManager());
				modelMap.put("reserveProperty", report.getReserveProperty());

//				if(reportMain == null || ReportStatusEnum.HZBH.getValue().equals(reportMain.getReportStatus())) { //未汇总则显示待汇总数据
					List<ReportSwtz> swtzList = service.listSwtzByReportId(report.getId());
					status = report.getReportStatus();
					modelMap.put("reportId", report.getId());
					modelMap.put("swtzList", swtzList);
					modelMap.put("fillTime", report.getCreateDate());
					List<HashMap> list = new ArrayList<>();
					for (int i = 0; i <swtzList.size() ; i++) {

						HashMap map = new HashMap();
						if(swtzList.get(i).getExtendsWarehouse()!=null){
							map.put("warehouseShort",swtzList.get(i).getExtendsWarehouse());
						}else {
							map.put("warehouseShort",swtzList.get(i).getReportWarehouse());
						}

						list.add(map);

					}
					modelMap.put("extendsWarehouse", list);
//				}
			}


		}

		modelMap.put("flag", "1");
//		modelMap.put("reportWarehouse", reportWarehouse);
		modelMap.put("status", status);
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		modelMap.addAttribute("grainTypes", JSONArray.fromObject(grainTypes));

		// 获取仓罐列表信息
		Map<String,Object> storeAndOrilMap = service.getStoreAndOilMap();
		modelMap.addAttribute("storeAndOrilMap",storeAndOrilMap);

		return "report/monthReport/fill_swtz";
	}

	/**
	 * 查询已审核
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("querySumSwtz")
	public String querySumSwtz(ModelMap modelMap, String reportMonth) {
		String reportWarehouse = Constant.HOME_WAREHOUSE;

		String status = "";
		if(StringUtils.isNotEmpty(reportMonth)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportStatus(ReportStatusEnum.HZTG.getValue());//已审
			param.setReportName(ReportNameEnum.SWTZ.getValue());
			param.setReportWarehouse(reportWarehouse);
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				List<ReportSwtz> swtzList = service.listSumSwtz(report.getId());
				status = report.getReportStatus();
				modelMap.put("reportId", report.getId());
				modelMap.put("swtzList", swtzList);
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("reportMain", report);
			}
		}
		modelMap.put("reportWarehouse", reportWarehouse);
		modelMap.put("status", status);
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		modelMap.addAttribute("grainTypes", JSONArray.fromObject(grainTypes));
		return "report/monthReport/fill_swtz_sum";
	}

	/**
	 * 实物台账审核
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("appSumSwtz")
	public String appSumSwtz(ModelMap modelMap, String reportMonth) {
		String reportWarehouse = Constant.HOME_WAREHOUSE;

		String status = "";
		if(StringUtils.isNotEmpty(reportMonth)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportStatus(ReportStatusEnum.HZDS.getValue());
			param.setReportName(ReportNameEnum.SWTZ.getValue());
			param.setReportWarehouse(reportWarehouse);
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				List<ReportSwtz> swtzList = service.listSumSwtz(report.getId());
				status = report.getReportStatus();
				modelMap.put("reportId", report.getId());
				modelMap.put("swtzList", swtzList);
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("reportMain", report);
			}
		}
		modelMap.put("reportWarehouse", reportWarehouse);
		modelMap.put("status", status);
		modelMap.put("reportMonth", reportMonth);
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		modelMap.addAttribute("grainTypes", JSONArray.fromObject(grainTypes));
		return "report/monthReport/fill_swtz_sum";
	}
	
	@RequestMapping(value="/getLastestQuantity",method=RequestMethod.POST)
	@ResponseBody
	public double getLastestQuantity(@RequestParam("reportWarehouse") String reportWarehouse,
			@RequestParam("storehouse") String storehouse,
			@RequestParam("variety") String variety) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("reportWarehouse", reportWarehouse);
		map.put("storehouse", storehouse);
		map.put("variety", variety);
		Double quantity = service.getLastestQuantity(map);
		if(null==quantity)
			return 0;
		return quantity;
	}
	
	@RequestMapping(value="/GetLastMonthData",method=RequestMethod.POST)
	@ResponseBody
	public ReportMonthSwtzDTO GetLastMonthData(@RequestParam("reportMonth")String reportMonth, @RequestParam("reportWarehouseId")String reportWarehouseId) {
		ReportMonthSwtzDTO resDto = new ReportMonthSwtzDTO();
		SysUser user = TokenManager.getToken();

		ReportMonth param = new ReportMonth();
		param.setReportMonth(reportMonth);
		param.setReportName(ReportNameEnum.SWTZ.getValue());
		if(StringUtils.isEmpty(reportWarehouseId)){
			reportWarehouseId = user.getWareHouseId();
		}
		param.setReportWarehouseId(reportWarehouseId);
		ReportMonth report = monthService.getReport(param);
		if (report != null){
			List<ReportSwtz> swtzList = service.listSwtzByReportId(report.getId());
			resDto.setData(swtzList);
			resDto.setManager(report.getManager());
			resDto.setReserveProperty(report.getReserveProperty());
			resDto.setSuccess(true);
		}
		return resDto;
	}


	/**
	 * 保存代储点储备粮油
	 *
	 * @param jsonlist
	 * @return
	 */
	@RequestMapping("/saveProxySwtz")
	@ResponseBody
	public ActionResultModel saveProxySwtz(String reportWarehouseId, String reportWarehouse,String reportId, String reportMonth, String jsonlist, String manager, String reserveProperty) {
		ActionResultModel actionResultModel = new ActionResultModel();
		if (StringUtils.isEmpty(reportWarehouse) || Constant.HOME_WAREHOUSE.equals(reportWarehouse)) {
			actionResultModel.setSuccess(false);
			actionResultModel.setMsg("您没有该权限！！");
		}else{
			List<ReportSwtz> swtzList = JSON.parseArray(jsonlist, ReportSwtz.class);
//			List<StorageWarehouse> storageWarehouses =storageWarehouseService.getAllWarehouse();
			Set<String> distinctSet = new HashSet<>();//过滤是否存在重复库点与仓号的值
			for (ReportSwtz swtz:swtzList) {
			    String formatStr = swtz.getExtendsWarehouseId() + "##" + swtz.getStorehouse();
			    if(distinctSet.contains(formatStr)){
                    actionResultModel.setSuccess(false);
                    actionResultModel.setMsg("储存库点与仓号不能存在相同填报记录");
                    return actionResultModel;
                }

                distinctSet.add(formatStr);

//				for (StorageWarehouse storageWarehouse:storageWarehouses) {
//					if(storageWarehouse.getWarehouseShort().equals(swtz.getExtendsWarehouse())){
//                        swtz.setExtendsWarehouseId(storageWarehouse.getId());
//					}
//				}
			}
			reportId = service.addProxySwtz(reportWarehouseId,reportWarehouse,reportId, reportMonth, swtzList, manager, reserveProperty);
			actionResultModel.setSuccess(true);
			actionResultModel.setMsg(reportId);
		}

		return actionResultModel;
	}
	/**
	 * 实物台账填报
	 *
	 * @param
	 * @return
	 */
	@RequestMapping("fillProxySwtz")
	public String fillProxySwtz(ModelMap modelMap, String reportMonth, String reportWarehouse,String reportWarehouseId, String enterpriseName) {
		SysUser sysUser = TokenManager.getToken();
		//无法根据某个字段判断是否为代储用户 根据流程 代储用户需自行创建账户 即根据Note判断
		List<StorageWarehouse> list = storageWarehouseService.getStorageWarehouseByEnterpriseName(enterpriseName);
		if (list != null && list.size() > 0) {
			modelMap.put("extendsWarehouse", list);
			modelMap.put("extendsWarehouseJson",JSONArray.fromObject(list));
		} else {
			modelMap.put("extendsWarehouse", Collections.emptyList());
			modelMap.put("extendsWarehouseJson", "");
		}

		/*if(user.getNote()!=null) {
			list = storageWarehouseService.listWareHouseByType(user.getCompany());
			modelMap.put("extendsWarehouse", list);
		}else {
			HashMap<String,Object> param = new HashMap();
			param.put("warehouseType", "代储");
			list = storageWarehouseService.listValidWarehouse(param);
			list.add(0, new StorageWarehouse(user.getOriginCode(),user.getCompany(),user.getShortName()));
			modelMap.put("extendsWarehouse", list);
		}*/

		String status = "未保存";
		//String reportWarehouse = user.getShortName();
		if(StringUtils.isNotEmpty(reportMonth) && StringUtils.isNotEmpty(reportWarehouseId)){
			ReportMonth param = new ReportMonth();
			param.setReportMonth(reportMonth);
			param.setReportName(ReportNameEnum.SWTZ.getValue());
			param.setReportWarehouseId(reportWarehouseId);
			ReportMonth report = monthService.getReport(param);
			if (report != null){
				List<ReportSwtz> swtzList = service.listSwtzByReportId(report.getId());
				status = report.getReportStatus();
				modelMap.put("reportId", report.getId());
				modelMap.put("fillTime", report.getCreateDate());
				modelMap.put("swtzList", swtzList);
				modelMap.put("reportMain", report);
				modelMap.put("manager", report.getManager());
				modelMap.put("reserveProperty", report.getReserveProperty());
			}
		}

		List<String> warehouse = storageWarehouseService.getProxySwtzPointList(reportWarehouseId);
		modelMap.addAttribute("basepoint",warehouse);
//		for (StorageWarehouse item : storageWarehouseService.limitList())
//			warehouse.add(item.getWarehouseShort());


		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		modelMap.put("grainTypes", JSONArray.fromObject(grainTypes));
		modelMap.put("reportWarehouse", reportWarehouse);
		modelMap.put("reportWarehouseId", reportWarehouseId);
		modelMap.put("status", status);

		List<SysDict> validTypes=sysService.getSysDictListByType("质检类型");

		modelMap.addAttribute("validTypes",validTypes);
		modelMap.addAttribute("currentPoint",sysUser.getShortName());

		// 获取仓罐列表信息
		Map<String,Object> storeAndOrilMap = service.getStoreAndOilMap();
		modelMap.addAttribute("storeAndOrilMap",storeAndOrilMap);
		return "report/monthReport/fill_swtz";
	}

	 /**
	  * 模板导入数据
	  * @param file
	  * @return
	  */
	@ResponseBody
	@RequestMapping("/importExcel")
	public ActionResultModel importExcel(@RequestParam("file") MultipartFile file,@RequestParam(required = false) String reportWarehouseId){
		ActionResultModel actionResultModel = new ActionResultModel();
		StorageWarehouse storageWarehouse = storageWarehouseService.get(reportWarehouseId);
		Set<String> warehouseShortSet = new HashSet<String>();
		if(null != storageWarehouse){
			warehouseShortSet = storageWarehouseService.getStorageWarehouseShortByEnterpriseId(storageWarehouse.getEnterpriseId());
		}
		ImportParams params = new ImportParams();
		params.setHeadRows(2);
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		Set<String> grainTypeSet = new HashSet<>();
		for(SysDict sysDict :grainTypes){
			grainTypeSet.add(sysDict.getValue());
		}
		try {
			List<ReportSwtz> list = ExcelImportUtil.importExcel(file.getInputStream(), ReportSwtz.class, params);
			for(ReportSwtz reportSwtz : list){
				if(StringUtils.isNotEmpty(reportSwtz.getExtendsWarehouse()) && warehouseShortSet.contains(reportSwtz.getExtendsWarehouse())) {
					String warehouseId = storageWarehouseService.getWarehouseIdByShortname(reportSwtz.getExtendsWarehouse());
					if (StringUtils.isEmpty(warehouseId)) {
						actionResultModel.setSuccess(false);
						actionResultModel.setMsg(reportSwtz.getExtendsWarehouse() + " 库点不存在");
						return actionResultModel;
					} else {
						reportSwtz.setExtendsWarehouseId(warehouseId);
					}
				} else {
					actionResultModel.setSuccess(false);
					actionResultModel.setMsg("库点为空或库点不存在，请检查导入内容");
					return actionResultModel;
				}

				if(StringUtils.isEmpty(reportSwtz.getVariety()) || !grainTypeSet.contains(reportSwtz.getVariety())){
					actionResultModel.setSuccess(false);
					actionResultModel.setMsg("品种为空或品种不存在，请检查导入内容");
					return actionResultModel;
				}

				/*if(StringUtils.isNotEmpty(reportSwtz.getStorehouse())){
					int count = storageStoreHouseService.countStoreHouseByEncode(reportSwtz.getStorehouse(),reportSwtz.getExtendsWarehouseId());
					if(count <= 0){
						actionResultModel.setSuccess(false);
						actionResultModel.setMsg(reportSwtz.getStorehouse() + " 仓号不存在");
						return actionResultModel;
					}
				}*/
			}
			actionResultModel.setSuccess(true);
			actionResultModel.setData(list);
		}catch (Exception e){
			e.printStackTrace();
			actionResultModel.setSuccess(false);
		}

		return actionResultModel;
	}

}
