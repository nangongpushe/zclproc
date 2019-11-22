package com.dhc.fastersoft.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.StorageWarehouseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.page.PageList;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.Consumables;
import com.dhc.fastersoft.entity.system.SysFile;
import com.dhc.fastersoft.service.ConsumablesService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysFileService;
import com.dhc.fastersoft.utils.LayPage;


/**
* @ClassName: ConsumablesController
* @Description: 易耗品
* @author 张乐
* @date 2017年9月28日 下午2:53:43
 */
@Controller
@RequestMapping("/Consumables")
public class ConsumablesController extends BaseController{
	@Autowired 
	ConsumablesService consumablesService;
	@Autowired
	SysFileService sysFileService;
	 @Autowired
	 SysDictService sysDictService;
	@Autowired
	StorageWarehouseService storageWarehouseService;
	
	 @RequestMapping("index")
	public String index(ModelMap map){
//		 List<SysDict> storehouses = sysDictService.getSysDictListByType("储备粮库点");
//			map.put("storehouses", storehouses);

		 HashMap<String, Object> maps = new HashMap<>();
		 maps.put("warehouseType", "储备库");
		 List<StorageWarehouse> storehouses = storageWarehouseService.listValidWarehouse(maps);
		 map.put("storehouses", storehouses);
		 map.put("falg", "");

		 if(!TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")){


			 maps.put("warehouseShort",  TokenManager.getToken().getShortName());
			 int i= storageWarehouseService.check(maps);
			 List<StorageWarehouse> storehouses1 = new ArrayList<StorageWarehouse>() ;
			 if (i>0) {
				 StorageWarehouse storageWarehouse = new StorageWarehouse();
				 storageWarehouse.setWarehouseShort(TokenManager.getToken().getShortName());
				 storehouses1.add(storageWarehouse);
				 map.put("storehouses", storehouses1);
				 map.put("falg", "1");
			 }
		 }
		return "/Consumables/consumables_list";
	}

	@SysLogAn("访问：物资管理-库存管理-易耗品入库")
	 @RequestMapping("")
		public String main(ModelMap map){

		 HashMap<String, Object> maps = new HashMap<>();
		 maps.put("warehouseType", "储备库");
		 List<StorageWarehouse> storehouses = storageWarehouseService.listValidWarehouse(maps);
		 map.put("storehouses", storehouses);
		 map.put("falg", "");

		 if(!TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")){


			 maps.put("warehouseShort",  TokenManager.getToken().getShortName());
			 int i= storageWarehouseService.check(maps);
			 List<StorageWarehouse> storehouses1 = new ArrayList<StorageWarehouse>() ;
			 if (i>0) {
				 StorageWarehouse storageWarehouse = new StorageWarehouse();
				 storageWarehouse.setWarehouseShort(TokenManager.getToken().getShortName());
				 storehouses1.add(storageWarehouse);
				 map.put("storehouses", storehouses1);
				 map.put("falg", "1");
			 }
		 }
			return "/Consumables/consumables_list";
		}
	
	/**
	* 方法名 pageQuery
	* 方法作用: 查询列表
	* 作者：张乐 
	* 修改时间: 2017年9月28日 下午5:02:41
	 */
	@RequestMapping(value="/pageQuery")
	public Object pageQuery(HttpServletRequest request) {
		
		ActionResultModel actionResultModel = new ActionResultModel();
		PageList list = consumablesService.pageQuery(request);
		actionResultModel.setData(list);
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}
	
	/**
	* 方法名 toAdd
	* 方法作用: 添加
	* 作者：张乐 
	* 修改时间: 2017年9月28日 下午5:03:12
	 */
	@RequestMapping("add")
	public String toAdd(HttpServletRequest request,ModelMap map){
		HashMap<String, Object> maps = new HashMap<>();
		maps.put("warehouseType", "储备库");
		List<StorageWarehouse> storehouses = storageWarehouseService.listValidWarehouse(maps);
		map.put("storehouses", storehouses);
		map.put("falg", "");
		SysUser user = TokenManager.getToken();

		if(!TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")){


			maps.put("warehouseShort",  TokenManager.getToken().getShortName());
			int i= storageWarehouseService.check(maps);
			List<StorageWarehouse> storehouses1 = new ArrayList<StorageWarehouse>() ;
			if (i>0) {
				StorageWarehouse storageWarehouse = new StorageWarehouse();
				storageWarehouse.setWarehouseShort(TokenManager.getToken().getShortName());
				storageWarehouse.setId(user.getWareHouseId());
				storehouses1.add(storageWarehouse);
				map.put("storehouses", storehouses1);
				map.put("falg", "1");
			}
		}
		return "/Consumables/consumables_add";
	}
	
	/**
	* 方法名 edit
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年9月29日 下午5:59:25
	 */
	@RequestMapping("edit")
	public String edit(HttpServletRequest request,ModelMap map,String id){
		HashMap<String, Object> maps = new HashMap<>();
		maps.put("warehouseType", "储备库");
		List<StorageWarehouse> storehouses = storageWarehouseService.listValidWarehouse(maps);
		map.put("storehouses", storehouses);
		map.put("falg", "");

		if(!TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")){


			maps.put("warehouseShort",  TokenManager.getToken().getShortName());
			int i= storageWarehouseService.check(maps);
			List<StorageWarehouse> storehouses1 = new ArrayList<StorageWarehouse>() ;
			if (i>0) {
				StorageWarehouse storageWarehouse = new StorageWarehouse();
				storageWarehouse.setWarehouseShort(TokenManager.getToken().getShortName());
				storageWarehouse.setId(TokenManager.getToken().getWareHouseId());
				storehouses1.add(storageWarehouse);
				map.put("storehouses", storehouses1);
				map.put("falg", "1");
			}
		}
		Consumables consumables = consumablesService.getConsumablesByID(id);
		map.addAttribute("consumables", consumables);
		/*List<SysFile> sysFiles=sysFileService.getFilesByGroupId(consumables.getGroupId());*/

		List<SysFile> sysFiles = null;
		if(consumables.getGroupId() != null) {
			sysFiles = sysFileService.getFilesByGroupId(consumables.getGroupId());
			if(sysFiles!=null){
				Map filemap = new HashMap();
				for (SysFile file:sysFiles){
					String downloadUrl = file.getDownloadUrl();
					String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
					filemap.put(file.getId(),suffix);
					map.addAttribute("suffixMap", filemap);
				}
			}
		}
		map.addAttribute("sysFiles", sysFiles);
		return "/Consumables/consumables_edit";
	}
	
	/**
	* 方法名 edit
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年9月29日 下午5:59:25
	 */
	@RequestMapping("view")
	public String view(HttpServletRequest request,ModelMap map,String id){
		Consumables consumables = consumablesService.getConsumablesByID(id);
		map.addAttribute("consumables", consumables);
		/*List<SysFile> sysFiles=sysFileService.getFilesByGroupId(consumables.getGroupId());
		map.addAttribute("sysFiles", sysFiles);*/
		List<SysFile> sysFiles = null;
		if(consumables.getGroupId() != null) {
			sysFiles = sysFileService.getFilesByGroupId(consumables.getGroupId());
			if(sysFiles!=null){
				Map filemap = new HashMap();
				for (SysFile file:sysFiles){
					String downloadUrl = file.getDownloadUrl();
					String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
					filemap.put(file.getId(),suffix);
					map.addAttribute("suffixMap", filemap);
				}
			}
		}
		map.addAttribute("sysFiles", sysFiles);
		return "/Consumables/consumables_view";
	}
	
	/**
	* 方法名 save
	* 方法作用: 保存易耗品
	* 作者：张乐 
	* 修改时间: 2017年9月28日 下午5:03:37
	 */
	@RequestMapping(value="/Create",method={RequestMethod.POST})
	@ResponseBody
	public ActionResultModel Create(Consumables consumables,  HttpServletRequest request,ModelMap modelMap,@RequestParam(value="file",required=false) MultipartFile[] files){
		String userId = TokenManager.getNickname();
		ActionResultModel actionResultModel = new ActionResultModel();
//		JSONObject ret = new JSONObject();
		String id = request.getParameter("id");
		
//		Consumables consumables = new Consumables();
		try {
			if (id.length()==0) {
				consumables.setId(UUID.randomUUID().toString().replace("-", ""));
			}else {
				consumables.setId(id);
			}
			if(files.length>= 0){
				String groupId = request.getParameter("groupId");	
				groupId=sysFileService.uploadFiles(request, groupId, files, "Durables");
				consumables.setGroupId(groupId);	
			}
		
			consumables.setCreator(userId);

			if (id.length()==0) {
				consumablesService.add(consumables);
				sysLogService.add(request, "物资管理-库存管理-易耗品入库-新增");
			}else {
				consumablesService.update(consumables);
				sysLogService.add(request, "物资管理-库存管理-易耗品入库-修改");
			}
			
			actionResultModel.setSuccess(true);
		} catch (Exception e) {
			actionResultModel.setSuccess(false);
			e.printStackTrace();
		}
		
		 return actionResultModel;
	}
	
	
	/**
	* 方法名 updateApply
	* 方法作用: 更新领取
	* 作者：张乐 
	* 修改时间: 2017年9月28日 下午5:03:37
	 */
	@SysLogAn("物资管理-库存管理-易耗品入库-领取")
	@RequestMapping(value="/updateApply")
	@ResponseBody
	public ActionResultModel updateApply( Consumables consumables, HttpServletRequest request,ModelMap modelMap){
		//User user=(User) WebUtils.getSessionAttribute(request, "user");
		ActionResultModel actionResultModel = new ActionResultModel();
//		String id = request.getParameter("id");
//		
//		 consumables = new Consumables();
		try {
//			consumables.setId(id);
//			consumables.setApply(Integer.valueOf(request.getParameter("apply")));
//			consumables.setSurplus(Integer.valueOf(request.getParameter("surplus")));
//			consumables.setTotalApply(Integer.valueOf(request.getParameter("totalApply")));
			consumablesService.updateApply(consumables);		
			actionResultModel.setSuccess(true);
//			ret.put("success", true);
		} catch (Exception e) {
			// TODO: handle exception
			actionResultModel.setSuccess(false);
			e.printStackTrace();
		}
		
		return actionResultModel;
	}
	
	
	@RequestMapping(value="/list")
	@ResponseBody
	public LayPage<Consumables> list(HttpServletRequest request) {
		
		LayPage<Consumables> list = consumablesService.list(request);
		return list;
	}
	
	/**
	* 方法名 delete
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年10月3日 下午1:37:42
	 */
	@SysLogAn("物资管理-库存管理-易耗品入库-删除")
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel delete(String id) {
		ActionResultModel actionResultModel = new ActionResultModel();
		int row=consumablesService.remove(id);
		if(row>0) {
			actionResultModel.setSuccess(true);
			actionResultModel.setMsg("删除成功");
		}else {
			actionResultModel.setSuccess(false);
			actionResultModel.setMsg("删除失败");
		}
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}
	
}
