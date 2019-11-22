
package com.dhc.fastersoft.controller;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.page.PageList;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.StorageWarehouseDao;
import com.dhc.fastersoft.entity.Durables;
import com.dhc.fastersoft.entity.DurablesOptions;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysFile;
import com.dhc.fastersoft.service.DurablesOptionsService;
import com.dhc.fastersoft.service.DurablesService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysFileService;
import com.dhc.fastersoft.utils.LayPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;


/**
* @ClassName: DurablesController
* @Description: 非易耗
* @author 张乐
* @date 2017年9月28日 下午2:41:47
 */
@Controller
@RequestMapping("/Durables")
public class DurablesController extends BaseController{
	@Autowired 
	DurablesService durablesService;
	@Autowired
	DurablesOptionsService DurablesOptionsService;
	@Autowired
	SysFileService sysFileService;
	 @Autowired
	 SysDictService sysDictService;
	@Autowired
	StorageWarehouseDao storageWarehouseDao;
	 @RequestMapping("index")
	public String index(ModelMap map){
		 List<SysDict> storehouses = sysDictService.getSysDictListByType("储备粮库点");
			map.put("storehouses", storehouses);
		return "/Durables/durables_list";
	}
	@SysLogAn("访问：物资管理-库存管理-设备入库")
	 @RequestMapping("")
		public String main(ModelMap map){
			/* List<SysDict> storehouses = sysDictService.getSysDictListByType("储备粮库点");
				map.put("storehouses", storehouses);*/
			List<StorageWarehouse> storehouses = new ArrayList<StorageWarehouse>();
			//获取6个库点编码
			List kudianCodes = storageWarehouseDao.listKudianCode();
			String originCode=TokenManager.getToken().getOriginCode();
			boolean isKudian = kudianCodes.contains(originCode);
			if(isKudian){
				StorageWarehouse sd=new StorageWarehouse();
				sd.setWarehouseShort(TokenManager.getToken().getShortName());
				sd.setId(TokenManager.getToken().getWareHouseId());
				storehouses.add(sd);
			}else {
	//			storehouses = sysDictService.getSysDictListByType("储备粮库点");
				HashMap<String, Object> maps = new HashMap<>();
				maps.put("warehouseType", "储备库");
				storehouses = storageWarehouseDao.listValidWarehouse(maps);
			}
			map.put("storehouses", storehouses);
			return "/Durables/durables_list";
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
		PageList list = durablesService.pageQuery(request);
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
		List<StorageWarehouse> storehouses = new ArrayList<>();
		//获取6个库点编码
		List kudianCodes = storageWarehouseDao.listKudianCode();
		String originCode=TokenManager.getToken().getOriginCode();
		boolean isKudian = kudianCodes.contains(originCode);
		if(isKudian){
			StorageWarehouse sd=new StorageWarehouse();
			sd.setWarehouseShort(TokenManager.getToken().getShortName());
			sd.setId(TokenManager.getToken().getWareHouseId());
			storehouses.add(sd);
		}else {
//			storehouses = sysDictService.getSysDictListByType("储备粮库点");
			HashMap<String, Object> maps = new HashMap<>();
			maps.put("warehouseType", "储备库");
			storehouses = storageWarehouseDao.listValidWarehouse(maps);
		}
		map.put("storehouses", storehouses);
		List<SysDict> states = sysDictService.getSysDictListByType("目前状态");
		 map.put("states", states);
		return "/Durables/durables_add";
	}
	
	/**
	* 方法名 edit
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年9月29日 下午5:59:25
	 */
	@RequestMapping("edit")
	public String edit(HttpServletRequest request,ModelMap map,String id){
		List<StorageWarehouse> storehouses = new ArrayList<StorageWarehouse>();
		//获取6个库点编码
		List kudianCodes = storageWarehouseDao.listKudianCode();
		String originCode=TokenManager.getToken().getOriginCode();
		boolean isKudian = kudianCodes.contains(originCode);
		if(isKudian){
			StorageWarehouse sd=new StorageWarehouse();
			sd.setWarehouseShort(TokenManager.getToken().getShortName());
			sd.setId(TokenManager.getToken().getWareHouseId());
			storehouses.add(sd);
		}else {
//			storehouses = sysDictService.getSysDictListByType("储备粮库点");
			HashMap<String, Object> maps = new HashMap<>();
			maps.put("warehouseType", "储备库");
			storehouses = storageWarehouseDao.listValidWarehouse(maps);
		}
		map.put("storehouses", storehouses);
		Durables durables = durablesService.getDurablesByID(id);
		map.addAttribute("durables", durables);
		List<SysFile> sysFiles=sysFileService.getFilesByGroupId(durables.getGroupId());
		map.addAttribute("sysFiles", sysFiles);
		List<DurablesOptions> durablesOptions=DurablesOptionsService.getDurablesOptionsByID(id);
		map.addAttribute("durablesOptions", durablesOptions);
		 List<SysDict> states = sysDictService.getSysDictListByType("目前状态");
		 map.put("states", states);
		return "/Durables/durables_edit";
	}
	
	/**
	* 方法名 edit
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年9月29日 下午5:59:25
	 */
	@RequestMapping("view")
	public String view(HttpServletRequest request,ModelMap map,String id){
		Durables durables = durablesService.getDurablesByID(id);
		map.addAttribute("durables", durables);
		List<SysFile> sysFiles=sysFileService.getFilesByGroupId(durables.getGroupId());
		map.addAttribute("sysFiles", sysFiles);
		List<DurablesOptions> durablesOptions=DurablesOptionsService.getDurablesOptionsByID(id);
		map.addAttribute("durablesOptions", durablesOptions);
		return "/Durables/durables_view";
	}
	
	/**
	* 方法名 save
	* 方法作用: 保存易耗品
	* 作者：张乐 
	* 修改时间: 2017年9月28日 下午5:03:37
	 */
	@RequestMapping(value="/Create",method={RequestMethod.POST})
	@ResponseBody
	public ActionResultModel Create(Durables durables,  HttpServletRequest request,ModelMap modelMap,@RequestParam(value="file",required=false) MultipartFile[] files){
		//User user=(User) WebUtils.getSessionAttribute(request, "user");
		
		String userId = TokenManager.getNickname();
		ActionResultModel actionResultModel = new ActionResultModel();
//		JSONObject ret = new JSONObject();
		String id = request.getParameter("id");
		String[] durablesIds = request.getParameterValues("durablesId");
		String[] optionModels = request.getParameterValues("optionModel");
		String[] optionNames = request.getParameterValues("optionName");
		String[] optionNums = request.getParameterValues("optionNum");
		String[] optionPlaces = request.getParameterValues("optionPlace");
		
		
//		Durables Durables = new Durables();
		try {
			
				if(files.length>= 0){
					String groupId = request.getParameter("groupId");
					/*for(MultipartFile file : files){
						//获取文件名称
						String fileName = file.getOriginalFilename();
						String prefix=fileName.substring(fileName.lastIndexOf(".")+1);//获取文件后缀
						if (!prefix.equals("bmp")&&!prefix.equals("jpeg")&&!prefix.equals("jpg")&&!prefix.equals("png")&&!prefix.equals("image")){
							actionResultModel.setSuccess(false);
							actionResultModel.setMsg("请上传图片");
							return actionResultModel;
						}

					}*/
					groupId=sysFileService.uploadFiles(request, groupId, files, "Durables");
					durables.setGroupId(groupId);	
				}
			
//			durables.setOperator(userId);
			if (id.length()==0) {
				
				if (durablesService.getEncodeCount(durables.getEncode())==0) {
					durables.setId(UUID.randomUUID().toString().replace("-", ""));
					durablesService.add(durables);
				}else {
					actionResultModel.setSuccess(false);
					actionResultModel.setData("物资编码已存在!");
				}
				sysLogService.add(request, "物资管理-库存管理-设备入库-新增");
			}else {
				durables.setId(id);
				durablesService.update(durables);
				sysLogService.add(request, "物资管理-库存管理-设备入库-修改");
			}
			//先删除所有附件
			DurablesOptionsService.remove(durables.getId());
			
			if(durablesIds!=null){
				for (int i = 0; i < durablesIds.length; i++) {
					DurablesOptions durablesOptions =new DurablesOptions();
					durablesOptions.setDurablesId(durables.getId());
					durablesOptions.setOptionModel(optionModels[i]);
					durablesOptions.setOptionName(optionNames[i]);
					durablesOptions.setOptionPlace(optionPlaces[i]);
					if (!optionNums[i].equals("")) {
						durablesOptions.setOptionNum(Integer.valueOf(optionNums[i]));
					}				
					durablesOptions.setId(UUID.randomUUID().toString().replace("-", ""));					
					DurablesOptionsService.add(durablesOptions);
//					if (durablesIds[i].length()==0) {
//						durablesOptions.setId(UUID.randomUUID().toString().replace("-", ""));					
//						DurablesOptionsService.add(durablesOptions);
//					}else {
//						durablesOptions.setId(durablesIds[i]);	
//						DurablesOptionsService.update(durablesOptions);
//					}
				}
			}
			
			
			actionResultModel.setSuccess(true);
		} catch (Exception e) {
			actionResultModel.setSuccess(false);
			e.printStackTrace();
		}
		
		 return actionResultModel;
	}
	
	

	
	/**
	* 方法名 list
	* 方法作用: 获取列表
	* 作者：张乐 
	* 修改时间: 2017年10月3日 下午8:11:08
	 */
	@RequestMapping(value="/list")
	@ResponseBody
	public LayPage<Durables> list(HttpServletRequest request) {
		
		LayPage<Durables> list = durablesService.list(request);
		return list;
	}
	/**
	* 方法名 delete
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年10月3日 下午1:37:42
	 */
	@SysLogAn("物资管理-库存管理-设备入库-删除")
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel delete(String id) {
		ActionResultModel actionResultModel = new ActionResultModel();
		int row=durablesService.remove(id);
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
