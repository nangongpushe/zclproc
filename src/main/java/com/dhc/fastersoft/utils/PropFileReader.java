package com.dhc.fastersoft.utils;

import java.io.IOException;

import java.io.InputStream;

import java.util.Properties;
/**
 * 
 * @author mengxq
 *屬性文件、屬性字段讀取
 *參數：fileName 需讀取的屬性文件名,proName 需讀取的屬性字段
 *屬性文件位置只能為src目錄下
 */

public class PropFileReader {

	public String getPorpertyValue(String fileName,String proName){
		InputStream inputStream  =   this .getClass().getClassLoader().getResourceAsStream(fileName);    
		Properties p  =   new  Properties();    
		try {    
			p.load(inputStream);    

		}catch(IOException e1){    

			e1.printStackTrace();
		}     
		return p.getProperty(proName);
}

	public  static void main(String[] args){
		PropFileReader p1  = new PropFileReader();
		System.out.println(p1.getPorpertyValue("log4j.properties","log4j.appender.File.File"));
	} 
}
