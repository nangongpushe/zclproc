package com.dhc.fastersoft.controller.store;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.TemplateExportParams;
import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.constants.BusinessConstants;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.controller.BaseController;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.store.StorageFumigate;
import com.dhc.fastersoft.entity.store.StoragePhosphine;
import com.dhc.fastersoft.entity.store.StoragePhosphinePoint;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.DurablesService;
import com.dhc.fastersoft.service.StorageOilcanService;
import com.dhc.fastersoft.service.StorageStoreHouseService;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.service.store.StorageFumigateService;
import com.dhc.fastersoft.service.store.StoragePhosphineService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.utils.LayPage;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.type.TypeFactory;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.*;

@Controller
@RequestMapping("/StoragePhosphine")
public class StoragePhosphineController extends BaseController{
	private static Logger log = Logger.getLogger(StoragePhosphineController.class);
	@Autowired
	private StoragePhosphineService phosphineService;
	@Autowired
	private StorageFumigateService fumigateService;
	@Autowired
	private StorageStoreHouseService storehouseService;
	@Autowired
	private StorageOilcanService oilcanService;
	@Autowired
	private StorageWarehouseService storageWarehouseService;
	@Autowired
	private SysDictService sysDictService;
	@Autowired
	private DurablesService durablesService;
	//列表导出模板名
	private static String listTemplateName = "磷化氢浓度检测记录";
	
	
	@RequestMapping("/add")
	public String add(Model model) {
		StoragePhosphine phosphine = new StoragePhosphine();
		SysUser user = TokenManager.getToken();
		String shortName=user.getShortName();
		String warehouseId = user.getWareHouseId();
		phosphine.setWarehouse(shortName);
		phosphine.setWarehouseId(warehouseId);
		/*phosphine.setInspector(user.getName());*/
		phosphine.setInspecteTime(Calendar.getInstance().getTime());
		
		model.addAttribute("model", phosphine);
		model.addAttribute("isEdit", false);
		model.addAttribute("storehouses",storehouseService.listStorehouseOfWarehouse(warehouseId));
		return "StoragePhosphine/storagephosphine_add";
	}
	
	@RequestMapping(value="/edit",params="sid")
	public String edit(Model model,@RequestParam(value="sid") String sid, @RequestParam(value="Projectile",required=false, defaultValue="")String Projectile) {
		StoragePhosphine phosphine = phosphineService.getById(sid);
		SysUser user = TokenManager.getToken();
		String shortName=user.getShortName();
		String warehouseId = user.getWareHouseId();
		model.addAttribute("model", phosphine);
		model.addAttribute("isEdit", true);
		model.addAttribute("storehouses",storehouseService.listStorehouseOfWarehouse(warehouseId));
		//return "StoragePhosphine/storagephosphine_add";
		return Projectile.equals("Projectile")?"StoragePhosphine/storagephosphine_add_dialog":"StoragePhosphine/storagephosphine_add";
	}
	//复制新增
	@RequestMapping(value="/editadd",params="sid")
	public String editadd(Model model,@RequestParam("sid") String sid) {
		StoragePhosphine phosphine = phosphineService.getById(sid);
		SysUser user = TokenManager.getToken();
		String warehouseId = user.getWareHouseId();
		String shortName=user.getShortName();
		model.addAttribute("model", phosphine);
		model.addAttribute("isEdit", false);
		model.addAttribute("storehouses",storehouseService.listStorehouseOfWarehouse(warehouseId));
		return "StoragePhosphine/storagephosphine_add";
	}

	@SysLogAn("访问：仓储管理-粮油情检测管理-磷化氢检测记录")
	@RequestMapping("/main")
	public String main(Model model) {
		//对数据进行权限上的控制
		SysUser user=TokenManager.getToken();
//		String shortName=user.getShortName();
		String warehouseId = user.getWareHouseId();
		if(TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")) {
			//公司查看全部,不做限制
			List<StorageWarehouse> wareHouse = storageWarehouseService.limitListCBL();
			/*List<String> warehouseNames = new ArrayList<>();
			for(StorageWarehouse item : wareHouse)
				warehouseNames.add(item.getWarehouseShort());*/
			model.addAttribute("wareHouse", wareHouse);
		}else {
			//所属库看自己的
			/*List<String> warehouses=new ArrayList<>();
			warehouses.add(shortName);
			model.addAttribute("warehousesName", warehouses);*/
			model.addAttribute("wareHouse", null);
			String warehousesName = user.getShortName();
			String warehousesId =user.getWareHouseId();
			model.addAttribute("warehousesName", warehousesName);
			model.addAttribute("warehousesId", warehousesId);
		}
		//熏蒸记录
		HashMap<String, Object> map = new HashMap<>();
		map.put("warehouse", warehouseId);
		List<StorageFumigate> fumigates = fumigateService.list(map);
		model.addAttribute("fumigates",fumigates);
		
		return "StoragePhosphine/storagephosphine_main";
	}
	
	@RequestMapping(value="/view",params="sid")
	public String view(Model model,@RequestParam("sid") String sid) {
		StoragePhosphine phosphine = phosphineService.getById(sid);
		model.addAttribute("model", phosphine);
		return "StoragePhosphine/storagephosphine_view";
	}

	/**
	 * excel导出
	 * @param request
	 * @param response
	 * @param ids
	 * @throws IOException
	 */
	@SysLogAn("仓储管理-粮油情检测管理-磷化氢检测记录-导出")
	@RequestMapping(value="/exportExcel")
	@ResponseBody
	public void ExportExcel(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value="ids")String ids) throws IOException {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("ids", ids.split(","));
		List<StoragePhosphine> list = phosphineService.list(map);
		List<HashMap<String, Object>> listMap = new ArrayList<>();
		for(StoragePhosphine phosphine:list) {
			HashMap<String, Object> newPhosphine = new HashMap<>();	
			newPhosphine.put("warehouse", phosphine.getWarehouse());
			newPhosphine.put("encode", phosphine.getEncode());
			newPhosphine.put("fumigate", phosphine.getFumigate());
			newPhosphine.put("average", phosphine.getAverage());

			if(StringUtils.isNotEmpty(phosphine.getInspectors())){
				newPhosphine.put("inspector", StringUtils.join(phosphine.getInspector(),"/",phosphine.getInspectors()));
			}else{
				newPhosphine.put("inspector", phosphine.getInspector());
			}

			newPhosphine.put("inspecteTime", phosphine.getInspecteTime());
			List<StoragePhosphinePoint> points = phosphineService.getPointsByPhosphineId(phosphine.getId());
			for(StoragePhosphinePoint point : points) {
				if("粮堆检测点1号".equals(point.getPoint())) {
					newPhosphine.put("pointOne", point.getValue());
				}else if("粮堆检测点2号".equals(point.getPoint())) {
					newPhosphine.put("pointTwo", point.getValue());
				}else if("粮堆检测点3号".equals(point.getPoint())) {
					newPhosphine.put("pointThree", point.getValue());
				}else if("粮堆检测点4号".equals(point.getPoint())) {
					newPhosphine.put("pointFour", point.getValue());
				}else if("粮堆检测点5号".equals(point.getPoint())) {
					newPhosphine.put("pointFive", point.getValue());
				}else if("粮堆检测点6号".equals(point.getPoint())) {
					newPhosphine.put("pointSix", point.getValue());
				}else if("粮堆检测点7号".equals(point.getPoint())) {
					newPhosphine.put("pointSeven", point.getValue());
				}
			}
			listMap.add(newPhosphine);
		}
		//模板导出
		String path = "templates\\"+listTemplateName+".xls";
		TemplateExportParams params = new TemplateExportParams(path);
		response.setHeader("content-Type", "application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;filename=" +  java.net.URLEncoder.encode(listTemplateName,"UTF-8") + ".xls");
		response.setCharacterEncoding("UTF-8");
		Map<String, Object> mapForExport = new HashMap<>();
		mapForExport.put("list", listMap);
		Workbook workbook = ExcelExportUtil.exportExcel(params,mapForExport);
		workbook.write(response.getOutputStream());

	}	
	
	/**
	 * 新增、编辑
	 * @param storagePhosphine
	 * @param isedit
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Object  saveOrUpdate(StoragePhosphine storagePhosphine,
			@RequestParam(value="isedit") Boolean isedit,
			@RequestParam(value="detailListStr") String detailListStr) throws IOException {
		
		ActionResultModel actionResultModel = new ActionResultModel();
		ObjectMapper mapper = new ObjectMapper();
		List<StoragePhosphinePoint> detail = mapper.readValue(detailListStr,TypeFactory.defaultInstance().constructCollectionType(List.class,StoragePhosphinePoint.class));
		storagePhosphine.setPointList(detail);
		if(null == isedit || !isedit) {
			storagePhosphine.setInspectorId(TokenManager.getSysUserId());
			phosphineService.save(storagePhosphine);
			sysLogService.add(request, "仓储管理-粮油情检测管理-磷化氢检测记录-新增");
		}
		else {
			phosphineService.update(storagePhosphine);
			sysLogService.add(request, "仓储管理-粮油情检测管理-磷化氢检测记录-删除");
		}
		actionResultModel.setSuccess(true);
		
		return actionResultModel;
	}
	/**
	 * 
	 * @param sid
	 * @return
	 */
	@SysLogAn("仓储管理-粮油情检测管理-磷化氢检测记录-删除")
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel remove(@RequestParam(value="sid") String sid) {
		ActionResultModel actionResultModel = new ActionResultModel();
		phosphineService.remove(sid);
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}

	
	@RequestMapping(value="/list")
	@ResponseBody
	public LayPage<StoragePhosphine> list(
			@RequestParam(value="pageIndex") int pageIndex,
			@RequestParam(value="pageSize") int pageSize,
			@RequestParam(value="warehouse",required=false) String warehouse,
			@RequestParam(value="encode",required=false) String encode,
			@RequestParam(value="fumigate",required=false) String fumigate,
			@RequestParam(value="inspector",required=false) String inspector,
			@RequestParam(value="inspecteTime",required=false) String inspecteTime){
		
		HashMap<String, Object> map=new HashMap<>();
		map.put("pageIndex", pageIndex);
		map.put("pageSize", pageSize);
		map.put("warehouse", warehouse);
		map.put("encode", encode);
		map.put("fumigate", fumigate);
		map.put("inspector", inspector);
		map.put("inspecteTime",inspecteTime);

		//对数据进行权限上的控制
		SysUser user=TokenManager.getToken();
		if(user.getOriginCode() != null
				&& BusinessConstants.CBL_CODE.equals(user.getOriginCode().toLowerCase())) {
			//公司查看全部,不做限制
		} else {
			//所属库看自己的
			map.put("warehouse", user.getWareHouseId());
		}

		int total =phosphineService.count(map);
		List<StoragePhosphine> list=null;
		if(total>0)
			list = phosphineService.list(map);
		
		LayPage<StoragePhosphine> pageUtil=new LayPage<>(list, total);

		return pageUtil;
	}
	
}
