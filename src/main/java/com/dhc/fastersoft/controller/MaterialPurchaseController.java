package com.dhc.fastersoft.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.common.SysLogAn;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.MaterialPurchase;
import com.dhc.fastersoft.entity.MaterialPurchaseDeatil;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.MaterialPurchaseDeatilService;
import com.dhc.fastersoft.service.MaterialPurchaseService;
import com.dhc.fastersoft.service.system.SysUserService;
import com.dhc.fastersoft.utils.LayPage;

@Controller
@RequestMapping("/MaterialPurchase")
public class MaterialPurchaseController extends BaseController{
	
	@Autowired
	MaterialPurchaseService materialPurchaseService;
	@Autowired
	MaterialPurchaseDeatilService materialPurchaseDeatilService;
	@Autowired
	SysUserService sysUserService;
	
	@RequestMapping("index")
	public String index() {
		return "/MaterialPurchase/materialPurchase_list";
	}

	@SysLogAn("访问：物资管理-采购管理")
	@RequestMapping("")
	public String main() {
		return "/MaterialPurchase/materialPurchase_list";
	}

	
	/**
	* 方法名 toAdd
	* 方法作用: 添加
	* 作者：张乐 
	* 修改时间: 2017年9月28日 下午5:03:12
	 */
	@RequestMapping("add")
	public String toAdd(HttpServletRequest request,ModelMap map){
		SysUser sysUser = sysUserService.selectByPrimaryKey(TokenManager.getSysUserId());
		String str=TokenManager.getToken().getOriginCode();
		map.put("purchaseDept", sysUser.getDepartment());
		map.put("purchaseMan", sysUser.getName());
		return "/MaterialPurchase/materialPurchase_add";
	}
	
	/**
	* 方法名 edit
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年9月29日 下午5:59:25
	 */
	@RequestMapping("edit")
	public String edit(HttpServletRequest request,ModelMap map,String id){
		MaterialPurchase materialPurchase = materialPurchaseService.getMaterialPurchaseByID(id);
		map.addAttribute("materialPurchase", materialPurchase);
		List<MaterialPurchaseDeatil> materialPurchaseDeatils=materialPurchaseDeatilService.getMaterialPurchaseDeatilByID(id);
//		double d=0;
//		for (int i=0;i<materialPurchaseDeatils.size();i++){
//			MaterialPurchaseDeatil m=materialPurchaseDeatils.get(i);
//			Double.parseDouble(m.getQuantity());
//			Double.parseDouble(m.getEstimatedUnitPrice());
//			d+=Double.parseDouble(m.getQuantity())+Double.parseDouble(m.getEstimatedUnitPrice());
//		}
//		if (d-materialPurchase.getTotalAmount()!=0){
//			materialPurchase.setTotalAmount(d);
//		}
		map.addAttribute("materialPurchaseDeatils", materialPurchaseDeatils);
		return "/MaterialPurchase/materialPurchase_edit";
	}
	
	/**
	* 方法名 edit
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年9月29日 下午5:59:25
	 */
	@RequestMapping("view")
	public String view(HttpServletRequest request,ModelMap map,String id){
		MaterialPurchase materialPurchase = materialPurchaseService.getMaterialPurchaseByID(id);
		map.addAttribute("materialPurchase", materialPurchase);
		List<MaterialPurchaseDeatil> materialPurchaseDeatils=materialPurchaseDeatilService.getMaterialPurchaseDeatilByID(id);
		map.addAttribute("materialPurchaseDeatils", materialPurchaseDeatils);
		return "/MaterialPurchase/materialPurchase_view";
	}
	
	/**
	* 方法名 save
	* 方法作用: 保存物资采购
	* 作者：张乐 
	* 修改时间: 2017年9月28日 下午5:03:37
	 */
	@RequestMapping(value="/Create",method={RequestMethod.POST})
	@ResponseBody
	public ActionResultModel Create(MaterialPurchase materialPurchase,  HttpServletRequest request,ModelMap modelMap){
		//User user=(User) WebUtils.getSessionAttribute(request, "user");
		ActionResultModel actionResultModel = new ActionResultModel();
//		JSONObject ret = new JSONObject();
		String id = request.getParameter("id");
		String[] purchaseIds = request.getParameterValues("purchaseId");
		String[] materialNames = request.getParameterValues("materialName");
		String[] models = request.getParameterValues("model");
		String[] quantitys = request.getParameterValues("quantity");
		String[] unitPrices = request.getParameterValues("unitPrice");
		String[] estimatedUnitPrices = request.getParameterValues("estimatedUnitPrice");
		String[] remarks = request.getParameterValues("remark");
		
		
//		Durables Durables = new Durables();
		try {
			if (id.length()==0) {
				materialPurchase.setId(UUID.randomUUID().toString().replace("-", ""));
				materialPurchase.setPurchaseSerial(this.getId());
				materialPurchase.setOriginCode(TokenManager.getToken().getOriginCode());
				materialPurchaseService.add(materialPurchase);
				sysLogService.add(request, "物资管理-采购管理-新增");
			}else {
				materialPurchase.setId(id);
				materialPurchaseService.update(materialPurchase);
				sysLogService.add(request, "物资管理-采购管理-修改");
			}
			//先删除所有附件
			materialPurchaseDeatilService.remove(materialPurchase.getId());
			
			if(purchaseIds!=null){
				for (int i = 0; i < purchaseIds.length; i++) {
					MaterialPurchaseDeatil materialPurchaseDeatil =new MaterialPurchaseDeatil();
					materialPurchaseDeatil.setEstimatedUnitPrice(estimatedUnitPrices[i]);		
					materialPurchaseDeatil.setMaterialName(materialNames[i]);
					materialPurchaseDeatil.setModel(models[i]);
					materialPurchaseDeatil.setPurchaseId(materialPurchase.getId());
					materialPurchaseDeatil.setQuantity(quantitys[i]);
					materialPurchaseDeatil.setRemark(remarks[i]);
					materialPurchaseDeatil.setUnitPrice(unitPrices[i]);
					materialPurchaseDeatil.setId(UUID.randomUUID().toString().replace("-", ""));					
					materialPurchaseDeatilService.add(materialPurchaseDeatil);

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
	public LayPage<MaterialPurchase> list(HttpServletRequest request) {
		LayPage<MaterialPurchase> list = materialPurchaseService.list(request);
		return list;
	}
	
	/**
	* 方法名 delete
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年10月3日 下午1:37:42
	 */
	@SysLogAn("物资管理-采购管理-删除")
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel delete(String id) {
		ActionResultModel actionResultModel = new ActionResultModel();
		int row=materialPurchaseService.remove(id);
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
