package com.dhc.fastersoft.controller.store;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.controller.BaseController;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.store.StoreFeedBack;
import com.dhc.fastersoft.entity.store.StoreFeedBackProblems;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysFile;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.service.store.StoreEnterpriseService;
import com.dhc.fastersoft.service.store.StoreFeedBackProblemsService;
import com.dhc.fastersoft.service.store.StoreFeedBackService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysFileService;
import com.dhc.fastersoft.service.system.SysRoleService;
import com.dhc.fastersoft.service.system.SysUserService;
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
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.*;


@Controller
@RequestMapping("StoreFeedBackAgent")
public class StoreFeedBackAgentController extends BaseController{
	
	@Autowired
    StoreFeedBackService storeFeedBackService;
	@Autowired
    StoreFeedBackProblemsService storeFeedBackProblemsService;
	 @Autowired
     SysDictService sysDictService;
	 @Autowired
     StoreEnterpriseService storeEnterpriseService;
	 @Autowired
     SysUserService sysUserService;
	 @Autowired
     StorageWarehouseService storageWarehouseService;
	 @Autowired
     SysRoleService sysRoleService;
	 @Autowired
     SysFileService sysFileService;
	 

	@SysLogAn("访问：代储监管-业务信息-问题反馈")
	 @RequestMapping("")
	public String index(HttpServletRequest request,ModelMap map) {
	
//		List<SysDict> storehouses = sysDictService.getSysDictListByType("储备粮库点");
//		map.put("storehouses", storehouses);
		map.put("supervise", 1);
//		//现获取用户的权限
//				Set<String> types = sysRoleService.findRoleTypeByUserId(TokenManager.getSysUserId());
//				for (String type : types) {
//					if (type.equals("代储管理员")) {
////						//通过分片监管区查找库点与库点负责人
//						List<StoreEnterprise> storeEnterprise = storeEnterpriseService.getStoreEnterpriseByUserId(TokenManager.getSysUserId());
//						if (storeEnterprise !=null&&storeEnterprise.size()==0) {
//							map.put("supervise", 0);
//						
//						}
//
//					}
//				}
//				List<SysDict> storehouses1 = new ArrayList<SysDict>() ;
//				//现获取用户的权限
//			
//				for (String type : types) {
//					 if (type.equals("库点管理员")) {
//						//去分片监管查库看监管的企业  通过企业编号唯一去查找库的名称
//						SysUser sysUser = 	sysUserService.selectByPrimaryKey(TokenManager.getSysUserId());
//						SysDict sysDict = new SysDict();
//						storehouses1.add(sysDict);
//						sysDict.setValue(TokenManager.getToken().getShortName());
//						map.put("storehouses", storehouses1);
//					
//					}
//				}
		
		 HashMap<String, Object> maps = new HashMap<>();						
			maps.put("warehouseType", "代储库");
			List<StorageWarehouse> storehouses = storageWarehouseService.listValidWarehouse(maps);
			map.put("storehouses", storehouses);
			map.put("falg", "");

		List kudianCodes = storageWarehouseService.listKudianCode();
		boolean isKudian = kudianCodes.contains(TokenManager.getToken().getOriginCode());
		//代储
		if("cbl".equals(TokenManager.getToken().getOriginCode().toLowerCase())){


		}else {
			if(!"".equals(TokenManager.getToken().getShortName())){
				if(isKudian){
					storehouses=storageWarehouseService.listSuperviseOfWarehouse(TokenManager.getToken().getShortName());
					map.put("storehouses", storehouses);
				}else {
					maps.put("warehouseId", TokenManager.getToken().getWareHouseId());
					int i = storageWarehouseService.check(maps);
					//自己  就要自评
					List<StorageWarehouse> storehouses1 = new ArrayList<StorageWarehouse>();
					if (i > 0) {
						storehouses1.add(storageWarehouseService.getWarehouseById(TokenManager.getToken().getWareHouseId()));
						map.put("storehouses", storehouses1);
						map.put("falg", "1");
					}
				}

			}
		}
		return "/StoreFeedBackAgent/storeFeedBack_list";
	}
	

	
	/**
	* 方法名 toAdd
	* 方法作用: 添加
	* 作者：张乐 
	* 修改时间: 2017年9月28日 下午5:03:12
	 */
	@RequestMapping("add")
	public String toAdd(HttpServletRequest request,ModelMap map){
		map.put("inspectorType", request.getParameter("inspectorType"));
//		//获取库点管理人的信息

		
		SysUser user= TokenManager.getToken();
		String shortName=user.getShortName();
//		List<SysDict> storehouses = sysDictService.getSysDictListByType("储备粮库点");
		 HashMap<String, Object> maps = new HashMap<>();						
			maps.put("warehouseType", "代储库");
			List<StorageWarehouse> storehouses = storageWarehouseService.listValidWarehouse(maps);
			map.put("storehouses", storehouses);
	
		map.put("storehouse", shortName);
		map.put("falg", "");
		List kudianCodes = storageWarehouseService.listKudianCode();
		boolean isKudian = kudianCodes.contains(TokenManager.getToken().getOriginCode());
		//代储

		if(!"".equals(TokenManager.getToken().getShortName())){
			if(isKudian){
				storehouses=storageWarehouseService.listSuperviseOfWarehouse(TokenManager.getToken().getShortName());
				map.put("storehouses", storehouses);
			}else {
				maps.put("warehouseId", TokenManager.getToken().getWareHouseId());
				int i = storageWarehouseService.check(maps);
				//自己  就要自评
				List<StorageWarehouse> storehouses1 = new ArrayList<StorageWarehouse>();
				if (i > 0) {
					storehouses1.add(storageWarehouseService.getWarehouseById(TokenManager.getToken().getWareHouseId()));
					map.put("storehouses", storehouses1);
					map.put("falg", "1");
				}
			}

		}
		return "/StoreFeedBackAgent/storeFeedBack_add";
	}
	
	 @RequestMapping(value="/select_examineSerial_list")
	 public String select_examineSerial_list(HttpServletRequest request,ModelMap map) {
		
		 HashMap<String, Object> maps = new HashMap<>();						
			maps.put("warehouseType", "代储库");
			List<StorageWarehouse> storehouses = storageWarehouseService.listValidWarehouse(maps);
			map.put("storehouses", storehouses);
		 map.put("storehouse", request.getParameter("storehouse"));
			
			return "/StoreFeedBackAgent/select_examineSerial_list";
		}
	/**
	* 方法名 edit
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年9月29日 下午5:59:25
	 */
	@RequestMapping("edit")
	public String edit(HttpServletRequest request,ModelMap map,String id){
		
		StoreFeedBack storeFeedBack = storeFeedBackService.getStoreFeedBackByID(id);
		map.addAttribute("storeFeedBack", storeFeedBack);
		List<StoreFeedBackProblems> storeFeedBackDeatils=storeFeedBackProblemsService.getStoreFeedBackProblemsByID(storeFeedBack.getFeedbackSerial());
		map.addAttribute("storeFeedBackDeatils", storeFeedBackDeatils);
		//获取库点管理人的信息

		
		SysUser user= TokenManager.getToken();
		String shortName=user.getShortName();
//		List<SysDict> storehouses = sysDictService.getSysDictListByType("储备粮库点");
		 HashMap<String, Object> maps = new HashMap<>();						
			maps.put("warehouseType", "代储库");
			List<StorageWarehouse> storehouses = storageWarehouseService.listValidWarehouse(maps);
			map.put("storehouses", storehouses);
	
		map.put("storehouse", shortName);
		map.put("falg", "");
		List kudianCodes = storageWarehouseService.listKudianCode();
		boolean isKudian = kudianCodes.contains(TokenManager.getToken().getOriginCode());
		//代储

		if(!"".equals(TokenManager.getToken().getShortName())){
			if(isKudian){
				storehouses=storageWarehouseService.listSuperviseOfWarehouse(TokenManager.getToken().getShortName());
				map.put("storehouses", storehouses);
			}else {
				maps.put("warehouseId", TokenManager.getToken().getWareHouseId());
				int i = storageWarehouseService.check(maps);
				//自己  就要自评
				List<StorageWarehouse> storehouses1 = new ArrayList<StorageWarehouse>();
				if (i > 0) {
					map.put("storehouses", storageWarehouseService.getWarehouseById(TokenManager.getToken().getWareHouseId()));
					map.put("falg", "1");
				}
			}

		}
		SysFile myFile=sysFileService.selectById(storeFeedBack.getGroupId());
		map.addAttribute("myFile", myFile);
		if(myFile!=null){
			String downloadUrl = myFile.getDownloadUrl();
			String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
			map.addAttribute("suffix", suffix);
		}
		return "/StoreFeedBackAgent/storeFeedBack_edit";
	}
	
	/**
	* 方法名 edit
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年9月29日 下午5:59:25
	 */
	@RequestMapping("view")
	public String view(HttpServletRequest request,ModelMap map,String id){
		map.put("inspectorType", request.getParameter("inspectorType"));
		StoreFeedBack storeFeedBack = storeFeedBackService.getStoreFeedBackByID(id);
		map.addAttribute("storeFeedBack", storeFeedBack);
		List<StoreFeedBackProblems> storeFeedBackDeatils=storeFeedBackProblemsService.getStoreFeedBackProblemsByID(storeFeedBack.getFeedbackSerial());
		map.addAttribute("storeFeedBackDeatils", storeFeedBackDeatils);
		List<SysDict> storehouses = sysDictService.getSysDictListByType("储备粮库点");
		map.put("storehouses", storehouses);
		SysFile myFile=sysFileService.selectById(storeFeedBack.getGroupId());
		map.addAttribute("myFile", myFile);
		if(myFile!=null){
			String downloadUrl = myFile.getDownloadUrl();
			String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
			map.addAttribute("suffix", suffix);
		}
		return "/StoreFeedBackAgent/storeFeedBack_view";
	}
	
	/**
	* 方法名 edit
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年9月29日 下午5:59:25
	 */
	@SysLogAn("代储监管-业务信息-问题反馈-导出")
	@RequestMapping("export")
	public String export(HttpServletRequest request,ModelMap map,String id, HttpServletResponse response){
		map.put("inspectorType", request.getParameter("inspectorType"));
		StoreFeedBack storeFeedBack = storeFeedBackService.getStoreFeedBackByID(id);
//		map.addAttribute("storeFeedBack", storeFeedBack);
//		List<StoreFeedBackProblems> storeFeedBackDeatils=storeFeedBackProblemsService.getStoreFeedBackProblemsByID(storeFeedBack.getFeedbackSerial());
//		map.addAttribute("storeFeedBackDeatils", storeFeedBackDeatils);
		String fileName = storeFeedBack.getStorehouse()+"问题反馈表.xls";
		try {
			fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		response.setCharacterEncoding("UTF-8");
		response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
		request.setAttribute("storeFeedBack", storeFeedBack);
		List<StoreFeedBackProblems> storeFeedBackDeatils=storeFeedBackProblemsService.getStoreFeedBackProblemsByID(storeFeedBack.getFeedbackSerial());
		map.addAttribute("storeFeedBackDeatils", storeFeedBackDeatils);
		return "/StoreFeedBackAgent/storeFeedBack_export";
	}

	@SysLogAn("代储监管-业务信息-问题反馈-打印")
	@RequestMapping("print")
	public String print(HttpServletRequest request,ModelMap map,String id){
		map.put("inspectorType", request.getParameter("inspectorType"));
		StoreFeedBack storeFeedBack = storeFeedBackService.getStoreFeedBackByID(id);
		map.addAttribute("storeFeedBack", storeFeedBack);
		List<StoreFeedBackProblems> storeFeedBackDeatils=storeFeedBackProblemsService.getStoreFeedBackProblemsByID(storeFeedBack.getFeedbackSerial());
		map.addAttribute("storeFeedBackDeatils", storeFeedBackDeatils);
		List<SysDict> storehouses = sysDictService.getSysDictListByType("储备粮库点");
		map.put("storehouses", storehouses);
		return "/StoreFeedBackAgent/storeFeedBack_print";
	}
	/**
	* 方法名 save
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年9月28日 下午5:03:37
	 */
	@RequestMapping(value="/Create",method={RequestMethod.POST})
	@ResponseBody
	public ActionResultModel Create(StoreFeedBack storeFeedBack, HttpServletRequest request, ModelMap modelMap, @RequestParam(value="file",required=false) MultipartFile[] files){
		//User user=(User) WebUtils.getSessionAttribute(request, "user");
		ActionResultModel actionResultModel = new ActionResultModel();
		storeFeedBack.setCreatorId(TokenManager.getSysUserId());
//		JSONObject ret = new JSONObject();
		String id = request.getParameter("id");
		String[] advises = request.getParameterValues("advise");
		String[] feedbackIds = request.getParameterValues("feedbackId");
		String[] descriptions = request.getParameterValues("description");
		String[] rectifications = request.getParameterValues("rectification");
		String[] types = request.getParameterValues("type");
//		String[] estimatedUnitPrices = request.getParameterValues("estimatedUnitPrice");
//		String[] remarks = request.getParameterValues("remark");
		storeFeedBack.setType("0");
		
		
//		Durables Durables = new Durables();
		try {
			if(files.length> 0){
				String  groupId=UUID.randomUUID().toString().replace("-", "");
				sysFileService.uploadFile(request, groupId, files[0], "storeFeedBack");
				storeFeedBack.setGroupId(groupId);	
			}
			if (id.length()==0) {
				storeFeedBack.setId(UUID.randomUUID().toString().replace("-", ""));
				storeFeedBack.setFeedbackSerial(this.getId());
				storeFeedBackService.add(storeFeedBack);
				sysLogService.add(request, "代储监管-业务信息-问题反馈-新增");
			}else {
				storeFeedBack.setId(id);
				storeFeedBackService.update(storeFeedBack);
				sysLogService.add(request, "代储监管-业务信息-问题反馈-修改");
			}
			//先删除所有附件
			storeFeedBackProblemsService.remove(storeFeedBack.getFeedbackSerial());
			
			if(advises!=null){
				for (int i = 0; i < feedbackIds.length; i++) {
					StoreFeedBackProblems storeFeedBackProblems =new StoreFeedBackProblems();
					storeFeedBackProblems.setSerial(storeFeedBack.getFeedbackSerial());
					storeFeedBackProblems.setAdvise(advises[i]);
					storeFeedBackProblems.setDescription(descriptions[i]);
					storeFeedBackProblems.setRectification(rectifications[i]);
					storeFeedBackProblems.setType(types[i]);
					storeFeedBackProblems.setFeedbackId(UUID.randomUUID().toString().replace("-", ""));					
					storeFeedBackProblemsService.add(storeFeedBackProblems);

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
	 * @描述 java生成流水号   
	 * 14位时间戳 + 6位随机数  
	 * @作者  
	 * @时间:2017-1-12 上午10:10:41  
	 * @参数:@return   
	 * @返回值：String  
	 */  
	public String getId(){    
	    String id="";   
	    //获取当前时间戳         
	    SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");    
	    String temp = sf.format(new Date());    
	    //获取6位随机数  
	    int random=(int) ((Math.random()+1)*1000);    
	    id=temp+random;    
	    return id;    
	} 

	
	/**
	* 方法名 list
	* 方法作用: 获取列表
	* 作者：张乐 
	* 修改时间: 2017年10月3日 下午8:11:08
	 */
	@RequestMapping(value="/list")
	@ResponseBody
	public LayPage<StoreFeedBack> list(HttpServletRequest request) {
		
		LayPage<StoreFeedBack> list = storeFeedBackService.list(request,"0");
		return list;
	}
	
	/**
	* 方法名 delete
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年10月3日 下午1:37:42
	 */
	@SysLogAn("代储监管-业务信息-问题反馈-删除")
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel delete(String id) {
		ActionResultModel actionResultModel = new ActionResultModel();
		int row=storeFeedBackService.remove(id);
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