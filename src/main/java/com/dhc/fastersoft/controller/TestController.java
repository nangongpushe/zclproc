package com.dhc.fastersoft.controller;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.page.PageList;
import com.dhc.fastersoft.entity.Test;
import com.dhc.fastersoft.entity.TestVerifyBuilder;
import com.dhc.fastersoft.service.TestService;
import com.dhc.fastersoft.utils.FileUtil;
import com.dhc.fastersoft.utils.excel.ExcelExportUtils;
import com.dhc.fastersoft.utils.excel.ExcelImportUtils;
import com.dhc.fastersoft.utils.excel.POIConstant;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;

/**
 * 测试类
 * 
 * @author Canbol
 * @date 2017年9月20日 上午10:25:23
 */
@RequestMapping("/test")
@Controller
public class TestController {

	private static Logger log = Logger.getLogger(TestController.class);
	@Autowired
	private TestService service;
	
	/**
	 * 定义：excel标题，提取数据的字段，占用列长度
	 */
	private static final Object[][] fields = new Object[][]{
		{"姓名","name",POIConstant.NAME},
		{"年龄","age",POIConstant.NUMBER}
	};

	/**
	 * 列表页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping()
	public String list() {
		return "test/test_list";
	}

	@RequestMapping("/pageQuery")
	@ResponseBody
	public ActionResultModel pageQuery(HttpServletRequest request) {
		ActionResultModel actionResultModel = new ActionResultModel();
		PageList list = service.pageQuery(request);
		actionResultModel.setData(list);
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}

	@RequestMapping("addPage")
	public String addPage(ModelMap modelMap) {
		modelMap.put("auvp", "a");
		return "test/test";
	}
	
	@RequestMapping("editPage")
	public String editPage(ModelMap modelMap, String id) {
		Test test = service.getTestById(id);
		modelMap.put("test", test);
		modelMap.put("auvp", "u");
		return "test/test";
	}
	
	@RequestMapping("detailPage")
	public String detailPage(ModelMap modelMap, String id) {
		Test test = service.getTestById(id);
		modelMap.put("test", test);
		modelMap.put("auvp", "v");
		return "test/test";
	}

	/**
	 * 添加或修改
	 * 
	 * @param auvp
	 * @param user
	 * @return
	 */
	@RequestMapping("/save")
	@ResponseBody
	public ActionResultModel save(@RequestParam(value = "auvp") String auvp, Test test) {
		ActionResultModel actionResultModel = new ActionResultModel();
		if (auvp.equals("a")) {
			service.add(test);
		} else if (auvp.equals("u")) {
			service.update(test);
		}
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}

	/**
	 * 删除
	 *
	 * @param pk
	 * @return
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public ActionResultModel delete(String pks) {
		ActionResultModel actionResultModel = new ActionResultModel();
		service.delete(pks);
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}

	// 导出excel方法
	@RequestMapping("exportExcel")
	public void exportExcel(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute("state", null);
		// 生成提示信息，
		response.setContentType("application/vnd.ms-excel");
		String codedFileName = null;
		OutputStream fOut = null;
		try {
			// 进行转码，使其支持中文文件名
			codedFileName = java.net.URLEncoder.encode("测试", "UTF-8");
			response.setHeader("content-disposition", "attachment;filename=" + codedFileName + ".xls");
			
			List list = service.query(request);
			Workbook bean = ExcelExportUtils.createWorkbook(list, fields);
			
			fOut = response.getOutputStream();
			bean.write(fOut);
		} catch (UnsupportedEncodingException e1) {
		} catch (Exception e) {
		} finally {
			try {
				fOut.flush();
				fOut.close();
			} catch (IOException e) {
			}
			session.setAttribute("state", "open");
		}
		System.out.println("文件生成...");
	}
	
	@RequestMapping(value="/importExcel",produces="text/html;charset=UTF-8")
	public String importExcel(@RequestParam(value = "file", required = true) MultipartFile file,HttpServletRequest request) {
		try {
			Workbook wb = WorkbookFactory.create(file.getInputStream());
			Sheet sheet = wb.getSheetAt(0);
			List<Test> list = ExcelImportUtils.parseSheet(
					Test.class, TestVerifyBuilder.getInstance(), sheet, 1);
			service.importExcel(list);
			request.setAttribute("message", "成功导入"+list.size()+"条");
		} catch (Exception e) {
			request.setAttribute("message", e.getMessage().split("\r\n"));
			e.printStackTrace();
		}
		request.setAttribute("path", "/test.shtml");
		return "common/uploadfileMessage";
	}
	
	@RequestMapping("/download")  
    public void downloadFile(HttpServletRequest request, HttpServletResponse response){
		String realPath = request.getSession().getServletContext().getRealPath("/");
		String path = realPath +"templates/test.xlsx";
        try {
        	FileUtil.writeFileToResponse(new File(path), response, "test.xlsx", request);
		} catch (IOException e) {
			e.printStackTrace();
		}
    } 

}
