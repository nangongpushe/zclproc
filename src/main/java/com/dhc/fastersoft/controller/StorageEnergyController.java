package com.dhc.fastersoft.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dhc.fastersoft.common.SysLogAn;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.StorageEnergy;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.service.StorageEnergyService;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysRoleService;
import com.dhc.fastersoft.service.system.SysUserService;
import com.dhc.fastersoft.utils.FileUtil;
import com.dhc.fastersoft.utils.LayPage;

@Controller
@RequestMapping("/StorageEnergy")
public class StorageEnergyController {
    @Autowired    
    StorageEnergyService storageEnergyService;
    @Autowired
	 SysDictService sysDictService;
	 @Autowired
	 SysRoleService sysRoleService;
	 @Autowired
	 SysUserService sysUserService;
	 @Autowired
	 StorageWarehouseService storageWarehouseService;

	 @SysLogAn("访问：仓库管理-能耗管理")
	 @RequestMapping("")
		public String index(ModelMap map) {
//			List<SysDict> storehouses = sysDictService.getSysDictListByType("储备粮库点");
//			map.put("storehouses", storehouses);
//			List<SysDict> storehouses1 = new ArrayList<SysDict>() ;
//			//现获取用户的权限
//			Set<String> types = sysRoleService.findRoleTypeByUserId(TokenManager.getSysUserId());
//			for (String type : types) {
//				 if (type.equals("库点管理员")) {
//					//去分片监管查库看监管的企业  通过企业编号唯一去查找库的名称
//					SysUser sysUser = 	sysUserService.selectByPrimaryKey(TokenManager.getSysUserId());
//					SysDict sysDict = new SysDict();
//					storehouses1.add(sysDict);
//					sysDict.setValue(sysUser.getCompany());
//					map.put("storehouses", storehouses1);
//				
//				}
//			}
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
			return "/StorageEnergy/storageEnergy_list";
		}
	 
	 @SysLogAn("仓库管理-能耗管理-导入")
		@RequestMapping(value="/importxls",method=RequestMethod.POST)
		@ResponseBody
		public ActionResultModel importStorageEnergys(@RequestParam(value = "file", required = true) MultipartFile file) {
			List<String> result = storageEnergyService.importStorageEnergys(file);

			ActionResultModel actionResultModel = new ActionResultModel();
			actionResultModel.setSuccess(true);
			 if(result.size()>0){
				 actionResultModel.setSuccess(false);
				 actionResultModel.setMsg(result.get(0));
			 }
			return actionResultModel;
		}
		
		@RequestMapping(value="list",method=RequestMethod.POST)
		@ResponseBody
		public ActionResultModel list(HttpServletRequest request) {
			LayPage<StorageEnergy> list = storageEnergyService.list(request);
			ActionResultModel actionResultModel = new ActionResultModel();
			actionResultModel.setData(list);
			actionResultModel.setSuccess(true);
			return actionResultModel;
		}
		
		@RequestMapping("/download")  
	    public void downloadFile(HttpServletRequest request, HttpServletResponse response){
			String realPath = request.getSession().getServletContext().getRealPath("/");
			String path = realPath +"templates/能耗管理模板.xls";
	        try {
	        	FileUtil.writeFileToResponse(new File(path), response, "能耗管理模板.xls", request);
			} catch (IOException e) {
				e.printStackTrace();
			}
	    } 
}
