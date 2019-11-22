package com.dhc.fastersoft.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.entity.StorageStoreHouse;
import com.dhc.fastersoft.entity.StorageStoreHouseOption;
import com.dhc.fastersoft.service.StorageStoreHouseOptionService;
import com.dhc.fastersoft.service.StorageStoreHouseService;
import com.dhc.fastersoft.utils.LayPage;

@RequestMapping("/storageStoreHouseOption")
@Controller
public class StorageStoreHouseOptionController extends BaseController{
	
	@Autowired
	private StorageStoreHouseOptionService service;
	@Autowired
	private StorageStoreHouseService storeService;
	
	
	@RequestMapping()
	public String index(String storehouseId, Model model) {
		StorageStoreHouse storhouse = storeService.getSingle(storehouseId);
		model.addAttribute("storageStoreHouse", storhouse);
		return "storageStoreHouse/store_house_option_main";		
	}
	
	@RequestMapping(value="/save",method={RequestMethod.POST})
	@ResponseBody
	public ActionResultModel save(@RequestBody StorageStoreHouseOption option,
			@RequestParam(value="auvp") String auvp) {
		ActionResultModel result = new ActionResultModel();
		String flag = request.getParameter("flag");
		if (auvp.equals("a")) {
			result = service.save(option);
			if("dc".equals(flag)){
				sysLogService.add(request, "代储监管-企业信息-仓房管理-新建维修");
			}else{
				sysLogService.add(request, "仓储管理-仓房管理-仓房信息管理-新建维修");
			}
		} else if (auvp.equals("u")) {
			result = service.update(option);
			if("dc".equals(flag)){
				sysLogService.add(request, "代储监管-企业信息-仓房管理-修改维修");
			}else{
				sysLogService.add(request, "仓储管理-仓房管理-仓房信息管理-修改维修");
			}
		}
		return result;		
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public LayPage<StorageStoreHouseOption> list(HttpServletRequest request) {
		LayPage<StorageStoreHouseOption> page = service.list(request);
		return page;		
	}
	
	@RequestMapping("/remove")
	@ResponseBody
	public ActionResultModel remove(@RequestParam(value="id") String id) {
		ActionResultModel result = new ActionResultModel();
		result = service.remove(id);
		return result;		
	}
	
	@RequestMapping("/editPage")
	public String editPage(Model model,@RequestParam(value="id") String id) {
		StorageStoreHouseOption option = service.getSingle(id);
		StorageStoreHouse storageStoreHouse = storeService.getSingle(option.getStorehouseId());
		model.addAttribute("option", option);
		model.addAttribute("auvp", "u");
		model.addAttribute("storageStoreHouse",storageStoreHouse);
		return "storageStoreHouse/store_house_option_add";
	}
	
	@RequestMapping("/addPage")
	public String addOptionPage(Model model, @RequestParam(value="storehouseId") String storehouseId) {
		StorageStoreHouse storageStoreHouse = storeService.getSingle(storehouseId);
		model.addAttribute("storageStoreHouse",storageStoreHouse);
		model.addAttribute("auvp", "a");
		return "storageStoreHouse/store_house_option_add";
	}


	@RequestMapping(value="/proxySave",method={RequestMethod.POST})
	@ResponseBody
	public ActionResultModel proxySave(@RequestBody StorageStoreHouseOption option,
								  @RequestParam(value="auvp") String auvp) {
		ActionResultModel result = new ActionResultModel();
		//String flag = request.getParameter("flag");
		if (auvp.equals("a")) {
			result = service.save(option);
				sysLogService.add(request, "代储监管-企业信息-[代储]仓房管理-新建维修");
		} else if (auvp.equals("u")) {
			result = service.update(option);
				sysLogService.add(request, "代储监管-企业信息-[代储]仓房管理-修改维修");
		}
		return result;
	}

    @RequestMapping("/proxyEditPage")
    public String proxyEditPage(Model model,@RequestParam(value="id") String id) {
        StorageStoreHouseOption option = service.getSingle(id);
        StorageStoreHouse storageStoreHouse = storeService.getSingle(option.getStorehouseId());
        model.addAttribute("option", option);
        model.addAttribute("auvp", "u");
        model.addAttribute("storageStoreHouse",storageStoreHouse);
        return "storageStoreHouse/proxy_store_house_option_add";
    }
}