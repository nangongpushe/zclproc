package com.dhc.fastersoft.controller;


import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.Constant;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.CustomerInformation;
import com.dhc.fastersoft.entity.CustomerInformationVerifyBuilder;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.exception.ImportException;
import com.dhc.fastersoft.service.CustomerInformationService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.utils.FileUtil;
import com.dhc.fastersoft.utils.LayEntity;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.utils.excel.ExcelImportUtils;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;



/**
 * 客户信息类
 * @author dell
 * @date
 */
@RequestMapping("CustomerInformation")
@Controller
public class CustomerInformationController extends BaseController{
	private static Logger log = Logger.getLogger(CustomerInformationController.class);
	
	@Autowired
	CustomerInformationService service;
	@Autowired
	SysDictService sysService;

	/**
	 * 列表页面
	 * 
	 * @param
	 * @return
	 */
	@SysLogAn("访问：客户管理-客户信息")
	@RequestMapping()
	private String list(ModelMap modelMap) {
		List<SysDict> enterpriseNature = sysService.getSysDictListByType("库点企业性质");
		modelMap.addAttribute("enterpriseNature",enterpriseNature);
		// TODO Auto-generated method stub
		return "customer/list";
	}
	/**
	 * 统计列表页面
	 * 
	 * @param
	 * @return
	 */
	@SysLogAn("访问：客户管理-统计分析")
	@RequestMapping("listEcharts")
	private String listEcharts() {
		// TODO Auto-generated method stub
		return "customer/listEcharts";
	}
	/**
	 * 列表页面信息
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/list")
	@ResponseBody
	private LayPage<CustomerInformation> list(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<CustomerInformation> list=service.list(request);
		return list;
	}
	/**
	 * 统计列表页面信息
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/getCharts")
	@ResponseBody
	private List<CustomerInformation> getCharts(HttpServletRequest request) {
		// TODO Auto-generated method stub

       List<CustomerInformation> list=service.listEcharts(request);
		return list;
	}
	
	
	
	
	
	
	/**
	 * 新增
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/addPage")
	public String addPage(ModelMap modelMap){
		List<SysDict> industry = sysService.getSysDictListByType("行业类型");
		modelMap.addAttribute("industry",industry);	
		List<SysDict> bankCreditRating = sysService.getSysDictListByType("银行信用等级");
		modelMap.addAttribute("bankCreditRating",bankCreditRating);	
		List<SysDict> enterpriseNature = sysService.getSysDictListByType("库点企业性质");
		modelMap.addAttribute("enterpriseNature",enterpriseNature);	
		List<SysDict> clientType = sysService.getSysDictListByType("客户分类");
		modelMap.addAttribute("clientType",clientType);	
		modelMap.put("auvp", "a");
		return "customer/add";
		}
	/**
	 * 编辑
	 * @param modelMap
	 * @param id
	 * @return
	 */
	@RequestMapping("/editPage")
	public String editPage(ModelMap modelMap, String id) {
		CustomerInformation customerInformation=service.getCIById(id);
		modelMap.put("customerInformation", customerInformation);
		List<SysDict> industry = sysService.getSysDictListByType("行业类型");
		modelMap.addAttribute("industry",industry);	
		List<SysDict> bankCreditRating = sysService.getSysDictListByType("银行信用等级");
		modelMap.addAttribute("bankCreditRating",bankCreditRating);	
		List<SysDict> enterpriseNature = sysService.getSysDictListByType("库点企业性质");
		modelMap.addAttribute("enterpriseNature",enterpriseNature);	
		List<SysDict> clientType = sysService.getSysDictListByType("客户分类");
		modelMap.addAttribute("clientType",clientType);	
		modelMap.put("auvp", "u");
		return "customer/add";
	}
	/**
	 * 查看
	 * @param modelMap
	 * @param id
	 * @return
	 */
	@RequestMapping("/detailPage")
	public String detailPage(ModelMap modelMap, String id) {
		CustomerInformation customerInformation=service.getCIById(id);
		modelMap.put("customerInformation", customerInformation);
		List<SysDict> industry = sysService.getSysDictListByType("行业类型");
		modelMap.addAttribute("industry",industry);	
		List<SysDict> bankCreditRating = sysService.getSysDictListByType("银行信用等级");
		modelMap.addAttribute("bankCreditRating",bankCreditRating);	
		List<SysDict> enterpriseNature = sysService.getSysDictListByType("库点企业性质");
		modelMap.addAttribute("enterpriseNature",enterpriseNature);	
		List<SysDict> clientType = sysService.getSysDictListByType("客户分类");
		modelMap.addAttribute("clientType",clientType);	
		modelMap.put("auvp", "v");
		return "customer/add";
	}

	@RequestMapping("/clientInfo")
	public String clientInfo(ModelMap modelMap, String clientName) {
		CustomerInformation customerInformation = service.getClientInfoByName(clientName);
		modelMap.put("customerInformation", customerInformation);
		return "customer/clientInfo";
	}

	@SysLogAn("客户管理-客户信息-导入")
	@RequestMapping(value="/importExcel")
	@ResponseBody
	public LayEntity importExcel(MultipartFile file,HttpServletRequest request){
		LayEntity layFileEntity = new LayEntity();
		try {
			InputStream is = file.getInputStream();
			Workbook wb = WorkbookFactory.create(is);
			Sheet sheet = wb.getSheetAt(0);
			List<CustomerInformation> list=ExcelImportUtils.parseSheet(CustomerInformation.class, CustomerInformationVerifyBuilder.getInstance(), sheet, 2);
			LayPage<CustomerInformation> page = service.importExcel(list);
			String msg = page.getMsg();
			if (msg=="") {
				layFileEntity.setCode(Constant.SUCCESS_CODE);
				layFileEntity.setMsg("上传成功:导入"+page.getCount()+"条");
				
			}else {
				layFileEntity.setCode(Constant.FAIL_CODE);
				layFileEntity.setMsg("导入失败:导入第"+page.getCount()+"条出现以下问题("+msg+")");
			}
		}catch (ImportException ie){
			layFileEntity.setCode(1);
			layFileEntity.setMsg(ie.getMessage());
			ie.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			layFileEntity.setCode(1);
		    layFileEntity.setMsg("上传失败");
			e.printStackTrace();
		}
		return layFileEntity;
	}
	
	
	/**
	 * 统计列表页面信息
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/checkIsAdd")
	@ResponseBody
	private int checkIsAdd(HttpServletRequest request) {
		// TODO Auto-generated method stub

       int clientCount=0;
       clientCount=service.checkIsAdd(request.getParameter("socialCreditCode"));
	   return clientCount;
	}
	/**
	 * 添加或修改
	 * 
	 * @param auvp
	 * @param
	 * @return
	 */
	@RequestMapping("/save")
	@ResponseBody
	public ActionResultModel save(@RequestParam(value = "auvp")String auvp,CustomerInformation entity){
		ActionResultModel actionResultModel = new ActionResultModel();
		String shortName = TokenManager.getToken().getShortName();
		if (auvp.equals("a")) {
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
			String date=df.format(new Date());
			entity.setCreator(TokenManager.getNickname());
			entity.setCreateDate(date);
			
			entity.setCompany(shortName);
			service.add(entity);
			sysLogService.add(request, "客户管理-客户信息-增加");
		}else if (auvp.equals("u")) {
			if (entity.getCreator()==""||entity.getCreator()==null) {
				entity.setCreator(TokenManager.getNickname());
			}
			if (entity.getCreateDate()==""||entity.getCreateDate()==null) {
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
				String date=df.format(new Date());
				entity.setCreateDate(date);
			}
			if (entity.getCompany()==""||entity.getCompany()==null) {
				entity.setCompany(shortName);
			}
			service.update(entity);
			sysLogService.add(request, "客户管理-客户信息-修改");
		}
		actionResultModel.setSuccess(true);
		return	actionResultModel;
	}
	/**
	 * 删除
	 * @param id
	 * @return
	 */
	@SysLogAn("客户管理-客户信息-删除")
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel delete(String id) {
		ActionResultModel actionResultModel = new ActionResultModel();
		int row=service.delete(id);
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
	@SysLogAn("客户管理-客户信息-加入黑名单")
	@RequestMapping("/inblacklist")
	@ResponseBody
	public ActionResultModel inblacklist(HttpServletRequest request,String ids) {
		ActionResultModel actionResultModel = new ActionResultModel();
		int inblacklist= service.inblacklist(ids);
		 if(inblacklist>0) {
				actionResultModel.setSuccess(true);
			}else {
				actionResultModel.setSuccess(false);
			}
		return actionResultModel;
	}
	@SysLogAn("客户管理-客户信息-移除黑名单")
	@RequestMapping("/outblacklist")
	@ResponseBody
	public ActionResultModel outblacklist(HttpServletRequest request,String ids) {
		ActionResultModel actionResultModel = new ActionResultModel();
		int outblacklist=service.outblacklist(ids);
		if(outblacklist>0) {
			actionResultModel.setSuccess(true);
		}else {
			actionResultModel.setSuccess(false);
		}
		return actionResultModel;
	}
	// 导出excel方法
	@SysLogAn("客户管理-客户信息-导出")
	@RequestMapping("/exportExcel")
	public String export(HttpServletRequest request, HttpServletResponse response) {
		List<CustomerInformation> list = new ArrayList();
		try {
			//list = userService.export(request);
			String sEcho = request.getParameter("sEcho");
			list=service.query(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String fileName = "客户信息.xls";
		try {
			fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		response.setCharacterEncoding("UTF-8");
		response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
		request.setAttribute("exportList", list);
		return "/customer/export";
	}
	@RequestMapping("/download")  
    public void downloadFile(HttpServletRequest request, HttpServletResponse response){
		String realPath = request.getSession().getServletContext().getRealPath("/");
		String path = realPath +"templates/客户信息导入模版.xlsx";
        try {
        	FileUtil.writeFileToResponse(new File(path), response, "客户信息导入模版.xlsx", request);
		} catch (IOException e) {
			e.printStackTrace();
		}
    }


    @ResponseBody
    @RequestMapping("/search/{id}")
    public ActionResultModel selectCustomerInfo(@PathVariable String id){
		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		actionResultModel.setData(service.getCIById(id));
		return actionResultModel;
	}
}


