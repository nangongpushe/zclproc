package com.dhc.fastersoft.controller;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.StorageGrainInspection;
import com.dhc.fastersoft.entity.StorageGrainInspectionEChart;
import com.dhc.fastersoft.entity.StorageGrainInspectionTemp;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.*;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysUserService;
import com.dhc.fastersoft.utils.LayPage;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/storageGrainInspection")
@Controller
public class StorageGrainInspectionController extends BaseController{

	private static String storehouseStype = "仓房状态";

	@Autowired
	StorageGrainInspectionService service;
	@Autowired
	StorageWarehouseService warehouseService;
	@Autowired
	StorageStoreHouseService storehouseService;
	@Autowired
	SysUserService userService;
	@Autowired
	SysDictService dictService;
	@Autowired
	ReportSwtzService swtzService;

	@Autowired
	StorageGrainInspectionTempService storageGrainInspectionTempService;


	@RequestMapping()
	public String index(Model model, @RequestParam(value="type",required=false)String type) {

		List<SysDict> ststusList = dictService.getSysDictListByType(storehouseStype);
		if(type==null){
			type="";
		}

		if("dc".equals(type)){
			sysLogService.add(request, "访问：代储监管-报表台账-粮情检测记录");
		}else{
			sysLogService.add(request, "访问：仓储管理-粮油情监测管理-粮情检测记录");
		}
		model.addAttribute("type",type);
		model.addAttribute("ststusList", ststusList);
		return "storageGrainInspection/grain_inspection_main";
	}

	@RequestMapping("/addPage")
	public String addPage(Model model, @RequestParam(value="type",required=false)String type){
		model.addAttribute("type",type);
		SysUser user = TokenManager.getToken();
		model.addAttribute("user",user);
		String warehouse = user.getWareHouseId();
		String warehouseCode = user.getOriginCode();
		if(warehouse==null){
			warehouse="";
		}

		String[] storehouseEncodeArray = storehouseService.getEncodeByWarehouseId(warehouse);
		model.addAttribute("storehouseEncodeArray", storehouseEncodeArray);
		model.addAttribute("warehouseCode",warehouseCode);
		model.addAttribute("auvp","a");

		List<SysUser> sysUserList = userService.getList();

		model.addAttribute("sysUserList",sysUserList);
		StorageGrainInspection storageGrainInspection = new StorageGrainInspection();
		storageGrainInspection.setShedLeakage("1");
		storageGrainInspection.setWallLeakage("1");
		storageGrainInspection.setDoorLeakage("1");
		storageGrainInspection.setShedCrack("1");
		storageGrainInspection.setCheckSituation("1");
		model.addAttribute("grainInspection",storageGrainInspection);
		//粮油品种
		List<SysDict> grainTypes = dictService.getSysDictListByType("粮油品种");
		model.addAttribute("grainTypes", grainTypes);
		StorageWarehouse storageWarehouse = warehouseService.getWarehouseById(TokenManager.getToken().getWareHouseId());
		model.addAttribute("warehouseShort",storageWarehouse==null?"":storageWarehouse.getWarehouseShort());
		return "storageGrainInspection/grain_inspection_add";
	}

	@RequestMapping("/save")
	@ResponseBody
	public ActionResultModel save(@RequestBody StorageGrainInspection grainInspection,
								  @RequestParam(value="auvp") String auvp) {

		/*JSONObject json = (JSONObject) JSON.parseObject(jsonStr);
		grainInspection = JSONObject.toJavaObject(json, StorageGrainInspection.class);*/

		ActionResultModel result = new ActionResultModel();
		/*System.out.println(jsonStr);
		System.out.println(this.getClass().toString() + " : " + grainInspection.toString());*/


		String[]  pestCheckTypeList1 =grainInspection.getPestCheckTypeList();
		String[] pestSampleSiteList1 =grainInspection.getPestSampleSiteList();

		int j = pestCheckTypeList1.length-2;
		String[] pestCheckTypeList= new String[j];

		int a =pestSampleSiteList1.length-2;
		String[] pestSampleSiteList = new String[a];

		int index = 0;
		int index1= 0;
		if(j==0){
			grainInspection.setPestCheckTypeList(null);
		}else{
			for (int i = 0;i < pestCheckTypeList1.length;i++){
				if (!pestCheckTypeList1[i].equals("abc")){
					pestCheckTypeList[index]=pestCheckTypeList1[i];
					index++;
				}
			}
			grainInspection.setPestCheckTypeList(pestCheckTypeList);
		}
		if (a==0){
			grainInspection.setPestSampleSiteList(null);
		}else {
			for (int i = 0;i < pestSampleSiteList1.length;i++){
				if (!pestSampleSiteList1[i].equals("abc")){
					pestSampleSiteList[index1]=pestSampleSiteList1[i];
					index1++;
				}
			}
			grainInspection.setPestSampleSiteList(pestSampleSiteList);
		}




		String type = request.getParameter("type");
		grainInspection.setWarehouseId(TokenManager.getToken().getWareHouseId());
		if ( auvp.equals("a") || auvp.equals("c") ) {
			grainInspection.setCreatorId(TokenManager.getSysUserId());
			/*List<StorageStoreHouse> sshList=storehouseService.getByEncodeAndWarehouse(grainInspection.getEncode(),grainInspection.getWarehouse());
			grainInspection.setEncode(sshList.get(0).getId());*/
			result = service.save(grainInspection);

			//result = storageGrainInspectionTempService.add(storageGrainInspectionTemp);
			if("dc".equals(type)){
				sysLogService.add(request, "代储监管-报表台账-粮情检测记录-增加");
			}else{
				sysLogService.add(request, "仓储管理-粮油情监测管理-粮情检测记录-增加");
			}
		} else if ( auvp.equals("u") ) {
			result = service.update(grainInspection);
			if("dc".equals(type)){
				sysLogService.add(request, "代储监管-报表台账-粮情检测记录-修改");
			}else{
				sysLogService.add(request, "仓储管理-粮油情监测管理-粮情检测记录-修改");
			}
		}

		service.reportGrainInspection(grainInspection);	// 发送

		return result;
	}

	@RequestMapping("/list")
	@ResponseBody
	public LayPage<StorageGrainInspection> list(HttpServletRequest request) {
		LayPage<StorageGrainInspection> page = service.list(request);
		return page;
	}

	@RequestMapping("/viewPage")
	public String viewPage(Model model,
						   @RequestParam(value="id",required=true) String id,
						   @RequestParam(value="type",required=false)String type,
						   @RequestParam(value="Projectile",required=false, defaultValue="")String Projectile) {
		model.addAttribute("type",type);
		StorageGrainInspection grainInspection = service.get(id);
		model.addAttribute("grainInspection", grainInspection);

		model.addAttribute("auvp", "v");

		String warehouse = grainInspection.getWarehouse();
		if(warehouse==null){
			warehouse="";
		}
		String[] storehouseEncodeArray = storehouseService.getEncodeByWarehouse(warehouse);
		model.addAttribute("storehouseEncodeArray", storehouseEncodeArray);

		List<SysUser> sysUserList = userService.getList();

		model.addAttribute("sysUserList",sysUserList);

		//获取小表对象
		String p_id = grainInspection.getId();
		List<StorageGrainInspectionTemp> storageGrainInspectionTemps =service.selectStorageGrainInspectionTempByPid(p_id);
		model.addAttribute("storageGrainInspectionTemps", storageGrainInspectionTemps);


		return Projectile.equals("Projectile")?"storageGrainInspection/grain_inspection_view_dialog":"storageGrainInspection/grain_inspection_view";
	}

	@RequestMapping("/remove")
	@ResponseBody
	public ActionResultModel remove(@RequestParam(value="id",required=true) String id, String type) {
		ActionResultModel result = service.remove(id);
		if("dc".equals(type)){
			sysLogService.add(request, "代储监管-报表台账-粮情检测记录-删除");
		}else{
			sysLogService.add(request, "仓储管理-粮油情监测管理-粮情检测记录-删除");
		}
		return result;
	}

	@RequestMapping("/editPage")
	public String editPage(Model model,
						   @RequestParam(value="type",required=false)String type,
						   @RequestParam(value="id",required=true) String id ,
						   @RequestParam(value="Projectile",required=false, defaultValue="")String Projectile,
						   @RequestParam(value="operatorFlag",required=false) String operatorFlag) {
		StorageGrainInspection grainInspection = service.get(id);
//		System.out.println(grainInspection.getQuantity());
		model.addAttribute("type",type);
		/*String warehouse = grainInspection.getWarehouse();*/
		String warehouse = TokenManager.getToken().getWareHouseId();
		if(warehouse==null){
			warehouse="";
		}

		String[] storehouseEncodeArray = storehouseService.getEncodeByWarehouseId(warehouse);
		model.addAttribute("storehouseEncodeArray", storehouseEncodeArray);

		List<SysUser> sysUserList = userService.getList();

		model.addAttribute("sysUserList",sysUserList);

		//获取小表对象
		String p_id = grainInspection.getId();
		List<StorageGrainInspectionTemp> storageGrainInspectionTemps =service.selectStorageGrainInspectionTempByPid(p_id);
		if(operatorFlag != null || "".equals(operatorFlag)){
			grainInspection.setId(null);
			model.addAttribute("auvp","c");
		}else{
			model.addAttribute("auvp","u");
		}

		//System.out.println(grainInspection.toString());
		model.addAttribute("grainInspection", grainInspection);

		model.addAttribute("storageGrainInspectionTemps", storageGrainInspectionTemps);
		//粮油品种
		List<SysDict> grainTypes = dictService.getSysDictListByType("粮油品种");
		model.addAttribute("grainTypes", grainTypes);

		//return "storageGrainInspection/grain_inspection_add";
		return Projectile.equals("Projectile")?"storageGrainInspection/grain_inspection_add_dialog":"storageGrainInspection/grain_inspection_add";
	}
	@RequestMapping(value = "/getTime",method = RequestMethod.POST)
	@ResponseBody
	public int getTimeCount(@RequestParam(value = "warehouse")String warehouse, @RequestParam(value = "encode")String encode, @RequestParam(value = "reportDate")String reportDate){
		HashMap<String,Object> map= new HashMap<String,Object>();
		map.put("warehouse",warehouse);
		map.put("encode",encode);
		map.put("reportDate",reportDate);
		int count = service.getTimeCount(map);
		return count;
	}

	@SysLogAn("访问：仓储管理-粮油情检测管理-粮情三温图")
	@RequestMapping("/threeTempChart")
	public String threeTempChart(Model model){
		model.addAttribute("isFirstLoad",true);

		SysUser user = null;

		try{


			user = TokenManager.getToken();
			String  userId=request.getParameter("userId");
			if(userId!=null){
				user=	userService.selectById(userId);
			}
			model.addAttribute("user",user);

			String shortName=null!=user.getShortName()?user.getShortName():user.getCompany();
			StorageWarehouse storageWarehouse = warehouseService.getStorageWarehouse(user.getOriginCode());
			String warehouseId = null;
			if(storageWarehouse != null) {
				warehouseId = storageWarehouse.getId();
			}
			model.addAttribute("storehouseArray", storehouseService.listStorehouseOfWarehouse(warehouseId));
		} catch(Exception ex){
			//ex.printStackTrace();
		}
        if(StringUtils.isNotEmpty(user.getOriginCode())) {
			if (user.getOriginCode().toUpperCase().equals("CBL")) {
				List<StorageWarehouse> warehouse = warehouseService.getAllWarehouse();
				model.addAttribute("warehouse", warehouse);
			} else {
				model.addAttribute("warehouse", new StorageWarehouse[]{warehouseService.getStorageWarehouse(user.getOriginCode())});
			}
		}else{
			List<StorageWarehouse> warehouse = warehouseService.getAllWarehouse();
			model.addAttribute("warehouse", warehouse);
		}

		return "storageGrainInspection/three_temp_chart";
	}

	@RequestMapping("/getEChartData")
	@ResponseBody
	public StorageGrainInspectionEChart getLineEchart(HttpServletRequest request) {
		StorageGrainInspectionEChart echart = service.getEChartData(request);
		return echart;
	}
	//在实物台账中暂无找到选择的仓房本月的实际数量，已经将实际数量置为默认值
	/*@RequestMapping("/getQuantity")
	@ResponseBody
	public ActionResultModel getCurrMonthQuantity(HttpServletRequest request) {
		return swtzService.getCurrMonthQuantity(request);
	}*/

	//在实物台账中暂无找到选择的仓房上月的实际数量，已经将实际数量置为默认值
	@RequestMapping("/getQuantity")
	@ResponseBody
	public ActionResultModel getLastMonthQuantity(HttpServletRequest request) {
		System.out.println("nihao ");
		return swtzService.getLastMonthQuantity(request);
	}

	@RequestMapping("/grainInspection")
	public String grainInspectionCount(Map<String,Object> map){
		List<StorageWarehouse> warehouseList = warehouseService.getStoreWarehouseByTypeWithCBK();
		map.put("warehouseList",warehouseList);
		return "storageGrainInspection/grain_inspection_count";
	}

	/**
	 * 精粮油统计
	 * @param pageNum
	 * @param pageSize
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	@RequestMapping("/statistics")
	@ResponseBody
	public LayPage<Map<String, Object>> statistics(@RequestParam(required = false,defaultValue = "1") Integer pageNum,
												   @RequestParam(required = false,defaultValue = "10") Integer pageSize,
												   @RequestParam(required = false) String startDate,
												   @RequestParam(required = false) String endDate) {
		Map<String, Object> map = new HashMap<>();
		map.put("startDate",startDate);
		map.put("endDate",endDate);
		LayPage page = service.statistics(pageNum,pageSize,map);
		return page;
	}

	/**
	 * 精粮油统计导出
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/excelStatistice")
	public void excelStatistics(HttpServletResponse response,
								@RequestParam(required = false) String startDate,
								@RequestParam(required = false) String endDate) throws IOException {
		Map<String, Object> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		Workbook workbook = service.excel(map);
		response.setHeader("content-Type", "application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;filename=" + java.net.URLEncoder.encode("粮情检测记录统计", "UTF-8") + ".xls");
		response.setCharacterEncoding("UTF-8");
		workbook.write(response.getOutputStream());
	}

	@ResponseBody
	@RequestMapping(value = "/report", method = RequestMethod.POST)
	public Map<String, Object> reportGrainSituation(@RequestBody StorageGrainInspection storageGrainInspection){
		Map<String, Object> responseMap = new HashMap<>();
		responseMap.put("isSuccess",true);
		try{
			service.reportGrainSituation(storageGrainInspection);
			responseMap.put("msg","添加成功");
		}catch (Exception e){
			responseMap.put("isSuccess",false);
			responseMap.put("msg", e.getMessage());
		}
		return responseMap;
	}
}
