package com.dhc.fastersoft.controller.system;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import cn.afterturn.easypoi.excel.ExcelImportUtil;
import cn.afterturn.easypoi.excel.ExcelXorHtmlUtil;
import cn.afterturn.easypoi.excel.entity.ImportParams;
import cn.afterturn.easypoi.excel.entity.enmus.ExcelType;

@Controller
@RequestMapping("excel")
public class ExcelController {

	@RequestMapping("/import")
	public String importExcel(Model model,MultipartFile file){
		
		ImportParams params = new ImportParams();
		 params.setHeadRows(1);
		
		 List<Model> list = ExcelImportUtil.importExcel(
				 (File) file,
		           Model.class, params);
		
		return "success";
	}
	
	@RequestMapping("/exportExcel")
	@ResponseBody
	public void exportExcel(HttpServletResponse response,HttpServletRequest request){
		
	}
}
