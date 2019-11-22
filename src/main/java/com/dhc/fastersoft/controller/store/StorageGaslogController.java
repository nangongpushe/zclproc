package com.dhc.fastersoft.controller.store;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.controller.BaseController;
import com.dhc.fastersoft.entity.StorageGaslogTemp;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.*;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.StorageGaslog;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.utils.PageUtil;
import com.dhc.fastersoft.utils.UpdateUtil;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;

@Controller
@RequestMapping("/StorageGaslog")
public class StorageGaslogController extends BaseController{

	@Autowired
	private StorageStoreHouseService storageStoreHouseService;
	@Autowired
	private StorageGaslogService storageGaslogService;
	@Autowired
	private StorageWarehouseService storageWarehouseService;
	@Autowired
	private StorageOilcanService storageOilcanService;
	@Autowired
	private StorageGaslogTempService storageGaslogTempService;

	@SysLogAn("访问：仓储管理-粮油情检测管理-氮气浓度检测记录")
	@RequestMapping(value="/view",method=RequestMethod.GET)
	public String ListStorageGaslog(Model model) {
		return "StorageGaslog/storagegaslog_view";
	}
	
	@RequestMapping(value="/view",method=RequestMethod.POST)
	@ResponseBody
	public LayPage ListStorageGaslog(StorageGaslog gaslog,@RequestParam("page")int page,@RequestParam("limit")int limit) {
		PageUtil<StorageGaslog> pageUtil = new PageUtil<>();
		pageUtil.setPageIndex(page);
		pageUtil.setPageSize(limit);
		SysUser user = TokenManager.getToken();
		String company = user.getCompany();
		String warehouseId = user.getWareHouseId();
		if(!StringUtils.equals(user.getOriginCode().toUpperCase(),"CBL")){
//		if(!company.equals("浙江省储备粮管理有限公司")){
			gaslog.setWarehouseId(warehouseId);
		}
		pageUtil.setEntity(gaslog);
		
		pageUtil.setResult(storageGaslogService.ListLimitLog(pageUtil));
		
		LayPage<StorageGaslog> result = new LayPage<>();
		result.setCount(pageUtil.getTotalCount());
		result.setData(pageUtil.getResult());
		return result;
	}

	//到复制新增
	@RequestMapping(value="/toeditadd",method=RequestMethod.GET)
	public String ToEditAddStorageGaslog(Model model,@RequestParam(value="id",required=false)String id) {
		StorageGaslog log = id != null?storageGaslogService.GetStorageGaslog(id):new StorageGaslog(TokenManager.getToken().getShortName(),new SimpleDateFormat("yyyy年MM月dd日").format(Calendar.getInstance().getTime()),TokenManager.getNickname());
		model.addAttribute("oilcan",storageStoreHouseService.listStorehouseOfWarehouse(log.getWarehouseId()));
		String p_id = log.getId();
		if (p_id!=null){
			List<StorageGaslogTemp> storageGaslogTemps = storageGaslogTempService.selectStorageGaslogTempByPid(p_id);
			model.addAttribute("storageGaslogTemps",storageGaslogTemps);
		}
		//model.addAttribute("oilcan",storageOilcanService.list(log.getWarehouseName()).getData());
		model.addAttribute("gaslog",log);
		return "StorageGaslog/storagegaslog_editadd";
	}
	//复制新增
	@RequestMapping(value="/editadd",method=RequestMethod.POST)
	@ResponseBody
	public Map EditAddStorageGaslog(StorageGaslog gaslog) {
		gaslog.setCreateTime(Calendar.getInstance().getTime());
		gaslog.setDetectionHumenId(TokenManager.getSysUserId());
		storageGaslogService.AddStorageLog(gaslog);
		Map<String,Object> result = new HashMap<>();
		result.put("success", true);
		return result;
	}
	
	@RequestMapping(value="/{enter}",method=RequestMethod.GET)
	public String StorageGaslogEnter(Model model,@RequestParam(value="id",required=false)String id, @RequestParam(value="Projectile",required=false, defaultValue="")String Projectile) {
		StorageGaslog log = id != null?storageGaslogService.GetStorageGaslog(id):new StorageGaslog(TokenManager.getToken().getShortName(),new SimpleDateFormat("yyyy年MM月dd日").format(Calendar.getInstance().getTime()),TokenManager.getNickname());
		log.setWarehouseId(TokenManager.getToken().getWareHouseId());
		model.addAttribute("oilcan",storageStoreHouseService.listStorehouseOfWarehouse(log.getWarehouseId()));
		String p_id = log.getId();
		if (p_id!=null){
			List<StorageGaslogTemp> storageGaslogTemps = storageGaslogTempService.selectStorageGaslogTempByPid(p_id);
			model.addAttribute("storageGaslogTemps",storageGaslogTemps);
		}

		//model.addAttribute("oilcan",storageOilcanService.list(log.getWarehouseName()).getData());
		model.addAttribute("gaslog",log);
		//return "StorageGaslog/storagegaslog_add";
		return Projectile.equals("Projectile")?"StorageGaslog/storagegaslog_add_dialog":"StorageGaslog/storagegaslog_add";
	}
	
	@RequestMapping(value="/Detail",method=RequestMethod.GET)
	public String DetailStorageGaslog(Model model,@RequestParam(value="id")String id) {
		String p_id = id;
		if (p_id!=null){
			List<StorageGaslogTemp> storageGaslogTemps = storageGaslogTempService.selectStorageGaslogTempByPid(p_id);
			model.addAttribute("storageGaslogTemps",storageGaslogTemps);
		}
		model.addAttribute("gaslog",storageGaslogService.GetStorageGaslog(id));
		return "StorageGaslog/storagegaslog_detail";
	}

	@SysLogAn("仓储管理-粮油情检测管理-氮气浓度检测记录-新增")
	@RequestMapping(value="/Add",method=RequestMethod.POST)
	@ResponseBody
	public Map AddStorageGaslog(StorageGaslog gaslog) {

		gaslog.setCreateTime(Calendar.getInstance().getTime());
		gaslog.setDetectionHumenId(TokenManager.getSysUserId());
		storageGaslogService.AddStorageLog(gaslog);
		
		Map<String,Object> result = new HashMap<>();
		result.put("success", true);
		return result;
	}

	@SysLogAn("仓储管理-粮油情检测管理-氮气浓度检测记录-修改")
	@RequestMapping(value="/Edit",method=RequestMethod.POST)
	@ResponseBody
	public Map EditStorageGaslog(StorageGaslog gaslog) {
		StorageGaslog gaslogBase = storageGaslogService.GetStorageGaslog(gaslog.getId());

		try {
			UpdateUtil.UpdateField(gaslog, gaslogBase, new String[] {"id","createTime"});
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		storageGaslogService.UpdateStoragelog(gaslogBase);
		
		Map<String,Object> result = new HashMap<>();
		result.put("success", true);
		return result;
	}

	@SysLogAn("仓储管理-粮油情检测管理-氮气浓度检测记录-删除")
	@RequestMapping(value="/Delete",method=RequestMethod.POST)
	@ResponseBody
	public Map DeleteStorageGaslog(@RequestParam("id")String id) {
		storageGaslogService.DeleteStoragelog(id);
		
		Map<String,Object> result = new HashMap<>();
		result.put("success", true);
		return result;
	}

	@SysLogAn("仓储管理-粮油情检测管理-氮气浓度检测记录-导出")
	@RequestMapping(value="/ExportExcel")
	@ResponseBody
	public void ExportExcel(HttpServletResponse response,@RequestParam("ids")String ids) throws IOException{
		List<StorageGaslog> list = new ArrayList<>();
		list.addAll(storageGaslogService.GetStorageGaslogByIds(Arrays.asList(ids.split(","))));
		String title = "氮气浓度检测记录";
		
		response.setHeader("content-Type", "application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;filename=" +  java.net.URLEncoder.encode(title,"UTF-8") + ".xls");
		response.setCharacterEncoding("UTF-8");
		Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams(title, title),StorageGaslog.class, list);

		workbook.write(response.getOutputStream());
	}
}
