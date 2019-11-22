package com.dhc.fastersoft.controller.store;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.controller.BaseController;
import com.dhc.fastersoft.entity.store.StoreEnterprise;
import com.dhc.fastersoft.entity.store.StoreWinUnit;
import com.dhc.fastersoft.entity.system.SysFile;
import com.dhc.fastersoft.service.store.StoreEnterpriseService;
import com.dhc.fastersoft.service.store.StoreWinUnitService;
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
import java.text.SimpleDateFormat;
import java.util.*;


@Controller
@RequestMapping("StoreWinUnit")
public class StoreWinUnitController extends BaseController{
	
	@Autowired
    StoreWinUnitService storeWinUnitService;
	@Autowired
    SysFileService sysFileService;
	 @Autowired
     StoreEnterpriseService storeEnterpriseService;
	 @Autowired
     SysUserService sysUserService;

	 @Autowired
     SysRoleService sysRoleService;

	@SysLogAn("访问：代储监管-业务信息-优胜单位申报")
	@RequestMapping("")
	public String index() {
		return "/StoreWinUnit/storeWinUnit_list";
	}
	

	
	/**
	* 方法名 toAdd
	* 方法作用: 添加
	* 作者：张乐 
	* 修改时间: 2017年9月28日 下午5:03:12
	 */
	@RequestMapping("add")
	public String toAdd(HttpServletRequest request,ModelMap map){
		//现获取用户的权限
		
		HashMap<String, String> maps = new HashMap<String, String>();
		maps.put("warehouseCode", TokenManager.getToken().getOriginCode());
		 Calendar now = Calendar.getInstance();  
		maps.put("year", String.valueOf(now.get(Calendar.YEAR)));
		List<StoreEnterprise> storeEnterprise = storeEnterpriseService.getStoreEnterpriseByWarehouseCode(maps);
		map.put("wareHouse", "");
		map.put("company", "");
		if (storeEnterprise.size()!=0) {
			map.put("wareHouse", storeEnterprise.get(0).getWareHouse());
			map.put("company", storeEnterprise.get(0).getEnterpriseName());
		}
		
		
		return "/StoreWinUnit/storeWinUnit_add";
	}
	
	/**
	* 方法名 edit
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年9月29日 下午5:59:25
	 */
	@RequestMapping("edit")
	public String edit(HttpServletRequest request,ModelMap map,String id){
		StoreWinUnit storeWinUnit = storeWinUnitService.getStoreWinUnitByID(id);
		map.addAttribute("storeWinUnit", storeWinUnit);
		SysFile myFile=sysFileService.selectById(storeWinUnit.getGroupId());
		map.addAttribute("myFile", myFile);
		if(myFile!=null){
			String downloadUrl = myFile.getDownloadUrl();
			String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
			map.addAttribute("suffix", suffix);
		}
		return "/StoreWinUnit/storeWinUnit_edit";
	}
	
	/**
	* 方法名 edit
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年9月29日 下午5:59:25
	 */
	@RequestMapping("view")
	public String view(HttpServletRequest request,ModelMap map,String id){
		StoreWinUnit storeWinUnit = storeWinUnitService.getStoreWinUnitByID(id);
		map.addAttribute("storeWinUnit", storeWinUnit);
		SysFile myFile=sysFileService.selectById(storeWinUnit.getGroupId());
		map.addAttribute("myFile", myFile);
		if(myFile!=null){
			String downloadUrl = myFile.getDownloadUrl();
			String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
			map.addAttribute("suffix", suffix);
		}
		return "/StoreWinUnit/storeWinUnit_view";
	}
	
	/**
	* 方法名 save
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年9月28日 下午5:03:37
	 */
	@RequestMapping(value="/Create",method={RequestMethod.POST})
	@ResponseBody
	public ActionResultModel Create(StoreWinUnit storeWinUnit, HttpServletRequest request, ModelMap modelMap, @RequestParam(value="file",required=false) MultipartFile[] files){
		//User user=(User) WebUtils.getSessionAttribute(request, "user");
		ActionResultModel actionResultModel = new ActionResultModel();
//		JSONObject ret = new JSONObject();
		String id = request.getParameter("id");
		if (storeWinUnit.getRecommend().equals("未推荐")) {
			storeWinUnit.setRecommend("0");
		}else {
			storeWinUnit.setRecommend("1");
		}
		storeWinUnit.setCreatorId(TokenManager.getSysUserId());
		try {
				
			if(files.length> 0){
				String  groupId=UUID.randomUUID().toString().replace("-", "");
				sysFileService.uploadFile(request, groupId, files[0], "StoreWinUnit");
				storeWinUnit.setGroupId(groupId);	
			}
			if (id.length()==0) {
				storeWinUnit.setId(UUID.randomUUID().toString().replace("-", ""));
				storeWinUnit.setSerial(this.getId());
				storeWinUnit.setRecommend("0");
				
				storeWinUnitService.add(storeWinUnit);
				sysLogService.add(request, "代储监管-业务信息-优胜单位申报-新增");
			}else {
				storeWinUnit.setId(id);
				storeWinUnitService.update(storeWinUnit);
				sysLogService.add(request, "代储监管-业务信息-优胜单位申报-修改");
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
	 * @作者 shaomy  
	 * @时间:2017-1-12 上午10:10:41  
	 * @参数:@return   
	 * @返回值：String  
	 */  
	public String getId(){    
	    String id="";   
	    //获取当前时间戳         
	    SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHH");    
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
	public LayPage<StoreWinUnit> list(HttpServletRequest request) {
		
		LayPage<StoreWinUnit> list = storeWinUnitService.list(request);
		return list;
	}
	
	/**
	* 方法名 delete
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年10月3日 下午1:37:42
	 */
	@SysLogAn("代储监管-业务信息-优胜单位申报-删除")
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel delete(String id) {
		ActionResultModel actionResultModel = new ActionResultModel();
		int row=storeWinUnitService.remove(id);
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
	@SysLogAn("代储监管-业务信息-优胜单位申报-推荐")
	@RequestMapping(value="/recommend",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel updateRecommend(String id, HttpServletRequest request) {
		ActionResultModel actionResultModel = new ActionResultModel();
		storeWinUnitService.updateRecommend(id);	
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}
	
	
	@RequestMapping(value="/getcompany",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel getcompany(String id, HttpServletRequest request) {
		ActionResultModel actionResultModel = new ActionResultModel();
		HashMap<String, String> maps = new HashMap<String, String>();
		maps.put("warehouseCode", TokenManager.getToken().getOriginCode());
		maps.put("year", request.getParameter("year1"));
		List<StoreEnterprise> storeEnterprise = storeEnterpriseService.getStoreEnterpriseByWarehouseCode(maps);
		
		if (storeEnterprise.size()!=0) {		
			actionResultModel.setData(storeEnterprise.get(0));
		}else {
			actionResultModel.setData(new StoreEnterprise());
		}
		
		
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}
	
	
	
}