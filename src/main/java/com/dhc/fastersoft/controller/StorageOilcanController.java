package com.dhc.fastersoft.controller;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.common.SysLogAn;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.StorageOilcan;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.StorageOilcanService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.utils.LayPage;

@RequestMapping("/storageOilcan")
@Controller
public class StorageOilcanController extends BaseController{
	
	@Autowired
	StorageOilcanService service;
	@Autowired
	private SysDictService dicService;

	@SysLogAn("访问：仓储管理-仓房管理-油罐信息管理")
	@RequestMapping
	public String index(Model model) {
		
		String type = "油罐类型";
		List<SysDict> oilcanTypeDict = dicService.getSysDictListByType(type);
		//System.out.println(dictList.size());
		model.addAttribute("oilcanTypeDict",oilcanTypeDict);
		
		String type1 = "仓房状态";
		List<SysDict> oilcanStatusDict = dicService.getSysDictListByType(type1);
		//System.out.println(dictList.size());
		model.addAttribute("oilcanStatusDict",oilcanStatusDict);	
		return "storageOilcan/storage_oilcan_main";
	}
	
	@RequestMapping("/addPage")
	public String addPage(Model model){
		SysUser user = TokenManager.getToken();
		model.addAttribute("user",user);
		
		String type = "油罐类型";
		List<SysDict> typeDict = dicService.getSysDictListByType(type);
		//System.out.println(dictList.size());
		model.addAttribute("typeDict",typeDict);	
		
		String type1 = "仓房状态";
		List<SysDict> statusDict = dicService.getSysDictListByType(type1);
		model.addAttribute("statusDict",statusDict);
		
		model.addAttribute("auvp","a");
		return "storageOilcan/storage_oilcan_add";
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public ActionResultModel save(@RequestBody StorageOilcan oilcan, @RequestParam(value="auvp") String auvp) {
		ActionResultModel result = new ActionResultModel();
		if ( auvp.equals("a") ) {
			oilcan.setId(UUID.randomUUID().toString().replace("-", ""));
			oilcan.setCreatorId(TokenManager.getSysUserId());
			result = service.save(oilcan);
			sysLogService.add(request, "仓储管理-仓房管理-油罐信息管理-新增");
		} else if ( auvp.equals("u") ) {
			result = service.update(oilcan);
			sysLogService.add(request, "仓储管理-仓房管理-油罐信息管理-修改");
		} 
		return result;
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public LayPage<StorageOilcan> list(HttpServletRequest request) {
		LayPage<StorageOilcan> page = service.list(request);
		return page;
	}
	
	@RequestMapping("/viewPage")
	public String viewPage(Model model, @RequestParam(value="id",required=true) String id) {
		StorageOilcan oilcan = service.get(id);
		model.addAttribute("oilcan", oilcan);
		model.addAttribute("auvp", "v");
		
		String type = "油罐类型";
		List<SysDict> typeDict = dicService.getSysDictListByType(type);
		//System.out.println(dictList.size());
		model.addAttribute("typeDict",typeDict);	
		
		String type1 = "仓房状态";
		List<SysDict> statusDict = dicService.getSysDictListByType(type1);
		model.addAttribute("statusDict",statusDict);
		
		return "storageOilcan/storage_oilcan_view";
	}

	@SysLogAn("仓储管理-仓房管理-油罐信息管理-删除")
	@RequestMapping("/remove")
	@ResponseBody
	public ActionResultModel remove(@RequestParam(value="id",required=true) String id) {
		ActionResultModel result = service.remove(id);
		return result;
	}
	
	@RequestMapping("/editPage")
	public String editPage(Model model, @RequestParam(value="id",required=true) String id) {
		StorageOilcan oilcan = service.get(id);
		model.addAttribute("oilcan", oilcan);
		model.addAttribute("auvp","u");
		
		String type = "油罐类型";
		List<SysDict> typeDict = dicService.getSysDictListByType(type);
		//System.out.println(dictList.size());
		model.addAttribute("typeDict",typeDict);	
		
		String type1 = "仓房状态";
		List<SysDict> statusDict = dicService.getSysDictListByType(type1);
		model.addAttribute("statusDict",statusDict);
		
		return "storageOilcan/storage_oilcan_add";
	}

	@RequestMapping("/addRepairPage")
	public String addRepairPage(Model model,@RequestParam(value = "oilcanId",required = true) String oilcanId) {
		StorageOilcan oilcan = service.get(oilcanId);
		model.addAttribute("oilcan", oilcan);
		model.addAttribute("auvp", "a");
		return "storageOilcan/storage_oilcan_repair_add";
		
	}
	
}
