package com.dhc.fastersoft.controller.system;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysFileService;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.utils.StringUtils;

@RequestMapping("/sysDict")
@Controller
public class SysDictController extends BaseController{
	
	@Autowired
	private SysDictService sysDictService;
	
	@Autowired
	private SysFileService sysFileService;
	
	/**
	 * 列表页面
	 *
	 * @param request
	 * @return
	 */
	@SysLogAn("访问：系统管理-数据字典")
	@RequestMapping()
	public String index(HttpServletRequest request) {
		return "system/sysDict/sysDict_view";
	}
	
	/**
	 * 增加
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/add")
	public String add(HttpServletRequest request) {
		List<SysDict> list = sysDictService.selectAll();
		request.setAttribute("type", "添加");
		request.setAttribute("list", list);
		return "system/sysDict/sysDict_edit";
	}
	
	/** 
	* @Title: save 
	* @Description: save方法
	* @throws 
	*/ 
	
	@RequestMapping(value="/save")
	public String save(SysDict sysDict){
		if(StringUtils.isBlank(sysDict.getId())){
			sysDict.setId(StringUtils.createUUID());
			sysDict.setCreateBy(TokenManager.getSysUserId());
			sysDictService.save(sysDict);
			sysLogService.add(request, "系统管理-数据字典-新增");
		}else {
			sysDict.setUpdateBy(TokenManager.getSysUserId());
			sysDictService.updateById(sysDict);
			sysLogService.add(request, "系统管理-数据字典-修改");
		}
		
		return "redirect:/sysDict.shtml";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public LayPage<SysDict> list(HttpServletRequest request){
		
		LayPage<SysDict> page = sysDictService.pageList(request);
		return page;
	}

	@SysLogAn("系统管理-数据字典-删除")
	@RequestMapping("/del")
	public void list(@RequestParam("id")String id){
		
		sysDictService.deleteById(id);
	}

	/**
	 * 修改
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/edit")
	public String edit(HttpServletRequest request) {
		List<SysDict> list = sysDictService.selectAll();
		request.setAttribute("list", list);
		request.setAttribute("type", "编辑");
		String id = request.getParameter("id");
		SysDict sysDict  = sysDictService.selectById(id);
		request.setAttribute("sysDict", sysDict);
		return "system/sysDict/sysDict_edit";
	}
	
	/**
	 * 修改
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/detail")
	public String detail(HttpServletRequest request) {
		List<SysDict> list = sysDictService.selectAll();
		request.setAttribute("list", list);
		request.setAttribute("type", "详情");
		String id = request.getParameter("id");
		SysDict sysDict  = sysDictService.selectById(id);
		request.setAttribute("sysDict", sysDict);
		return "system/sysDict/sysDict_edit";
	}
}
