package com.dhc.fastersoft.controller;

import javax.servlet.http.HttpServletRequest;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.utils.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.QualityTemplet;
import com.dhc.fastersoft.entity.QualityTempletItem;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.service.QualityTempletItemService;
import com.dhc.fastersoft.service.QualityTempletService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.utils.LayPage;

@RequestMapping("QualityTemplet")
@Controller
public class QualityTempletController extends BaseController{
	
	private static Logger log = Logger.getLogger(QualityTempletController.class);
	@Autowired
	 QualityTempletService service;
	
	@Autowired
	 QualityTempletItemService serviceItem;
	
	@Autowired
	SysDictService sysService;

	@SysLogAn("访问：质量管理-质量档案-粮油模板")
	@RequestMapping()
	public String index() {
		return "QualityTemplet/list";
	}
	/**
	 * 列表页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/list")
	@ResponseBody
	private LayPage<QualityTemplet> list(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<QualityTemplet> list=service.list(request);
		return list;
	}
	/**
	 * 列表页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/listChoice")
	@ResponseBody
	private LayPage<QualityTemplet> listChoice(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<QualityTemplet> list=service.listChoice(request);
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
		QualityTemplet qualityTemplet = service.getByID(id);
		map.addAttribute("entity", qualityTemplet);
		List<QualityTempletItem> entityItem = serviceItem.getByID(id);
		map.addAttribute("entityItem", entityItem);
		List<SysDict> type=sysService.getSysDictListByType("粮油品种");
		map.addAttribute("type",type);
		List<SysDict> grade=sysService.getSysDictListByType("粮油等级");
		map.addAttribute("grade",grade);
		List<SysDict> validTypes=sysService.getSysDictListByType("质检类型");
		map.addAttribute("validTypes",validTypes);
		map.put("auvp", "v");
		return "/QualityTemplet/add";
	}
	
	@RequestMapping(value="/itemDetailList",method=RequestMethod.GET)
	@ResponseBody
	public QualityTemplet itemDetailList(@RequestParam("tempid")String tempid) {
		QualityTemplet entity = service.getByID(tempid);
		List<QualityTempletItem> entityItem = serviceItem.getByID(tempid);
		entity.setGrade("");
		entity.setItemId("");
		entity.setItemName("");
		entity.setStandard("");
		entity.setOrderNo("");
		for(QualityTempletItem item : entityItem) {
			entity.setGrade(entity.getGrade().concat(item.getGrade()+','));
			entity.setItemId(entity.getItemId().concat(item.getId()+','));
			entity.setItemName(entity.getItemName().concat(item.getItemName()+','));
			entity.setStandard(entity.getStandard().concat(item.getStandard()+','));
			BigDecimal b =item.getOrderNo();
			String a = b.toString();
			entity.setOrderNo(entity.getOrderNo().concat(a+','));
		}
		entity.setGrade(entity.getGrade().substring(0,entity.getGrade().length()-1));
		entity.setItemId(entity.getItemId().substring(0,entity.getItemId().length()-1));
		entity.setItemName(entity.getItemName().substring(0,entity.getItemName().length()-1));
		entity.setStandard(entity.getStandard().substring(0,entity.getStandard().length()-1));
		entity.setOrderNo(entity.getOrderNo().substring(0,entity.getOrderNo().length()-1));
		return entity;
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
		QualityTemplet qualityTemplet = service.getByID(id);
		map.addAttribute("entity", qualityTemplet);
		List<QualityTempletItem> entityItem = serviceItem.getByID(id);
		map.addAttribute("entityItem", entityItem);
		List<SysDict> type=sysService.getSysDictListByType("粮油品种");
		map.addAttribute("type",type);
		List<SysDict> grade=sysService.getSysDictListByType("粮油等级");
		map.addAttribute("grade",grade);
		List<SysDict> validTypes=sysService.getSysDictListByType("质检类型");
		map.addAttribute("validTypes",validTypes);
		map.put("auvp", "u");
		return "/QualityTemplet/add";
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
		List<SysDict> validTypes=sysService.getSysDictListByType("质检类型");
		map.addAttribute("validTypes",validTypes);
		map.put("auvp", "a");
		return "QualityTemplet/add";
		}
	/**
	 * 删除
	 * @param id
	 * @return
	 */
	@SysLogAn("质量管理-质量档案-粮油模板-删除")
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
	 * @return
	 */
	@RequestMapping(value="/save",method={RequestMethod.POST}) 
	@ResponseBody
	public ActionResultModel save(QualityTemplet entity,HttpServletRequest request,ModelMap modelMap,
			@RequestParam("itemName")String[] itemName,@RequestParam("grade")String[] grade,
			@RequestParam("standard")String[] standard,@RequestParam("templetId")String[] templetId ,
								  @RequestParam("orderNo")BigDecimal[] orderNo){
		ActionResultModel actionResultModel = new ActionResultModel();
		String sqlId="";
		try{
		String id=request.getParameter("id");

			/*int numberItem=itemName.length;
			for (int j=0;j<numberItem;j++){
				if (StringUtils.isBlank(itemName[j])){
					actionResultModel.setSuccess(false);
					actionResultModel.setMsg("第"+j+"行，第一列不可为空");
					return actionResultModel;
				}else if (StringUtils.isBlank(grade[j])){
					actionResultModel.setSuccess(false);
					actionResultModel.setMsg("第"+j+"行，第二列不可为空");
					return actionResultModel;
				}else if (StringUtils.isBlank(standard[j])){
					actionResultModel.setSuccess(false);
					actionResultModel.setMsg("第"+j+"行，第三列不可为空");
					return actionResultModel;
				}else if (StringUtils.isBlank(orderNo[j])){
					actionResultModel.setSuccess(false);
					actionResultModel.setMsg("第"+j+"行，第四列不可为空");
					return actionResultModel;
				}
			}*/
		/*String[] templetId = request.getParameterValues("templetId");
		String[] itemName = request.getParameterValues("itemName");
		String[] grade = request.getParameterValues("grade");
		String[] standard = request.getParameterValues("standard");*/
		if (id.length()==0) {
			 sqlId=UUID.randomUUID().toString().replace("-", "");
			entity.setId(sqlId);
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
			String date=df.format(new Date());
			entity.setCreator(TokenManager.getSysUserId());
			entity.setCreateDate(date);
			entity.setCompany(TokenManager.getToken().getCompany());
			service.add(entity);
			sysLogService.add(request, "质量管理-质量档案-粮油模板-新增");
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
				entity.setCompany(TokenManager.getToken().getCompany());
			}
			service.update(entity);
			serviceItem.deleteItem(id);
			sqlId=id;
			sysLogService.add(request, "质量管理-质量档案-粮油模板-修改");
		}
		if(itemName!=null&&itemName.length>0){
			List<QualityTempletItem> qitems = new ArrayList<>();
			QualityTempletItem qtiItem = null;
			for (int i = 0; i < itemName.length; i++) {
				qtiItem = new QualityTempletItem();
				qtiItem.setTempletId(sqlId);
				qtiItem.setItemName(itemName[i]);
				qtiItem.setStandard(standard[i]);
				qtiItem.setGrade(grade[i]);
				qtiItem.setOrderNo(orderNo[i]);
				qtiItem.setId(UUID.randomUUID().toString().replace("-", ""));
				qitems.add(qtiItem);
			}
			serviceItem.addByList(qitems);
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
	@RequestMapping("/check")
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
