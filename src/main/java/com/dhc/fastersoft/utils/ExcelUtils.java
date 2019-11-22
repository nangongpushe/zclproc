package com.dhc.fastersoft.utils;

import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

public class ExcelUtils {
	public String[][] array;
	int notNullArray[] = null; //new int[]{0,1,2}
	String typeArray[] = null; //new String[]{"0=int","1=int"}
	String lengthArray[] = null; //new String[]{"0=10","1=5"}
	Map<Integer, SimpleDateFormat> dateTime = new HashMap();
	Map<Integer, List> containList = new HashMap();
	
	
	public ExcelUtils(InputStream inputStream) {

		Workbook rwb = null;
		try {
			rwb = Workbook.getWorkbook(inputStream);
			Sheet sheet = rwb.getSheet(0);
			int columns = sheet.getColumns();		// 获取Excel表的列数
			int rows = sheet.getRows();
			int nilRows = 0;  // 为空的行数
//			array = new String[rows][columns];
			Cell[][] cell = new Cell[columns][rows];
			ArrayList nilNum = new ArrayList();
			for (int i = 0; i < rows; i++) {
				boolean nil = true;
				for (int j = 0; j < columns; j++) {
					cell[j][i] = sheet.getCell(j, i);
					String tempStr = cell[j][i].getContents();
					if(tempStr!=null&&!tempStr.trim().equals("")){
						nil = false;
						break;
					}
				}
				if(nil){
					nilRows++;
					nilNum.add(i);
				}
			}
			array = new String[rows-nilRows][columns];
			for (int i = 0; i < rows; i++) {
				if(nilNum.contains(i)){
					continue;
				}
				for (int j = 0; j < columns; j++) {
					cell[j][i] = sheet.getCell(j, i);
					String tempStr = cell[j][i].getContents();
					if(tempStr==null)
						tempStr = "";
					array[i][j] = tempStr.trim();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			if(inputStream !=null)
				inputStream.close();
			if(rwb != null)
				rwb.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	
	}

	public List checkExcelData() {
		List errorList = new ArrayList();
		
		String tempStr = "";
		String temp[];
		Iterator iter;
		
		if(array == null){
			errorList.add("沒有數據");
			return errorList;
		}
		
		if(notNullArray == null) notNullArray = new int[0];
		if(typeArray == null) typeArray = new String[0];
		if(lengthArray == null) lengthArray = new String[0];
		
		for(int i=1;i<array.length;i++){
			//判断不为空
			for(int j = 0; j < notNullArray.length; j++){
				int tempNum = notNullArray[j];
				if("".equals(array[i][tempNum])){
					errorList.add("第" + (i + 1) + "行,第" + (tempNum + 1) + "列(" + array[0][tempNum] + ")的值不能為空！");
				}
			}
			
			//判断类型
			for(int j = 0; j < typeArray.length; j++){
				temp = typeArray[j].split("=");				
				int tempNum = Integer.parseInt(temp[0]);
				if("int".equals(temp[1])){
					tempStr = "正整數";
				}else if("double".equals(temp[1])||"float".equals(temp[1])||"positive".equals(temp[1])){
					tempStr = "數字類型";
				}else if("minus".equals(temp[1])){
					tempStr = "負數";
				}
				if(!"".equals(array[i][tempNum])){
					if(!checkType(temp[1],array[i][tempNum]))
						errorList.add("第" + (i + 1) + "行,第" + (tempNum + 1) + "列(" + array[0][tempNum] + ")的值類型不是" + tempStr + "！");
				}
			}
			
			//长度判断
			for(int k=0; k<lengthArray.length; k++){
				temp = lengthArray[k].split("=");
				int tempNum = Integer.parseInt(temp[0]);
				int tempLength = Integer.parseInt(temp[1]);
				if(!"".equals(array[i][tempNum])){
					if(array[i][tempNum].length()>tempLength){
						errorList.add("第" + (i + 1) + "行,第" + (tempNum + 1) + "列(" + array[0][tempNum] + ")的長度不能超過" + tempLength + "！");
					}
				}
			}
			
			//时间校验
			iter = dateTime.entrySet().iterator();
			while (iter.hasNext()) {
				Map.Entry<Integer,SimpleDateFormat> entry = (Map.Entry) iter.next();
				int key = entry.getKey();
				SimpleDateFormat val = entry.getValue();
				if(!"".equals(array[i][key]) && !DateUtil.checkDateTime(array[i][key], val)){
					errorList.add("第" + (i + 1) + "行,第" + (key + 1) + "列(" + array[0][key] + ")格式不正確！");
				}
			}
			
			//判断是否存在
			iter = containList.entrySet().iterator();
			while (iter.hasNext()) {
				Map.Entry<Integer,List> entry = (Map.Entry) iter.next();
				int key = entry.getKey();
				List val = entry.getValue();
				if(!"".equals(array[i][key]) && !val.contains(array[i][key])){
					errorList.add("第" + (i + 1) + "行,第" + (key + 1) + "列(" + array[0][key] + ")的值不存在！");
				}
			}
		}
		return errorList;
	}
	
	public static boolean checkType(String type,String value){
		boolean isFlag = false;
		try{
			if(StringUtils.isNotBlank(value)){
				if("int".equals(type)){
					Pattern pattern = Pattern.compile("^\\d+$");
					Matcher isNum = pattern.matcher(value.trim());
					if(isNum.matches())
						isFlag = true;
				}else if("double".equals(type)){
					Pattern pattern = Pattern.compile("^\\d+(\\.\\d+)?$");
					Matcher isNum = pattern.matcher(value.trim());
					if(isNum.matches())
						isFlag = true;
				}else if("minus".equals(type)){  // 匹配负整数 
					Pattern pattern = Pattern.compile("^-[0-9]*[1-9][0-9]*$");
					Matcher isNum = pattern.matcher(value.trim());
					if(isNum.matches())
						isFlag = true;
				}else if("positive".equals(type)){  // 匹配正整数
					Pattern pattern = Pattern.compile("^[0-9]*[1-9][0-9]*$");
					Matcher isNum = pattern.matcher(value.trim());
					if(isNum.matches())
						isFlag = true;
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return isFlag;
	}

	public int[] getNotNullArray() {
		return notNullArray;
	}

	public void setNotNullArray(int[] notNullArray) {
		this.notNullArray = notNullArray;
	}

	public String[] getTypeArray() {
		return typeArray;
	}

	public void setTypeArray(String[] typeArray) {
		this.typeArray = typeArray;
	}

	public String[] getLengthArray() {
		return lengthArray;
	}

	public void setLengthArray(String[] lengthArray) {
		this.lengthArray = lengthArray;
	}

	public Map<Integer, SimpleDateFormat> getDateTime() {
		return dateTime;
	}

	public void setDateTime(Map<Integer, SimpleDateFormat> dateTime) {
		this.dateTime = dateTime;
	}

	public Map<Integer, List> getContainList() {
		return containList;
	}

	public void setContainList(Map<Integer, List> containList) {
		this.containList = containList;
	}

	public String[][] getArray() {
		return array;
	}

	public void setArray(String[][] array) {
		this.array = array;
	}
}
