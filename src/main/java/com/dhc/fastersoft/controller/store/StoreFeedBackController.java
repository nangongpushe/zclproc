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
import com.dhc.fastersoft.service.store.StoreExamineService;
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
@RequestMapping("StoreFeedBack")
public class StoreFeedBackController extends BaseController{
	
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
     SysRoleService sysRoleService;
	 @Autowired
     StoreExamineService storeExamineService;
	 @Autowired
     SysFileService sysFileService;
	 @Autowired
     StorageWarehouseService storageWarehouseService;

	 @SysLogAn("访问：仓储管理-粮库管理-问题反馈表管理")
	 @RequestMapping("")
	public String index(HttpServletRequest request,ModelMap map) {
	
//		List<SysDict> storehouses = sysDictService.getSysDictListByType("储备粮库点");
//		map.put("storehouses", storehouses);
//		List<SysDict> storehouses1 = new ArrayList<SysDict>() ;
//		//现获取用户的权限
//		Set<String> types = sysRoleService.findRoleTypeByUserId(TokenManager.getSysUserId());
//		for (String type : types) {
//			 if (type.equals("库点管理员")) {
//				//去分片监管查库看监管的企业  通过企业编号唯一去查找库的名称
//				SysUser sysUser = 	sysUserService.selectByPrimaryKey(TokenManager.getSysUserId());
//				SysDict sysDict = new SysDict();
//				storehouses1.add(sysDict);
//				sysDict.setValue(sysUser.getCompany());
//				map.put("storehouses", storehouses1);
//			
//			}
//		}
		 
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
		return "/StoreFeedBack/storeFeedBack_list";
	}
	
	 @RequestMapping(value="/select_examineSerial_list")
	 public String select_examineSerial_list(HttpServletRequest request,ModelMap map) {
		
		 HashMap<String, Object> maps = new HashMap<>();						
			maps.put("warehouseType", "储备库");
			List<StorageWarehouse> storehouses = storageWarehouseService.listValidWarehouse(maps);
			map.put("storehouses", storehouses);
		    map.put("storehouse", request.getParameter("storehouse"));
			
			return "/StoreFeedBack/select_examineSerial_list";
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
		SysUser user= TokenManager.getToken();
		String shortName=user.getShortName();
//		List<SysDict> storehouses = sysDictService.getSysDictListByType("储备粮库点");
		 HashMap<String, Object> maps = new HashMap<>();						
			maps.put("warehouseType", "储备库");
			List<StorageWarehouse> storehouses = storageWarehouseService.listValidWarehouse(maps);
			map.put("storehouses", storehouses);
	
		map.put("storehouse", shortName);
		map.put("falg", "");
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
//		//获取库点管理人的信息
//		List<SysDict> storehouses = sysDictService.getSysDictListByType("储备粮库点");
//		map.put("storehouses", storehouses);
//		List<String> manangers = new ArrayList<String>();
//			for (SysDict sysDict : storehouses) {
//				HashMap<String, String> maps = new HashMap<String, String>();
//				maps.put("storeHouse", sysDict.getValue());
//				maps.put("type", "库点管理员");
//			List<SysUser> sysUsers = sysUserService.getListByStoreHouseAndType(maps);
//			if (sysUsers==null || sysUsers.size()==0) {
//				manangers.add("");
//			}else {
//				StringBuffer buf=new StringBuffer();
//				for (SysUser sysUser : sysUsers) {
//					buf.append(sysUser.getName());
//					buf.append(",");
//				}
//				if (buf.length()>0) {
//					manangers.add(buf.toString().substring(0, buf.toString().length()-1));
//				}
//				
//			}
//			
//		}
//
//		
//		map.put("manangers", manangers);
//		
//		//现获取用户的权限
//		//现获取用户的权限
//		Set<String> types = sysRoleService.findRoleTypeByUserId(TokenManager.getSysUserId());
//		for (String type : types) {
//			if (type.equals("代储管理员")) {
//				//通过分片监管区查找库点与库点负责人
//				List<StoreEnterprise> storeEnterprise = storeEnterpriseService.getStoreEnterpriseByUserId(TokenManager.getSysUserId());
//				if (storeEnterprise.size()!=0) {
//					map.put("wareHouse", storeEnterprise.get(0).getWareHouse());
//					HashMap<String, String> maps = new HashMap<String, String>();
//					maps.put("storeHouse", storeEnterprise.get(0).getWareHouse());
//					List<SysUser> sysUsers = sysUserService.getListByStoreHouseAndType(maps);
//					if (sysUsers==null || sysUsers.size()==0) {
//						map.put("mananger", "");
//					}else {
//						StringBuffer buf=new StringBuffer();
//						for (SysUser sysUser : sysUsers) {
//							buf.append(sysUser.getName());
//							buf.append(",");
//						}
//						if (buf.length()>0) {
//						
//							map.put("wareHouse", buf.toString().substring(0, buf.toString().length()-1));
//						}
//						
//					}
//					
//					
//					
//				}
//				
//			}else if (type.equals("库点管理员")) {
//				//去分片监管查库看监管的企业  通过企业编号唯一去查找库的名称
//				SysUser sysUser = 	sysUserService.selectByPrimaryKey(TokenManager.getSysUserId());
//				map.put("wareHouse", sysUser.getCompany());
//				map.put("mananger", sysUser.getName());
//			}
//		}
		List<SysUser> listSysUser=sysUserService.getList();
		map.addAttribute("listSysUser", listSysUser);
		return "/StoreFeedBack/storeFeedBack_add";
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
//		//获取库点管理人的信息
//		List<SysDict> storehouses = sysDictService.getSysDictListByType("储备粮库点");
//		map.put("storehouses", storehouses);
//		List<String> manangers = new ArrayList<String>();
//			for (SysDict sysDict : storehouses) {
//				HashMap<String, String> maps = new HashMap<String, String>();
//				maps.put("storeHouse", sysDict.getValue());
//				maps.put("type", "库点管理员");
//			List<SysUser> sysUsers = sysUserService.getListByStoreHouseAndType(maps);
//			if (sysUsers==null || sysUsers.size()==0) {
//				manangers.add("");
//			}else {
//				StringBuffer buf=new StringBuffer();
//				for (SysUser sysUser : sysUsers) {
//					buf.append(sysUser.getName());
//					buf.append(",");
//				}
//				if (buf.length()>0) {
//					manangers.add(buf.toString().substring(0, buf.toString().length()-1));
//				}
//				
//			}
//			
//		}
//
//		
//		map.put("manangers", manangers);
		
		//获取库点管理人的信息
		SysUser user= TokenManager.getToken();
		String shortName=user.getShortName();
		 HashMap<String, Object> maps = new HashMap<>();						
			maps.put("warehouseType", "储备库");
			List<StorageWarehouse> storehouses = storageWarehouseService.listValidWarehouse(maps);
			map.put("storehouses", storehouses);
		map.put("storehouse", shortName);
		map.put("falg", "");
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
		List<SysUser> listSysUser=sysUserService.getList();
		map.addAttribute("listSysUser", listSysUser);
		SysFile sysFile=sysFileService.selectById(storeFeedBack.getGroupId());
		if(sysFile!=null){
			String downloadUrl = sysFile.getDownloadUrl();
			String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
			map.addAttribute("suffix", suffix);
		}
		map.addAttribute("sysFile", sysFile);
		return "/StoreFeedBack/storeFeedBack_edit";
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
		SysFile sysFile=sysFileService.selectById(storeFeedBack.getGroupId());
		if(sysFile!=null){
			String downloadUrl = sysFile.getDownloadUrl();
			String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
			map.addAttribute("suffix", suffix);
		}
		map.addAttribute("sysFile", sysFile);
		return "/StoreFeedBack/storeFeedBack_view";
	}
	
	/**
	* 方法名 edit
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年9月29日 下午5:59:25
	 */
	@SysLogAn("仓储管理-粮库管理-问题反馈表管理-导出")
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
	
	@RequestMapping("print")
	public String print(HttpServletRequest request,ModelMap map,String id){
		map.put("inspectorType", request.getParameter("inspectorType"));
		StoreFeedBack storeFeedBack = storeFeedBackService.getStoreFeedBackByID(id);
		map.addAttribute("storeFeedBack", storeFeedBack);
		List<StoreFeedBackProblems> storeFeedBackDeatils=storeFeedBackProblemsService.getStoreFeedBackProblemsByID(storeFeedBack.getFeedbackSerial());
		map.addAttribute("storeFeedBackDeatils", storeFeedBackDeatils);
		List<SysDict> storehouses = sysDictService.getSysDictListByType("储备粮库点");
		map.put("storehouses", storehouses);
		return "/StoreFeedBack/storeFeedBack_print";
	}

	@RequestMapping("select_user_list")
	public String select_user_list(HttpServletRequest request,ModelMap map,String id){

	    List<StorageWarehouse> list= storageWarehouseService.getWarehouseCode(request.getParameter("storehouse"));
		if(list != null && list.size() > 0){
			map.addAttribute("originCode",list.get(0).getWarehouseCode());
		}
		if (request.getParameter("temp_page")!=null){
			if(request.getParameter("temp_page").equals("durables_add")){ // 从设备入库保管负责人
				map.addAttribute("pge",request.getParameter("temp_page"));
			}
			if(request.getParameter("temp_page").equals("guardian")){ // 从设备入库维护负责人
				map.addAttribute("guardian",request.getParameter("temp_page"));
			}
			if(request.getParameter("temp_page").equals("operator")){ // 从设备入库操作负责人
				map.addAttribute("operator",request.getParameter("temp_page"));
			}
			if(request.getParameter("temp_page").equals("custodian")){ // 从易耗品保管员
				map.addAttribute("custodian",request.getParameter("temp_page"));
			}
			if(request.getParameter("temp_page").equals("inspectorManager")){ // 从问题反馈表管理检查组负责人
				map.addAttribute("inspectorManager",request.getParameter("temp_page"));
			}
			if(request.getParameter("temp_page").equals("inspectors")){ // 从问题反馈表管理检查人员
				map.addAttribute("inspectors",request.getParameter("temp_page"));
			}

		}
		return "/StoreFeedBack/select_sysUser_list";
	}

	@RequestMapping("getUserList")
	public String getUserList(ModelMap modelMap, String warehouseId){
		StorageWarehouse warehouse = storageWarehouseService.getWarehouseById(warehouseId);
		if(warehouse != null){
			modelMap.addAttribute("originCode",warehouse.getWarehouseCode());
		}
		return "/StoreFeedBack/select_sysUser_list";
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
//		storeFeedBack.setWarehouseId(TokenManager.getToken().getWareHouseId());
//		if (storeFeedBack.getInspectorType().equals("自评")) {
//			storeFeedBack.setStorehouse(request.getParameter("storehouse1"));
//		}
//		JSONObject ret = new JSONObject();
		String id = request.getParameter("id");
		String[] advises = request.getParameterValues("advise");
		String[] feedbackIds = request.getParameterValues("feedbackId");
		String[] descriptions = request.getParameterValues("description");
		String[] rectifications = request.getParameterValues("rectification");
		String[] types = request.getParameterValues("type");
//		String[] estimatedUnitPrices = request.getParameterValues("estimatedUnitPrice");
//		String[] remarks = request.getParameterValues("remark");
		
		storeFeedBack.setType("1");
		
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
				sysLogService.add(request, "仓储管理-粮库管理-问题反馈表管理-新增");
			}else {
				storeFeedBack.setId(id);
				storeFeedBackService.update(storeFeedBack);
				sysLogService.add(request, "仓储管理-粮库管理-问题反馈表管理-修改");
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
		
		LayPage<StoreFeedBack> list = storeFeedBackService.list(request,"1");
		return list;
	}
	
	/**
	* 方法名 delete
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年10月3日 下午1:37:42
	 */
	@SysLogAn("仓储管理-粮库管理-问题反馈表管理-删除")
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