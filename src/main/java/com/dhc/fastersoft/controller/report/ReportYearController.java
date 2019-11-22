package com.dhc.fastersoft.controller.report;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.utils.PropFileReader;
import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import cn.afterturn.easypoi.excel.ExcelXorHtmlUtil;
import cn.afterturn.easypoi.excel.entity.ExcelToHtmlParams;

import com.dhc.fastersoft.common.Constant;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.system.SysFile;
import com.dhc.fastersoft.entity.yearReport.ReportYear;
import com.dhc.fastersoft.service.system.SysFileService;
import com.dhc.fastersoft.service.yearReport.YearReportService;
import com.dhc.fastersoft.utils.FileUtil;
import com.dhc.fastersoft.utils.LayEntity;
import com.dhc.fastersoft.utils.StringUtils;

@RequestMapping("/yearReport")
@Controller
public class ReportYearController {
	
	@Autowired
	private SysFileService sysFileService;
	
	@Autowired
	private YearReportService yearReportService;
	/**
	 * 列表页面
	 * @param
	 * @return
	 */
	@SysLogAn("访问：报表台账-报表管理-年报填报")
	@RequestMapping()
	public String index() {
		return "report/yearReport/report_index";
	}

	@SysLogAn("报表台账-报表管理-年报填报-新增")
	@RequestMapping(value="/saveReport")
	public String uploadYearReport(HttpServletRequest request,ReportYear reportYear) {
		ReportYear newReportYear = yearReportService.selectByProperty(reportYear);
		if(StringUtils.isNotBlank(newReportYear)){
			yearReportService.delete(newReportYear);
		}
		reportYear.setId(request.getParameter("fileId"));
		reportYear.setCreateDate(new Date(System.currentTimeMillis()));
		reportYear.setCreator(TokenManager.getSysUserId());
		yearReportService.addReportYear(reportYear);
       	SysFile sysFile = sysFileService.selectById(request.getParameter("fileId"));
	       //下载文件路径
       /*String realPath=request.getSession().getServletContext().getRealPath(sysFile.getDownloadUrl());*/
		StringBuilder realPath = new StringBuilder();
		PropFileReader propFileReader = new PropFileReader();
		String realPath1 = propFileReader.getPorpertyValue("filePaths.properties","update_url");
		realPath.append(realPath1).append("/"+sysFile.getDownloadUrl()) ;
	       
	       File file = new File(realPath + File.separator);
	      ExcelToHtmlParams excelToHtmlParams;
		try {
			excelToHtmlParams = new ExcelToHtmlParams(WorkbookFactory.create(file), false);
			String html= ExcelXorHtmlUtil.excelToHtml(excelToHtmlParams);	
			html = html.replace("class='excelDefaults'", "class='layui-table'");
			request.setAttribute("data", html);
		} catch (EncryptedDocumentException e) {
			e.printStackTrace();
		} catch (InvalidFormatException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}	
		return "report/yearReport/report_index";
	}
	
	@RequestMapping(value="/getReport")
	@ResponseBody
	public Map<String, String> getReport(HttpServletRequest request,ReportYear reportYear) {
		 Map<String,String> map = new HashMap<String, String>();
		ReportYear newReportYear = yearReportService.selectByProperty(reportYear);
		if(newReportYear==null||"".equals(newReportYear)){
			map.put("code", "1");
			map.put("msg", "没有此年份报表数据,请重新上传或者联系管理员");
			return map;
		}
		
    	   SysFile sysFile = sysFileService.selectById(newReportYear.getId());
 	       //下载文件路径
 	       //String realPath=request.getSession().getServletContext().getRealPath(sysFile.getDownloadUrl());
			StringBuilder realPath = new StringBuilder();
			PropFileReader propFileReader = new PropFileReader();
			String realPath1 = propFileReader.getPorpertyValue("filePaths.properties","update_url");
			realPath.append(realPath1).append("/"+sysFile.getDownloadUrl()) ;
 	       File file = new File(realPath + File.separator);
 	      ExcelToHtmlParams excelToHtmlParams;
		try {
			
			excelToHtmlParams = new ExcelToHtmlParams(WorkbookFactory.create(file), false);
			String html= ExcelXorHtmlUtil.excelToHtml(excelToHtmlParams);
			html = html.replace("class='excelDefaults'", "class='layui-table'");
	        map.put("data", html);
	        map.put("code", Constant.SUCCESS_CODE+"");
		} catch (EncryptedDocumentException e) {
			map.put("code", "1");
			map.put("msg", "没有此年份报表数据,请重新上传或者联系管理员");
			return map;
		} catch (InvalidFormatException e) {
			map.put("code", "1");
			map.put("msg", "没有此年份报表数据,请重新上传或者联系管理员");
			return map;
		} catch (IOException e) {
			map.put("code", "1");
			map.put("msg", "没有数据,请重新上传或者联系管理员");
			return map;
		}
		return map;
	}
	
	@RequestMapping("/download")  
    public void downloadFile(HttpServletRequest request, HttpServletResponse response){
		String realPath = request.getSession().getServletContext().getRealPath("/");
		String reportName = request.getParameter("reportName");
		String path = realPath +"templates\\"+reportName+".xlsx";
        try {
        	FileUtil.writeFileToResponse(new File(path), response, reportName+".xlsx", request);
		} catch (IOException e) {
			e.printStackTrace();
		}
    }
	
	@RequestMapping(value="/uploadFile")
	@ResponseBody
	public LayEntity upFile(MultipartFile file,HttpServletRequest request){
		LayEntity layFileEntity = new LayEntity();
		Map<String,Object> data  = new HashMap<String, Object>();
		String fileName = file.getOriginalFilename();
        String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
        if(!suffix.endsWith("xlsx")){
        	layFileEntity.setCode(1);
		    layFileEntity.setMsg("请选择正确的文件格式");
		    return layFileEntity;
        }
		String uuid = UUID.randomUUID().toString().replace("-", "");
		data.put("fileId", uuid);
		data.put("fileName", file.getOriginalFilename());
		try {
			sysFileService.uploadFile(request, uuid, file, null);
			layFileEntity.setCode(Constant.SUCCESS_CODE);
			layFileEntity.setData(data);
		    layFileEntity.setMsg("上传成功");
		} catch (Exception e) {
			layFileEntity.setCode(1);
		    layFileEntity.setMsg("上传失败");
			e.printStackTrace();
		}
		
		return layFileEntity;
	}
	
}
