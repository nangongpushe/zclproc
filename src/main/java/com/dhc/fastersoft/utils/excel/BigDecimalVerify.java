package com.dhc.fastersoft.utils.excel;

import java.math.BigDecimal;

import org.apache.commons.lang3.StringUtils;

/**
 * BigDecimal校验实体
 * @author Administrator
 *
 */
public class BigDecimalVerify extends AbstractCellVerify{
	private String cellName;
	private AbstractCellValueVerify cellValueVerify;
	private boolean allowNull;
	
	public BigDecimalVerify(String cellName, boolean allowNull) {
		this.cellName = cellName;
		this.allowNull = allowNull;
	}

	public BigDecimalVerify(String cellName, AbstractCellValueVerify cellValueVerify, boolean allowNull) {
		super();
		this.cellName = cellName;
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
		
		if(format(cellValue).doubleValue()<=0){
			throw MessageException.newMessageException(cellName+"必须大于零");
		}
		
		cellValue = format(cellValue);
		if(null!=cellValueVerify){
			cellValue = cellValueVerify.verify(cellValue);
		}
		return cellValue;
	}

	private BigDecimal format(Object fileValue) {
		BigDecimal value;
		try {
			value = new BigDecimal(String.valueOf(fileValue));
		} catch (Exception e) {
			e.printStackTrace();
			throw MessageException.newMessageException(cellName+"格式不正确:"+fileValue);
		}
		return value;
	}
}
