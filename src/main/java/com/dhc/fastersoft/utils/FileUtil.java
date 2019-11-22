
package com.dhc.fastersoft.utils;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.output.FileWriterWithEncoding;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import com.dhc.fastersoft.controller.TestController;
//import com.dhc.fastersoft.util.RequestUtil;

/**
 * 文件操作工具类
 * 实现文件的创建、删除、复制、压缩、解压以及目录的创建、删除、复制、压缩解压等功能
 * @version 2013-06-21
 */
public class FileUtil extends org.apache.commons.io.FileUtils {
	
	public static final String CONTENT_TYPE = "application/octet-stream; charset=utf-8";
	public static final String CONTENT_LENGTH = "Content-Length";
	public static final String CONTENT_DISPOSITION = "Content-Disposition";
	private static Logger log = Logger.getLogger(TestController.class);

	/**
	 * 复制单个文件，如果目标文件存在，则不覆盖
	 * @param srcFileName 待复制的文件名
	 * @param descFileName 目标文件名
	 * @return 如果复制成功，则返回true，否则返回false
	 */
	public static boolean copyFile(String srcFileName, String descFileName) {
		return FileUtil.copyFileCover(srcFileName, descFileName, false);
	}

	/**
	 * 复制单个文件
	 * @param srcFileName 待复制的文件名
	 * @param descFileName 目标文件名
	 * @param coverlay 如果目标文件已存在，是否覆盖
	 * @return 如果复制成功，则返回true，否则返回false
	 */
	public static boolean copyFileCover(String srcFileName,
			String descFileName, boolean coverlay) {
		File srcFile = new File(srcFileName);
		// 判断源文件是否存在
		if (!srcFile.exists()) {
			log.debug("复制文件失败，源文件 " + srcFileName + " 不存在!");
			return false;
		}
		// 判断源文件是否是合法的文件
		else if (!srcFile.isFile()) {
			log.debug("复制文件失败，" + srcFileName + " 不是一个文件!");
			return false;
		}
		File descFile = new File(descFileName);
		// 判断目标文件是否存在
		if (descFile.exists()) {
			// 如果目标文件存在，并且允许覆盖
			if (coverlay) {
				log.debug("目标文件已存在，准备删除!");
				if (!FileUtil.delFile(descFileName)) {
					log.debug("删除目标文件 " + descFileName + " 失败!");
					return false;
				}
			} else {
				log.debug("复制文件失败，目标文件 " + descFileName + " 已存在!");
				return false;
			}
		} else {
			if (!descFile.getParentFile().exists()) {
				// 如果目标文件所在的目录不存在，则创建目录
				log.debug("目标文件所在的目录不存在，创建目录!");
				// 创建目标文件所在的目录
				if (!descFile.getParentFile().mkdirs()) {
					log.debug("创建目标文件所在的目录失败!");
					return false;
				}
			}
		}

		// 准备复制文件
		// 读取的位数
		int readByte = 0;
		InputStream ins = null;
		OutputStream outs = null;
		try {
			// 打开源文件
			ins = new FileInputStream(srcFile);
			// 打开目标文件的输出流
			outs = new FileOutputStream(descFile);
			byte[] buf = new byte[1024];
			// 一次读取1024个字节，当readByte为-1时表示文件已经读取完毕
			while ((readByte = ins.read(buf)) != -1) {
				// 将读取的字节流写入到输出流
				outs.write(buf, 0, readByte);
			}
			log.debug("复制单个文件 " + srcFileName + " 到" + descFileName
					+ "成功!");
			return true;
		} catch (Exception e) {
			log.debug("复制文件失败：" + e.getMessage());
			return false;
		} finally {
			// 关闭输入输出流，首先关闭输出流，然后再关闭输入流
			if (outs != null) {
				try {
					outs.close();
				} catch (IOException oute) {
					oute.printStackTrace();
				}
			}
			if (ins != null) {
				try {
					ins.close();
				} catch (IOException ine) {
					ine.printStackTrace();
				}
			}
		}
	}

	/**
	 * 复制整个目录的内容，如果目标目录存在，则不覆盖
	 * @param srcDirName 源目录名
	 * @param descDirName 目标目录名
	 * @return 如果复制成功返回true，否则返回false
	 */
	public static boolean copyDirectory(String srcDirName, String descDirName) {
		return FileUtil.copyDirectoryCover(srcDirName, descDirName,
				false);
	}

	/**
	 * 复制整个目录的内容 
	 * @param srcDirName 源目录名
	 * @param descDirName 目标目录名
	 * @param coverlay 如果目标目录存在，是否覆盖
	 * @return 如果复制成功返回true，否则返回false
	 */
	public static boolean copyDirectoryCover(String srcDirName,
			String descDirName, boolean coverlay) {
		File srcDir = new File(srcDirName);
		// 判断源目录是否存在
		if (!srcDir.exists()) {
			log.debug("复制目录失败，源目录 " + srcDirName + " 不存在!");
			return false;
		}
		// 判断源目录是否是目录
		else if (!srcDir.isDirectory()) {
			log.debug("复制目录失败，" + srcDirName + " 不是一个目录!");
			return false;
		}
		// 如果目标文件夹名不以文件分隔符结尾，自动添加文件分隔符
		String descDirNames = descDirName;
		if (!descDirNames.endsWith(File.separator)) {
			descDirNames = descDirNames + File.separator;
		}
		File descDir = new File(descDirNames);
		// 如果目标文件夹存在
		if (descDir.exists()) {
			if (coverlay) {
				// 允许覆盖目标目录
				log.debug("目标目录已存在，准备删除!");
				if (!FileUtil.delFile(descDirNames)) {
					log.debug("删除目录 " + descDirNames + " 失败!");
					return false;
				}
			} else {
				log.debug("目标目录复制失败，目标目录 " + descDirNames + " 已存在!");
				return false;
			}
		} else {
			// 创建目标目录
			log.debug("目标目录不存在，准备创建!");
			if (!descDir.mkdirs()) {
				log.debug("创建目标目录失败!");
				return false;
			}

		}

		boolean flag = true;
		// 列出源目录下的所有文件名和子目录名
		File[] files = srcDir.listFiles();
		for (int i = 0; i < files.length; i++) {
			// 如果是一个单个文件，则直接复制
			if (files[i].isFile()) {
				flag = FileUtil.copyFile(files[i].getAbsolutePath(),
						descDirName + files[i].getName());
				// 如果拷贝文件失败，则退出循环
				if (!flag) {
					break;
				}
			}
			// 如果是子目录，则继续复制目录
			if (files[i].isDirectory()) {
				flag = FileUtil.copyDirectory(files[i]
						.getAbsolutePath(), descDirName + files[i].getName());
				// 如果拷贝目录失败，则退出循环
				if (!flag) {
					break;
				}
			}
		}

		if (!flag) {
			log.debug("复制目录 " + srcDirName + " 到 " + descDirName + " 失败!");
			return false;
		}
		log.debug("复制目录 " + srcDirName + " 到 " + descDirName + " 成功!");
		return true;

	}

	/**
	 * 
	 * 删除文件，可以删除单个文件或文件夹
	 * 
	 * @param fileName 被删除的文件名
	 * @return 如果删除成功，则返回true，否是返回false
	 */
	public static boolean delFile(String fileName) {
 		File file = new File(fileName);
		if (!file.exists()) {
			log.debug(fileName + " 文件不存在!");
			return true;
		} else {
			if (file.isFile()) {
				return FileUtil.deleteFile(fileName);
			} else {
				return FileUtil.deleteDirectory(fileName);
			}
		}
	}

	/**
	 * 
	 * 删除单个文件
	 * 
	 * @param fileName 被删除的文件名
	 * @return 如果删除成功，则返回true，否则返回false
	 */
	public static boolean deleteFile(String fileName) {
		File file = new File(fileName);
		if (file.exists() && file.isFile()) {
			if (file.delete()) {
				log.debug("删除单个文件 " + fileName + " 成功!");
				return true;
			} else {
				log.debug("删除单个文件 " + fileName + " 失败!");
				return false;
			}
		} else {
			log.debug(fileName + " 文件不存在!");
			return true;
		}
	}

	/**
	 * 
	 * 删除目录及目录下的文件
	 * 
	 * @param dirName 被删除的目录所在的文件路径
	 * @return 如果目录删除成功，则返回true，否则返回false
	 */
	public static boolean deleteDirectory(String dirName) {
		String dirNames = dirName;
		if (!dirNames.endsWith(File.separator)) {
			dirNames = dirNames + File.separator;
		}
		File dirFile = new File(dirNames);
		if (!dirFile.exists() || !dirFile.isDirectory()) {
			log.debug(dirNames + " 目录不存在!");
			return true;
		}
		boolean flag = true;
		// 列出全部文件及子目录
		File[] files = dirFile.listFiles();
		for (int i = 0; i < files.length; i++) {
			// 删除子文件
			if (files[i].isFile()) {
				flag = FileUtil.deleteFile(files[i].getAbsolutePath());
				// 如果删除文件失败，则退出循环
				if (!flag) {
					break;
				}
			}
			// 删除子目录
			else if (files[i].isDirectory()) {
				flag = FileUtil.deleteDirectory(files[i]
						.getAbsolutePath());
				// 如果删除子目录失败，则退出循环
				if (!flag) {
					break;
				}
			}
		}

		if (!flag) {
			log.debug("删除目录失败!");
			return false;
		}
		// 删除当前目录
		if (dirFile.delete()) {
			log.debug("删除目录 " + dirName + " 成功!");
			return true;
		} else {
			log.debug("删除目录 " + dirName + " 失败!");
			return false;
		}

	}

	/**
	 * 创建文件目录
	 * @param file
	 */
	public static void createNotExistsFolder(File file) {
		if (!file.getParentFile().exists()) {
			createNotExistsFolder(file.getParentFile());
		}
		file.mkdir();
	}
	
	/**
	 * 创建单个文件
	 * @param descFileName 文件名，包含路径
	 * @return 如果创建成功，则返回true，否则返回false
	 */
	public static boolean createFile(String descFileName) {
		File file = new File(descFileName);
		if (file.exists()) {
			log.debug("文件 " + descFileName + " 已存在!");
			return false;
		}
		if (descFileName.endsWith(File.separator)) {
			log.debug(descFileName + " 为目录，不能创建目录!");
			return false;
		}
		if (!file.getParentFile().exists()) {
			// 如果文件所在的目录不存在，则创建目录
			if (!file.getParentFile().mkdirs()) {
				log.debug("创建文件所在的目录失败!");
				return false;
			}
		}

		// 创建文件
		try {
			if (file.createNewFile()) {
				log.debug(descFileName + " 文件创建成功!");
				return true;
			} else {
				log.debug(descFileName + " 文件创建失败!");
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.debug(descFileName + " 文件创建失败!");
			return false;
		}
	}
	
	public static File createOrGetFile(String descFileName) {
		File file = new File(descFileName);
		if (file.exists()) {
			log.debug("文件 " + descFileName + " 已存在!");
			return file;
		}
		if (descFileName.endsWith(File.separator)) {
			log.debug(descFileName + " 为目录，不能创建目录!");
			return null;
		}
		if (!file.getParentFile().exists()) {
			// 如果文件所在的目录不存在，则创建目录
			if (!file.getParentFile().mkdirs()) {
				log.debug("创建文件所在的目录失败!");
				return null;
			}
		}

		// 创建文件
		try {
			if (file.createNewFile()) {
				log.debug(descFileName + " 文件创建成功!");
				return file;
			} else {
				log.debug(descFileName + " 文件创建失败!");
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.debug(descFileName + " 文件创建失败!");
			return null;
		}
	}
	
	/**
	 * 创建目录
	 * @param descDirName 目录名,包含路径
	 * @return 如果创建成功，则返回true，否则返回false
	 */
	public static boolean createDirectory(String descDirName) {
		String descDirNames = descDirName;
		if (!descDirNames.endsWith(File.separator)) {
			descDirNames = descDirNames + File.separator;
		}
		File descDir = new File(descDirNames);
		if (descDir.exists()) {
			log.debug("目录 " + descDirNames + " 已存在!");
			return false;
		}
		// 创建目录
		if (descDir.mkdirs()) {
			log.debug("目录 " + descDirNames + " 创建成功!");
			return true;
		} else {
			log.debug("目录 " + descDirNames + " 创建失败!");
			return false;
		}

	}

	/**
	 * 获取待压缩文件在ZIP文件中entry的名字，即相对于跟目录的相对路径名
	 * @param dirPath 目录名
	 * @param file entry文件名
	 * @return
	 */
	private static String getEntryName(String dirPath, File file) {
		String dirPaths = dirPath;
		if (!dirPaths.endsWith(File.separator)) {
			dirPaths = dirPaths + File.separator;
		}
		String filePath = file.getAbsolutePath();
		// 对于目录，必须在entry名字后面加上"/"，表示它将以目录项存储
		if (file.isDirectory()) {
			filePath += "/";
		}
		int index = filePath.indexOf(dirPaths);

		return filePath.substring(index + dirPaths.length());
	}
	
//	/**
//	 * TODO 获取绝对路径
//	 * @param urlPath
//	 * @return
//	 */
//	public static String getAbsolutePath(String urlPath) {
//		if(StringUtils.isBlank(urlPath)) {
//			return "";
//		} else {
//			return "d:/rap/" + urlPath.substring(urlPath.indexOf("/", 1), urlPath.length());
//		}
//	}
	
	/**
	 * 将内容写入文件
	 * @param content
	 * @param filePath
	 */
	public static void writeFile(String content, String filePath) {
		try {
			if (FileUtil.createFile(filePath)){
				FileWriter fileWriter = new FileWriter(filePath, true);
				BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
				bufferedWriter.write(content);
				bufferedWriter.close();
				fileWriter.close();
			}else{
				log.info("生成失败，文件已存在！");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 将内容写入文件
	 * @param content
	 * @param filePath
	 */
	public static void writeFileWithEncoding(String content, String filePath,String encoding) {
		System.out.println("生成文件");
		try {
			if (FileUtil.createFile(filePath)){
				FileWriterWithEncoding fileWriter = new FileWriterWithEncoding(filePath,encoding, true);
				BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
				bufferedWriter.write(content);
				bufferedWriter.close();
				fileWriter.close();
			}else{
				log.info("生成失败，文件已存在！");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static File createTempFile() {
		try{
//			String tempPath = ParameterUtils.getParamValue("tempPath");
			String tempPath = getTempDirectoryPath();
			if(StringUtils.isBlank(tempPath)){
				tempPath="e:/rap/temp/";
			}
			long ms = System.currentTimeMillis();
			String fileName = tempPath+ms;
			File file = FileUtil.createOrGetFile(fileName);
			return file;
		}catch(Exception e){
			log.info("临时文件目录不存在！");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 将文件写到http输出流
	 * @author wzw 2014年11月8日
	 * @param file
	 * @param response
	 * @param newFileName
	 * @throws IOException
	 */
	public static void writeFileToResponse(File file,HttpServletResponse response,String newFileName,HttpServletRequest request) throws IOException{
		response.setContentType(CONTENT_TYPE);
		response.setHeader(CONTENT_LENGTH, String.valueOf(file.length()));
		String explorerType = RequestUtil.getExplorerType(request);
		if(explorerType==null||explorerType.contains("IE")){
			//IE
			response.setHeader(CONTENT_DISPOSITION,"attachment; filename=\""
					+ RequestUtil.encode(newFileName, "UTF-8") + "\"");
		}else{
			//fireFox/Chrome
			response.setHeader(CONTENT_DISPOSITION, "attachment; filename=" 
				+ new String(newFileName.getBytes("utf-8"), "ISO8859-1"));
		}
		setOutputStream(response,file);
	}
	/**
	 * 将文件写到http输出流
	 * @author wzw 2014年11月8日
	 * @param file
	 * @param response
	 * @param newFileName
	 * @throws IOException
	 */
	public static void writeFileToResponse(String fileContent,HttpServletResponse response,String newFileName,HttpServletRequest request) throws IOException{
		response.setContentType(CONTENT_TYPE);
		String explorerType = RequestUtil.getExplorerType(request);
		if(explorerType!=null&&explorerType.contains("IE")){
			//IE
			response.setHeader(CONTENT_DISPOSITION,"attachment; filename=\""
					+ RequestUtil.encode(newFileName, "UTF-8") + "\"");
		}else{
			//fireFox/Chrome
			response.setHeader(CONTENT_DISPOSITION, "attachment; filename=" 
				+ new String(newFileName.getBytes("utf-8"), "ISO8859-1"));
		}
		response.getWriter().write(fileContent);
	}
	
	public static void setOutputStream(final HttpServletResponse response, final File file) 
			throws IOException{
		BufferedOutputStream output = null;
		BufferedInputStream input = null;
		
		try {
			input = new BufferedInputStream(new FileInputStream(file));
			output = new BufferedOutputStream(response.getOutputStream());
			byte[] buff = new byte[2048];
			int readLen = 0;
			while((readLen = input.read(buff, 0, buff.length)) != -1){
				output.write(buff, 0, readLen);
			}
			output.flush();
		} catch (IOException e) {
			throw e;
		} finally {
			if(input != null){
				try {
					input.close();
				} catch (IOException e) {
				} finally {
					input = null;
				}
			}
			if(output != null){
				try {
					output.close();
				} catch (IOException e) {
				} finally {
					output = null;
				}
			}				
		}
	}
	
	/**
	 * 以简洁的方式显示文件大小
	 * @author wzw 2014年11月19日
	 * @param fileSize 文件大小 单位是bit
	 * @return 根据大小返回GB、MB、KB的形式
	 */
	public static String reviewFileSize(Double fileSize){
		if(fileSize==null){
			return null;
		}
		if(fileSize>1024*1024*1024){
			return String.format("%.2f", fileSize/(1024*1024*1024))+"GB";
		}
		if(fileSize>1024*1024){
			return String.format("%.2f", fileSize/(1024*1024))+"MB";
		}
		if(fileSize>1024){
			return String.format("%.2f", fileSize/1024)+"KB";
		}
		return String.format("%.2f", fileSize)+"B";
	}
	
	public static String reviewFileSize(String fileSize) {
		if(StringUtils.isBlank(fileSize)){
			return null;
		}
		Double d = Double.parseDouble(fileSize);
		return reviewFileSize(d);
	}
	
	 /**
	  * 
	  * @param path 文件夹路径是否存在，不存在创建
	  */
	 public static void isExist(String path) {
		 File file = new File(path);
		 //判断文件夹是否存在,如果不存在则创建文件夹
		 if (!file.exists()) {
			 file.mkdirs();
		 }
	 }
}
