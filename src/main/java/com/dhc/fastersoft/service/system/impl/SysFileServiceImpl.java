package com.dhc.fastersoft.service.system.impl;

import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.system.SysFileDao;
import com.dhc.fastersoft.entity.system.SysFile;
import com.dhc.fastersoft.service.system.SysFileService;
import com.dhc.fastersoft.utils.FileUtil;
import com.dhc.fastersoft.utils.PropFileReader;
import com.dhc.fastersoft.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Service("sysFile")
public class SysFileServiceImpl implements SysFileService{
	
	@Autowired
	private SysFileDao sysFileDao;

	@Override
	public String saveFile(File file) {
		
		return null;
	}

	@Override
	public String uploadFile(HttpServletRequest request, String fileId,
			MultipartFile file, String groupId) {
		String userId = TokenManager.getSysUserId();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		//处理文件
		if(file.isEmpty()){
			return "文件为空";
		}
		StringBuilder filePath = new StringBuilder();
		PropFileReader propFileReader = new PropFileReader();
		String realPath = propFileReader.getPorpertyValue("filePaths.properties","update_url");
		/*String realPath=request.getSession().getServletContext().getRealPath(Constant.UPLOAD_PATH);*/
		
		//获取文件名称
		String fileName = file.getOriginalFilename();
		String prefix=fileName.substring(fileName.lastIndexOf(".")+1);//获取文件后缀\
		String reName=dateFormat.format(new Date())+"."+prefix;
		filePath.append(realPath).append("/upload").append("/"+reName);
		if (prefix.equals("xls")||prefix.equals("xlsx")||prefix.equals("docx")||prefix.equals("doc")||prefix.equals("png")||prefix.equals("jpg")||prefix.equals("pdf")||prefix.equals("PDF")||prefix.equals("txt")){
			try {
				FileUtil.isExist(filePath.toString());		//路径不存在，创建路径
				File uploadFile = new File(filePath.toString());
				if (!uploadFile.exists()) {
					uploadFile.mkdirs();
				}

				file.transferTo(uploadFile);

				SysFile sf = new SysFile();
				sf.setId(fileId);
				sf.setGroupId(groupId);
				sf.setFileName(fileName);
				sf.setFileType(prefix);
				Long size =(file.getSize()/1024);
				sf.setFileSize(size);
				sf.setCreator(userId);
				sf.setCreateDate(new Date());
				sf.setSavingDays(30L);
				sf.setFileRename(reName);
				sf.setPhysicalPath(filePath.toString());		//物理路径
				sf.setDownloadUrl("upload/"+reName);
				sysFileDao.insert(sf);
			} catch (IllegalStateException e) {
				e.printStackTrace();
				return "上传失败！请检查文件重新上传。";
			} catch (IOException e) {
				e.printStackTrace();
				return "上传失败！请检查文件重新上传。";

			}
		}else {
			return "上传失败！只能上传后缀名为：xls,xlsx,docx,doc,png,jpg,pdf,PDF,txt";
		}

		return "上传成功！";
	}
	
	@Override
	public String uploadFiles(HttpServletRequest request,String groupId,
			MultipartFile[] files, String folderName) {
		//String fileId;
			SysFile sf =null;//改名後的文件名稱
			String userId = TokenManager.getSysUserId();
				//处理文件
				String uuid = null;
				if("".equals(files)){
					System.err.println("文件为空！");
					return null;
				}		
				
				String[] pictureId=request.getParameterValues("pictureId");
				/*1.pictureId 不为空则获取groupId为保存值   保存值为uuid 为空则获取新的uuid*/
				if("".equals(pictureId)||pictureId==null||pictureId.length==0){
					uuid = UUID.randomUUID().toString().replace("-", "");
					/*如果将原来的图片全部删除，前台传回来的的pictureId也为空，则查出这个collection.根据groupid属性删除之前这个藏品上传的全部图片*/
					String id = request.getParameter("id");
					if(!"".equals(groupId)&&groupId!=null){
						
						sysFileDao.deleteByGroupId(groupId);
					}
				}else {
					
					uuid = request.getParameter("groupId");
					/*查询原本有的图片*/
					List<SysFile> sysFiles = sysFileDao.getFilesByGroupId(uuid);
					/*创建两个对比图片的list*/
					List<String> sysFilesIds = new ArrayList<String>();
					List<String> pictureIds = new ArrayList<String>();
					for(SysFile sysFile : sysFiles){
						sysFilesIds.add(sysFile.getId()+"");
					}
					for(String str:pictureId){
						pictureIds.add(str);
					}
					/*对比list有没有变化*/
					List<String> list = StringUtil.compareArray(pictureIds, sysFilesIds);
					/*执行删除*/
					for(String deleteIds:list){
						sysFileDao.deleteByPrimaryKey(deleteIds);
					}
				}
				
				
				for(MultipartFile file : files){
					StringBuilder filePath = new StringBuilder();
					PropFileReader propFileReader = new PropFileReader();
					String realPath = propFileReader.getPorpertyValue("filePaths.properties","update_url");
					filePath.append(realPath).append("/uploadFiles").append("/"+folderName).append("/");

					//filePath.append(getRealPath()).append(folderName).append("/");
					FileUtil.isExist(filePath.toString());		//路径不存在，创建路径
					//获取文件名称
					String fileName = file.getOriginalFilename();
					String prefix=fileName.substring(fileName.lastIndexOf(".")+1);//获取文件后缀
					SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmssSSS");
					String reName=df.format(new Date())+"."+prefix;
					filePath.append(reName);
				
					try {
						//保存文件
						file.transferTo(new File(filePath.toString()));
						//保存文件歷史
						 sf = new SysFile();
						//fileId = sysFileDao.getFileId();
						sf.setId(UUID.randomUUID().toString().replace("-", ""));
						//String groupId = sysFileDao.getFileGroupId();
						
						sf.setGroupId(uuid);							//文件包编号 一次上传多个文件时用到。
						sf.setFileName(file.getOriginalFilename());		//原文件名
						sf.setFileName(fileName);
						sf.setFileType(prefix);
						Long size =(file.getSize()/1024);
						sf.setFileSize(size);		
						sf.setCreator(userId);
						sf.setCreateDate(new Date());
						sf.setSavingDays(30L);
						sf.setFileRename(reName);
						sf.setPhysicalPath(filePath.toString());		//物理路径
						sf.setDownloadUrl("uploadFiles/"+folderName+"/"+reName);
						sysFileDao.insert(sf);
						
						
					} catch (IllegalStateException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
						return null;
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
						return null;
					}
					
				}
				return uuid;
				
	}
	
	
	
	
	@Override
	public SysFile selectById(String fileId) {
		// TODO Auto-generated method stub
		return sysFileDao.selectByPrimaryKey(fileId);
	}
	
	@Override
	public List<SysFile> getFilesByGroupId(String groupId) {
		// TODO Auto-generated method stub
		if(groupId == null)
			return new ArrayList<SysFile>();
		return sysFileDao.getFilesByGroupId(groupId);
	}

	@Override
	public String uploadFiles(HttpServletRequest request, String groupId, MultipartFile[] files, String folderName,String[] param) {
		SysFile sf =null;//改名後的文件名稱
		String userId = TokenManager.getSysUserId();
			//处理文件
			String uuid = null;
			if("".equals(files)){
				System.err.println("文件为空！");
				return null;
			}		
			
			String[] pictureId = param;
			/*1.pictureId 不为空则获取groupId为保存值   保存值为uuid 为空则获取新的uuid*/
			if("".equals(pictureId)||pictureId==null||pictureId.length==0){
				uuid = UUID.randomUUID().toString().replace("-", "");
				/*如果将原来的图片全部删除，前台传回来的的pictureId也为空，则查出这个collection.根据groupid属性删除之前这个藏品上传的全部图片*/
				String id = request.getParameter("id");
				if(!"".equals(groupId)&&groupId!=null){
					sysFileDao.deleteByGroupId(groupId);
				}
			}else {
				uuid = groupId;
				/*查询原本有的图片*/
				List<SysFile> sysFiles = sysFileDao.getFilesByGroupId(uuid);
				/*创建两个对比图片的list*/
				List<String> sysFilesIds = new ArrayList<String>();
				List<String> pictureIds = new ArrayList<String>();
				for(SysFile sysFile : sysFiles)
					sysFilesIds.add(sysFile.getId()+"");
				for(String str:pictureId)
					pictureIds.add(str);
				/*对比list有没有变化*/
				List<String> list = StringUtil.compareArray(pictureIds, sysFilesIds);
				/*执行删除*/
				for(String deleteIds:list){
					sysFileDao.deleteByPrimaryKey(deleteIds);
				}
			}
			
			
			for(MultipartFile file : files){
				StringBuilder filePath = new StringBuilder();
				PropFileReader propFileReader = new PropFileReader();
				String realPath = propFileReader.getPorpertyValue("filePaths.properties","update_url");
				filePath.append(realPath).append("/uploadFiles").append("/"+folderName).append("/");
				/*filePath.append(request.getSession().getServletContext().getRealPath("/")).append("uploadFiles/").append(folderName).append("/");*/
				FileUtil.isExist(filePath.toString());		//路径不存在，创建路径
				//获取文件名称
				String fileName = file.getOriginalFilename();
				String prefix=fileName.substring(fileName.lastIndexOf(".")+1);//获取文件后缀
				SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmssSSS");
				String reName=df.format(new Date())+"."+prefix;
				filePath.append(reName);
				try {
					//保存文件
					file.transferTo(new File(filePath.toString()));
					//保存文件歷史
					 sf = new SysFile();
					//fileId = sysFileDao.getFileId();
					sf.setId(UUID.randomUUID().toString().replace("-", ""));
					//String groupId = sysFileDao.getFileGroupId();
					
					sf.setGroupId(uuid);							//文件包编号 一次上传多个文件时用到。
					sf.setFileName(file.getOriginalFilename());		//原文件名
				
		
					sf.setFileName(fileName);
					sf.setFileType(prefix);
					Long size =(file.getSize()/1024);
					sf.setFileSize(size);		
					sf.setCreator(userId);
					sf.setCreateDate(new Date());
					sf.setSavingDays(30L);
					sf.setFileRename(reName);
					sf.setPhysicalPath(filePath.toString());		//物理路径
					sf.setDownloadUrl("uploadFiles/"+folderName+"/"+reName);
					sysFileDao.insert(sf);
					
					
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					return null;
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					return null;
				}
				
			}
			return uuid;
	}

	@Override
	public int delete(String id) {
		// TODO Auto-generated method stub
		return sysFileDao.delete(id);
	}

	@Override
	public SysFile getByID(String id) {
		// TODO Auto-generated method stub
		return sysFileDao.selectByPrimaryKey(id);
	}


	

}
