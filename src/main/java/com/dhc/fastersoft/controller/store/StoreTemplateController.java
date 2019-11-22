package com.dhc.fastersoft.controller.store;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.controller.BaseController;
import com.dhc.fastersoft.entity.store.StoreTemplate;
import com.dhc.fastersoft.entity.store.StoreTemplateItem;
import com.dhc.fastersoft.entity.store.Tree;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.service.store.StoreTemplateItemService;
import com.dhc.fastersoft.service.store.StoreTemplateService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.utils.LayPage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;


@Controller
@RequestMapping("StoreTemplate")
public class StoreTemplateController extends BaseController{
	@Autowired
	private SysDictService sysDictService;
	@Autowired
    StoreTemplateService storeTemplateService;
	@Autowired
    StoreTemplateItemService storeTemplateItemService;
	
	
	@SysLogAn("访问：代储监管-业务信息-考评模板表")
	@RequestMapping("")
	public String index() {
		return "/StoreTemplate/storeTemplate_list";
	}
	

	
	/**
	* 方法名 toAdd
	* 方法作用: 添加
	* 作者：张乐 
	* 修改时间: 2017年9月28日 下午5:03:12
	 */
	@RequestMapping("add")
	public String toAdd(HttpServletRequest request,ModelMap map){
		
	
	
		return "/StoreTemplate/storeTemplate_add";
	}
	
	
	/**
	* 方法名 edit
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年9月29日 下午5:59:25
	 */
	@RequestMapping("edit")
	public String edit(HttpServletRequest request,ModelMap map,String id,String templateId){
		StoreTemplate storeTemplate = storeTemplateService.getStoreTemplateByID(templateId);
		map.put("storeTemplate", storeTemplate);
	
		return "/StoreTemplate/storeTemplate_edit";
	}
	
	/**
	* 方法名 edit
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年9月29日 下午5:59:25
	 */
	@RequestMapping("view")
	public String view(HttpServletRequest request,ModelMap map,String id,String templateId){
		StoreTemplate storeTemplate = storeTemplateService.getStoreTemplateByID(templateId);
		map.put("storeTemplate", storeTemplate);
		
		return "/StoreTemplate/storeTemplate_view";
	}
	
	/**
	* 方法名 getStoreTemplateContent
	* 方法作用: 获取考核选项
	* 作者：张乐 
	* 修改时间: 2017年10月14日 下午1:41:39
	 */
	@RequestMapping(value="getStoreTemplate",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel getStoreTemplate(String id, HttpServletRequest request, String templateId) {
		ActionResultModel actionResultModel = new ActionResultModel();
		String typeString="考评项目";
		if (request.getParameter("type").equals("1")) {
			//四化
			typeString="四化考评项目";
		}
		StoreTemplateItem storeTemplateItem0 = new StoreTemplateItem();
		storeTemplateItem0.setItemName(typeString);
		Integer oneRowSpan=0;
		
		//1.找到第一级节点
		List<StoreTemplateItem> storeTemplateItems = storeTemplateItemService.getOneClassList(templateId);
		storeTemplateItem0.setChildren(storeTemplateItems);
		//2.找到第2级节点
		for (StoreTemplateItem storeTemplateItem : storeTemplateItems) {
			HashMap<String, Object> maps = new HashMap<String, Object>();
			maps.put("parentId", storeTemplateItem.getId());
			maps.put("templetId", templateId);
			List<StoreTemplateItem> storeTemplateItems2 = storeTemplateItemService.getTwoClassList(maps);
			storeTemplateItem.setChildren(storeTemplateItems2);
			//3.找到第3级节点
			for (StoreTemplateItem storeTemplateItem2 : storeTemplateItems2) {
				List<StoreTemplateItem> storeTemplateItems3 =	storeTemplateItemService.getItemListByParentId(storeTemplateItem2.getId(), templateId);
				oneRowSpan=oneRowSpan+storeTemplateItems3.size();
				
				storeTemplateItem2.setChildren(storeTemplateItems3);
			}
			storeTemplateItem.setRowspan(oneRowSpan);
	
		}
		actionResultModel.setData(storeTemplateItem0);
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}
	
	
	/**
	* 方法名 getStoreTemplateContent
	* 方法作用: 获取所有考核选项
	* 作者：张乐 
	* 修改时间: 2017年10月14日 下午1:41:39
	 */
	@RequestMapping(value="TemplateContent",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel getStoreTemplateContent(String id, HttpServletRequest request, String templateId) {
		ActionResultModel actionResultModel = new ActionResultModel();
		String typeString="考评项目";
		if (request.getParameter("type").equals("1")) {
			//四化
			typeString="四化考评项目";
		}
		List<Object> actionResultModels = new ArrayList<Object>();

		List<SysDict> sysDictss =	sysDictService.getSysDictListByType(typeString);
		SysDict sysDict = new SysDict();
		for (SysDict sysDict2 : sysDictss) {
			if (sysDict2.getParentid()==null) {
				sysDict = sysDict2;
				break;
			}
		}
		Tree tree = new Tree();
		if (sysDict!=null) {
			List<SysDict> sysDicts = sysDictService.getSysDictByparentId(sysDict.getId());
			tree.setId(sysDict.getId());
			tree.setName(sysDict.getValue());
			tree.setNocheck(true);
			tree.setOpen(true);
			List<Tree> trees = new ArrayList<Tree>();
			for (SysDict sysDict2 : sysDicts) {
				Tree tree2 = new Tree();
				tree2.setId(sysDict2.getId());
				tree2.setName(sysDict2.getValue());
				tree2.setNocheck(true);
				tree2.setOpen(true);
				trees.add(tree2);
				List<SysDict> sysDict2s = sysDictService.getSysDictByparentId(sysDict2.getId());
				List<Tree> tree2s = new ArrayList<Tree>();
				for (SysDict sysDict3 : sysDict2s) {
					Tree tree3 = new Tree();
					tree3.setId(sysDict3.getId());
					tree3.setName(sysDict3.getValue());
					tree3.setNocheck(true);
					tree3.setOpen(true);
					tree2s.add(tree3);
					List<SysDict> sysDict3s = sysDictService.getSysDictByparentId(sysDict3.getId());
					List<Tree> tree3s = new ArrayList<Tree>();
					for (SysDict sysDict4 : sysDict3s) {
						//考核内容
						Tree tree4 = new Tree();
						tree4.setId(sysDict4.getId());
						tree4.setName(sysDict4.getValue());
						tree4.setNocheck(false);
						tree4.setOpen(false);
						tree3s.add(tree4);
					}
					
					tree3.setChildren(tree3s);
				}
				tree2.setChildren(tree2s);
			}
			tree.setChildren(trees);
		}
		actionResultModels.add(tree);
		if (templateId!=null) {
			List<StoreTemplateItem> storeTemplateItems =	storeTemplateItemService.getItemListByTemplateId(templateId);
			actionResultModels.add(storeTemplateItems);
			
		}
		actionResultModel.setData(actionResultModels);
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}
	
	/**
	* 方法名 save
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年9月28日 下午5:03:37
	 */
	@RequestMapping(value="/Create",method={RequestMethod.POST})
	@ResponseBody
	public ActionResultModel Create(StoreTemplate storeTemplate, HttpServletRequest request, ModelMap modelMap){
		//User user=(User) WebUtils.getSessionAttribute(request, "user");
		
		String userName = TokenManager.getNickname();
		
		ActionResultModel actionResultModel = new ActionResultModel();
//		JSONObject ret = new JSONObject();
		String id = request.getParameter("id");
		
		try {
			
			storeTemplate.setCreator(userName);
			storeTemplate.setCreatorId(TokenManager.getSysUserId());
			if (id.length()==0) {
				storeTemplate.setId(UUID.randomUUID().toString().replace("-", ""));
				storeTemplate.setTempletNo(this.getId());
				storeTemplateService.add(storeTemplate);
				sysLogService.add(request, "代储监管-业务信息-考评模板表-新增");
			}else {
				storeTemplate.setId(id);
				storeTemplateService.update(storeTemplate);
				sysLogService.add(request, "代储监管-业务信息-考评模板表-修改");
			}
			
			//先删除所有附件
			storeTemplateItemService.remove(storeTemplate.getTempletNo());
			String[] ids = request.getParameter("ids").split(",");
			String[] items = request.getParameter("items").split(",");
			String[] scores = request.getParameter("scores").split(",");
		
				for (int i = 0; i < ids.length; i++) {
					StoreTemplateItem storeTemplateItem = new StoreTemplateItem();
					storeTemplateItem.setId(UUID.randomUUID().toString().replace("-", ""));
					storeTemplateItem.setTempletId(storeTemplate.getTempletNo());
					storeTemplateItem.setItemId(items[i]);
					storeTemplateItem.setParentId(ids[i]);
					storeTemplateItem.setStandard(scores[i]);
					storeTemplateItemService.add(storeTemplateItem);

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
	public LayPage<StoreTemplate> list(HttpServletRequest request) {
		
		LayPage<StoreTemplate> list = storeTemplateService.list(request);
		return list;
	}
	
	/**
	* 方法名 delete
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年10月3日 下午1:37:42
	 */
	@SysLogAn("代储监管-业务信息-考评模板表-删除")
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel delete(String id) {
		ActionResultModel actionResultModel = new ActionResultModel();
		int row=storeTemplateService.remove(id);
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