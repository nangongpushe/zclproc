package com.dhc.fastersoft.common.page;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

public class QueryUtil {
	public static HashMap<String,String> pageQuery(HttpServletRequest request){
		final int page=Integer.parseInt(request.getParameter("page")==null?"1":request.getParameter("page"));
        final int pageSize=Integer.parseInt(request.getParameter("pageSize")==null?"10":request.getParameter("pageSize"));

        String start = "";
        String end = "";
        if(page==1){
        	start = "select * from (";
        	end = ") where rownum <= " + pageSize;
        } else {
        	start = "select * from ( select row_.*, rownum rownum_ from (";
        	end = ") row_ where rownum <= "+page*pageSize+") where rownum_ > " + (page-1)*pageSize;
        }
        HashMap<String,String> maps = new HashMap<String,String>();
        maps.put("start", start);
        maps.put("end", end);
        
        return maps;
	}
	
	/** 
	* @Title: pageHashMap 
	* @Description: 增加分页参数
	*/ 
	
	public static HashMap<String,String> pageHashMap(HttpServletRequest request){
		final int page=Integer.parseInt(request.getParameter("page")==null?"1":request.getParameter("page"));
        final int pageSize=Integer.parseInt(request.getParameter("limit")==null?"10":request.getParameter("limit"));

        String start = "";
        String end = "";
        if(page==1){
        	start = "select * from (";
        	end = ") where rownum <= " + pageSize;
        } else {
        	start = "select * from ( select row_.*, rownum rownum_ from (";
        	end = ") row_ where rownum <= "+page*pageSize+") where rownum_ > " + (page-1)*pageSize;
        }
        HashMap<String,String> maps = new HashMap<String,String>();
        maps.put("start", start);
        maps.put("end", end);
        
        return maps;
	}
}
