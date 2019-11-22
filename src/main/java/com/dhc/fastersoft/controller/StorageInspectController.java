package com.dhc.fastersoft.controller;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.service.StorageWarehouseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.StorageInspect;
import com.dhc.fastersoft.entity.system.SysFile;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.StorageInspectService;
import com.dhc.fastersoft.service.system.SysFileService;
import com.dhc.fastersoft.service.system.SysUserService;
import com.dhc.fastersoft.utils.LayPage;

@RequestMapping("StorageInspect")
@Controller
public class StorageInspectController extends BaseController{
	@Autowired
	StorageInspectService service;
	@Autowired
	SysUserService sysUserService;
	@Autowired
	SysFileService sysFileService;
	@Autowired
	StorageWarehouseService storageWarehouseService;
	/**
	 * 列表页面
	 * 
	 * @param request
	 * @return
	 */
	@SysLogAn("访问：仓储管理-全国查库")
	@RequestMapping()
	private String list(ModelMap map) {
		List<SysUser> listSysUser=sysUserService.getList();
		map.addAttribute("listSysUser", listSysUser);
//		List<SysUser> distinctList=sysUserService.distinctList();
//		map.addAttribute("distinctList", distinctList);
		List<StorageWarehouse> distinctList=storageWarehouseService.getAllWarehouse();
		map.addAttribute("distinctList", distinctList);
		return "StorageInspect/list";
	}
	@RequestMapping("/list")
	@ResponseBody()
	private LayPage<StorageInspect> list(HttpServletRequest request) {
		// TODO Auto-generated method stub
		LayPage<StorageInspect> list=service.list(request);
		return list;
	}
	/***
	 * 跳转到登记页面
	 * @param map
	 * @return
	 */
	@RequestMapping("/addPage")
	public String addPage(ModelMap map){
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		StorageInspect entity = new StorageInspect();
		entity.setCreator(TokenManager.getNickname());
		entity.setCreateDate(df.format(new Date()));
		SysUser sysUser=TokenManager.getToken();
		entity.setReportUnit(TokenManager.getToken().getShortName()!=null?TokenManager.getToken().getShortName():"");
		entity.setWarehouseId(TokenManager.getToken().getWareHouseId()!=null?TokenManager.getToken().getWareHouseId():"");
		entity.setYear(new SimpleDateFormat("yyyy").format(new Date()));
		String sqlId=UUID.randomUUID().toString().replace("-", "");
		entity.setId(sqlId);
		map.addAttribute("entity", entity);
		List<SysUser> listSysUser=sysUserService.getList();
		map.addAttribute("listSysUser", listSysUser);
		map.put("auvp", "a");
		return "StorageInspect/add";
		}
	/**
	 * 添加或修改
	 * 
	 * @param auvp
	 * @param user
	 * @return
	 */
	@RequestMapping("/save") 
	@ResponseBody
	public ActionResultModel save(@RequestParam(value = "auvp")String auvp,StorageInspect entity){
		ActionResultModel actionResultModel = new ActionResultModel();
		
		if (auvp.equals("a")) {
			
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
			String date=df.format(new Date());
			entity.setCreator(TokenManager.getNickname());
			entity.setCreateDate(date);
			entity.setCompany(TokenManager.getToken().getShortName()!=null?TokenManager.getToken().getShortName():"");
			entity.setGroupId(entity.getId());
			entity.setCreatorId(TokenManager.getSysUserId());
			service.add(entity);
			sysLogService.add(request, "仓储管理-全国查库-新增");
		}else if (auvp.equals("u")) {
			if (entity.getCreator()==""||entity.getCreator()==null) {
				entity.setCreator(TokenManager.getNickname());
			}
			if (entity.getCreateDate()==""||entity.getCreateDate()==null) {
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
				String date=df.format(new Date());
				entity.setCreateDate(date);
			}
			if (entity.getCompany()==""||entity.getCompany()==null) {
				entity.setCompany(TokenManager.getToken().getShortName()!=null?TokenManager.getToken().getShortName():"");
			}
			entity.setCreatorId(TokenManager.getSysUserId());
			service.update(entity);
			sysLogService.add(request, "仓储管理-全国查库-修改");
		}
		actionResultModel.setSuccess(true);
		return	actionResultModel;
	}
	/**
	 * 编辑
	 * @param map
	 * @param id
	 * @return
	 */
	@RequestMapping("/editPage")
	public String editPage(ModelMap map, String id) {
		StorageInspect entity=service.getById(id);
		map.addAttribute("entity", entity);
		/*List<SysFile> listsysFile=sysFileService.getFilesByGroupId(id);*/
		List<SysFile> listsysFile = null;
		if(id != null) {
			listsysFile = sysFileService.getFilesByGroupId(id);
			if(listsysFile!=null){
				Map filemap = new HashMap();
				for (SysFile file:listsysFile){
					String downloadUrl = file.getDownloadUrl();
					String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
					filemap.put(file.getId(),suffix);
					map.addAttribute("suffixMap", filemap);
				}
			}
		}
		map.addAttribute("listsysFile", listsysFile);
		List<SysUser> listSysUser=sysUserService.getList();
		map.addAttribute("listSysUser", listSysUser);
		map.addAttribute("auvp", "u");
		return "StorageInspect/add";
	}
	/**
	 * 查看
	 * @param map
	 * @param id
	 * @return
	 */
	@RequestMapping("/detailPage")
	public String detailPage(ModelMap map, String id) {
		StorageInspect entity=service.getById(id);
		map.put("entity", entity);
		/*List<SysFile> listsysFile=sysFileService.getFilesByGroupId(id);*/
		List<SysFile> listsysFile = null;
		if(id != null) {
			listsysFile = sysFileService.getFilesByGroupId(id);
			if(listsysFile!=null){
				Map filemap = new HashMap();
				for (SysFile file:listsysFile){
					String downloadUrl = file.getDownloadUrl();
					String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
					filemap.put(file.getId(),suffix);
					map.addAttribute("suffixMap", filemap);
				}
			}
		}
		map.addAttribute("listsysFile", listsysFile);
		List<SysUser> listSysUser=sysUserService.getList();
		map.addAttribute("listSysUser", listSysUser);
		map.put("auvp", "v");
		return "StorageInspect/add";
	}
	/**
	 * 删除
	 * @param id
	 * @return
	 */
	@SysLogAn("仓储管理-全国查库-删除")
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel remove(String id) {
		ActionResultModel actionResultModel = new ActionResultModel();
		int row=service.delete(id);
		if(row>0) {
			actionResultModel.setSuccess(true);
			actionResultModel.setMsg("删除成功");
		}else {
			actionResultModel.setSuccess(false);
			actionResultModel.setMsg("删除失败");
		}
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}
}
