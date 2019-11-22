package com.dhc.fastersoft.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.service.system.SysDictService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dhc.fastersoft.entity.QualityResult;
import com.dhc.fastersoft.entity.QualityResultItem;
import com.dhc.fastersoft.service.QualityResultItemService;
import com.dhc.fastersoft.service.QualityResultService;
import com.dhc.fastersoft.utils.LayPage;

@RequestMapping("QualityFileInfo")
@Controller
public class QualityFileInfoController{
	@Autowired
	QualityResultService service;
	@Autowired
	QualityResultItemService serviceItem;

	@Autowired
	private SysDictService sysDictService;
	/**
	 * 跳转到列表页面
	 * @return
	 */
	@SysLogAn("访问：质量管理-质量档案-质量档案信息")
	@RequestMapping()
	public String index(Model model) {
		List<SysDict> varietyList = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("varietyList",varietyList);
		List<SysDict> validTypes=sysDictService.getSysDictListByType("质检类型");
		model.addAttribute("validTypes",validTypes);
		return "QualityFileInfo/list";
	}
	/**
	 * 列表页面信息
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/list")
	@ResponseBody
	private LayPage<QualityResult> list(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<QualityResult> list=service.list(request);
		return list;
	}
	/**
	 * 跳转到对比页面
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("/listContrast")
	public String listContrast(ModelMap map,String ids) throws UnsupportedEncodingException{
		String str=ids.split(",")[0];
		String val=new String(ids.split(",")[1].getBytes("iso-8859-1"),"utf-8").toString();
		map.put("auvp", str);
		map.put("val", val);
		return "QualityFileInfo/listContrast";
	}
	/**
	 * 列表页面信息
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/listCon")
	@ResponseBody
	private LayPage<QualityResultItem> listCon(HttpServletRequest request,String ids) {
		// TODO Auto-generated method stub
		LayPage<QualityResultItem> list=serviceItem.listCon(ids);
		return list;
	}
	// 导出excel方法
	@RequestMapping("/exportExcel")
	public String export(HttpServletRequest request, HttpServletResponse response) {
		List<QualityResult> list = new ArrayList();
		try {
			//list = userService.export(request);
			String sEcho = request.getParameter("sEcho");
			list=service.query(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String fileName = "质量档案信息.xls";
		try {
			fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
		request.setAttribute("exportList", list);
		return "/QualityResult/export";
	}
}
