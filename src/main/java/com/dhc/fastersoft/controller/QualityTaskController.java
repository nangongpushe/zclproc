package com.dhc.fastersoft.controller;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dhc.fastersoft.common.SysLogAn;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.QualitySample;
import com.dhc.fastersoft.entity.QualityTask;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.QualitySampleService;
import com.dhc.fastersoft.service.QualityTaskService;
import com.dhc.fastersoft.service.system.SysUserService;
import com.dhc.fastersoft.utils.LayPage;

@RequestMapping("QualityTask")
@Controller
public class QualityTaskController extends BaseController{
	@Autowired
	QualityTaskService service;
	@Autowired
	QualitySampleService qsService;
	@Autowired
	SysUserService sysUserService;
	@Autowired
	private QualitySampleService qualitySampleService;
	// 导出excel方法
	@SysLogAn("质量管理-检验任务-检验任务-导出")
			@RequestMapping("/exportExcel")
			public String export(HttpServletRequest request, HttpServletResponse response) {
				List<QualityTask> list = new ArrayList();
				try {
					//list = userService.export(request);
					String sEcho = request.getParameter("sEcho");
					list=service.query(request);
				} catch (Exception e) {
					e.printStackTrace();
				}
				String fileName = "检验任务.xls";
				try {
					fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
				} catch (UnsupportedEncodingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
				request.setAttribute("exportList", list);
				return "/QualityTask/export";
			}
	/**
	 * 跳转到列表页面
	 * @return
	 */
	@SysLogAn("访问：质量管理-检验任务-检验任务")
	@RequestMapping()
	public String index(ModelMap map) {
		List<SysUser> distinctList=sysUserService.distinctList();
		map.addAttribute("distinctList", distinctList);
		return "QualityTask/list";
	}
	/**
	 * 列表页面信息
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/list")
	@ResponseBody
	private LayPage<QualityTask> list(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<QualityTask> list=service.list(request);
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
		QualityTask entity = service.getByID(id);
		map.addAttribute("entity", entity);

		HashMap<String, Object> searchMap = new HashMap<>();
		List<QualitySample> qualitySamples=qualitySampleService.getMessage(searchMap);
		map.put("qualitySamples", qualitySamples);
		map.put("auvp", "v");
		return "QualityTask/add";
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
		QualityTask entity = service.getByID(id);
		map.addAttribute("entity", entity);

		HashMap<String, Object> searchMap = new HashMap<>();
		List<QualitySample> qualitySamples=qualitySampleService.getMessage(searchMap);
		map.put("qualitySamples", qualitySamples);
		map.put("auvp", "u");
		return "QualityTask/add";
	}
	/***
	 * 跳转到登记页面
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/addPage")
	public String addPage(ModelMap map){
		HashMap<String, Object> searchMap = new HashMap<>();
		List<QualitySample> qualitySamples=qualitySampleService.getMessage(searchMap);
		map.put("qualitySamples", qualitySamples);
		QualityTask entity = new QualityTask();
		entity.setCreator(TokenManager.getNickname());
		entity.setWearhouse(TokenManager.getToken().getShortName());
		map.put("entity", entity);
		map.put("auvp", "a");
		return "QualityTask/add";
		}
	/**
	 * 打印
	 * @param map
	 * @param id
	 * @return
	 */
	@SysLogAn("质量管理-检验任务-检验任务-打印")
	@RequestMapping("/print")
	public String print(ModelMap map, String id) {
		QualityTask entity = service.getByID(id);
		map.addAttribute("entity", entity);
		HashMap<String, Object> searchMap = new HashMap<>();
		List<QualitySample> qualitySamples=qualitySampleService.getMessage(searchMap);
		map.put("qualitySamples", qualitySamples);
		map.put("auvp", "p");
		return "QualityTask/print";
	}
	/**
	 * 删除
	 * @param id
	 * @return
	 */
	@SysLogAn("质量管理-检验任务-检验任务-删除")
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel delete(String ids) {
		ActionResultModel actionResultModel = new ActionResultModel();
		int row=service.remove(ids);
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
	 * 添加或修改
	 * 
	 * @param auvp
	 * @param user
	 * @return
	 */
	@RequestMapping(value="/save",method={RequestMethod.POST}) 
	@ResponseBody
	public ActionResultModel save(QualityTask entity,HttpServletRequest request,ModelMap modelMap){
		ActionResultModel actionResultModel = new ActionResultModel();
		
		try{
		String id=request.getParameter("id");
		String sqlId="";
		if (id.length()==0) {
			 sqlId=UUID.randomUUID().toString().replace("-", "");
			entity.setId(sqlId);
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
			String date=df.format(new Date());
			entity.setCreator(TokenManager.getSysUserId());
			entity.setCreateDate(date);
			entity.setCompany(TokenManager.getToken().getShortName()!=null?TokenManager.getToken().getShortName():"");
			service.add(entity);
			sysLogService.add(request, "质量管理-检验任务-检验任务-新增");
			
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
			sysLogService.add(request, "质量管理-检验任务-检验任务-修改");
		}
		
		actionResultModel.setSuccess(true);
	} catch (Exception e) {
		actionResultModel.setSuccess(false);
		e.printStackTrace();
	}
		return actionResultModel;
		
	}
	@RequestMapping("/check")
	@ResponseBody
	public ActionResultModel  check(HttpServletRequest request){
		ActionResultModel actionResultModel = new ActionResultModel();
		int count=service.check(request);
		if(count>0) {
			actionResultModel.setSuccess(false);
		}else {
			actionResultModel.setSuccess(true);
		}
		return actionResultModel;
	}
}
