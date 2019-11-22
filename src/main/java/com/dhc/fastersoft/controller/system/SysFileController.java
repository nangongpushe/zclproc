package com.dhc.fastersoft.controller.system;

import com.dhc.fastersoft.common.Constant;
import com.dhc.fastersoft.entity.QualityTemplet;
import com.dhc.fastersoft.entity.QualityTempletItem;
import com.dhc.fastersoft.entity.system.SysFile;
import com.dhc.fastersoft.service.QualityTempletItemService;
import com.dhc.fastersoft.service.QualityTempletService;
import com.dhc.fastersoft.service.system.SysFileService;
import com.dhc.fastersoft.utils.FileUtil;
import com.dhc.fastersoft.utils.LayEntity;
import com.dhc.fastersoft.utils.PropFileReader;
import eu.bitwalker.useragentutils.Browser;
import eu.bitwalker.useragentutils.UserAgent;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.activation.FileDataSource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.activation.DataSource;
import java.io.*;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/sysFile")
public class SysFileController {
	
	@Autowired
	private SysFileService sysFileService;
	@Autowired
	QualityTempletService qualityTempletService;

	@Autowired
	QualityTempletItemService qualityTempletItemService;
    /**
     * @return  
    * @Title: download 
    * @Description: 根据图片名字下载图片
    * @param @param request
    * @param @param filename
    * @throws 
    */ 
    
    @RequestMapping(value="/download")
    public ResponseEntity<byte[]> download(HttpServletRequest request,
            @RequestParam("fileId") String fileId,
            Model model,HttpServletResponse response)throws Exception {
    	 //下载文件路径
    	SysFile sysFile = sysFileService.selectById(fileId);
	       //下载文件路径
		StringBuilder realPath = new StringBuilder();
		PropFileReader propFileReader = new PropFileReader();
		String realPath1 = propFileReader.getPorpertyValue("filePaths.properties","update_url");
		realPath.append(realPath1).append("/"+sysFile.getDownloadUrl()) ;
	       /*String realPath=request.getSession().getServletContext().getRealPath(sysFile.getDownloadUrl());*/
	     /*  String path = request.getServletContext().getRealPath("/images/");*/
	       File file = new File(realPath + File.separator);

	       if(file.exists()){
	       	/*    String path = request.getServletContext().getRealPath("/images/");
        		File file = new File(path + File.separator + filename);*/
			   HttpHeaders headers = new HttpHeaders();
			   //下载显示的文件名，解决中文名称乱码问题
			   String downloadFielName = new String(sysFile.getFileName().getBytes("GBK"),"iso-8859-1");
			   //通知浏览器以attachment（下载方式）打开图片
			   headers.setContentDispositionFormData("attachment", downloadFielName);
			   //application/octet-stream ： 二进制流数据（最常见的文件下载）。
			   headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			   return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),
					   headers, HttpStatus.OK);
		   }else{
			   response.setCharacterEncoding("UTF-8");
//			   response.getWriter().write("<html><script src='../js/jquery.min.js'></script><script src='../assets/layui/layui.all.js'></script><body><script>$(function(){layer.alert('文件不存在',function(){window.history.back()});});</script></body></html>");
			   response.getWriter().write("<script>alert('文件不存在');window.history.back()</script>");
			   return null;
		   }
    }
    /**
     * 按数据库的路径下载
     * @param request
     * @param response
     * @param fileId
     */
   @RequestMapping("/downloadKIN")  
    public void downloadFile1(HttpServletRequest request, HttpServletResponse response,@RequestParam("fileId") String fileId){
	   //下载文件路径
   	SysFile sysFile = sysFileService.selectById(fileId);
	       //下载文件路径
	       String realPath=request.getSession().getServletContext().getRealPath(sysFile.getDownloadUrl());
        try {
        	FileUtil.writeFileToResponse(new File(realPath), response, sysFile.getFileName(), request);
		} catch (IOException e) {
			e.printStackTrace();
		}
    } 
	@RequestMapping(value="/uploadFile")
	@ResponseBody
	public LayEntity upFile(MultipartFile file,HttpServletRequest request){
		LayEntity layFileEntity = new LayEntity();
		Map<String,Object> data  = new HashMap<String, Object>();
		
		String uuid = UUID.randomUUID().toString().replace("-", "");
		data.put("fileId", uuid);
		data.put("fileName", file.getOriginalFilename());
		try {
			String  fileMsg = sysFileService.uploadFile(request, uuid, file, null);
			if (fileMsg.equals("上传失败！只能上传后缀名为：xls,xlsx,docx,doc,png,jpg,pdf,txt")){
				data.put("fileName", null);
				layFileEntity.setCode(1);
			}else {
				layFileEntity.setCode(Constant.SUCCESS_CODE);
				layFileEntity.setData(data);
			}
		    layFileEntity.setMsg(fileMsg);
		} catch (Exception e) {
			layFileEntity.setCode(1);
		    layFileEntity.setMsg("上传失败");
			e.printStackTrace();
		}
		
		return layFileEntity;
	}
	/**
	 * 新文件upload模块
	 * @param file
	 * @param request
	 * @param type  规定的导入文件后缀名以逗号隔开xls,xlsx,jpg
	 * @return
	 */
	@RequestMapping(value="/uploadFileNew")
	@ResponseBody
	public LayEntity upFileNew(MultipartFile file,HttpServletRequest request,String type,String groupId){
		LayEntity layFileEntity = new LayEntity();
		Map<String,Object> data  = new HashMap<String, Object>();
		String fileName = file.getOriginalFilename();
        String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);
        String[] str=type.split(",");
        Map<String, String> map=new HashMap<String, String>();
        for (int i = 0; i < str.length; i++) {
        	map.put(str[i], str[i]);
		}
         boolean containsKey = map.containsKey(suffix);
        if (!containsKey) {
        	layFileEntity.setCode(Constant.FAIL_CODE);
		    layFileEntity.setMsg("请选择正确的文件格式");
		    return layFileEntity;
		}
		String uuid = UUID.randomUUID().toString().replace("-", "");
		data.put("fileId", uuid);
		data.put("fileName", file.getOriginalFilename());
		data.put("groupId", groupId);
		try {
			sysFileService.uploadFile(request, uuid, file, groupId);
			layFileEntity.setCode(Constant.SUCCESS_CODE);
			layFileEntity.setData(data);
		    layFileEntity.setMsg("上传成功");
		} catch (Exception e) {
			layFileEntity.setCode(Constant.FAIL_CODE);
		    layFileEntity.setMsg("上传失败");
			e.printStackTrace();
		}
		
		return layFileEntity;
	}
	@RequestMapping("/downloadTemplate")
	public void downloadFile(HttpServletRequest request, HttpServletResponse response){
		String realPath = request.getSession().getServletContext().getRealPath("/");
		String fileName = request.getParameter("filename");
		String path = realPath +"templates/"+fileName+".xlsx";
		try {
			FileUtil.writeFileToResponse(new File(path), response, fileName+".xlsx", request);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping("/downloadTemplate1")
	public void downloadFile1(HttpServletRequest request, HttpServletResponse response){
		String realPath = request.getSession().getServletContext().getRealPath("/");
		String fileName = request.getParameter("filename");
		String path = realPath +"templates/"+fileName+".xls";
		try {
			FileUtil.writeFileToResponse(new File(path), response, fileName+".xls", request);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@RequestMapping("/downloadResultTemplate")
	public void downloadResultTemplate(HttpServletRequest request, HttpServletResponse response)throws Exception {
		String templateId = request.getParameter("templateId");
		QualityTemplet qualityTemplet = qualityTempletService.getByID(templateId);
		List<QualityTempletItem> qualityTempletItem = qualityTempletItemService.getByID(templateId);
		//定义表头
		String[] excelMainHeader = {"样品编号", "样品名称", "抽样基数(吨)","抽样地点","承检单位","检验开始日期","检验结束日期","受检单位","产品等级","储存方式","粮食产地","入库年度","收获年份"};
		int mainLength = excelMainHeader.length;
		int templateLength = qualityTempletItem.size();
		int excelTitleLenght = mainLength+templateLength;
		String excelHeader[] = new String[excelTitleLenght];
		for(int i= 0;i<mainLength;i++){
			//插入主表表头
			excelHeader[i] =excelMainHeader[i];
		}
		for(int i=mainLength;i<excelTitleLenght;i++){
			//插入检验结果表头
			excelHeader[i] = qualityTempletItem.get(i-mainLength).getItemName();
		}
		//这里需要说明一个问题：如果是 Offices 2007以前的Excel版本，new的对象是：**HSSFWorkbook** ，Offices 2007以后的Excel版本new的对象才是
		XSSFWorkbook  wb = new XSSFWorkbook();
		//生成一个工作表（解析不了名称中带‘/’的）
		Sheet sheet = wb.createSheet("质量模板");
		Row row = sheet.createRow((int) 0);
		XSSFCellStyle style = wb.createCellStyle(); style.setAlignment(CellStyle.ALIGN_CENTER);
		for (int i = 0; i < excelHeader.length; i++) {
			Cell cell = row.createCell(i);
			cell.setCellValue(excelHeader[i]);
			cell.setCellStyle(style);
		}
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-disposition", "attachment;filename="+new String(qualityTemplet.getTempletName().getBytes(),"ISO8859-1")+".xlsx");
		OutputStream ouputStream = response.getOutputStream();
		wb.write(ouputStream);
		ouputStream.flush();
		ouputStream.close();
	}

	@RequestMapping("/delete")
	@ResponseBody
	public Map  delete(String id){
		Map<String,Object> result = new HashMap<>();
		SysFile sf=sysFileService.getByID(id);
        boolean bl = deleteFile(sf.getPhysicalPath());
        	int count=sysFileService.delete(id);
    		if(count>0) {
				result.put("success", true);
    		}else {
				result.put("success", false);
    		}
		return result;
	}

	public static boolean  deleteFile(String fileName){
		File file = new File(fileName);
		if(file.isFile() && file.exists()){
			Boolean succeedDelete = file.delete();
			if(succeedDelete){
				return true;
			}
			else{
				return false;
			}
		}else{
			return false;
		}
	}

	/**
	 * 文件预览
	 * @param fileId
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	///sysFile/openFile
	@RequestMapping("/openFile")
	public void view(@RequestParam("fileId") String fileId,
					 HttpServletRequest request,
					 HttpServletResponse response) throws Exception {
		SysFile sysFile = sysFileService.selectById(fileId);

		StringBuilder filePath = new StringBuilder();
		PropFileReader propFileReader = new PropFileReader();
		String realPath1 = propFileReader.getPorpertyValue("filePaths.properties","update_url");
		String realPath=realPath1+"/"+sysFile.getDownloadUrl();
		/*String realPath=request.getSession().getServletContext().getRealPath(sysFile.getDownloadUrl());*/
		File file = new File(realPath);
		DataSource dataSource = new FileDataSource(file);
		//附件显示名
		String fjName = "";
		fjName = sysFile.getFileName();

		String suffix = "";
		if (fjName.indexOf(".") != -1) {
			suffix = fjName.substring(fjName.lastIndexOf(".") + 1);
			suffix.trim().toLowerCase();
		}

			boolean isPdf = suffix.equalsIgnoreCase("pdf") ? true : false;
			if(isPdf) {
				setFileDownloadHeader(request, response,
						fjName,true);
			} else {
				setFileDownloadHeader(request, response,
						fjName,false);
			}
		InputStream is = dataSource.getInputStream();
		IOUtils.copy(is, response.getOutputStream());
		response.getOutputStream().flush();
		IOUtils.closeQuietly(is);
		IOUtils.closeQuietly(response.getOutputStream());
	}

	/**
	 * 设置让浏览器弹出下载对话框的Header.
	 *
	 * @param fileName 下载后的文件名.
	 */
	private static void setFileDownloadHeader(HttpServletRequest request,
											 HttpServletResponse response, String fileName, Boolean isPdf)
			throws UnsupportedEncodingException {
		// 中文文件名支持
		String encodedFileName = null;
		// 替换空格，否则firefox下有空格文件名会被截断,其他浏览器会将空格替换成+号
		encodedFileName = fileName.trim().replaceAll(" ", "_");

		String userAgent = request.getHeader("User-Agent");
		boolean isMSIE = ((userAgent != null) && userAgent.contains("MSIE")||userAgent.contains("Trident"));
		String name = UserAgent.parseUserAgentString(request.getHeader("User-Agent")).getBrowser().getName();
		if (isMSIE || name.equalsIgnoreCase(Browser.EDGE.getName())) {
			encodedFileName = URLEncoder.encode(encodedFileName, "UTF-8");
		} else {
			encodedFileName = new String(fileName.getBytes("UTF-8"),
					"ISO8859-1");
		}

		String contentDisposition = "attachment";
		contentDisposition = "inline";

		response.setHeader("Content-Disposition", contentDisposition + "; filename=\""
				+ encodedFileName + "\"");
		if (isPdf) {
			response.setContentType("application/pdf;charset=utf-8");
		}
		response.setCharacterEncoding("UTF-8");
	}

	public String getFileUrl(String fileId)throws Exception {
		//下载文件路径
		SysFile sysFile = sysFileService.selectById(fileId);
		return sysFile.getDownloadUrl();
	}

	/**
	 * 文件预览
	 * @param fileUrl
	 * @throws Exception
	 */
	///sysFile/openExcel
	@RequestMapping("/openExcel")
	public String openExcel(@RequestParam("fileUrl") String fileUrl) throws Exception {
		return "pageoffice/pageoffice-word-edit";
	}

}
