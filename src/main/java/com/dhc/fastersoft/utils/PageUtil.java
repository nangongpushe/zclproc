package com.dhc.fastersoft.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
/**
 * 
 * @author 少凡
 * 
 * 分页辅助类
 * @param <T> 泛型类
 * @version 2017-09-27
 * @field TotalCount 总数据数量
 * @field Result 分页数据内容
 */
public class PageUtil<T>{
	
 	private int pageIndex;
	private int pageSize;
	private int totalCount;
	private T entity;
	private List<T> result;
	private Map otherPram;
	
	public Map getOtherPram() {
		return otherPram;
	}
	public void setOtherPram(Map otherPram) {
		this.otherPram = otherPram;
	}
	public int getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public T getEntity() {
		return entity;
	}
	public void setEntity(T entity) {
		this.entity = entity;
	}
	public List<T> getResult() {
		return result;
	}
	public void setResult(List<T> result) {
		this.result = result;
	}
	
	public PageUtil(){
		result = new ArrayList<T>();
	}
}
