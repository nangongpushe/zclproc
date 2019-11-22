package com.dhc.fastersoft.controller.store;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.controller.BaseController;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.store.StorageCooling;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.DurablesService;
import com.dhc.fastersoft.service.StorageStoreHouseService;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.service.store.StorageCoolingService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.utils.LayPage;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.TemplateExportParams;

/**
 * 
 * @author lay
 *
 */
@Controller
@RequestMapping("/StorageCooling")
public class StorageCoolingController extends BaseController{
	private static Logger log = Logger.getLogger(StorageCoolingController.class);
	@Autowired
	private StorageCoolingService coolingService;
	@Autowired
	private StorageStoreHouseService storehouseService;
	@Autowired
	private StorageWarehouseService storageWarehouseService;
	@Autowired
	private SysDictService sysDictService;
	@Autowired
	private DurablesService durablesService;
	//列表导出模板名
	private static String listTemplateName = "谷物冷却记录列表";
	//详情导出模板名
	private static String detailTemplateName = "谷物冷却记录";
	
	
	@RequestMapping("/add")
	public String add(Model model) {
		StorageCooling cooling = new StorageCooling();
		SysUser user = TokenManager.getToken();
		String shortName=null!=user.getShortName()?user.getShortName():user.getCompany();
		String warehouseId = user.getWareHouseId();
		cooling.setWarehouse(shortName);
		cooling.setWarehouseId(warehouseId);
		Date date = Calendar.getInstance().getTime();
		cooling.setRecordDate(date);
		//操作人暂定未系统当前用户
		cooling.setOperator(user.getName());
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		//仓房类型
		List<SysDict> storehouseTypes = sysDictService.getSysDictListByType("仓房类型");
	

		model.addAttribute("grainTypes", grainTypes);
		model.addAttribute("storehouseTypes", storehouseTypes);
		model.addAttribute("model", cooling);
		model.addAttribute("isEdit", false);
		model.addAttribute("storehouses",storehouseService.listStorehouseOfWarehouse(warehouseId));
		return "StorageCooling/storagecooling_add";
	}
	
	@RequestMapping(value="/edit",params="sid")
	public String edit(Model model,@RequestParam("sid") String sid, @RequestParam(value="Projectile",required=false, defaultValue="")String Projectile) {
		StorageCooling cooling = coolingService.getById(sid);
		SysUser user = TokenManager.getToken();
		String shortName=  null!=user.getShortName()?user.getShortName():user.getCompany();
		String warehouseId = user.getWareHouseId();
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		//仓房类型
		List<SysDict> storehouseTypes = sysDictService.getSysDictListByType("仓房类型");
	
		model.addAttribute("grainTypes", grainTypes);
		model.addAttribute("storehouseTypes", storehouseTypes);
		model.addAttribute("model", cooling);
		model.addAttribute("isEdit", true);
		model.addAttribute("storehouses",storehouseService.listStorehouseOfWarehouse(warehouseId));
		//return "StorageCooling/storagecooling_add";
		return Projectile.equals("Projectile")?"StorageCooling/storagecooling_add_dialog":"StorageCooling/storagecooling_add";
	}
//复制新增
	@RequestMapping(value="/editadd",params="sid")
	public String editadd(Model model,@RequestParam("sid") String sid) {
		StorageCooling cooling = coolingService.getById(sid);
		SysUser user = TokenManager.getToken();
		String shortName=null!=user.getShortName()?user.getShortName():user.getCompany();
		String warehouseId = user.getWareHouseId();

		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		//仓房类型
		List<SysDict> storehouseTypes = sysDictService.getSysDictListByType("仓房类型");

		model.addAttribute("grainTypes", grainTypes);
		model.addAttribute("storehouseTypes", storehouseTypes);
		model.addAttribute("model", cooling);
		model.addAttribute("isEdit", false);
		model.addAttribute("storehouses",storehouseService.listStorehouseOfWarehouse(warehouseId));
		return "StorageCooling/storagecooling_add";
	}

	@SysLogAn("访问：仓储管理-粮油情检测管理-谷物冷却记录")
	@RequestMapping("/main")
	public String main(Model model) {
		//对数据进行权限上的控制
		SysUser user=TokenManager.getToken();
		if(user.getOriginCode().toLowerCase().equals("cbl")) {
			//公司查看全部,不做限制
			List<StorageWarehouse> wareHouse = storageWarehouseService.limitListCBL();
			/*List<String> warehouseNames = new ArrayList<>();
			for(StorageWarehouse item : wareHouse)
				warehouseNames.add(item.getWarehouseShort());*/
			model.addAttribute("wareHouse", wareHouse);
		}else {
			//所属库看自己的
			/*List<String> warehouses=new ArrayList<>();
			warehouses.add(user.getShortName());
			model.addAttribute("warehousesName", warehouses);*/
			model.addAttribute("wareHouse", null);
			String warehousesName = user.getShortName();
			String warehousesId =user.getWareHouseId();
			model.addAttribute("warehousesName", warehousesName);
			model.addAttribute("warehousesId", warehousesId);
		}
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("grainTypes", grainTypes);
		return "StorageCooling/storagecooling_main";
	}
	
	@RequestMapping(value="/view",params="sid")
	public String view(Model model,@RequestParam("sid") String sid) {
		StorageCooling cooling = coolingService.getById(sid);
		model.addAttribute("t", cooling);
		return "StorageCooling/storagecooling_view";
	}

	/**
	 * excel导出
	 * @param request
	 * @param response
	 * @param id
	 * @throws IOException
	 */
	@SysLogAn("仓储管理-粮油情检测管理-谷物冷却记录-导出")
	@RequestMapping(value="/exportExcel")
	@ResponseBody
	public void ExportExcel(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value="ids")String ids) throws IOException {

		HashMap<String, Object> map = new HashMap<>();
		map.put("ids", ids.split(","));
		List<StorageCooling> list = coolingService.list(map);
		//模板导出
        String path = request.getServletContext().getRealPath("/templates/"+listTemplateName+".xls");
		//String path =pathwa+ "templates\\"+listTemplateName+".xls";
		TemplateExportParams params = new TemplateExportParams(path);
		response.setHeader("content-Type", "application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;filename=" +  java.net.URLEncoder.encode(listTemplateName,"UTF-8") + ".xls");
		response.setCharacterEncoding("UTF-8");
		Map<String, Object> mapForExport = new HashMap<>();
		mapForExport.put("list", list);
		Workbook workbook = ExcelExportUtil.exportExcel(params,mapForExport);
		workbook.write(response.getOutputStream());

	}
	
	/**
	 * 
	 * @param request
	 * @param response
	 * @param id
	 * @throws IOException
	 */
	@RequestMapping(value="/exportExcelOfDetail")
	@ResponseBody
	public void ExportExcelOfDetail(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value="id")String id) throws IOException {
		
		StorageCooling cooling = coolingService.getById(id);
		
		//模板导出
		String path = "templates\\"+detailTemplateName+".xls";
		TemplateExportParams params = new TemplateExportParams(path);
		response.setHeader("content-Type", "application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;filename=" +  java.net.URLEncoder.encode(detailTemplateName,"UTF-8") + ".xls");
		response.setCharacterEncoding("UTF-8");
		Map<String, Object> mapForExport = new HashMap<>();
		mapForExport.put("t", cooling);
		Workbook workbook = ExcelExportUtil.exportExcel(params,mapForExport);
		workbook.write(response.getOutputStream());

	}
	
	
	
	/**
	 * 新增、编辑
	 * @param storageMachineAir
	 * @param isedit
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Object  saveOrUpdate(StorageCooling storageCooling,
			@RequestParam(value="isedit") Boolean isedit) throws IOException {
		
		ActionResultModel actionResultModel = new ActionResultModel();

		if(null == isedit || !isedit) {
			storageCooling.setOperatorId(TokenManager.getSysUserId());
			coolingService.save(storageCooling);
			sysLogService.add(request, "仓储管理-粮油情检测管理-谷物冷却记录-新增");
		}
		else {
			coolingService.update(storageCooling);
			sysLogService.add(request, "仓储管理-粮油情检测管理-谷物冷却记录-修改");
		}
		actionResultModel.setSuccess(true);
		
		return actionResultModel;
	}
	/**
	 * 
	 * @param sid
	 * @return
	 */
	@SysLogAn("仓储管理-粮油情检测管理-谷物冷却记录-删除")
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel remove(@RequestParam(value="sid") String sid) {
		ActionResultModel actionResultModel = new ActionResultModel();
		coolingService.remove(sid);
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}

	
	@RequestMapping(value="/list")
	@ResponseBody
	public LayPage<StorageCooling> list(
			@RequestParam(value="pageIndex") int pageIndex,
			@RequestParam(value="pageSize") int pageSize,
			@RequestParam(value="warehouse",required=false) String warehouse,
			@RequestParam(value="storehouse",required=false) String storehouse,
			@RequestParam(value="operator",required=false) String operator,
			@RequestParam(value="grainType",required=false) String grainType,
			@RequestParam(value="recordDate",required=false) String recordDate) throws UnsupportedEncodingException {
		
		HashMap<String, Object> map=new HashMap<>();
		map.put("pageIndex", pageIndex);
		map.put("pageSize", pageSize);
		map.put("warehouse", warehouse);
		map.put("storehouse", storehouse);
		map.put("operator", operator);
		map.put("grainType", grainType);
		map.put("recordDate",recordDate);
		
		//对数据进行权限上的控制
		SysUser user=TokenManager.getToken();
		if(user.getOriginCode().toLowerCase().equals("cbl")) {
			//公司查看全部,不做限制
		}else {
			//所属库看自己的
			map.put("warehouse", user.getWareHouseId());
		}

		int total =coolingService.count(map);
		List<StorageCooling> list=null;
		if(total>0)
			list = coolingService.list(map);
		
		LayPage<StorageCooling> pageUtil=new LayPage<>(list, total);

		return pageUtil;
	}
	
}
