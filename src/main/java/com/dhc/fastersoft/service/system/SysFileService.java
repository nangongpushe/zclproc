package com.dhc.fastersoft.service.system;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import com.dhc.fastersoft.entity.system.SysFile;

public interface SysFileService {
	
	String saveFile(File file);
	
	String uploadFile(HttpServletRequest request,String fileId,MultipartFile file,String folderName);
	public String uploadFiles(HttpServletRequest request,String groupId,MultipartFile[] files, String string);
	
	public String uploadFiles(HttpServletRequest request,String groupId,MultipartFile[] files, String string,String[] param);

	
	SysFile selectById(String fileId);
	List<SysFile> getFilesByGroupId(String groupId);

	int delete(String id);

	SysFile getByID(String id);


}
