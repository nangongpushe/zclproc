package com.dhc.fastersoft.controller.store;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.controller.BaseController;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.StoreSuperviseItem;
import com.dhc.fastersoft.entity.store.StoreExamine;
import com.dhc.fastersoft.entity.store.StoreExamineItem;
import com.dhc.fastersoft.entity.store.StoreTemplate;
import com.dhc.fastersoft.entity.store.StoreTemplateItem;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysFile;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.service.store.*;
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
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("StoreExamine")
public class StoreExamineController extends BaseController{

	 @Autowired
     StoreExamineService storeExamineService;
	 @Autowired
     StoreTemplateService storeTemplateService;
	 @Autowired
     StoreExamineItemService storeExamineItemService;
	 @Autowired
     SysFileService sysFileService;
	 @Autowired
     SysDictService sysDictService;
	 @Autowired
     SysRoleService sysRoleService;
	 @Autowired
     SysUserService sysUserService;
	 @Autowired
     StoreEnterpriseService storeEnterpriseService;
	 @Autowired
     StorageWarehouseService storageWarehouseService;
	 @Autowired
     StoreTemplateItemService storeTemplateItemService;

	 @SysLogAn("访问：仓储管理-粮库管理-考核评分管理")
	 @RequestMapping("")
		public String index(ModelMap map) {
		 
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
//			//现获取用户的权限
//			Set<String> types = sysRoleService.findRoleTypeByUserId(TokenManager.getSysUserId());
//			for (String type : types) {
//				 if (type.equals("库点管理员")) {
//					//去分片监管查库看监管的企业  通过企业编号唯一去查找库的名称
//					SysUser sysUser = 	sysUserService.selectByPrimaryKey(TokenManager.getSysUserId());
//					SysDict sysDict = new SysDict();
//					storehouses1.add(sysDict);
//					sysDict.setValue(sysUser.getCompany());
//					
//				
//				}
//			}
			return "/StoreExamine/storeExamine_list";
		}
		
	 @RequestMapping("/select_templet_list")
		public String selectDurablesList(HttpServletRequest request,ModelMap map)  {
		 map.put("type", request.getParameter("type"));
			return "/StoreExamine/select_templet_list";
		}
	 
	 @RequestMapping("/select_EnterpriseName_list")
		public String selectEnterpriseNamelist(HttpServletRequest request,ModelMap map)  {
			
			try {
				map.put("storehouse", URLDecoder.decode(request.getParameter("storehouse"), "UTF-8"));
			} catch (Exception e) {
				// TODO: handle exception
			}
			
		
			return "/StoreExamine/select_EnterpriseName_list";
		}
		
	
		/**
		* 方法名 toAdd
		* 方法作用: 添加
		* 作者：张乐 
		* 修改时间: 2017年9月28日 下午5:03:12
		 */
		@RequestMapping("add")
		public String toAdd(HttpServletRequest request,ModelMap map){
			map.put("examineSerial", this.getId());
			//获取库点管理人的信息
			//对数据进行权限上的控制
			SysUser user= TokenManager.getToken();
			String shortName=user.getShortName();
//			List<SysDict> storehouses = sysDictService.getSysDictListByType("储备粮库点");
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
			    	   storageWarehouse.setId(TokenManager.getToken().getWareHouseId());
			    	   storehouses1.add(storageWarehouse);
			    		map.put("storehouses", storehouses1);
			    		map.put("falg", "1");
			       }
				}
//			List<String> manangers = new ArrayList<String>();
//				for (SysDict sysDict : storehouses) {
//					HashMap<String, String> maps = new HashMap<String, String>();
//					maps.put("storeHouse", sysDict.getValue());
//					maps.put("type", "库点管理员");
//				List<SysUser> sysUsers = sysUserService.getListByStoreHouseAndType(maps);
//				if (sysUsers==null || sysUsers.size()==0) {
//					manangers.add("");
//				}else {
//					StringBuffer buf=new StringBuffer();
//					for (SysUser sysUser : sysUsers) {
//						buf.append(sysUser.getName());
//						buf.append(",");
//					}
//					if (buf.length()>0) {
//						manangers.add(buf.toString().substring(0, buf.toString().length()-1));
//					}
//					
//				}
//				
//			}
//
//			
//			map.put("manangers", manangers);
//			
//			//现获取用户的权限
//			//现获取用户的权限
//			Set<String> types = sysRoleService.findRoleTypeByUserId(TokenManager.getSysUserId());
//			for (String type : types) {
//				if (type.equals("代储管理员")) {
//					//通过分片监管区查找库点与库点负责人
//					List<StoreEnterprise> storeEnterprise = storeEnterpriseService.getStoreEnterpriseByUserId(TokenManager.getSysUserId());
//					if (storeEnterprise.size()!=0) {
//						map.put("wareHouse", storeEnterprise.get(0).getWareHouse());
//						HashMap<String, String> maps = new HashMap<String, String>();
//						maps.put("storeHouse", storeEnterprise.get(0).getWareHouse());
//						List<SysUser> sysUsers = sysUserService.getListByStoreHouseAndType(maps);
//						if (sysUsers==null || sysUsers.size()==0) {
//							map.put("mananger", "");
//						}else {
//							StringBuffer buf=new StringBuffer();
//							for (SysUser sysUser : sysUsers) {
//								buf.append(sysUser.getName());
//								buf.append(",");
//							}
//							if (buf.length()>0) {
//							
//								map.put("wareHouse", buf.toString().substring(0, buf.toString().length()-1));
//							}
//							
//						}
//						
//						
//						
//					}
//					
//				}else if (type.equals("库点管理员")) {
//					//去分片监管查库看监管的企业  通过企业编号唯一去查找库的名称
//					SysUser sysUser = 	sysUserService.selectByPrimaryKey(TokenManager.getSysUserId());
//					map.put("wareHouse", sysUser.getCompany());
//					map.put("mananger", sysUser.getName());
//				}
//			}
			
			return "/StoreExamine/storeExamine_add";
		}
		
		 
		/**
		* 方法名 edit
		* 方法作用: 
		* 作者：张乐 
		* 修改时间: 2017年9月29日 下午5:59:25
		 */
		@RequestMapping("edit")
		public String edit(HttpServletRequest request,ModelMap map,String id){
			StoreExamine StoreExamine = storeExamineService.getStoreExamineByID(id);
			map.addAttribute("storeExamine", StoreExamine);
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
					   storageWarehouse.setId(TokenManager.getToken().getWareHouseId());
			    	   storehouses1.add(storageWarehouse);
			    		map.put("storehouses", storehouses1);
			    		map.put("falg", "1");
			       }
				}
//			List<String> manangers = new ArrayList<String>();
//				for (SysDict sysDict : storehouses) {
//					HashMap<String, String> maps = new HashMap<String, String>();
//					maps.put("storeHouse", sysDict.getValue());
//					maps.put("type", "库点管理员");
//				List<SysUser> sysUsers = sysUserService.getListByStoreHouseAndType(maps);
//				if (sysUsers==null || sysUsers.size()==0) {
//					manangers.add("");
//				}else {
//					StringBuffer buf=new StringBuffer();
//					for (SysUser sysUser : sysUsers) {
//						buf.append(sysUser.getName());
//						buf.append(",");
//					}
//					if (buf.length()>0) {
//						manangers.add(buf.toString().substring(0, buf.toString().length()-1));
//					}
//					
//				}
//				
//			}
//
//			
//			map.put("manangers", manangers);
			SysFile sysFile=sysFileService.selectById(StoreExamine.getGroupId());
			if(sysFile!=null){
				String downloadUrl = sysFile.getDownloadUrl();
				String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
				map.addAttribute("suffix", suffix);
			}
			map.addAttribute("sysFile", sysFile);
			return "/StoreExamine/storeExamine_edit";
		}

		@SysLogAn("代储监管-业务信息-考核评分-打印")
		@RequestMapping("print")
		public String print(HttpServletRequest request,ModelMap map,String id){
			StoreExamine StoreExamine = storeExamineService.getStoreExamineByID(id);
			map.addAttribute("storeExamine", StoreExamine);
//			List<SysDict> storehouses = sysDictService.getSysDictListByType("储备粮库点");
//			map.put("storehouses", storehouses);
//			SysFile sysFile=sysFileService.selectById(StoreExamine.getGroupId());
//			map.addAttribute("sysFile", sysFile);
			return "/StoreExamine/storeExamine_print";
		}
		
		/**
		* 方法名 edit
		* 方法作用: 
		* 作者：张乐 
		* 修改时间: 2017年9月29日 下午5:59:25
		 */
		@RequestMapping("view")
		public String view(HttpServletRequest request,ModelMap map,String id){
			StoreExamine StoreExamine = storeExamineService.getStoreExamineByID(id);
			map.addAttribute("storeExamine", StoreExamine);
		/*	List<SysDict> storehouses = sysDictService.getSysDictListByType("储备粮库点");
			map.put("storehouses", storehouses);*/
			SysFile sysFile=sysFileService.selectById(StoreExamine.getGroupId());
			if(sysFile!=null){
				String downloadUrl = sysFile.getDownloadUrl();
				String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
				map.addAttribute("suffix", suffix);
			}
			map.addAttribute("sysFile", sysFile);
			return "/StoreExamine/storeExamine_view";
		}
		
		/**
		* 方法名 save
		* 方法作用: 
		* 作者：张乐 
		* 修改时间: 2017年9月28日 下午5:03:37
		 */
		@RequestMapping(value="/Create",method={RequestMethod.POST})
		@ResponseBody
		public ActionResultModel Create(StoreExamine storeExamine, HttpServletRequest request, ModelMap modelMap, @RequestParam(value="file",required=false) MultipartFile[] files){
			//User user=(User) WebUtils.getSessionAttribute(request, "user");
			
		
			ActionResultModel actionResultModel = new ActionResultModel();
//			if (storeExamine.getExamineType().equals("企业自评")) {
//				storeExamine.setStorehouse(request.getParameter("storehouse1"));
//			}
//			JSONObject ret = new JSONObject();
			String id = request.getParameter("id");

			storeExamine.setType("1");
//			StoreExamine StoreExamine = new StoreExamine();
			try {
	
				if(files.length> 0){
					String  groupId=UUID.randomUUID().toString().replace("-", "");
					sysFileService.uploadFile(request, groupId, files[0], "storeExamine");
					storeExamine.setGroupId(groupId);	
				}
				if (id.length()==0) {
					storeExamine.setId(UUID.randomUUID().toString().replace("-", ""));
					storeExamine.setCreatorId(TokenManager.getSysUserId());
					storeExamineService.add(storeExamine);
					sysLogService.add(request, "仓储管理-粮库管理-考核评分管理-新增");
				}else {
					storeExamine.setId(id);
					storeExamineService.update(storeExamine);
					sysLogService.add(request, "仓储管理-粮库管理-考核评分管理-修改");
				}
				
				//先删除所有选择
				String[] itemNames = request.getParameterValues("itemName");
				String[] points = request.getParameterValues("point");
				String[] standards = request.getParameterValues("standard");
				String[] parentIds = request.getParameterValues("parentId");
				
				
				//先删除所有附件
				storeExamineItemService.remove(storeExamine.getExamineSerial());
				
				if(standards!=null){
					for (int i = 0; i < standards.length; i++) {
						StoreExamineItem storeExamineItem = new StoreExamineItem();
						storeExamineItem.setId(UUID.randomUUID().toString().replace("-", ""));
						storeExamineItem.setItem(itemNames[i]);
						storeExamineItem.setPoint(points[i]);
						storeExamineItem.setStandard(standards[i]);
						storeExamineItem.setExamineId(storeExamine.getExamineSerial());
						storeExamineItem.setParentId(parentIds[i]);
						storeExamineItemService.add(storeExamineItem);
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
		public LayPage<StoreExamine> list(HttpServletRequest request) {
			
			LayPage<StoreExamine> list = storeExamineService.list(request,"1");
			return list;
		}
		/**
		* 方法名 list
		* 方法作用: 获取列表
		* 作者：张乐 
		* 修改时间: 2017年10月3日 下午8:11:08
		 */
		@RequestMapping(value="/list1")
		@ResponseBody
		public LayPage<StoreExamine> list1(HttpServletRequest request) {
			
			LayPage<StoreExamine> list = storeExamineService.list(request,"");
			return list;
		}
		
		@RequestMapping(value="/templetList")
		@ResponseBody
		public LayPage<StoreTemplate> selectTempletList(HttpServletRequest request) {
			
			LayPage<StoreTemplate> list = storeTemplateService.list(request);
			return list;
		}
		@RequestMapping(value="/get_EnterpriseName_list")
		@ResponseBody
		public LayPage<StoreSuperviseItem> getEnterpriseNamelist(HttpServletRequest request) {
			
			LayPage<StoreSuperviseItem> list = storeTemplateService.getEnterpriseNamelist(request);
			return list;
		}
		
		
		/**
		* 方法名 delete
		* 方法作用: 
		* 作者：张乐 
		* 修改时间: 2017年10月3日 下午1:37:42
		 */
		@SysLogAn("代储监管-业务信息-考核评分-删除")
		@RequestMapping(value="/remove",method=RequestMethod.POST)
		@ResponseBody
		public ActionResultModel delete(String id) {
			ActionResultModel actionResultModel = new ActionResultModel();
			int row=storeExamineService.remove(id);
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
		* 方法名 getStoreTemplateContent
		* 方法作用: 获取考核选项
		* 作者：张乐 
		* 修改时间: 2017年10月14日 下午1:41:39
		 */
		@RequestMapping(value="getStoreTemplate",method=RequestMethod.POST)
		@ResponseBody
		public ActionResultModel getStoreTemplate(String id, HttpServletRequest request, String templateId, String examineId) {
			ActionResultModel actionResultModel = new ActionResultModel();

			StoreTemplateItem storeTemplateItem0 = new StoreTemplateItem();
			String typeString="考评项目";
			if (request.getParameter("type").equals("1")) {
				//四化
				typeString="四化考评项目";
			}
			storeTemplateItem0.setItemName(typeString);
			
			
			//1.找到第一级节点
			List<StoreTemplateItem> storeTemplateItems = storeTemplateItemService.getOneClassList(templateId);
			storeTemplateItem0.setChildren(storeTemplateItems);
			//2.找到第2级节点
			for (StoreTemplateItem storeTemplateItem : storeTemplateItems) {
				Integer oneRowSpan=0;
				HashMap<String, Object> maps = new HashMap<String, Object>();
				maps.put("parentId", storeTemplateItem.getId());
				maps.put("templetId", templateId);
				List<StoreTemplateItem> storeTemplateItems2 = storeTemplateItemService.getTwoClassList(maps);
				storeTemplateItem.setChildren(storeTemplateItems2);
				//3.找到第3级节点
				for (StoreTemplateItem storeTemplateItem2 : storeTemplateItems2) {
					List<StoreExamineItem> storeTemplateItems3 =storeExamineItemService.getItemListByParentId(storeTemplateItem2.getId(), examineId);
					
					oneRowSpan=oneRowSpan+storeTemplateItems3.size();
					List<StoreTemplateItem> storeTemplateItems4 = new ArrayList<StoreTemplateItem>();
					for (StoreExamineItem storeExamineItem : storeTemplateItems3) {
						StoreTemplateItem templateItem = new StoreTemplateItem();
						 templateItem.setParentId(storeExamineItem.getParentId());
						 templateItem.setPoint(storeExamineItem.getPoint());
						 templateItem.setStandard(storeExamineItem.getStandard());
						 templateItem.setItemName(storeExamineItem.getItem());
						 storeTemplateItems4.add(templateItem);
					}
					storeTemplateItem2.setChildren(storeTemplateItems4);
				}
				storeTemplateItem.setRowspan(oneRowSpan);
		
			}
			actionResultModel.setData(storeTemplateItem0);
			actionResultModel.setSuccess(true);
			return actionResultModel;
		}
	
		@SysLogAn("代储监管-业务信息-考核评分-导出")
		@RequestMapping("export")
		public String export(HttpServletRequest request,ModelMap map,String id, HttpServletResponse response){
			StoreExamine StoreExamine = storeExamineService.getStoreExamineByID(id);
		
			
			ActionResultModel actionResultModel = new ActionResultModel();

			StoreTemplateItem storeTemplateItem0 = new StoreTemplateItem();
			String typeString="考评项目";
			if (request.getParameter("type").equals("1")) {
				//四化
				typeString="四化考评项目";
			}
			storeTemplateItem0.setItemName(typeString);
		
			
			//1.找到第一级节点
			List<StoreTemplateItem> storeTemplateItems = storeTemplateItemService.getOneClassList(StoreExamine.getExamineTemplet());
			storeTemplateItem0.setChildren(storeTemplateItems);
			//2.找到第2级节点
			for (StoreTemplateItem storeTemplateItem : storeTemplateItems) {
				Integer oneRowSpan=0;
				HashMap<String, Object> maps = new HashMap<String, Object>();
				maps.put("parentId", storeTemplateItem.getId());
				maps.put("templetId", StoreExamine.getExamineTemplet());
				List<StoreTemplateItem> storeTemplateItems2 = storeTemplateItemService.getTwoClassList(maps);
				storeTemplateItem.setChildren(storeTemplateItems2);
				//3.找到第3级节点
				for (StoreTemplateItem storeTemplateItem2 : storeTemplateItems2) {
					List<StoreExamineItem> storeTemplateItems3 =storeExamineItemService.getItemListByParentId(storeTemplateItem2.getId(), StoreExamine.getExamineSerial());
					
					oneRowSpan=oneRowSpan+storeTemplateItems3.size();
					List<StoreTemplateItem> storeTemplateItems4 = new ArrayList<StoreTemplateItem>();
					for (StoreExamineItem storeExamineItem : storeTemplateItems3) {
						StoreTemplateItem templateItem = new StoreTemplateItem();
						 templateItem.setParentId(storeExamineItem.getParentId());
						 templateItem.setPoint(storeExamineItem.getPoint());
						 templateItem.setStandard(storeExamineItem.getStandard());
						 templateItem.setItemName(storeExamineItem.getItem());
						 storeTemplateItems4.add(templateItem);
					}
					storeTemplateItem2.setChildren(storeTemplateItems4);
				}
				storeTemplateItem.setRowspan(oneRowSpan);
		
			}
			actionResultModel.setData(storeTemplateItem0);
			actionResultModel.setSuccess(true);
			map.put("data", actionResultModel);
			String fileName = "考核评分管理表.xls";
			try {
				fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
//			response.setCharacterEncoding("UTF-8");
			response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
			request.setAttribute("StoreExamine", StoreExamine);
			
			return "/StoreExamine/storeExamine_export";
		}
}
