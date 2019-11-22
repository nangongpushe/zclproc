package com.dhc.fastersoft.utils;

import java.util.List;
/**
 * 
 * @author lay
 * 
 * layui分页辅助类
 * @param <T> 泛型类
 * @version 2017-09-27
 */
public class LayPage<T>{
	
	private String msg;
	private int count;
	private int code;
	private List<T> data;
	
	public LayPage(){
		
	}
	
	public LayPage(List<T> data,int count){
		this.data=data;
		this.count=count;
		this.code=0;
		this.msg="";
	}
	
	public LayPage(List<T> data,int count,String msg){
		this.data=data;
		this.count=count;
		this.code=0;
		this.msg=msg;
	}
	
	public LayPage(List<T> data,int count,int code,String msg){
		this.data=data;
		this.count=count;
		this.code=code;
		this.msg=msg;
	}
	
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public List<T> getData() {
		return data;
	}
	public void setData(List<T> data) {
		this.data = data;
	}
	
	
}
