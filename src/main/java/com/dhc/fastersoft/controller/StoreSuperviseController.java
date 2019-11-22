package com.dhc.fastersoft.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.common.SysLogAn;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.Constant;
import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.StorageWarehouseDao;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.StoreSupervise;
import com.dhc.fastersoft.entity.StoreSuperviseItem;
import com.dhc.fastersoft.entity.system.SysFile;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.StorageStoreHouseService;
import com.dhc.fastersoft.service.StoreSuperviseService;
import com.dhc.fastersoft.service.system.SysFileService;
import com.dhc.fastersoft.utils.LayEntity;
import com.dhc.fastersoft.utils.LayPage;

@RequestMapping("/StoreSupervise")
@Controller
public class StoreSuperviseController extends BaseController{
	@Autowired
	private StoreSuperviseService service;
	@Autowired
	private SysFileService fileService;
	
	@Autowired
	private StorageStoreHouseService storehouseService;
	
	@Autowired
	StorageWarehouseDao warehouseDao;

	@RequestMapping(value="/save", method={RequestMethod.POST})
	@ResponseBody
	public ActionResultModel save(
			String auvp,
			String superviseJson,
			String detailJson) {
		//System.out.println(auvp + superviseJson + detailJson);
		
		JSONObject json = (JSONObject) JSON.parseObject(superviseJson);
		StoreSupervise supervise = JSONObject.toJavaObject(json, StoreSupervise.class);
		List<StoreSuperviseItem> items = new ArrayList<StoreSuperviseItem>();
		items = JSON.parseArray(detailJson, StoreSuperviseItem.class);
		
		supervise.setDetail(items);
		ActionResultModel result = new ActionResultModel();
		supervise.setCreatorId(TokenManager.getSysUserId());
		if (auvp.equals("a")) {
			result = service.save(supervise);
			sysLogService.add(request, "代储监管-分片监管-新增");
		} else if (auvp.equals("u")) {
			result = service.update(supervise);
			sysLogService.add(request, "代储监管-分片监管-修改");
		}
		return result;		
	}
	/**
	 * 检查计划年份
	 * @param request
	 * @param
	 * @return
	 */
	@RequestMapping("check")
	@ResponseBody
	public ActionResultModel  check(HttpServletRequest request){
		ActionResultModel actionResultModel = new ActionResultModel();
		int count=service.check(request);
		if(count>0) {
			actionResultModel.setSuccess(false);
		}else {
			actionResultModel.setSuccess(true);
		}
		return actionResultModel;
	}

	@SysLogAn("访问：代储监管-分片监管")
	@RequestMapping
	public String main() {
		return "StoreSupervise/storeSupervise_main";
	}
	
	@RequestMapping("/addPage")
	public String addPage(Model model) {
		model.addAttribute("auvp","a");
		
		/*String currSerial = service.getCurrSerial();
		model.addAttribute("currSerial", currSerial);*/
		
		SysUser user = TokenManager.getToken();
		model.addAttribute("user",user);
		StoreSupervise supervise=new StoreSupervise();
		String superviseSerial=service.getCurrSerial();
		supervise.setSuperviseSerial(superviseSerial);
		supervise.setCreator(TokenManager.getToken().getName());
		supervise.setCreateDept(TokenManager.getToken().getDepartment());
		model.addAttribute("supervise", supervise);
		
		
		HashMap<String, String> map = QueryUtil.pageQuery(request);

        map.put("warehouseType", "储备库");
		List<StorageWarehouse> list = warehouseDao.list(map);

		model.addAttribute("storehouses", warehouseDao.list(map));
		
		return "StoreSupervise/storeSupervise_add";
	}
	
	@RequestMapping("/editPage")
	public String editPage(Model model, String id) {
		//System.out.println(id);
		StoreSupervise supervise = service.get(id);
		model.addAttribute("auvp","u");
		model.addAttribute("supervise", supervise);
		
		String groupId = supervise.getGroupId();
		SysFile myFile = fileService.selectById(groupId);
		model.addAttribute("myFile", myFile);
		if(myFile!=null){
			String downloadUrl = myFile.getDownloadUrl();
			String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
			model.addAttribute("suffix", suffix);
		}
		
		HashMap<String, String> map = QueryUtil.pageQuery(request);

        map.put("warehouseType", "储备库");

		model.addAttribute("storehouses", warehouseDao.list(map));

		return "StoreSupervise/storeSupervise_add";
	}
	@RequestMapping("/list")
	@ResponseBody
	public LayPage<StoreSupervise> list(HttpServletRequest request) {
		LayPage<StoreSupervise> page = service.list(request);
		return page;
	}
	@SysLogAn("代储监管-分片监管-删除")
	@RequestMapping("/remove")
	@ResponseBody
	public ActionResultModel remove(String id) {
		return service.remove(id);
	}
	
	@RequestMapping("/view")
	public String view(String id,Model model) {
		StoreSupervise supervise = service.get(id);
		
		String groupId = supervise.getGroupId();
		SysFile myFile = fileService.selectById(groupId);
		model.addAttribute("myFile", myFile);
		if(myFile!=null){
			String downloadUrl = myFile.getDownloadUrl();
			String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
			model.addAttribute("suffix", suffix);
		}
		
		model.addAttribute("auvp","v");
		model.addAttribute("supervise", supervise);
		return "StoreSupervise/storeSupervise_view";
	}
	
	//更换文件时删除服务器端已有文件，尚未处理
	@RequestMapping("/upload")
	@ResponseBody
	public LayEntity upload(HttpServletRequest request, MultipartFile file) {
		LayEntity layFileEntity = new LayEntity();
		Map<String,Object> data  = new HashMap<String, Object>();
		
		String uuid = UUID.randomUUID().toString().replace("-", "");
		data.put("fileId", uuid);
		data.put("fileName", file.getOriginalFilename());
		try {
			fileService.uploadFile(request, uuid, file, "storeSupervise");
			layFileEntity.setCode(Constant.SUCCESS_CODE);
			layFileEntity.setData(data);
		    layFileEntity.setMsg("上传成功");
		} catch (Exception e) {
			layFileEntity.setCode(1);
		    layFileEntity.setMsg("上传失败");
			e.printStackTrace();
		}
		return layFileEntity;
	}
}
