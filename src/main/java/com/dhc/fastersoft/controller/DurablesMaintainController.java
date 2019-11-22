package com.dhc.fastersoft.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.system.SysUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.entity.Durables;
import com.dhc.fastersoft.entity.DurablesMaintain;
import com.dhc.fastersoft.entity.DurablesOptions;
import com.dhc.fastersoft.service.DurablesMaintainService;
import com.dhc.fastersoft.service.DurablesOptionsService;
import com.dhc.fastersoft.service.DurablesService;
import com.dhc.fastersoft.utils.LayPage;

@Controller
@RequestMapping("/DurablesMaintain")
public class DurablesMaintainController extends BaseController{
	
	@Autowired
	 DurablesMaintainService durablesMaintainService;
	@Autowired
	DurablesService durablesService;
	@Autowired
	DurablesOptionsService durablesOptionsService;

	@SysLogAn("访问：物资管理-维修管理")
	@RequestMapping
	public String index() {
		return "/DurablesMaintain/durablesMaintain_list";
	}
	
	@RequestMapping("/select_durables_list")
	public String selectDurablesList(ModelMap map) {
		SysUser user= TokenManager.getToken();
		map.addAttribute("shortName",user.getShortName());
		return "/DurablesMaintain/select_durables_list";
	}
	
	/**
	* 方法名 getDurablesOptions
	* 方法作用: 获取非易耗品设备附件列表
	* 作者：张乐 
	* 修改时间: 2017年10月7日 上午9:14:39
	 */
	@RequestMapping("durablesOptions")
	@ResponseBody
	public ActionResultModel getDurablesOptions(HttpServletRequest request,ModelMap map,String id){
		List<DurablesOptions> durablesOptions=durablesOptionsService.getDurablesOptionsByID(id);		
		ActionResultModel actionResultModel = new ActionResultModel();
		try {
			actionResultModel.setData(durablesOptions);
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
	public LayPage<DurablesMaintain> list(HttpServletRequest request) {
		LayPage<DurablesMaintain> list = durablesMaintainService.list(request);
		return list;
	}
	
	/**
	* 方法名 toAdd
	* 方法作用: 添加
	* 作者：张乐 
	* 修改时间: 2017年9月28日 下午5:03:12
	 */
	@RequestMapping("add")
	public String toAdd(HttpServletRequest request,ModelMap map){

		return "/DurablesMaintain/durablesMaintain_add";
	}
	
	/**
	* 方法名 edit
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年9月29日 下午5:59:25
	 */
	@RequestMapping("edit")
	public String edit(HttpServletRequest request,ModelMap map,String id){
		DurablesMaintain durablesMaintain = durablesMaintainService.getDurablesMaintainById(id);
		map.addAttribute("durablesMaintain", durablesMaintain);
		Durables durables = durablesService.getDurablesByID(durablesMaintain.getDurablesId());
		map.addAttribute("durables", durables);
		List<DurablesOptions> durablesOptions=durablesOptionsService.getDurablesOptionsByID(durablesMaintain.getDurablesId());
		map.addAttribute("durablesOptions", durablesOptions);
	
		return "/DurablesMaintain/durablesMaintain_edit";
	}
	
	/**
	* 方法名 edit
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年9月29日 下午5:59:25
	 */
	@RequestMapping("view")
	public String view(HttpServletRequest request,ModelMap map,String id){
		DurablesMaintain durablesMaintain = durablesMaintainService.getDurablesMaintainById(id);
		map.addAttribute("durablesMaintain", durablesMaintain);
		Durables durables = durablesService.getDurablesByID(durablesMaintain.getDurablesId());
		map.addAttribute("durables", durables);
		List<DurablesOptions> durablesOptions=durablesOptionsService.getDurablesOptionsByID(durablesMaintain.getDurablesId());
		map.addAttribute("durablesOptions", durablesOptions);
		return "/DurablesMaintain/durablesMaintain_view";
	}
	
	/**
	* 方法名 save
	* 方法作用: 保存保养维修信息
	* 作者：张乐 
	* 修改时间: 2017年9月28日 下午5:03:37
	 */
	@RequestMapping(value="/Create",method={RequestMethod.POST})
	@ResponseBody
	public ActionResultModel Create(DurablesMaintain durablesMaintain,  HttpServletRequest request,ModelMap modelMap){
		//User user=(User) WebUtils.getSessionAttribute(request, "user");
		ActionResultModel actionResultModel = new ActionResultModel();

		String id = request.getParameter("id");
		
//		Durables Durables = new Durables();
		try {
			if (id.length()==0) {
				durablesMaintain.setId(UUID.randomUUID().toString().replace("-", ""));
				durablesMaintainService.add(durablesMaintain);
				sysLogService.add(request, "物资管理-维修管理-新增");
			}else {
				durablesMaintain.setId(id);
				durablesMaintainService.update(durablesMaintain);
				sysLogService.add(request, "物资管理-维修管理-修改");
			}
			
			actionResultModel.setSuccess(true);
		} catch (Exception e) {
			actionResultModel.setSuccess(false);
			e.printStackTrace();
		}
		
		 return actionResultModel;
	}
	
	

	
	
	
	/**
	* 方法名 delete
	* 方法作用: 
	* 作者：张乐 
	* 修改时间: 2017年10月3日 下午1:37:42
	 */
	@SysLogAn("物资管理-维修管理-删除")
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel delete(String id) {
		ActionResultModel actionResultModel = new ActionResultModel();
		int row=durablesMaintainService.remove(id);
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
	@SysLogAn("物资管理-维修管理-导出")
	@RequestMapping("/exportxls")
	public String export(HttpServletRequest request, HttpServletResponse response) {
		List<DurablesMaintain> list = new ArrayList();
		try {
			//list = userService.export(request);
			String sEcho = request.getParameter("sEcho");
			list=durablesMaintainService.exportxls(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String fileName = "维修管理信息.xls";
		try {
			fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		response.setCharacterEncoding("UTF-8");
		response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
		request.setAttribute("exportList", list);
		return "/DurablesMaintain/durablesMaintain_export";
	}
}
