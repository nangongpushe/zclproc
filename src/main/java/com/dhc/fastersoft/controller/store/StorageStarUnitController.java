package com.dhc.fastersoft.controller.store;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.controller.BaseController;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.store.StorageStarUnit;
import com.dhc.fastersoft.entity.system.SysFile;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.service.store.StorageStarUnitService;
import com.dhc.fastersoft.service.store.StoreEnterpriseService;
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
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("StorageStarUnit")
public class StorageStarUnitController extends BaseController{

	 @Autowired
     StorageStarUnitService storageStarUnitService;
	 @Autowired
     SysFileService sysFileService;
	 @Autowired
     SysDictService sysDictService;
	 @Autowired
     StoreEnterpriseService storeEnterpriseService;
	 @Autowired
     SysUserService sysUserService;

	 @Autowired
     SysRoleService sysRoleService;
	@Autowired
	StorageWarehouseService storageWarehouseService;
	 
	 @RequestMapping("index")
		public String index(ModelMap map) {
		 List storageWarehouseList=storageWarehouseService.getWarehouseList();
		 map.put("storageWarehouseList",storageWarehouseList);
		 
			return "/StorageStarUnit/storageStarUnit_list";
		}
		@SysLogAn("访问：仓储管理-粮库管理-星级粮库申报")
	 @RequestMapping("")
		public String main(ModelMap map) {
			//List storageWarehouseList=storageWarehouseService.getWarehouseList();
			//map.put("storageWarehouseList",storageWarehouseList);
			LayPage<StorageWarehouse> page=storageWarehouseService.selectWarehouseListByEnterprise(request);
			if(null != page)
				map.put("storageWarehouseList",page.getData());
			return "/StorageStarUnit/storageStarUnit_list";
		}	
		
		
		/**
		* 方法名 toAdd
		* 方法作用: 添加
		* 作者：张乐 
		* 修改时间: 2017年9月28日 下午5:03:12
		 */
		@RequestMapping("add")
		public String toAdd(HttpServletRequest request,ModelMap map){

			//List storageWarehouseList=storageWarehouseService.getWarehouseList();
			LayPage<StorageWarehouse> page=storageWarehouseService.selectWarehouseListByEnterprise(request);
			if(null != page)
			map.put("storageWarehouseList",page.getData());
			return "/StorageStarUnit/storageStarUnit_add";
		}
		
		/**
		* 方法名 edit
		* 方法作用: 
		* 作者：张乐 
		* 修改时间: 2017年9月29日 下午5:59:25
		 */
		@RequestMapping("edit")
		public String edit(HttpServletRequest request,ModelMap map,String id){
			StorageStarUnit storageStarUnit = storageStarUnitService.getStorageStarUnitByID(id);
			map.addAttribute("storageStarUnit", storageStarUnit);
			SysFile sysFile=sysFileService.selectById(storageStarUnit.getGroupId());
			if(sysFile!=null){
				String downloadUrl = sysFile.getDownloadUrl();
				String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
				map.addAttribute("suffix", suffix);
			}
			map.addAttribute("sysFile", sysFile);
			List storageWarehouseList=storageWarehouseService.getWarehouseList();
			map.put("storageWarehouseList",storageWarehouseList);
			return "/StorageStarUnit/storageStarUnit_edit";
		}
		
		/**
		* 方法名 edit
		* 方法作用: 
		* 作者：张乐 
		* 修改时间: 2017年9月29日 下午5:59:25
		 */
		@RequestMapping("view")
		public String view(HttpServletRequest request,ModelMap map,String id){
			StorageStarUnit storageStarUnit = storageStarUnitService.getStorageStarUnitByID(id);
			map.addAttribute("storageStarUnit", storageStarUnit);
			SysFile sysFile=sysFileService.selectById(storageStarUnit.getGroupId());
			if(sysFile!=null){
				String downloadUrl = sysFile.getDownloadUrl();
				String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
				map.addAttribute("suffix", suffix);
			}
			map.addAttribute("sysFile", sysFile);
			return "/StorageStarUnit/storageStarUnit_view";
		}
		
		/**
		* 方法名 save
		* 方法作用: 
		* 作者：张乐 
		* 修改时间: 2017年9月28日 下午5:03:37
		 */
		@RequestMapping(value="/Create",method={RequestMethod.POST})
		@ResponseBody
		public ActionResultModel Create(StorageStarUnit storageStarUnit, HttpServletRequest request, ModelMap modelMap, @RequestParam(value="file",required=false) MultipartFile[] files){
			//User user=(User) WebUtils.getSessionAttribute(request, "user");
			
			String userName = TokenManager.getNickname();
			ActionResultModel actionResultModel = new ActionResultModel();
//			JSONObject ret = new JSONObject();
			String id = request.getParameter("id");
			storageStarUnit.setType("0");
			
			storageStarUnit.setCreatorId(TokenManager.getSysUserId());
			storageStarUnit.setStoreHouse(TokenManager.getToken().getShortName());
//			StorageStarUnit StorageStarUnit = new StorageStarUnit();
			try {
				if(files.length> 0){
					String fileName = files[0].getOriginalFilename();
					String prefix=fileName.substring(fileName.lastIndexOf(".")+1);//获取文件后缀\
					if (prefix.equals("xls")||prefix.equals("xlsx")||prefix.equals("docx")||prefix.equals("doc")||prefix.equals("png")||prefix.equals("jpg")||prefix.equals("pdf")||prefix.equals("txt")){

					}else {
						actionResultModel.setSuccess(false);
						actionResultModel.setMsg("只能上传后缀名为：xls,xlsx,docx,doc,png,jpg,pdf,txt的文件");
						return actionResultModel;
					}

					String  groupId=UUID.randomUUID().toString().replace("-", "");
					sysFileService.uploadFile(request, groupId, files[0], "StoreWinUnit");
					storageStarUnit.setGroupId(groupId);	
				}
				storageStarUnit.setCreator(userName);
				if (id.length()==0) {
					storageStarUnit.setId(UUID.randomUUID().toString().replace("-", ""));
					//现获取用户的权限
//					Set<String> types = sysRoleService.findRoleTypeByUserId(TokenManager.getSysUserId());
//					for (String type : types) {
//						if (type.equals("代储管理员")) {
//							//通过分片监管区查找库点与库点负责人
//							List<StoreEnterprise> storeEnterprise = storeEnterpriseService.getStoreEnterpriseByUserId(TokenManager.getSysUserId());
//							if (storeEnterprise.size()!=0) {
//								storageStarUnit.setStoreHouse(storeEnterprise.get(0).getWareHouse());
//							
//							}
//							
//						}else if (type.equals("库点管理员")) {
//							//去分片监管查库看监管的企业  通过企业编号唯一去查找库的名称
//							SysUser sysUser = 	sysUserService.selectByPrimaryKey(TokenManager.getSysUserId());
//							storageStarUnit.setStoreHouse(sysUser.getCompany());
//							
//						}
//					}
					storageStarUnitService.add(storageStarUnit);
					sysLogService.add(request, "仓储管理-粮库管理-星级粮库申报-新增");
				}else {
					storageStarUnit.setId(id);
					storageStarUnitService.update(storageStarUnit);
					sysLogService.add(request, "仓储管理-粮库管理-星级粮库申报-修改");
				}
				actionResultModel.setSuccess(true);
			} catch (Exception e) {
				actionResultModel.setMsg("保存失败");
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
		public LayPage<StorageStarUnit> list(HttpServletRequest request) {
			
			LayPage<StorageStarUnit> list = storageStarUnitService.list(request);
			return list;
		}
		
		/**
		* 方法名 delete
		* 方法作用: 
		* 作者：张乐 
		* 修改时间: 2017年10月3日 下午1:37:42
		 */
		@SysLogAn("仓储管理-粮库管理-星级粮库申报-删除")
		@RequestMapping(value="/remove",method=RequestMethod.POST)
		@ResponseBody
		public ActionResultModel delete(String id) {
			ActionResultModel actionResultModel = new ActionResultModel();
			int row=storageStarUnitService.remove(id);
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
	 
		/**
		 * 導出
		 */
		@SysLogAn("仓储管理-粮库管理-星级粮库申报-导出")
		@RequestMapping("/exportxls")
		public String export(HttpServletRequest request, HttpServletResponse response) {
		List<StorageStarUnit> list = new ArrayList();
			StorageStarUnit storageStarUnit = new StorageStarUnit();
			try {
				//list = userService.export(request);
				String sEcho = request.getParameter("sEcho");
				storageStarUnit=storageStarUnitService.getStorageStarUnitByID(request.getParameter("id"));
			} catch (Exception e) {
				e.printStackTrace();
			}
			String fileName = storageStarUnit.getWarehouse()+"-"+storageStarUnit.getCreateDate()+"-"+"星级粮库评优表.xls";
			try {
				fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			list.add(storageStarUnit);
//			response.setCharacterEncoding("UTF-8");
			response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
			request.setAttribute("exportList", list);
			return "/StorageStarUnit/storageStarUnit_exportxls";
		}
}
