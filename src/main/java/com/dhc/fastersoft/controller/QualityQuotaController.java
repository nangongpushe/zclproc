package com.dhc.fastersoft.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.common.SysLogAn;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.QualityQuota;
import com.dhc.fastersoft.entity.QualityQuotaItem;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.service.QualityQuotaItemService;
import com.dhc.fastersoft.service.QualityQuotaService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.utils.LayPage;

@RequestMapping("QualityQuota")
@Controller
public class QualityQuotaController extends BaseController{
	@Autowired
	QualityQuotaService service;
	
	@Autowired
	QualityQuotaItemService serviceItem;
	
	@Autowired
	SysDictService sysService;
	/**
	 * 跳转到列表页面
	 * @return
	 */
	@SysLogAn("访问：质量管理-质量档案-等级指标管理")
	@RequestMapping()
	public String index(Model model) {
		List<SysDict> varietyList = sysService.getSysDictListByType("粮油品种");
		model.addAttribute("varietyList",varietyList);
		return "QualityQuota/list";
	}
	/**
	 * 列表页面信息
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/list")
	@ResponseBody
	private LayPage<QualityQuota> list(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<QualityQuota> list=service.list(request);
		return list;
	}
	/**
	 * 跳转到查看
	 * @param request
	 * @param map
	 * @param id
	 * @return
	 */
	@RequestMapping("/detailPage")
	public String detailPage(HttpServletRequest request,ModelMap map,String id){
		QualityQuota entity = service.getByID(id);
		map.addAttribute("entity", entity);
		List<QualityQuotaItem> entityItem = serviceItem.getByID(id);
		map.addAttribute("entityItem", entityItem);
		List<SysDict> type=sysService.getSysDictListByType("粮油品种");
		map.addAttribute("type",type);
		List<SysDict> grade=sysService.getSysDictListByType("粮油等级");
		map.addAttribute("grade",grade);
		map.put("auvp", "v");
		return "/QualityQuota/add";
	}
	/**
	 * 跳转到编辑
	 * @param request
	 * @param map
	 * @param id
	 * @return
	 */
	@RequestMapping("/editPage")
	public String editPage(HttpServletRequest request,ModelMap map,String id){
		QualityQuota entity = service.getByID(id);
		map.addAttribute("entity", entity);
		List<QualityQuotaItem> entityItem = serviceItem.getByID(id);
		map.addAttribute("entityItem", entityItem);
		List<SysDict> type=sysService.getSysDictListByType("粮油品种");
		map.addAttribute("type",type);
		List<SysDict> grade=sysService.getSysDictListByType("粮油等级");
		map.addAttribute("grade",grade);
		map.put("auvp", "u");
		return "/QualityQuota/add";
	}
	/***
	 * 跳转到登记页面
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/addPage")
	public String addPage(ModelMap map){
		List<SysDict> type=sysService.getSysDictListByType("粮油品种");
		map.addAttribute("type",type);
		List<SysDict> grade=sysService.getSysDictListByType("粮油等级");
		map.addAttribute("grade",grade);
		map.put("auvp", "a");
		return "QualityQuota/add";
		}
	/**
	 * 删除
	 * @param id
	 * @return
	 */
	@SysLogAn("质量管理-质量档案-等级指标管理-删除")
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel delete(String id) {
		ActionResultModel actionResultModel = new ActionResultModel();
		int row=service.remove(id);
		int countItem=serviceItem.count(id);
		if (countItem>0) {
			int row2=serviceItem.deleteItem(id);
			if(row>0&&row2>0) {
				actionResultModel.setSuccess(true);
				actionResultModel.setMsg("删除成功");
			}else {
				actionResultModel.setSuccess(false);
				actionResultModel.setMsg("删除失败");
			}
		}else {
			if(row>0) {
				actionResultModel.setSuccess(true);
				actionResultModel.setMsg("删除成功");
			}else {
				actionResultModel.setSuccess(false);
				actionResultModel.setMsg("删除失败");
			}
		}
		return actionResultModel;
	}
	/**
	 * 添加或修改
	 * 
	 * @param auvp
	 * @param user
	 * @return
	 */
	@RequestMapping(value="/save",method={RequestMethod.POST}) 
	@ResponseBody
	public ActionResultModel save(QualityQuota entity,HttpServletRequest request,ModelMap modelMap){
		ActionResultModel actionResultModel = new ActionResultModel();
		String sqlId="";
		try{
		
		String id=request.getParameter("id");
		String[] quotaId = request.getParameterValues("quotaId");
		String[] itemName = request.getParameterValues("itemName");
		String[] standard = request.getParameterValues("standard");
		if (id.length()==0) {
			 sqlId=UUID.randomUUID().toString().replace("-", "");
			entity.setId(sqlId);
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
			String date=df.format(new Date());
			entity.setCreator(TokenManager.getSysUserId());
			entity.setCreateDate(date);
			entity.setCompany(TokenManager.getToken().getShortName()!=null?TokenManager.getToken().getShortName():"");
			service.add(entity);
			sysLogService.add(request, "质量管理-质量档案-等级指标管理-新增");
		}else {
			entity.setId(id);
			if (entity.getCreator()==""||entity.getCreator()==null) {
				entity.setCreator(TokenManager.getSysUserId());
			}
			if (entity.getCreateDate()==""||entity.getCreateDate()==null) {
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
				String date=df.format(new Date());
				entity.setCreateDate(date);
			}
			if (entity.getCompany()==""||entity.getCompany()==null) {
				entity.setCompany(TokenManager.getToken().getShortName()!=null?TokenManager.getToken().getShortName():"");
			}
			service.update(entity);
			serviceItem.deleteItem(id);
			sqlId=id;
			sysLogService.add(request, "质量管理-质量档案-等级指标管理-修改");
		}
		if(quotaId!=null){
			for (int i = 0; i < quotaId.length; i++) {
				QualityQuotaItem qtiItem =new QualityQuotaItem();
				qtiItem.setQuotaId(sqlId);
				qtiItem.setItemName(itemName[i]);
				qtiItem.setStandard(standard[i]);
				qtiItem.setId(UUID.randomUUID().toString().replace("-", ""));
				serviceItem.add(qtiItem);

			}
		}
		actionResultModel.setSuccess(true);
	} catch (Exception e) {
		actionResultModel.setSuccess(false);
		int row=service.remove(sqlId);
		int row2=serviceItem.deleteItem(sqlId);
		e.printStackTrace();
	}
		return actionResultModel;
		
	}
	@RequestMapping("check")
	@ResponseBody
	public ActionResultModel  check(HttpServletRequest request,String str){
		ActionResultModel actionResultModel = new ActionResultModel();
		int count=service.check(request,str);
		if(count>0) {
			actionResultModel.setSuccess(false);
		}else {
			actionResultModel.setSuccess(true);
		}
		return actionResultModel;
	}    
}
