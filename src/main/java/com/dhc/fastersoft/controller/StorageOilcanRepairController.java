package com.dhc.fastersoft.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.entity.StorageOilcan;
import com.dhc.fastersoft.entity.StorageOilcanRepair;
import com.dhc.fastersoft.service.StorageOilcanRepairService;
import com.dhc.fastersoft.service.StorageOilcanService;
import com.dhc.fastersoft.utils.LayPage;

@RequestMapping("/storageOilcanRepair")
@Controller
public class StorageOilcanRepairController extends BaseController{
	@Autowired
	StorageOilcanRepairService service;
	@Autowired
	StorageOilcanService oilcanService;
	
	@RequestMapping("/list")
	@ResponseBody
	public LayPage<StorageOilcanRepair> list(HttpServletRequest request) {
		LayPage<StorageOilcanRepair> page = service.list(request);
		return page;
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public ActionResultModel save(@RequestParam(value = "auvp") String auvp, @RequestBody() StorageOilcanRepair repair) {
		ActionResultModel result = new ActionResultModel();
		if (auvp.equals("a")) {
			result = service.save(repair);
			sysLogService.add(request, "仓储管理-仓房管理-油罐信息管理-新建维修");
		} else if (auvp.equals("u")) {
			result = service.update(repair);
			sysLogService.add(request, "仓储管理-仓房管理-油罐信息管理-修改维修");
		}
		return result;
	}
	
	@RequestMapping("/remove")
	@ResponseBody
	public ActionResultModel remove(@RequestParam(value="id") String id) {
		ActionResultModel result = new ActionResultModel();
		result = service.remove(id);
		return result;		
	}
	
	@RequestMapping("/editPage")
	public String editPage(Model model, @RequestParam(value="id") String id) {
		StorageOilcanRepair repair = service.get(id);
		StorageOilcan oilcan = oilcanService.get(repair.getOilcanId());
		model.addAttribute("oilcan", oilcan);
		model.addAttribute("repair", repair);
		//System.out.println(repair.toString());
		model.addAttribute("auvp", "u");
		return "storageOilcan/storage_oilcan_repair_add";
	}
}
