package com.dhc.fastersoft.service.system;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

import com.dhc.fastersoft.entity.store.StorageStarUnit;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.utils.LayPage;

@Component
public interface SysDictService {
	
	int save(SysDict sysDict);
	
	LayPage<SysDict> pageList(HttpServletRequest request);
	
	List<SysDict> selectAll();
		
	void deleteById(String id);
	
	public SysDict getSysDictByType(String type);
	
	/** 
	* @Title: getSysDictList 
	* @Description: 根据类型返回多个字典
	* @param @param type
	* @throws 
	*/ 	
	public List<SysDict> getSysDictListByType(String type);
	
	
	/** 
	* @Title: getSysDictByLabel 
	* @Description: 根据label查询字典
	*/ 
	public SysDict getSysDictByLabel(String lebal);
	
	
	public List<SysDict> getSysDictByparentId(String parentId);

	SysDict selectById(String id);

	void updateById(SysDict sysDict);

}
