package com.dhc.fastersoft.controller.system;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dhc.fastersoft.common.Constant;

@Controller
@RequestMapping(value="/files")
public class SourceFileController {

	
	@RequestMapping(value="/code/{fileName}",method=RequestMethod.GET)
	public ResponseEntity<byte[]> getSourceFile(HttpServletRequest request,HttpServletResponse response,@PathVariable("fileName")String fileName)throws Exception{
	    String realPath=request.getSession().getServletContext().getRealPath("/");
	    String subfix = request.getRequestURI().substring(request.getRequestURI().lastIndexOf('.'));
	    File file = new File(realPath + Constant.EXPORT_PATH + fileName + subfix);
	    System.out.println(file.getPath());
	    if(file.exists()) {
	    	HttpHeaders headers = new HttpHeaders();
		    String downloadFielName = new String(file.getName().getBytes("GBK"),"iso-8859-1");
		    headers.setContentDispositionFormData("attachment", downloadFielName);
		    headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		    return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers, HttpStatus.OK);
	    }else {
	    	response.setCharacterEncoding("GBK");
		    response.getWriter().write("<script>alert('文件不存在');</script>");
	    	return null;
	    }
	}
}
