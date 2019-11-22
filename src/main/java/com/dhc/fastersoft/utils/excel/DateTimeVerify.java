package com.dhc.fastersoft.utils.excel;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;

/**
 * 日期校验实体
 * @author Administrator
 *
 */
public class DateTimeVerify extends AbstractCellVerify{
	private String cellName;
	private String pattern;
	private AbstractCellValueVerify cellValueVerify;
	private boolean allowNull;
	
	public DateTimeVerify(String cellName, String pattern, boolean allowNull) {
		this.cellName = cellName;
		this.pattern = pattern;
		this.allowNull = allowNull;
	}
	
	public DateTimeVerify(String cellName, String pattern, AbstractCellValueVerify cellValueVerify, boolean allowNull) {
		super();
		this.cellName = cellName;
		this.pattern = pattern;
		this.cellValueVerify = cellValueVerify;
		this.allowNull = allowNull;
	}

	@Override
	public Object verify(Object cellValue) throws Exception {
		if(allowNull){
			if(cellValue!=null && StringUtils.isNotEmpty(String.valueOf(cellValue))){
				cellValue = format(cellValue);
				if(null!=cellValueVerify){
					cellValue = cellValueVerify.verify(cellValue);
				}
				return cellValue;
			}
			return cellValue;
		}
		
		if(cellValue==null || StringUtils.isEmpty(String.valueOf(cellValue))){
			throw MessageException.newMessageException(cellName+"不能为空");
		}
		
		cellValue = format(cellValue);
		if(null!=cellValueVerify){
			cellValue = cellValueVerify.verify(cellValue);
		}
		return cellValue;
	}

	private Date format(Object fileValue) {
		if(fileValue instanceof Date){return (Date)fileValue;}
		Date value = null;
		try {
			SimpleDateFormat format = new SimpleDateFormat(pattern);
			value = format.parse(String.valueOf(fileValue));
		} catch (ParseException e) {
			e.printStackTrace();
			throw MessageException.newMessageException(cellName+"格式不正确:"+fileValue);
		}
		return value;
	}
}
