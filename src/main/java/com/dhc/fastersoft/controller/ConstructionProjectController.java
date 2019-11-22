package com.dhc.fastersoft.controller;

import java.io.*;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.constants.BusinessConstants;
import com.dhc.fastersoft.entity.*;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.dhc.fastersoft.common.Constant;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.enumdata.ConstructionDataTypeEnum;
import com.dhc.fastersoft.entity.system.SysFile;
import com.dhc.fastersoft.entity.system.SysProcessMapper;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.ConstructionBalanceService;
import com.dhc.fastersoft.service.ConstructionFundsService;
import com.dhc.fastersoft.service.ConstructionInfoService;
import com.dhc.fastersoft.service.ConstructionPlanService;
import com.dhc.fastersoft.service.ConstructionProjectService;
import com.dhc.fastersoft.service.ConstructionScheduleService;
import com.dhc.fastersoft.service.ReportMonthService;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.service.system.SysFileService;
import com.dhc.fastersoft.service.system.SysOAService;
import com.dhc.fastersoft.utils.JsonUtil;
import com.dhc.fastersoft.utils.NumberToCN;
import com.dhc.fastersoft.utils.PageUtil;
import com.dhc.fastersoft.utils.UpdateUtil;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.ExcelImportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import cn.afterturn.easypoi.excel.entity.ImportParams;

@Controller
@RequestMapping("/Construction")
public class ConstructionProjectController extends BaseController implements ApplicationContextAware{
	
	@Autowired
	private ConstructionProjectService construectionProjectService;
	@Autowired
	private ConstructionInfoService constructionInfoService;
	@Autowired
	private ConstructionBalanceService constructionBalanceService;
	@Autowired
	private ConstructionPlanService constructionPlanService;
	@Autowired
	private ConstructionScheduleService constructionScheduleService;
	@Autowired
	private ConstructionFundsService constructionFundsService;
	@Autowired
	private StorageWarehouseService storageWarehouseService;
	@Autowired
	private SysFileService sysFileService;
	@Autowired
	private SysOAService sysOAService;
	@Autowired
	private HttpServletRequest request;
	@Autowired
	private HttpSession session;
	
	@Autowired
	private ReportMonthService reportMonthService;
	
	ApplicationContext applicationContext;
	
	Properties prop = new Properties();
	
	private Map<String,String> mapper = new HashMap<>();
	private Map<String,String> TableMapper = new HashMap<>(); 

	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		this.applicationContext = applicationContext;
	}
	
	{
		mapper.put("Bidding", ConstructionDataTypeEnum.BIDDING.getValue());
		mapper.put("Change", ConstructionDataTypeEnum.CHANGE.getValue());
		mapper.put("Acceptance", ConstructionDataTypeEnum.ACCEPTANCE.getValue());
		
		TableMapper.put("Balance", "T_CONSTRUCTION_BALANCE");
		TableMapper.put("Funds", "T_CONSTRUCTION_FUNDS");
		TableMapper.put("Info", "T_CONSTRUCTION_INFO");
		TableMapper.put("Plan", "T_CONSTRUCTION_PLAN");
		TableMapper.put("PlanDetail", "T_CONSTRUCTION_PLAN_DETAIL");
		TableMapper.put("Project", "T_CONSTRUCTION_PROJECT");
		TableMapper.put("Schedule", "T_CONSTRUCTION_SCHEDULE");
		TableMapper.put("ScheduleDetail", "T_CONSTRUCTION_SCHEDULE_DETAIL");
		TableMapper.put("Performance", "T_ROTATE_PERFORMANCE");
		
		try {
			prop.load(this.getClass().getResourceAsStream("/limitPage.properties"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value="/{enter}/Detail",method= {RequestMethod.GET},params= {"cid"})
	public String GetDetail(Model model,@PathVariable(value="enter")String enter,@RequestParam("cid")String cid) {
		Object target = applicationContext.getBean("Construction"+enter+"Service");
		if(target == null)
			return "";
		Method method = null;
		Object result = null;
		try {
			method = target.getClass().getMethod("GetConstruction" + enter, String.class);
			result = method.invoke(target, cid);
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute(enter.toLowerCase(),result);
		return "Construction/"+enter.toLowerCase()+"construction_detail";
	}
	
	@RequestMapping(value="/DataExits",method=RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> DataExits(String projectSerial,String id){
		SysUser user = TokenManager.getToken();
		Map<String,Object> result = new HashMap<>();
		ConstructionProject param = new ConstructionProject();
		param.setProjectUnit(user.getShortName());
		param.setProjectSerial(projectSerial);
		PageUtil<ConstructionProject> pageUtil = new PageUtil<>();
		pageUtil.setEntity(param);
		int count = construectionProjectService.GetTotalCount(pageUtil);
		//判断除当前记录外是否存在同编号
		ConstructionProject constructionProject = new ConstructionProject();
		if (!id.equals("")){
			constructionProject = construectionProjectService.GetConstructionDetail(id);
			if (constructionProject.getProjectSerial().equals(projectSerial)){
				count = 0;
			}
		}
		result.put("success", true);
		if(count > 0)
			result.put("exits", true);
		else
			result.put("exits", false);
		return result;
	}
	
	@RequestMapping(value="/Add/New",method= {RequestMethod.GET})
	public String AddConstructionProject(Model model) {
		SysUser user = TokenManager.getToken();
		ConstructionProject constructionProject = new ConstructionProject();
		String  aa=TokenManager.getToken().getOriginCode().toLowerCase();
		if (!TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")){
		
			constructionProject.setProjectUnit(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort());
			constructionProject.setWarehouseId(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseCode());


		}
		List<ConstructionProject> parentList = construectionProjectService.parentProjectList(constructionProject);
		model.addAttribute("parentList",parentList);
		constructionProject.setProjectYear(String.valueOf(Calendar.getInstance().get(Calendar.YEAR)));
		model.addAttribute("construction",constructionProject);

		return "Construction/newconstruction_add";
	}

	@SysLogAn("访问：基建管理-新增基建项目")
	@RequestMapping(value="/Add/View",method= {RequestMethod.GET})
	public String ListConstructionProject(Model model,@RequestParam(value="identity",required=false)String identity) {
		PageUtil<ConstructionProject> pageUtil = new PageUtil<>();
		ConstructionProject param = new ConstructionProject();
		
		if(TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl"))
			identity=null;
		else
			identity="base";
		
		if(identity != null && identity.equals("base")) {
			SysUser user = TokenManager.getToken();
			param.setWarehouseId(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseCode());
			/*param.setProjectUnit(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort());*/
			model.addAttribute("identity",storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort());
			session.setAttribute("ident", "base");
		}else {
			param.setPlannedInvestment(10);
			HashMap<String,Object> otherParam = new HashMap<>();
			otherParam.put("symbol", ">=");
			pageUtil.setOtherPram(otherParam);
			session.removeAttribute("ident");
		}
		
		pageUtil.setEntity(param);
		pageUtil.setPageIndex(1);
		pageUtil.setPageSize(Integer.valueOf(prop.get("PageSize").toString()));
		
		pageUtil.setResult(construectionProjectService.ListLimitConstruction(pageUtil));
		
		model.addAttribute("constructionlist",pageUtil);
		return "Construction/newconstruction_view";
	}
	
	@RequestMapping(value="/Add/New",method= {RequestMethod.POST})
	@ResponseBody
	public Map<String,Object> AddConstructionProject(ConstructionProject constructionProject,@RequestParam(value="file",required=false)MultipartFile[] file,
			@RequestParam(value="imageFile",required=false)MultipartFile[] imageFile){
		SysUser user = TokenManager.getToken();
		StorageWarehouse sw=storageWarehouseService.getStorageWarehouse(user.getOriginCode());
		if (sw!=null){
			constructionProject.setProjectUnit(sw.getWarehouseShort());
			constructionProject.setWarehouseId(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseCode());
		}
		constructionProject.setCreateTime(Calendar.getInstance().getTime());
		
		if(file != null && file.length > 0) 
			constructionProject.setFileGroupId(sysFileService.uploadFiles(request, null, file, "ConstructionProject"));
		if(imageFile != null && imageFile.length > 0) 
			constructionProject.setImageGroupId(sysFileService.uploadFiles(request, null, imageFile, "ConstructionProject"));
		if(constructionProject.getId()==null){
			constructionProject.setId(UUID.randomUUID().toString().replace("-", ""));
		}
		construectionProjectService.AddConstruction(constructionProject);
		sysLogService.add(request, "基建管理-新增基建项目-新增");
		Map<String,Object> result = new HashMap<>();
		result.put("success", true);
		return result;
	}
	
	
	
	/**
	 * 是否存在同一项目名称
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/checkIsAddSameName")
	@ResponseBody
	private int checkIsAddSameName(HttpServletRequest request) {
		// TODO Auto-generated method stub

       int projectCount=0;
       projectCount=construectionProjectService.checkIsAddSameName(request.getParameter("projectName"),request.getParameter("projectSerial"));
	   return projectCount;
	}
	
	@RequestMapping(value="/Add/View",method= {RequestMethod.POST})
	@ResponseBody
	public PageUtil<ConstructionProject> ListConstructionProject(ConstructionProject constructionProject,
			@RequestParam("pageindex")int pageindex,@RequestParam("pagesize")int pagesize) {
		PageUtil<ConstructionProject> pageUtil = new PageUtil<>();
		if(session.getAttribute("ident") != null && session.getAttribute("ident").toString().equals("base")) {
			SysUser user = TokenManager.getToken();
			constructionProject.setProjectUnit(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort());
		}else{
			constructionProject.setPlannedInvestment(10);
			HashMap<String,Object> otherParam = new HashMap<>();
			otherParam.put("symbol", ">=");
			pageUtil.setOtherPram(otherParam);
		}
		pageUtil.setEntity(constructionProject);
		pageUtil.setPageIndex(pageindex);
		pageUtil.setPageSize(pagesize);
		
		pageUtil.setResult(construectionProjectService.ListLimitConstruction(pageUtil));
		
		return pageUtil;
	}
	
	@RequestMapping(value="/New/Edit",method= {RequestMethod.GET},params= {"cid"})
	public String UpdateConstructionProject(Model model,@RequestParam("cid")String cid) {
		ConstructionProject constructionProject = construectionProjectService.GetConstructionDetail(cid);
		constructionProject.setHasChildProject(construectionProjectService.isHashChildProject(cid));// 是否有子项目

		/*List<SysFile> files = null;
		if(constructionProject.getFileGroupId() != null) 
			files = sysFileService.getFilesByGroupId(constructionProject.getFileGroupId());*/

		List<SysFile> files = null;
		if(constructionProject.getFileGroupId() != null) {
			files = sysFileService.getFilesByGroupId(constructionProject.getFileGroupId());
			if(files!=null){
				Map map = new HashMap();
				for (SysFile file:files){
					String downloadUrl = file.getDownloadUrl();
					String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
					map.put(file.getId(),suffix);
					model.addAttribute("suffixMap", map);
				}
			}
		}
		/*List<SysFile> images = null;
		if(constructionProject.getImageGroupId() != null)
			images = sysFileService.getFilesByGroupId(constructionProject.getImageGroupId());*/

		List<SysFile> filesImg = null;
		if(constructionProject.getImageGroupId() != null) {
			filesImg = sysFileService.getFilesByGroupId(constructionProject.getImageGroupId());
			if(filesImg!=null){
				Map map = new HashMap();
				for (SysFile file:filesImg){
					String downloadUrl = file.getDownloadUrl();
					String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
					map.put(file.getId(),suffix);
					model.addAttribute("suffixImgMap", map);
				}
			}
		}

		// 无子项目的项目列表
		List<ConstructionProject> parentList = construectionProjectService.parentProjectList(constructionProject);
		model.addAttribute("parentList",parentList);
		
		model.addAttribute("files",files);
		model.addAttribute("filesImg",filesImg);
		model.addAttribute("construction",constructionProject);
		return "Construction/newconstruction_add";
	}
	
	@RequestMapping(value="/New/Edit",method= {RequestMethod.POST})
	@ResponseBody
	public Map<String,Object> UpdateConstructionProject(HttpServletRequest httpRequest,ConstructionProject constructionProject,@RequestParam(value="file",required=false)MultipartFile[] file,
			@RequestParam(value="imageFile",required=false)MultipartFile[] imageFile,
			@RequestParam(value="fileIds",required=false)String fileIds,@RequestParam(value="imageIds",required=false)String imageIds) {
		ConstructionProject constructionProjectBase = construectionProjectService.GetConstructionDetail(constructionProject.getId());
		
		try {
			UpdateUtil.UpdateField(constructionProject, constructionProjectBase, new String[]{"id"});
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if((file != null && file.length > 0)||fileIds != null) {
			String [] _fileIds = (JsonUtil.toObject(fileIds, String.class)).toArray(new String[] {});
			constructionProjectBase.setFileGroupId(sysFileService.uploadFiles(request, constructionProjectBase.getFileGroupId(), file, "ConstructionProject",_fileIds));
		}
		if((imageFile != null && imageFile.length > 0) || imageIds!=null) {
			String [] _imageIds = (JsonUtil.toObject(imageIds, String.class)).toArray(new String[] {});
			constructionProjectBase.setImageGroupId(sysFileService.uploadFiles(request, constructionProjectBase.getImageGroupId(), imageFile, "ConstructionProject",_imageIds));
		}
		
		construectionProjectService.UpdateConstruction(constructionProjectBase);
		sysLogService.add(request, "基建管理-新增基建项目-修改");
		
		Map<String,Object> result = new HashMap<>();
		result.put("success", true);
		return result;
	}
	
	@RequestMapping(value="/New/Detail",method= {RequestMethod.GET})
	public String ConstructionDetail(Model model,@RequestParam("cid")String cid) {
		ConstructionProject constructionProject = construectionProjectService.GetConstructionDetail(cid);
		
		Properties oaUrl = new Properties();
		try {
			oaUrl.load(this.getClass().getResourceAsStream("/OATable.properties"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<SysFile> files = null;
		if(constructionProject.getFileGroupId() != null) {
			files = sysFileService.getFilesByGroupId(constructionProject.getFileGroupId());
			if(files!=null){
				Map map = new HashMap();
				for (SysFile file:files){
					String downloadUrl = file.getDownloadUrl();
					String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
					map.put(file.getId(),suffix);
					model.addAttribute("suffixMap", map);
				}
			}
		}
		/*List<SysFile> images = null;
		if(constructionProject.getImageGroupId() != null)
			images = sysFileService.getFilesByGroupId(constructionProject.getImageGroupId());*/

		List<SysFile> filesImg = null;
		if(constructionProject.getImageGroupId() != null) {
			filesImg = sysFileService.getFilesByGroupId(constructionProject.getImageGroupId());
			if(filesImg!=null){
				Map map = new HashMap();
				for (SysFile file:filesImg){
					String downloadUrl = file.getDownloadUrl();
					String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
					map.put(file.getId(),suffix);
					model.addAttribute("suffixImgMap", map);
				}
			}
		}


        List<SysFile> datas = null;
        if(constructionProject.getDataGroupId() != null) {
            datas = sysFileService.getFilesByGroupId(constructionProject.getDataGroupId());
            if(datas!=null){
                Map map = new HashMap();
                for (SysFile file:datas){
                    String downloadUrl = file.getDownloadUrl();
                    String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
                    map.put(file.getId(),suffix);
                    model.addAttribute("suffixDatasMap", map);
                }
            }
        }
		model.addAttribute("oaUrl",oaUrl.get("OA_HOST"));
		model.addAttribute("files",files);
		model.addAttribute("filesImg",filesImg);
		model.addAttribute("datas",datas);
		model.addAttribute("project",constructionProject);
		return "Construction/newconstruction_detail";
	}

	@SysLogAn("访问：基建管理-管理项目")
	@RequestMapping(value="/Manage/View",method= {RequestMethod.GET})
	public String ListManageConstruction(Model model,@RequestParam(value="identity",required=false)String identity) {
		PageUtil<ConstructionProject> pageUtil = new PageUtil<>();
		ConstructionProject constructionProject = new ConstructionProject();
		
		if(TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl"))
			identity=null;
		else
			identity="base";
		
		if(identity != null && identity.equals("base")) {
			SysUser user = TokenManager.getToken();
			constructionProject.setWarehouseId(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseCode());
			/*constructionProject.setProjectUnit(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort());*/
			model.addAttribute("identity",storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort());
			session.setAttribute("ident", "base");
		}else {
			constructionProject.setPlannedInvestment(10);
			HashMap<String,Object> otherParam = new HashMap<>();
			otherParam.put("symbol", ">=");
			pageUtil.setOtherPram(otherParam);
			session.removeAttribute("ident");
		}
		
		pageUtil.setEntity(constructionProject);
		pageUtil.setPageIndex(1);
		pageUtil.setPageSize(Integer.valueOf(prop.get("PageSize").toString()));
		
		pageUtil.setResult(construectionProjectService.ListLimitConstruction(pageUtil));
		
		model.addAttribute("constructionlist",pageUtil);
		return "Construction/manageconstruction_view";
	}
	
	@RequestMapping(value="/Manage/View",method= {RequestMethod.POST})
	@ResponseBody
	public PageUtil ListManageConstruction(ConstructionProject constructionProject,
			@RequestParam("pageindex")int pageindex,@RequestParam("pagesize")int pagesize) {
		PageUtil<ConstructionProject> pageUtil = new PageUtil<>();
		if(session.getAttribute("ident") != null && session.getAttribute("ident").toString().equals("base")) {
			SysUser user = TokenManager.getToken();
			constructionProject.setProjectUnit(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort());
		}else{
			constructionProject.setPlannedInvestment(10);
			HashMap<String,Object> otherParam = new HashMap<>();
			otherParam.put("symbol", ">=");
			pageUtil.setOtherPram(otherParam);
		}
		pageUtil.setEntity(constructionProject);
		pageUtil.setPageIndex(pageindex);
		pageUtil.setPageSize(pagesize);
		
		pageUtil.setResult(construectionProjectService.ListLimitConstruction(pageUtil));
		return pageUtil;
	}
	
	@RequestMapping(value="/Manage/Edit",method= {RequestMethod.GET},params= {"cid"})
	public String UpdateManageConstruction(Model model,@RequestParam("cid")String cid) {
		ConstructionProject constructionProject = construectionProjectService.GetConstructionDetail(cid);
		
		/*List<SysFile> files = null;
		if(constructionProject.getFileGroupId() != null) 
			files = sysFileService.getFilesByGroupId(constructionProject.getFileGroupId());*/
        List<SysFile> files = null;
        if(constructionProject.getFileGroupId() != null) {
            files = sysFileService.getFilesByGroupId(constructionProject.getFileGroupId());
            if(files!=null){
                Map map = new HashMap();
                for (SysFile file:files){
                    String downloadUrl = file.getDownloadUrl();
                    String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
                    map.put(file.getId(),suffix);
                    model.addAttribute("suffixMap", map);
                }
            }
        }
		/*List<SysFile> datas = null;
		if(constructionProject.getDataGroupId() != null) 
			datas = sysFileService.getFilesByGroupId(constructionProject.getDataGroupId());*/

        List<SysFile> datas = null;
        if(constructionProject.getDataGroupId() != null) {
            datas = sysFileService.getFilesByGroupId(constructionProject.getDataGroupId());
            if(datas!=null){
                Map map = new HashMap();
                for (SysFile file:datas){
                    String downloadUrl = file.getDownloadUrl();
                    String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
                    map.put(file.getId(),suffix);
                    model.addAttribute("suffixDatasMap", map);
                }
            }
        }

		model.addAttribute("datas",datas);
		model.addAttribute("files",files);
		model.addAttribute("construction",constructionProject);
		return "Construction/manageconstruction_update";
	}

	@SysLogAn("基建管理-管理项目-修改")
	@RequestMapping(value="/Manage/Edit",method= {RequestMethod.POST})
	@ResponseBody
	public Map<String,Object> UpdateManageConstruction(ConstructionProject constructionProject,
			@RequestParam(value="data",required=false)MultipartFile[] data,@RequestParam(value="file",required=false)MultipartFile[] file,
			@RequestParam(value="dataIds",required=false)String dataIds,@RequestParam(value="fileIds",required=false)String fileIds) {
		ConstructionProject constructionProjectBase = construectionProjectService.GetConstructionDetail(constructionProject.getId());
		
		try {
			UpdateUtil.UpdateField(constructionProject, constructionProjectBase, new String[]{"id"});
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if((file != null && file.length > 0)||fileIds != null) {
			String [] _fileIds = (JsonUtil.toObject(fileIds, String.class)).toArray(new String[] {});
			constructionProjectBase.setFileGroupId(sysFileService.uploadFiles(request, constructionProjectBase.getFileGroupId(), file, "ConstructionProject",_fileIds));
		}
		if((data != null && data.length > 0) || dataIds!=null) {
			String [] _dataIds = (JsonUtil.toObject(dataIds, String.class)).toArray(new String[] {});
			constructionProjectBase.setDataGroupId(sysFileService.uploadFiles(request, constructionProjectBase.getDataGroupId(), data, "ConstructionProject",_dataIds));
		}
		
		construectionProjectService.UpdateConstruction(constructionProjectBase);
		
		Map<String,Object> result = new HashMap<>();
		result.put("success", true);
		return result;
	}

	@SysLogAn("访问：基建管理-年度计划")
	@RequestMapping(value="/Plan/View",method= {RequestMethod.GET})
	public String ListPlanConstruction(Model model,@RequestParam(value="identity",required=false)String identity) {

		SysUser sysUser = TokenManager.getToken();
		PageUtil<ConstructionPlan> pageUtil = new PageUtil<>();
		pageUtil.setPageIndex(1);
		pageUtil.setPageSize(Integer.valueOf(prop.get("PageSize").toString()));

		ConstructionPlan param = new ConstructionPlan();
		if (BusinessConstants.CBL_CODE.equals(sysUser.getOriginCode().toLowerCase())) {
			identity = null;
			Map<String,Object> otherParam = new HashMap<>();
			otherParam.put("onlyCompany", true);
			pageUtil.setOtherPram(otherParam);
			session.removeAttribute("company");
			session.removeAttribute("ident");
		} else {
			identity = BusinessConstants.BASE;
			StorageWarehouse storageWarehouse = storageWarehouseService.getStorageWarehouse(sysUser.getOriginCode());
			param.setWarehouseId(storageWarehouseService.getStorageWarehouse(sysUser.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(sysUser.getOriginCode()).getWarehouseCode());
			/*param.setProjectUnit(storageWarehouseService.getStorageWarehouse(sysUser.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(sysUser.getOriginCode()).getWarehouseShort());*/
			String warehouseShortName = "";
			if(storageWarehouse != null){
				warehouseShortName = storageWarehouse.getWarehouseShort();
			}
			/*param.setProjectUnit(warehouseShortName);*/
			model.addAttribute("identity", warehouseShortName);
			session.setAttribute("company", warehouseShortName);
			session.setAttribute("ident", BusinessConstants.BASE);
		}
		
		pageUtil.setEntity(param);
		
		pageUtil.setResult(constructionPlanService.ListLimitPlan(pageUtil));
		model.addAttribute("planlist", pageUtil);
		return "Construction/planconstruction_view";
	}
	
	@RequestMapping(value = "/Plan/ImportExcel",method=RequestMethod.POST)
	@ResponseBody
	public Object importExcel(@RequestParam(value="file") MultipartFile file){
		List<ConstructionPlanDetail> list = null;
		Map<String,Object> result = new HashMap<>();
		try {
			list = ExcelImportUtil.importExcel(file.getInputStream(), ConstructionPlanDetail.class, new ImportParams());
			
			if(list==null){
				result.put("success", false);
				result.put("msg", "未导入任何数据，请检查");
			}else{
				PageUtil<ConstructionProject> pageUtil = new PageUtil<>();
				pageUtil.setEntity(new ConstructionProject());
				pageUtil.setPageIndex(1);
				pageUtil.setPageSize(Integer.MAX_VALUE);
				
				
				
				List<String> projectNames = new ArrayList<>();
				for(ConstructionProject item : construectionProjectService.ListLimitConstruction(pageUtil))
					projectNames.add(item.getProjectName());
				
			
				for(ConstructionPlanDetail detail : list) {
					if(!projectNames.contains(detail.getProjectName())){
						result.put("success", false);
						result.put("msg", "项目列表中不包含名为\""+detail.getProjectName()+"\"的项目");
					}else if(!detail.getConstructionNature().equals("新建")||!detail.getConstructionNature().equals("续建")) {
						result.put("success", false);
						result.put("msg", "建设性质不包含新建或续建以外的值");
					}
				}
				
				result.put("success",true);
				result.put("list", list);
			}
		}catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result.put("success", false);
//			result.put("msg", "模板导入出现异常："+e.getMessage());
			result.put("msg", "模板导入出现异常,请导入正确的模板");
		}
			
		return result;
	}
	
	@RequestMapping(value="/Plan/Add",method= {RequestMethod.GET})
	public String AddPlanConstruction(Model model) {
		ConstructionPlan plan = new ConstructionPlan();
		SysUser user = TokenManager.getToken();
		plan.setCreator(user.getName());
		plan.setCreateDate(new Date());
		plan.setDepartment(user.getDepartment());
		plan.setProjectUnit(user.getShortName());
		
//		PageUtil<ConstructionProject> pageUtil = new PageUtil<>();
//		ConstructionProject project = new ConstructionProject();
//		project.setProjectUnit(user.getShortName());
//		pageUtil.setEntity(project);
//		pageUtil.setPageIndex(1);
//		pageUtil.setPageSize(Integer.MAX_VALUE);
//
//		model.addAttribute("projectList",construectionProjectService.ListLimitConstruction(pageUtil));
		model.addAttribute("plan",plan);
		String wareHouseCode = TokenManager.getToken().getOriginCode();
		if(wareHouseCode.equals("CBL")) {
			wareHouseCode = "";
		}
		model.addAttribute("projectUnitList", storageWarehouseService.HostWareHouses(wareHouseCode));//项目单位列表

		return "Construction/planconstruction_add";
	}

	@RequestMapping("listConstructionProjectByProjectUnit")
	@ResponseBody
	public List<ConstructionProject> getConstructionProjectListByProjectUnit(
			@RequestParam(required = false) String projectUnitId,
			@RequestParam(required = false) String projectUnitName){

		if(StringUtils.isBlank(projectUnitId) && StringUtils.isBlank(projectUnitName)){
			return Collections.emptyList();
		}

		return construectionProjectService.getConstructionProjectByProjectUnit(projectUnitId,projectUnitName);
	}
	
	@RequestMapping(value="/Plan/Edit",method= {RequestMethod.GET},params= {"cid"})
	public String EditPlanConstruction(Model model,@RequestParam("cid")String cid) {
		ConstructionPlan plan = constructionPlanService.GetConstructionPlan(cid);
//		PageUtil<ConstructionProject> pageUtil = new PageUtil<>();
//		ConstructionProject project = new ConstructionProject();
//
//		project.setProjectUnit(plan.getProjectUnit());
//		pageUtil.setEntity(project);
//		pageUtil.setPageIndex(1);
//		pageUtil.setPageSize(Integer.MAX_VALUE);
//		model.addAttribute("projectList",construectionProjectService.ListLimitConstruction(pageUtil));

		model.addAttribute("projectList",
				construectionProjectService.getConstructionProjectByProjectUnit(
						plan.getWarehouseId(),plan.getProjectUnit()));
		model.addAttribute("plan",plan);
		
		model.addAttribute("projectUnitList",storageWarehouseService.listHostWareHouse());//项目单位列表
		
		return "Construction/planconstruction_add";
	}

	@SysLogAn("基建管理-年度计划-修改")
	@RequestMapping(value="/Plan/Edit",method= {RequestMethod.POST})
	@ResponseBody
	public Map EditPlanConstruction(ConstructionPlan constructionPlan,@RequestParam("detailList")String detailList) {
		ConstructionPlan planBase = constructionPlanService.GetConstructionPlan(constructionPlan.getId());
		try {
			UpdateUtil.UpdateField(constructionPlan, planBase, new String[] {"id"});
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		double investmentSubtotal = 0,lastExpendSubtotal = 0,lastInvestmentSubtotal = 0,currentExpendSubtotal = 0,currentInvestmentSubtotal = 0;
		
		List<ConstructionPlanDetail> planDetail = JsonUtil.toObject(detailList, ConstructionPlanDetail.class);
		for(ConstructionPlanDetail detail : planDetail) {
			detail.setId(UUID.randomUUID().toString().replace("-", ""));
			investmentSubtotal += detail.getInvestment();
			lastExpendSubtotal += detail.getLastExpend();
			lastInvestmentSubtotal += detail.getLastInvestment();
			currentExpendSubtotal += detail.getCurrentExpend();
			currentInvestmentSubtotal += detail.getCurrentInvestment();
		}
		planBase.setInvestmentSubtotal(investmentSubtotal);
		planBase.setLastExpendSubtotal(lastExpendSubtotal);
		planBase.setLastInvestmentSubtotal(lastInvestmentSubtotal);
		planBase.setCurrentExpendSubtotal(currentExpendSubtotal);
		planBase.setCurrentInvestmentSubtotal(currentInvestmentSubtotal);
		planBase.setPlanDetail(planDetail);
		
		
		constructionPlanService.UpdateConstructionPlan(planBase);
		
		Map<String,Object> result = new HashMap<>();
		result.put("success", true);
		return result;
	}

	@SysLogAn("基建管理-年度计划-新增")
	@RequestMapping(value="/Plan/Add",method= {RequestMethod.POST})
	@ResponseBody
	public Map AddPlanConstruction(ConstructionPlan constructionPlan,@RequestParam("detailList")String detailList) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH), calendar.get(Calendar.DATE), 0, 0, 0);
		
		double investmentSubtotal = 0,lastExpendSubtotal = 0,lastInvestmentSubtotal = 0,currentExpendSubtotal = 0,currentInvestmentSubtotal = 0;
		
		List<ConstructionPlanDetail> planDetail = JsonUtil.toObject(detailList, ConstructionPlanDetail.class);
		for(ConstructionPlanDetail detail : planDetail) {
			detail.setId(UUID.randomUUID().toString().replace("-", ""));
			investmentSubtotal += detail.getInvestment();
			lastExpendSubtotal += detail.getLastExpend();
			lastInvestmentSubtotal += detail.getLastInvestment();
			currentExpendSubtotal += detail.getCurrentExpend();
			currentInvestmentSubtotal += detail.getCurrentInvestment();
		}
		SysUser user = TokenManager.getToken();
		constructionPlan.setPlanDetail(planDetail);
		constructionPlan.setCreator(user.getName());
		constructionPlan.setOperator(user.getName());
		constructionPlan.setCreateDate(Calendar.getInstance().getTime());
		constructionPlan.setHandleTime(calendar.getTime());
		constructionPlan.setDepartment(user.getDepartment()==null?"":user.getDepartment());
		constructionPlan.setInvestmentSubtotal(investmentSubtotal);
		constructionPlan.setLastExpendSubtotal(lastExpendSubtotal);
		constructionPlan.setLastInvestmentSubtotal(lastInvestmentSubtotal);
		constructionPlan.setCurrentExpendSubtotal(currentExpendSubtotal);
		constructionPlan.setCurrentInvestmentSubtotal(currentInvestmentSubtotal);
		
		constructionPlan.setFromTarget(constructionPlan.getFromTarget().equals("false")?session.getAttribute("ident").toString():null);
		
		constructionPlanService.AddConstructionPlan(constructionPlan);
		
		Map<String,Object> result = new HashMap<>();
		result.put("success", true);
		return result;
	}
	
	@RequestMapping(value="/Plan/View",method= {RequestMethod.POST})
	@ResponseBody
	public PageUtil ListPlanConstruction(ConstructionPlan constructionPlan,
			@RequestParam("pageindex")int pageindex,@RequestParam("pagesize")int pagesize) {
		PageUtil<ConstructionPlan> pageUtil = new PageUtil<>();
		
		if(session.getAttribute("ident") != null && session.getAttribute("ident").toString().equals("base")) {
				SysUser user = TokenManager.getToken();
				constructionPlan.setWarehouseId(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseCode());
				/*constructionPlan.setProjectUnit(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort());*/
		}else {
			Map<String,Object> otherParam = new HashMap<>();
			otherParam.put("onlyCompany", true);
			pageUtil.setOtherPram(otherParam);
		}
		
		pageUtil.setPageIndex(pageindex);
		pageUtil.setPageSize(pagesize);
		pageUtil.setEntity(constructionPlan);
		
		pageUtil.setResult(constructionPlanService.ListLimitPlan(pageUtil));
		return pageUtil;
	}

	@SysLogAn("访问：基建管理-年度计划(汇总)")
	@RequestMapping(value="/Plan/View/Collage",method= {RequestMethod.GET})
	public String ListPlanConstructionCollage(Model model) {
		PageUtil<ConstructionPlan> pageUtil = new PageUtil<>();
		pageUtil.setPageIndex(1);
		pageUtil.setPageSize(Integer.valueOf(prop.get("PageSize").toString()));
		pageUtil.setEntity(new ConstructionPlan());
		
		pageUtil.setResult(constructionPlanService.listGroupByYear(pageUtil));
		model.addAttribute("planlist", pageUtil);
		return "Construction/plancollageconstruction_view";
	}
	
	@RequestMapping(value="/Plan/View/Collage",method= {RequestMethod.POST})
	@ResponseBody
	public PageUtil ListPlanConstructionCollage(ConstructionPlan constructionPlan,
			@RequestParam("pageindex")int pageindex,@RequestParam("pagesize")int pagesize) {
		PageUtil<ConstructionPlan> pageUtil = new PageUtil<>();
		pageUtil.setPageIndex(pageindex);
		pageUtil.setPageSize(pagesize);
		pageUtil.setEntity(constructionPlan);
		
		pageUtil.setResult(constructionPlanService.listGroupByYear(pageUtil));
		return pageUtil;
	}
	
	@RequestMapping(value="/Plan/ExportExcel")
	@ResponseBody
	public void ExportExcelPlan(HttpServletResponse response,@RequestParam("id")String id,@RequestParam(value="collect",required=false)String collect) throws IOException {
		
		List<ConstructionPlan> list = new ArrayList<>();
		if(collect == null) {
			list.add(constructionPlanService.GetConstructionPlan(id));
		}else{
			PageUtil<ConstructionPlan> pageUtil = new PageUtil<>();
			pageUtil.setPageIndex(1);
			pageUtil.setPageSize(Integer.MAX_VALUE);
			ConstructionPlan param = new ConstructionPlan();
			param.setYear(collect);
			pageUtil.setEntity(param);
			Map<String,Object> otherParam = new HashMap<>();
			otherParam.put("onlyCompany", true);
			pageUtil.setOtherPram(otherParam);
			List<ConstructionPlan> dataList = constructionPlanService.ListLimitPlan(pageUtil);
			List<String> ids = new ArrayList<>();
			for(ConstructionPlan data : dataList)
				ids.add(data.getId());
			double investmentTotal = 0,lastExpendTotal = 0,lastInvestmentTotal = 0,
					currentExpendTotal = 0,currentInvestmentTotal = 0;
			dataList = constructionPlanService.ListPlanByIdArray(ids);
			for(ConstructionPlan plan : dataList) {
				investmentTotal += plan.getInvestmentSubtotal();
				lastExpendTotal += plan.getLastExpendSubtotal();
				lastInvestmentTotal += plan.getLastInvestmentSubtotal();
				currentExpendTotal += plan.getCurrentExpendSubtotal();
				currentInvestmentTotal += plan.getCurrentInvestmentSubtotal();
				if(list.contains(plan)) {
					int index = list.indexOf(plan);
					ConstructionPlan _plan = list.get(index);
					_plan.setInvestmentSubtotal(_plan.getInvestmentSubtotal() + plan.getInvestmentSubtotal());
					_plan.setLastExpendSubtotal(_plan.getLastExpendSubtotal() + plan.getLastExpendSubtotal());
					_plan.setLastInvestmentSubtotal(_plan.getLastInvestmentSubtotal() + plan.getLastInvestmentSubtotal());
					_plan.setCurrentExpendSubtotal(_plan.getCurrentExpendSubtotal() + plan.getCurrentExpendSubtotal());
					_plan.setCurrentInvestmentSubtotal(_plan.getCurrentInvestmentSubtotal() + plan.getCurrentInvestmentSubtotal());
					_plan.getPlanDetail().addAll(plan.getPlanDetail());
				}else {
					list.add(plan);
				}
			}
		}
		
		String title = list.get(0).getYear() + constructionPlanService.PLAN_NAME;
		
		response.setHeader("content-Type", "application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;filename=" +  java.net.URLEncoder.encode(title,"UTF-8") + ".xls");
		response.setCharacterEncoding("UTF-8");
		Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams(title, title),ConstructionPlan.class, list);

		workbook.write(response.getOutputStream());
	}
	
	@RequestMapping(value="/Plan/Detail",method= {RequestMethod.GET},params="pid")
	public String PlanDetail(Model model,@RequestParam("pid")String pid,@RequestParam(value="collect",required=false)String collect) {
		List<ConstructionPlan> planDetail = new ArrayList<ConstructionPlan>();
		
		if(collect == null)
			planDetail.add(constructionPlanService.GetConstructionPlan(pid));
		else {
			PageUtil<ConstructionPlan> pageUtil = new PageUtil<>();
			pageUtil.setPageIndex(1);
			pageUtil.setPageSize(Integer.MAX_VALUE);
			ConstructionPlan param = new ConstructionPlan();
			param.setYear(collect);
			pageUtil.setEntity(param);
			Map<String,Object> otherParam = new HashMap<>();
			otherParam.put("onlyCompany", true);
			pageUtil.setOtherPram(otherParam);
			List<ConstructionPlan> dataList = constructionPlanService.ListLimitPlan(pageUtil);
			List<String> ids = new ArrayList<>();
			for(ConstructionPlan data : dataList)
				ids.add(data.getId());
			double investmentTotal = 0,lastExpendTotal = 0,lastInvestmentTotal = 0,
					currentExpendTotal = 0,currentInvestmentTotal = 0;
			dataList = constructionPlanService.ListPlanByIdArray(ids);
			for(ConstructionPlan plan : dataList) {
				investmentTotal += plan.getInvestmentSubtotal();
				lastExpendTotal += plan.getLastExpendSubtotal();
				lastInvestmentTotal += plan.getLastInvestmentSubtotal();
				currentExpendTotal += plan.getCurrentExpendSubtotal();
				currentInvestmentTotal += plan.getCurrentInvestmentSubtotal();
				if(planDetail.contains(plan)) {
					int index = planDetail.indexOf(plan);
					ConstructionPlan _plan = planDetail.get(index);
					_plan.setInvestmentSubtotal(_plan.getInvestmentSubtotal() + plan.getInvestmentSubtotal());
					_plan.setLastExpendSubtotal(_plan.getLastExpendSubtotal() + plan.getLastExpendSubtotal());
					_plan.setLastInvestmentSubtotal(_plan.getLastInvestmentSubtotal() + plan.getLastInvestmentSubtotal());
					_plan.setCurrentExpendSubtotal(_plan.getCurrentExpendSubtotal() + plan.getCurrentExpendSubtotal());
					_plan.setCurrentInvestmentSubtotal(_plan.getCurrentInvestmentSubtotal() + plan.getCurrentInvestmentSubtotal());
					_plan.getPlanDetail().addAll(plan.getPlanDetail());
				}else {
					planDetail.add(plan);
				}
			}
			model.addAttribute("investmentTotal",investmentTotal);
			model.addAttribute("lastExpendTotal",lastExpendTotal);
			model.addAttribute("lastInvestmentTotal",lastInvestmentTotal);
			model.addAttribute("currentExpendTotal",currentExpendTotal);
			model.addAttribute("currentInvestmentTotal",currentInvestmentTotal);
			model.addAttribute("collect",true);
		}
		model.addAttribute("plans",planDetail);
		return "Construction/planconstruction_detail";
	}
	
	@RequestMapping(value="/{enter}/View",method= {RequestMethod.GET})
	public String ListConstruction(Model model,@PathVariable("enter")String enter,@RequestParam(value="identity",required=false)String identity) {
		PageUtil<ConstructionInfo> pageUtil = new PageUtil<>();
		pageUtil.setPageIndex(1);
		pageUtil.setPageSize(Integer.valueOf(prop.get("PageSize").toString()));
		ConstructionInfo info = new ConstructionInfo();
		
		if (TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl"))
			identity=null;
		else
			identity="base";
		
		if (identity != null && identity.equals("base")) {
			SysUser user = TokenManager.getToken();
			info.setWarehouseId(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseCode());
			/*info.setProjectUnit(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort());*/
			model.addAttribute("identity",storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort());
			session.setAttribute("ident", "base");
			session.setAttribute("company", storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort());
		} else {
			Map<String,Object> otherParam = new HashMap<>();
			otherParam.put("symbol", ">=");
			otherParam.put("plannedInvestment", 10);
			pageUtil.setOtherPram(otherParam);
			session.removeAttribute("ident");
		}
		
		info.setDataType(mapper.get(enter));
		pageUtil.setEntity(info);
		
		pageUtil.setResult(constructionInfoService.ListLimitChange(pageUtil));
		model.addAttribute(enter.toLowerCase()+"list",pageUtil);
		if("Bidding".equals(enter)){
			sysLogService.add(request, "访问：基建管理-招投标");
		}else if("Change".equals(enter)){
			sysLogService.add(request, "访问：基建管理-项目变更");
		}else if("Acceptance".equals(enter)){
			sysLogService.add(request, "访问：基建管理-工程验收");
		}
		return "Construction/"+enter.toLowerCase()+"construction_view";
	}
	
	@RequestMapping(value="/{enter}/Add",method= {RequestMethod.GET})
	public String AddConstruction(Model model,@PathVariable("enter")String enter) {

		SysUser user = TokenManager.getToken();
		String defaultProjectUnit;
		String warehouseId="";

		if (user.getOriginCode().toLowerCase().equals("cbl")) {
			defaultProjectUnit = "";
			warehouseId="";
		} else {
			defaultProjectUnit = user.getShortName();
			
			warehouseId = storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseCode();
		}

		PageUtil<ConstructionProject> pageUtil = new PageUtil<>();
		ConstructionProject project = new ConstructionProject();
		pageUtil.setEntity(project);
		pageUtil.setPageIndex(1);
		pageUtil.setPageSize(Integer.MAX_VALUE);
		project.setProjectUnit(defaultProjectUnit);
		project.setWarehouseId(warehouseId);
		model.addAttribute("projectList",construectionProjectService.ListLimitConstruction(pageUtil));
		
		ConstructionInfo info = new ConstructionInfo();
		info.setOperator(user.getName());
		info.setHandleTime(Calendar.getInstance().getTime());
		info.setDepartment(user.getDepartment());
		info.setProjectUnit(user.getShortName());
		
		model.addAttribute(enter.toLowerCase(),info);
		model.addAttribute("defaultProjectUnit",defaultProjectUnit);
		model.addAttribute("warehouseId",warehouseId);
		model.addAttribute("projectUnitList",storageWarehouseService.listHostWareHouse());//项目单位列表
		return "Construction/"+enter.toLowerCase()+"construction_add";
	}
	
	@RequestMapping(value="/{enter}/Edit",method= {RequestMethod.GET},params= {"cid"})
	public String EditConstruction(Model model,@PathVariable("enter")String enter,@RequestParam("cid")String cid) {
		SysUser user = TokenManager.getToken();
		PageUtil<ConstructionProject> pageUtil = new PageUtil<>();
		ConstructionProject project = new ConstructionProject();
		pageUtil.setEntity(project);
		pageUtil.setPageIndex(1);
		pageUtil.setPageSize(Integer.MAX_VALUE);
		project.setProjectUnit(TokenManager.getToken().getShortName());
		project.setWarehouseId(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseCode());
		ConstructionInfo info = constructionInfoService.GetConstructionInfo(cid);

		List<SysFile> files = null;
		if(info.getFileGroupId() != null) {
			files = sysFileService.getFilesByGroupId(info.getFileGroupId());
			if(files!=null){
				Map map = new HashMap();
				for (SysFile file:files){
					String downloadUrl = file.getDownloadUrl();
					String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
					map.put(file.getId(),suffix);
					model.addAttribute("suffixMap", map);
				}
			}
		}

		List<SysFile> filesImg = null;
		if(info.getImageGroupId() != null) {
			filesImg = sysFileService.getFilesByGroupId(info.getImageGroupId());
			if(filesImg!=null){
				Map map = new HashMap();
				for (SysFile file:filesImg){
					String downloadUrl = file.getDownloadUrl();
					String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
					map.put(file.getId(),suffix);
					model.addAttribute("suffixImgMap", map);
				}
			}
		}

		List<SysFile> filesMeets = null;
		if(info.getMeetGroupId() != null) {
			filesMeets = sysFileService.getFilesByGroupId(info.getMeetGroupId());
			if(filesMeets!=null){
				Map map = new HashMap();
				for (SysFile file:filesMeets){
					String downloadUrl = file.getDownloadUrl();
					String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
					map.put(file.getId(),suffix);
					model.addAttribute("suffixMeetsMap", map);
				}
			}
		}
		/*List<SysFile> files = null;
		if(info.getFileGroupId() != null)
			files = sysFileService.getFilesByGroupId(info.getFileGroupId());*/
		/*List<SysFile> images = null;
		if(info.getImageGroupId() != null)
			images = sysFileService.getFilesByGroupId(info.getImageGroupId());*/
		/*List<SysFile> meets = null;
		if(info.getMeetGroupId() != null)
			meets = sysFileService.getFilesByGroupId(info.getMeetGroupId());*/
		
	
		String defaultProjectUnit="";
		String warehouseId="";

		if(TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")){
			defaultProjectUnit="";
			warehouseId="";
		}else{
			defaultProjectUnit=info.getProjectUnit();
			warehouseId = storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getId();
		}
		
		model.addAttribute("files",files);
		model.addAttribute("filesImg",filesImg);
		model.addAttribute("filesMeets",filesMeets);
		model.addAttribute(enter.toLowerCase(),info);
		model.addAttribute("unitlist",storageWarehouseService.getAllWarehouse());
		model.addAttribute("projectList",construectionProjectService.ListLimitConstruction(pageUtil));
		model.addAttribute("projectUnitList",storageWarehouseService.listHostWareHouse());//项目单位列表
		model.addAttribute("defaultProjectUnit",defaultProjectUnit);
		model.addAttribute("warehouseId",warehouseId);
		return "Construction/"+enter.toLowerCase()+"construction_add";
	}
	
	@RequestMapping(value="/{enter}/Edit",method= {RequestMethod.POST})
	@ResponseBody
	public Map EditConstruction(ConstructionInfo constructionInfo,@PathVariable("enter")String enter,@RequestParam(value="file",required=false)MultipartFile[] file,
			@RequestParam(value="imageFile",required=false)MultipartFile[] imageFile,@RequestParam(value="meetFile",required=false)MultipartFile[] meetFile,
			@RequestParam(value="fileIds",required=false)String fileIds,@RequestParam(value="imageIds",required=false)String imageIds,
			@RequestParam(value="meetIds",required=false)String meetIds) {
		ConstructionInfo constructionInfoBase = constructionInfoService.GetConstructionInfo(constructionInfo.getId());
        SysUser user = TokenManager.getToken();

        try {
			UpdateUtil.UpdateField(constructionInfo, constructionInfoBase,new String[]{"id"});
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if((file != null && file.length > 0)||fileIds != null) {
			String [] _fileIds = (JsonUtil.toObject(fileIds, String.class)).toArray(new String[] {});
			constructionInfoBase.setFileGroupId(sysFileService.uploadFiles(request, constructionInfoBase.getFileGroupId(), file, "ConstructionInfo",_fileIds));
		}
		if((imageFile != null && imageFile.length > 0) || imageIds!=null) {
			String [] _imageIds = (JsonUtil.toObject(imageIds, String.class)).toArray(new String[] {});
			constructionInfoBase.setImageGroupId(sysFileService.uploadFiles(request, constructionInfoBase.getImageGroupId(), imageFile, "ConstructionInfo",_imageIds));
		}
		if((meetFile != null && meetFile.length > 0) || meetIds!=null) {
			String [] _meetIds = (JsonUtil.toObject(meetIds, String.class)).toArray(new String[] {});
			constructionInfoBase.setMeetGroupId(sysFileService.uploadFiles(request, constructionInfoBase.getMeetGroupId(), meetFile, "ConstructionInfo",_meetIds));
		}
        constructionInfoBase.setWarehouseId(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseCode());

        constructionInfoService.UpdateConstructionInfo(constructionInfoBase);

		if("Bidding".equals(enter)){
			sysLogService.add(request, "基建管理-招投标-修改");
		}else if("Change".equals(enter)){
			sysLogService.add(request, "基建管理-项目变更-修改");
		}else if("Acceptance".equals(enter)){
			sysLogService.add(request, "基建管理-工程验收-修改");
		}
		
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("success", true);
		return result;
	}
	
	@RequestMapping(value="/{enter}/View",method= {RequestMethod.POST})
	@ResponseBody
	public PageUtil ListConstruction(ConstructionInfo constructionInfo,@PathVariable("enter")String enter,
			@RequestParam("pageindex")int pageindex,@RequestParam("pagesize")int pagesize) {
		PageUtil<ConstructionInfo> pageUtil = new PageUtil<>();
		
		if(session.getAttribute("ident") != null && session.getAttribute("ident").equals("base")) {
			SysUser user = TokenManager.getToken();
			if(StringUtils.isNotEmpty(user.getOriginCode()) && !StringUtils.equals(user.getOriginCode().toUpperCase(),"CBL"))
				constructionInfo.setWarehouseId(user.getOriginCode());
		}else {
			Map<String,Object> otherParam = new HashMap<>();
			otherParam.put("symbol", ">=");
			otherParam.put("plannedInvestment", 10);
			pageUtil.setOtherPram(otherParam);
		}

		pageUtil.setPageIndex(pageindex);
		pageUtil.setPageSize(pagesize);
		constructionInfo.setDataType(mapper.get(enter));
		pageUtil.setEntity(constructionInfo);
		
		pageUtil.setResult(constructionInfoService.ListLimitChange(pageUtil));
		return pageUtil;
	}
	
	@RequestMapping(value="/{enter}/Add",method= {RequestMethod.POST})
	@ResponseBody
	public Map<String,Object> AddConstruction(ConstructionInfo constructionInfo,@PathVariable("enter")String enter,@RequestParam(value="file",required=false)MultipartFile[] file,
			@RequestParam(value="imageFile",required=false)MultipartFile[] imageFile,@RequestParam(value="meetFile",required=false)MultipartFile[] meetFile) {
		SysUser user = TokenManager.getToken();
		
		constructionInfo.setDepartment(user.getDepartment()==null?"":user.getDepartment());
		constructionInfo.setOperator(user.getName());
		constructionInfo.setHandleTime(Calendar.getInstance().getTime());
		
		if(file != null && file.length > 0) 
			constructionInfo.setFileGroupId(sysFileService.uploadFiles(request, null, file, "ConstructionInfo"));
		if(imageFile != null && imageFile.length > 0) 
			constructionInfo.setImageGroupId(sysFileService.uploadFiles(request, null, imageFile, "ConstructionInfo"));
		if(meetFile != null && meetFile.length > 0) 
			constructionInfo.setMeetGroupId(sysFileService.uploadFiles(request, null, meetFile, "ConstructionInfo"));
		
		constructionInfoService.AddConstructionInfo(constructionInfo);

		if("Bidding".equals(enter)){
			sysLogService.add(request, "基建管理-招投标-新增");
		}else if("Change".equals(enter)){
			sysLogService.add(request, "基建管理-项目变更-新增");
		}else if("Acceptance".equals(enter)){
			sysLogService.add(request, "基建管理-工程验收-新增");
		}
		
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("success", true);
		return result;
	}
	
	@RequestMapping(value="/Detail/{enter}",method=RequestMethod.GET,params="id")
	public String ConstructionBiddingDetail(Model model,@PathVariable("enter")String enter,@RequestParam("id")String id) {
		ConstructionInfo info = constructionInfoService.GetConstructionInfo(id);

        List<SysFile> files = null;
        if(info.getFileGroupId() != null) {
            files = sysFileService.getFilesByGroupId(info.getFileGroupId());
            if(files!=null){
                Map map = new HashMap();
                for (SysFile file:files){
                    String downloadUrl = file.getDownloadUrl();
                    String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
                    map.put(file.getId(),suffix);
                    model.addAttribute("suffixMap", map);
                }
            }
        }

        List<SysFile> filesImg = null;
        if(info.getImageGroupId() != null) {
            filesImg = sysFileService.getFilesByGroupId(info.getImageGroupId());
            if(filesImg!=null){
                Map map = new HashMap();
                for (SysFile file:filesImg){
                    String downloadUrl = file.getDownloadUrl();
                    String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
                    map.put(file.getId(),suffix);
                    model.addAttribute("suffixImgMap", map);
                }
            }
        }

        List<SysFile> filesMeets = null;
        if(info.getMeetGroupId() != null) {
            filesMeets = sysFileService.getFilesByGroupId(info.getMeetGroupId());
            if(filesMeets!=null){
                Map map = new HashMap();
                for (SysFile file:filesMeets){
                    String downloadUrl = file.getDownloadUrl();
                    String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
                    map.put(file.getId(),suffix);
                    model.addAttribute("suffixMeetsMap", map);
                }
            }
        }

		model.addAttribute("files",files);
		model.addAttribute("filesImg",filesImg);
		model.addAttribute("filesMeets",filesMeets);
		model.addAttribute("info",info);
		return "Construction/"+enter.toLowerCase()+"construction_detail";
	}

	@SysLogAn("访问：基建管理-工程结算")
	@RequestMapping(value="/Balance/View",method= {RequestMethod.GET})
	public String ListBalanceConstruction(Model model,@RequestParam(value="identity",required=false)String identity) {
		PageUtil<ConstructionBalance> pageUtil = new PageUtil<>();
		pageUtil.setPageIndex(1);
		pageUtil.setPageSize(Integer.valueOf(prop.get("PageSize").toString()));
		ConstructionBalance info = new ConstructionBalance();
		
		if(TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl"))
			identity=null;
		else
			identity="base";
		
		if(identity != null && identity.equals("base")) {
			SysUser user = TokenManager.getToken();
			/*info.setReportUnit(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort());*/
			info.setWarehouseId(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseCode());
			session.setAttribute("ident", "base");
		}else {
			Map<String,Object> otherParam = new HashMap<>();
			otherParam.put("symbol", ">=");
			otherParam.put("plannedInvestment", 10);
			pageUtil.setOtherPram(otherParam);
			session.removeAttribute("ident"); 
		}
		pageUtil.setEntity(info);
		
		pageUtil.setResult(constructionBalanceService.ListLimitBalance(pageUtil));
		model.addAttribute("balancelist",pageUtil);
		
		return "Construction/balanceconstruction_view";
	}
	
	@RequestMapping(value="/Balance/View",method= {RequestMethod.POST})
	@ResponseBody
	public PageUtil ListBalanceConstruction(ConstructionBalance constructionBalance,@RequestParam("pageindex")int pageindex,@RequestParam("pagesize")int pagesize) {
		PageUtil<ConstructionBalance> pageUtil = new PageUtil<>();
		pageUtil.setPageIndex(pageindex);
		pageUtil.setPageSize(pagesize);
		pageUtil.setEntity(constructionBalance);
		
		if(session.getAttribute("ident") != null && session.getAttribute("ident").toString().equals("base")) {
			SysUser user = TokenManager.getToken();
			constructionBalance.setWarehouseId(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseCode());
			/*constructionBalance.setReportUnit(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort());*/
			session.setAttribute("ident", "base");
		}else {
			Map<String,Object> otherParam = new HashMap<>();
			otherParam.put("symbol", ">=");
			otherParam.put("plannedInvestment", 10);
			pageUtil.setOtherPram(otherParam);
			session.removeAttribute("ident"); 
		}
		
		pageUtil.setResult(constructionBalanceService.ListLimitBalance(pageUtil));
		
		return pageUtil;
	}
	
	@RequestMapping(value="/Balance/Add",method= {RequestMethod.GET})
	public String AddBalanceConstruction(Model model) {
		PageUtil<ConstructionProject> pageUtil = new PageUtil<>();
		ConstructionProject project = new ConstructionProject();
		project.setProjectUnit(TokenManager.getToken().getShortName());
		pageUtil.setEntity(project);
		pageUtil.setPageIndex(1);
		pageUtil.setPageSize(Integer.MAX_VALUE);
		model.addAttribute("projectList",construectionProjectService.ListLimitConstruction(pageUtil));
		
		SysUser user = TokenManager.getToken();
		
		ConstructionBalance balance = new ConstructionBalance();
		balance.setOperator(user.getName());
		//balance.setProjectUnit(storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort()==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort());
		balance.setProjectUnit(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort());
		balance.setWarehouseId("CBL".equals(user.getOriginCode())?"":user.getOriginCode());
		balance.setReportDept(user.getDepartment()==null?"":user.getDepartment());
		balance.setReportUnit(storageWarehouseService.getStorageWarehouse(user.getOriginCode()) != null?storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort():"");
		


		model.addAttribute("balance", balance);
		return "Construction/balanceconstruction_add";
	}

	@SysLogAn("基建管理-工程结算-新增")
	@RequestMapping(value="/Balance/Add",method= {RequestMethod.POST})
	@ResponseBody
	public Map AddBalanceConstruction(ConstructionBalance constructionBalance,@RequestParam(value="file",required=false)MultipartFile[] file,
			@RequestParam(value="imageFile",required=false)MultipartFile[] imageFile) {
		SysUser user = TokenManager.getToken();
		
		constructionBalance.setReportTime(new SimpleDateFormat("yyyy年MM月dd日").format(Calendar.getInstance().getTime()));
		//constructionBalance.setReportUnit(storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort() != null?storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort():"");
		constructionBalance.setReportUnit(storageWarehouseService.getStorageWarehouse(user.getOriginCode()) != null?storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort():"");
		//constructionBalance.setWarehouseId(storageWarehouseService.getStorageWarehouse(user.getOriginCode()) != null?storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getId():"");
		constructionBalance.setOperator(user.getName());
		constructionBalance.setReportDept(user.getDepartment()!=null?user.getDepartment():"");
		
		if(file != null && file.length > 0) 
			constructionBalance.setFileGroupId(sysFileService.uploadFiles(request, null, file, "ConstructionBalance"));
		if(imageFile != null && imageFile.length > 0) 
			constructionBalance.setImageGroupId(sysFileService.uploadFiles(request, null, imageFile, "ConstructionBalance"));
		
		
		
		
		
		constructionBalanceService.AddConstructionBalance(constructionBalance);


		//附件
		String  fileCode=this.exprotAnyExcelBalance(constructionBalance.getId());
		StringBuffer files = new StringBuffer();

		if(constructionBalance.getFileGroupId()!=null){
			List<SysFile> list=  sysFileService.getFilesByGroupId(constructionBalance.getFileGroupId());
			if(list!=null && list.size()>0){
				for(SysFile sysFile:list){
					files.append(String.format("http://%s:%s%s/", request.getServerName(),request.getServerPort(),request.getContextPath())).append("/sysFile/download.shtml?fileId=").append(sysFile.getId());
					if(list.size()>1 && list.indexOf(sysFile)+1!=list.size()){
						files.append(",");
					}
				}
//				files =String.format("http://%s:%s%s/", request.getServerName(),request.getServerPort(),request.getContextPath()) + "files/code/" + constructionBalance.getFileGroupId()
//						+"."+list.get(0).getFileType();
			}


		}
//		//提交后要推送OA审核
		if(constructionBalance.getStatus().equals("审核中") || constructionBalance.getStatus().equals("OA审核中")) {
			ConstructionProject project = construectionProjectService.GetConstructionDetail(constructionBalance.getProjectSerial());
			String status = "";
			if(constructionBalance.getStatus().equals("审核中")) {
				if(project.getPlannedInvestment() < 50) {
					status = "已完成:驳回";
				}else {
					status = "已通过:驳回";
				}
			}else {
				status = "已完成:驳回";
			}
			sysOAService.LaunchedAuditAndFile(
					constructionBalance.getId(), 
					TokenManager.getSysUserId(),
					constructionBalance.getProjectName().concat("工程结算"),
					String.format("http://%s:%s%s/", request.getServerName(),request.getServerPort(),request.getContextPath()) + "files/code/" + fileCode,
					files.toString(),
					new SysProcessMapper("T_CONSTRUCTION_BALANCE","STATUS",status));
		}
		if("审核中".equals(constructionBalance.getStatus())){
			sysLogService.add(request, "基建管理-工程结算-提交");
		}else if("OA审核中".equals(constructionBalance.getStatus())){
			sysLogService.add(request, "基建管理-工程结算-OA审核");
		}else if("待提交".equals(constructionBalance.getStatus())){
			sysLogService.add(request, "基建管理-工程结算-修改");
		}else{
			sysLogService.add(request, "基建管理-工程结算-"+constructionBalance.getStatus());
		}
		
		
		
		
		Map<String,Object> result = new HashMap<>();
		result.put("success", true);
		return result;
	}


	/**
	 *
	 * @param id
	 * @return
	 */
	public String exprotAnyExcelBalance(String id) {
		SysUser user = TokenManager.getToken();
		String fileCode = null;

		ConstructionBalance  planmain = constructionBalanceService.GetConstructionBalance(id);
		if(planmain != null) {
			String host = String.format("http://%s:%s%s/", request.getServerName(),request.getServerPort(),request.getContextPath());
			HttpClient client = HttpClients.createDefault();
			//模拟进行一次登陆以绕过验证
			HttpPost post = new HttpPost(host + "sign/submitLogin.shtml");
			List<NameValuePair> list = new ArrayList<>();
			list.add(new BasicNameValuePair("account",user.getAccount()));
			list.add(new BasicNameValuePair("password",user.getPassword()));
			UrlEncodedFormEntity entity = null;
			try {
				entity = new UrlEncodedFormEntity(list,"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			post.setEntity(entity);
			HttpResponse response = null;
			try {
				response = client.execute(post);
			} catch (IOException e) {
				e.printStackTrace();
			}
			if(response != null) {
				HttpEntity httpEntity = response.getEntity();
				try {
					JSONObject returnData = JSONObject.fromObject(EntityUtils.toString(httpEntity,"utf-8"));
					if(!(returnData.get("message").equals("登录成功"))) {
						return fileCode;
					}
				}  catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			StringBuilder param = new StringBuilder();
			param.append("id="+id);
			param.append("&type=");
			HttpGet get = new HttpGet(host + String.format("Construction/Balance/ExportExcel.shtml?%s", param.toString()));
			try {
				response = client.execute(get);
			} catch (IOException e) {
				e.printStackTrace();
			}
			if(response != null) {
				HttpEntity httpEntity = response.getEntity();
				try {
					if(response.getStatusLine().getStatusCode() == HttpStatus.OK.value()) {
						InputStream in = httpEntity.getContent();
						File file = new File(request.getSession().getServletContext().getRealPath("/") + Constant.EXPORT_PATH);
						if(!file.exists())
							file.mkdirs();
						fileCode = UUID.randomUUID().toString().replace("-", "") + ".xls";
						FileOutputStream fos = new FileOutputStream(file.getPath() + "/" + fileCode);
						byte[] buffer = new byte[4096];
						int readLength = 0;
						while ((readLength=in.read(buffer)) > 0) {
							byte[] bytes = new byte[readLength];
							System.arraycopy(buffer, 0, bytes, 0, readLength);
							fos.write(bytes);
						}
						fos.flush();
						in.close();
						fos.close();
						return fileCode;
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return fileCode;
	}


	/**
	 *
	 * @param id
	 * @return
	 */
	public String exprotAnyExcelSchedule(String id) {
		SysUser user = TokenManager.getToken();
		String fileCode = null;

		ConstructionSchedule  planmain = constructionScheduleService.GetConstructionSchedule(id);

		if(planmain != null) {
			String host = String.format("http://%s:%s%s/", request.getServerName(),request.getServerPort(),request.getContextPath());
			HttpClient client = HttpClients.createDefault();
			//模拟进行一次登陆以绕过验证
			HttpPost post = new HttpPost(host + "sign/submitLogin.shtml");
			List<NameValuePair> list = new ArrayList<>();
			list.add(new BasicNameValuePair("account",user.getAccount()));
			list.add(new BasicNameValuePair("password",user.getPassword()));
			UrlEncodedFormEntity entity = null;
			try {
				entity = new UrlEncodedFormEntity(list,"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			post.setEntity(entity);
			HttpResponse response = null;
			try {
				response = client.execute(post);
			} catch (IOException e) {
				e.printStackTrace();
			}
			if(response != null) {
				HttpEntity httpEntity = response.getEntity();
				try {
					JSONObject returnData = JSONObject.fromObject(EntityUtils.toString(httpEntity,"utf-8"));
					if(!(returnData.get("message").equals("登录成功"))) {
						return fileCode;
					}
				}  catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			StringBuilder param = new StringBuilder();
			param.append("id="+id);
//			param.append("&collect="+planmain.getCollect());
			HttpGet get = new HttpGet(host + String.format("Construction/Schedule/ExprotExcel.shtml?%s", param.toString()));
			try {
				response = client.execute(get);
			} catch (IOException e) {
				e.printStackTrace();
			}
			if(response != null) {
				HttpEntity httpEntity = response.getEntity();
				try {
					if(response.getStatusLine().getStatusCode() == HttpStatus.OK.value()) {
						InputStream in = httpEntity.getContent();
						File file = new File(request.getSession().getServletContext().getRealPath("/") + Constant.EXPORT_PATH);
						if(!file.exists())
							file.mkdirs();
						fileCode = UUID.randomUUID().toString().replace("-", "") + ".xls";
						FileOutputStream fos = new FileOutputStream(file.getPath() + "/" + fileCode);
						byte[] buffer = new byte[4096];
						int readLength = 0;
						while ((readLength=in.read(buffer)) > 0) {
							byte[] bytes = new byte[readLength];
							System.arraycopy(buffer, 0, bytes, 0, readLength);
							fos.write(bytes);
						}
						fos.flush();
						in.close();
						fos.close();
						return fileCode;
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return fileCode;
	}




	@RequestMapping(value="/Balance/Edit",method= {RequestMethod.GET},params= {"cid"})
	public String EditBalanceConstruction(Model model,@RequestParam("cid")String cid) {
		PageUtil<ConstructionProject> pageUtil = new PageUtil<>();
		ConstructionProject project = new ConstructionProject();
		project.setProjectUnit(TokenManager.getToken().getShortName());
		pageUtil.setEntity(project);
		pageUtil.setPageIndex(1);
		pageUtil.setPageSize(Integer.MAX_VALUE);
		
		ConstructionBalance constructionBalance = constructionBalanceService.GetConstructionBalance(cid);

		List<SysFile> files = null;
		if(constructionBalance.getFileGroupId() != null) {
			files = sysFileService.getFilesByGroupId(constructionBalance.getFileGroupId());
			if(files!=null){
				Map map = new HashMap();
				for (SysFile file:files){
					String downloadUrl = file.getDownloadUrl();
					String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
					map.put(file.getId(),suffix);
					model.addAttribute("suffixMap", map);
				}
			}
		}

		List<SysFile> filesImg = null;
		if(constructionBalance.getImageGroupId() != null) {
			filesImg = sysFileService.getFilesByGroupId(constructionBalance.getImageGroupId());
			if(filesImg!=null){
				Map map = new HashMap();
				for (SysFile file:filesImg){
					String downloadUrl = file.getDownloadUrl();
					String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
					map.put(file.getId(),suffix);
					model.addAttribute("suffixImgMap", map);
				}
			}
		}
		
		model.addAttribute("files",files);
		model.addAttribute("filesImg",filesImg);
		model.addAttribute("balance",constructionBalance);
		model.addAttribute("projectList",construectionProjectService.ListLimitConstruction(pageUtil));
		
		return "Construction/balanceconstruction_add";
	}
	
	@RequestMapping(value="/Balance/Edit",method= {RequestMethod.POST})
	@ResponseBody
	public Map EditBalanceConstruction(ConstructionBalance constructionBalance,@RequestParam(value="file",required=false)MultipartFile[] file,
			@RequestParam(value="imageFile",required=false)MultipartFile[] imageFile,@RequestParam(value="fileIds",required=false)String fileIds,
			@RequestParam(value="imageIds",required=false)String imageIds) {
		ConstructionBalance constructionBalanceBase = constructionBalanceService.GetConstructionBalance(constructionBalance.getId());
		try {
			UpdateUtil.UpdateField(constructionBalance, constructionBalanceBase, new String[] {"id"});
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if((file != null && file.length > 0)||fileIds != null) {
			String [] _fileIds = (JsonUtil.toObject(fileIds, String.class)).toArray(new String[] {});
			constructionBalanceBase.setFileGroupId(sysFileService.uploadFiles(request, constructionBalanceBase.getFileGroupId(), file, "ConstructionBalance",_fileIds));
		}
		if((imageFile != null && imageFile.length > 0) || imageIds!=null) {
			String [] _imageIds = (JsonUtil.toObject(imageIds, String.class)).toArray(new String[] {});
			constructionBalanceBase.setImageGroupId(sysFileService.uploadFiles(request, constructionBalanceBase.getImageGroupId(), imageFile, "ConstructionBalance",_imageIds));
		}
		
		constructionBalanceService.UpdateConstructionBalance(constructionBalanceBase);

		//附件
		String  fileCode=this.exprotAnyExcelBalance(constructionBalance.getId());
		String  files="";

		if(constructionBalance.getFileGroupId()!=null){
			List<SysFile> list=  sysFileService.getFilesByGroupId(constructionBalance.getFileGroupId());
			if(list.size()>0){
				files =String.format("http://%s:%s%s/", request.getServerName(),request.getServerPort(),request.getContextPath()) + "files/code/" + constructionBalance.getFileGroupId()
						+"."+list.get(0).getFileType();
			}


		}
		//提交后要推送OA审核
		if(constructionBalanceBase.getStatus().equals("审核中") || constructionBalanceBase.getStatus().equals("OA审核中")) {
			ConstructionProject project = construectionProjectService.GetConstructionDetail(constructionBalanceBase.getProjectSerial());
			String status = "";
			if(constructionBalance.getStatus().equals("审核中")) {
				if(project.getPlannedInvestment() < 50) {
					status = "已完成:驳回";
				}else {
					status = "已通过:驳回";
				}
			}else {
				status = "已完成:驳回";
			}

			sysOAService.LaunchedAuditAndFile(
					constructionBalance.getId(),
					TokenManager.getSysUserId(),
					constructionBalanceBase.getProjectName().concat("工程结算"),
					String.format("http://%s:%s%s/", request.getServerName(),request.getServerPort(),request.getContextPath()) + "files/code/" + fileCode,
					files,
					new SysProcessMapper("T_CONSTRUCTION_BALANCE","STATUS",status));

		}
		if("审核中".equals(constructionBalanceBase.getStatus())){
			sysLogService.add(request, "基建管理-工程结算-提交");
		}else if("OA审核中".equals(constructionBalanceBase.getStatus())){
			sysLogService.add(request, "基建管理-工程结算-OA审核");
		}else if("待提交".equals(constructionBalanceBase.getStatus())){
			sysLogService.add(request, "基建管理-工程结算-修改");
		}else{
			sysLogService.add(request, "基建管理-工程结算-"+constructionBalanceBase.getStatus());
		}
		
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("success", true);
		return result;
	}
	
	@RequestMapping(value="/Balance/Detail",method= {RequestMethod.GET},params= {"id"})
	public String DetailBalanceConstruction(Model model,@RequestParam("id")String id) {
		ConstructionBalance constructionBalance = constructionBalanceService.GetConstructionBalance(id);

		List<SysFile> files = null;
		if(constructionBalance.getFileGroupId() != null) {
			files = sysFileService.getFilesByGroupId(constructionBalance.getFileGroupId());
			if(files!=null){
				Map map = new HashMap();
				for (SysFile file:files){
					String downloadUrl = file.getDownloadUrl();
					String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
					map.put(file.getId(),suffix);
					model.addAttribute("suffixMap", map);
				}
			}
		}

		List<SysFile> filesImg = null;
		if(constructionBalance.getImageGroupId() != null) {
			filesImg = sysFileService.getFilesByGroupId(constructionBalance.getImageGroupId());
			if(filesImg!=null){
				Map map = new HashMap();
				for (SysFile file:filesImg){
					String downloadUrl = file.getDownloadUrl();
					String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
					map.put(file.getId(),suffix);
					model.addAttribute("suffixImgMap", map);
				}
			}
		}
		
		model.addAttribute("files",files);
		model.addAttribute("filesImg",filesImg);
		model.addAttribute("balance",constructionBalance);
		
		return "Construction/balanceconstruction_detail";
	}
	
	@RequestMapping(value="/Balance/ExportExcel",method= {RequestMethod.GET},params= {"id"})
	@ResponseBody
	public void DetailBalanceConstruction(HttpServletResponse response,@RequestParam("id")String id) throws IOException {
		ConstructionBalance constructionBalance = constructionBalanceService.GetConstructionBalance(id);

		List<ConstructionBalance> list = new ArrayList<>();
		
		list.add(constructionBalance);
		
		String title = "基建项目结算委托审查审批表";
		
		response.setHeader("content-Type", "application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;filename=" +  java.net.URLEncoder.encode(title,"UTF-8") + ".xls");
		response.setCharacterEncoding("UTF-8");
		Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams(title, title),ConstructionBalance.class, list);

		workbook.write(response.getOutputStream());
	}

	@RequestMapping(value="/Balance/ExportExcel/{fileName}",method= {RequestMethod.GET})
	@ResponseBody
	public void DetailBalanceConstructionToOa(HttpServletResponse response,@PathVariable("fileName")String fileName) throws IOException {

		ConstructionBalance constructionBalance = constructionBalanceService.GetConstructionBalance(fileName);

		List<ConstructionBalance> list = new ArrayList<>();

		list.add(constructionBalance);

		String title = "基建项目结算委托审查审批表";

		response.setHeader("content-Type", "application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;filename=" +  java.net.URLEncoder.encode(title,"UTF-8") + ".xls");
		response.setCharacterEncoding("UTF-8");
		Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams(title, title),ConstructionBalance.class, list);

		workbook.write(response.getOutputStream());
	}


	@SysLogAn("访问：基建管理-工程进度")
	@RequestMapping(value="/Schedule/View",method= {RequestMethod.GET})
	public String ListScheduleConstruction(Model model,@RequestParam(value="identity",required=false)String identity) {
		PageUtil<ConstructionSchedule> pageUtil = new PageUtil<>();
		pageUtil.setPageIndex(1);
		pageUtil.setPageSize(Integer.valueOf(prop.get("PageSize").toString()));
		ConstructionSchedule schedule = new ConstructionSchedule();
		
		if(TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl"))
			identity=null;
		else
			identity="base";
		
		if(identity != null && identity.equals("base")) {
			SysUser user = TokenManager.getToken();
			schedule.setWarehouseId(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseCode());
			/*schedule.setProjectUnit(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort());*/
			session.setAttribute("ident", "base");
		}else {
			schedule.setInvestmentQuota(1);
			session.removeAttribute("ident");
		}
		
		pageUtil.setEntity(schedule);
		
		pageUtil.setResult(constructionScheduleService.ListLimitSchedule(pageUtil));
		model.addAttribute("schedulelist",pageUtil);
		
		return "Construction/scheduleconstruction_view";
	}

	@SysLogAn("访问：基建管理-工程进度(汇总)")
	@RequestMapping(value="/Schedule/View/Collect",method= {RequestMethod.GET})
	public String ListCollectScheduleConstruction(Model model,@RequestParam(value="needreported",required=false)boolean needreported) {
		PageUtil<ConstructionSchedule> pageUtil = new PageUtil<>();
		pageUtil.setPageIndex(1);
		pageUtil.setPageSize(Integer.valueOf(prop.get("PageSize").toString()));
		ConstructionSchedule schedule = new ConstructionSchedule();
		schedule.setCollect(1);
		schedule.setInvestmentQuota(1);
		if(needreported)
			schedule.setReported(1);
		pageUtil.setEntity(schedule);
		
		pageUtil.setResult(constructionScheduleService.ListGrouyByYearMonth(pageUtil));
		
		model.addAttribute("needreported",needreported);
		model.addAttribute("schedulelist",pageUtil);
		return "Construction/schedulecollectconstruction_view";
	}
	
	@RequestMapping(value="/Schedule/View/Collect",method= {RequestMethod.POST})
	@ResponseBody
	public PageUtil ListCollectScheduleConstruction(ConstructionSchedule constructionSchedule,
			@RequestParam("pageindex")int pageindex,@RequestParam("pagesize")int pagesize,
			@RequestParam(value="needreported",required=false)boolean needreported) {
		PageUtil<ConstructionSchedule> pageUtil = new PageUtil<>();
		pageUtil.setPageIndex(pageindex);
		pageUtil.setPageSize(pagesize);
		constructionSchedule.setInvestmentQuota(1);
		constructionSchedule.setCollect(1);
		if(needreported)
			constructionSchedule.setReported(1);
		pageUtil.setEntity(constructionSchedule);
		
		pageUtil.setResult(constructionScheduleService.ListGrouyByYearMonth(pageUtil));
		
		return pageUtil;
	}
	
	@RequestMapping(value="/Schedule/View",method= {RequestMethod.POST})
	@ResponseBody
	public PageUtil ListScheduleConstruction(@RequestParam("pageindex")int pageindex,
			@RequestParam("pagesize")int pagesize) {
		ConstructionSchedule constructionSchedule = new ConstructionSchedule();
		http://localhost:8080/zclproc/Construction/Schedule/View.shtml?yearMonth=&reportTime=
		// &approvedInvestmentSubtotal=&currentInvestmentSubtotal
		// =&accumulateInvestmentSubtotal=&status=&projectUnit=&pageindex=1&pagesize=10
		constructionSchedule.setYearMonth(request.getParameter("yearMonth"));
		constructionSchedule.setReportTime(request.getParameter("reportTime"));
		constructionSchedule.setStatus(request.getParameter("status"));
		constructionSchedule.setProjectUnit(request.getParameter("projectUnit"));
		constructionSchedule.setYearMonth(request.getParameter("yearMonth"));
		String  approvedInvestmentSubtotal=request.getParameter("approvedInvestmentSubtotal");
		String  currentInvestmentSubtotal=request.getParameter("currentInvestmentSubtotal");
		String  accumulateInvestmentSubtotal=request.getParameter("accumulateInvestmentSubtotal");

		if(!approvedInvestmentSubtotal.equals("")){
			constructionSchedule.setApprovedInvestmentSubtotal(Float.valueOf(approvedInvestmentSubtotal));
		}else{
			constructionSchedule.setApprovedInvestmentSubtotal(-1);
		}
		if(!currentInvestmentSubtotal.equals("")){
			constructionSchedule.setCurrentInvestmentSubtotal(Float.valueOf(currentInvestmentSubtotal));
		}
		if(!accumulateInvestmentSubtotal.equals("")){
			constructionSchedule.setAccumulateInvestmentSubtotal(Float.valueOf(accumulateInvestmentSubtotal));
		}

		PageUtil<ConstructionSchedule> pageUtil = new PageUtil<>();
		pageUtil.setPageIndex(pageindex);
		pageUtil.setPageSize(pagesize);
		pageUtil.setEntity(constructionSchedule);
		Object ob=session.getAttribute("ident");
		if(session.getAttribute("ident") != null && session.getAttribute("ident").toString().equals("base")) {
			SysUser user = TokenManager.getToken();
			constructionSchedule.setProjectUnit(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort());
		}else {
			constructionSchedule.setInvestmentQuota(1);
		}

		pageUtil.setResult(constructionScheduleService.ListLimitSchedule(pageUtil));
		
		return pageUtil;
	}
	
	@RequestMapping(value="/Schedule/{enter}",method= {RequestMethod.GET})
	public String AddScheduleConstruction(Model model,@PathVariable("enter")String enter,@RequestParam(value="cid",required=false)String cid) {
		PageUtil<ConstructionProject> pageUtil = new PageUtil<>();
		ConstructionProject project = new ConstructionProject();
		project.setProjectUnit(TokenManager.getToken().getShortName());
		pageUtil.setEntity(project);
		pageUtil.setPageIndex(1);
		pageUtil.setPageSize(Integer.MAX_VALUE);
		
		List<ConstructionProject> projectList = construectionProjectService.ListLimitConstruction(pageUtil);
		
		if(enter.toLowerCase().equals("edit")) {
			ConstructionSchedule schedule = constructionScheduleService.GetConstructionSchedule(cid);
			model.addAttribute("schedule", schedule);
		}else {
			SysUser user = TokenManager.getToken();
			
			ConstructionSchedule schedule = new ConstructionSchedule();
			schedule.setOperator(user.getName());
			//schedule.setProjectUnit(storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort()==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort());
			schedule.setProjectUnit(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort());
			schedule.setWarehouseId(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseCode());
			schedule.setHandleTime(Calendar.getInstance().getTime());
			model.addAttribute("schedule", schedule);
		}
		model.addAttribute("projectList",projectList);
		return "Construction/scheduleconstruction_add";
	}

	@SysLogAn("基建管理-工程进度-新增")
	@RequestMapping(value="/Schedule/Add",method= {RequestMethod.POST})
	@ResponseBody
	public Map AddScheduleConstruction(ConstructionSchedule constructionSchedule,
			@RequestParam(value="detailList",required=false)String detailList) {
		SysUser user = TokenManager.getToken();
		
		constructionSchedule.setOperator(user.getName());
		constructionSchedule.setHandleTime(Calendar.getInstance().getTime());
		
		double approvedInvestmentSubtotal = 0,currentInvestmentSubtotal = 0,accumulateInvestmentSubtotal = 0;
		
		List<ConstructionScheduleDetail> scheduleDetail = JsonUtil.toObject(detailList, ConstructionScheduleDetail.class);
		for(ConstructionScheduleDetail detail : scheduleDetail) {
			detail.setId(UUID.randomUUID().toString().replace("-", ""));
			approvedInvestmentSubtotal += detail.getApprovedInvestment();
			currentInvestmentSubtotal += detail.getCurrentInvestment();
			accumulateInvestmentSubtotal += detail.getAccumulateInvestment();
		}
		constructionSchedule.setScheduleDetail(scheduleDetail);
		constructionSchedule.setApprovedInvestmentSubtotal(approvedInvestmentSubtotal);
		constructionSchedule.setCurrentInvestmentSubtotal(currentInvestmentSubtotal);
		constructionSchedule.setAccumulateInvestmentSubtotal(accumulateInvestmentSubtotal);
		constructionSchedule.setReportTime(new SimpleDateFormat("yyyy年MM月dd日").format(Calendar.getInstance().getTime()));
		
		constructionScheduleService.AddConstructionSchedule(constructionSchedule);
		
		//推送OA
//		String tableInfo =String.format("http://%s:%s%s/", request.getServerName(),request.getServerPort(),request.getContextPath()) + "Construction/Schedule/ExprotExcel.shtml?id="+constructionSchedule.getId();

		//附件
		String  fileCode=this.exprotAnyExcelSchedule(constructionSchedule.getId());

		if(constructionSchedule.getStatus().equals("已汇总")) {
			constructionSchedule.setCollect(1);
			sysLogService.add(request, "基建管理-工程进度-汇总");
		}else if(constructionSchedule.getStatus().equals("审核中")) {
			sysOAService.LaunchedAudit(
					constructionSchedule.getId(), 
					TokenManager.getSysUserId(),
					constructionSchedule.getYearMonth().concat("工程进度"),
					String.format("http://%s:%s%s/", request.getServerName(),request.getServerPort(),request.getContextPath()) + "files/code/" + fileCode,

					new SysProcessMapper("T_CONSTRUCTION_SCHEDULE","STATUS","已通过:驳回"));
			sysLogService.add(request, "基建管理-工程进度-提交");
		}else if("待汇总".equals(constructionSchedule.getStatus())){
			sysLogService.add(request, "基建管理-工程进度-上报");
		}else if("待提交".equals(constructionSchedule.getStatus())){
			sysLogService.add(request, "基建管理-工程进度-修改");
		}else{
			sysLogService.add(request, "基建管理-工程进度-"+constructionSchedule.getStatus());
		}
		
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("success", true);
		return result;
	}
	
	@RequestMapping(value="/Schedule/Edit",method= {RequestMethod.POST})
	@ResponseBody
	public Map EditScheduleConstruction(ConstructionSchedule constructionSchedule,@RequestParam(value="detailList",required=false)String detailList) {
		ConstructionSchedule scheduleBase = constructionScheduleService.GetConstructionSchedule(constructionSchedule.getId());
		try {
			UpdateUtil.UpdateField(constructionSchedule, scheduleBase, new String[] {"id"});
		} catch (IllegalArgumentException | IllegalAccessException e) {
			e.printStackTrace();
		}
		
		double approvedInvestmentSubtotal = 0,currentInvestmentSubtotal = 0,accumulateInvestmentSubtotal = 0;
		
		if(detailList!=null) {
			List<ConstructionScheduleDetail> scheduleDetail = JsonUtil.toObject(detailList, ConstructionScheduleDetail.class);
			for(ConstructionScheduleDetail detail : scheduleDetail) {
				detail.setId(UUID.randomUUID().toString().replace("-", ""));
				approvedInvestmentSubtotal += detail.getApprovedInvestment();
				currentInvestmentSubtotal += detail.getCurrentInvestment();
				accumulateInvestmentSubtotal += detail.getAccumulateInvestment();
			}
			scheduleBase.setScheduleDetail(scheduleDetail);
			scheduleBase.setApprovedInvestmentSubtotal(approvedInvestmentSubtotal);
			scheduleBase.setCurrentInvestmentSubtotal(currentInvestmentSubtotal);
			scheduleBase.setAccumulateInvestmentSubtotal(accumulateInvestmentSubtotal);
		}
		
		//推送OA
		String tableInfo =String.format("http://%s:%s%s/", request.getServerName(),request.getServerPort(),request.getContextPath()) + "Construction/Schedule/ExprotExcel.shtml?id="+scheduleBase.getId();

		//附件
		String  fileCode=this.exprotAnyExcelSchedule(constructionSchedule.getId());
		if(scheduleBase.getStatus().equals("已汇总")) {
			scheduleBase.setCollect(1);
			sysLogService.add(request, "基建管理-工程进度-汇总");
		}else if(scheduleBase.getStatus().equals("审核中")) {
			sysOAService.LaunchedAudit(
					scheduleBase.getId(), 
					TokenManager.getSysUserId(),
					scheduleBase.getYearMonth().concat("工程进度"),
					String.format("http://%s:%s%s/", request.getServerName(),request.getServerPort(),request.getContextPath()) + "files/code/" + fileCode,

					new SysProcessMapper("T_CONSTRUCTION_SCHEDULE","STATUS","已通过:驳回"));
			sysLogService.add(request, "基建管理-工程进度-提交");
		}else if("待汇总".equals(scheduleBase.getStatus())){
            scheduleBase.setReportTime(new SimpleDateFormat("yyyy年MM月dd日").format(Calendar.getInstance().getTime()));
			sysLogService.add(request, "基建管理-工程进度-上报");
		}else if("待提交".equals(scheduleBase.getStatus())){
			sysLogService.add(request, "基建管理-工程进度-修改");
		}else{
			sysLogService.add(request, "基建管理-工程进度-"+scheduleBase.getStatus());
		}

		constructionScheduleService.UpdateConstructionSchedule(scheduleBase);
		
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("success", true);
		return result;
	}

	@SysLogAn("基建管理-工程进度(汇总)-上报")
	@RequestMapping(value="/Schedule/Collect/Edit",method=RequestMethod.POST)
	@ResponseBody
	public Map EditScheduleCollectStatus(ConstructionSchedule constructionSchedule) {
		PageUtil<ConstructionSchedule> pageUtil = new PageUtil<>();
		pageUtil.setPageIndex(1);
		pageUtil.setPageSize(Integer.MAX_VALUE);
		ConstructionSchedule param = new ConstructionSchedule();
		param.setYearMonth(constructionSchedule.getYearMonth());
		param.setCollect(1);
		pageUtil.setEntity(param);
		
		List<ConstructionSchedule> collectData = constructionScheduleService.ListLimitSchedule(pageUtil);
		
		for(ConstructionSchedule item : collectData)
			item.setReported(constructionSchedule.getReported());
		
		constructionScheduleService.UpdateScheduleByArray(collectData);
		
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("success", true);
		return result;
	}
	
	@RequestMapping(value="/Schedule/Detail",method=RequestMethod.GET)
	public String ScheduleConstructionDetail(Model model,@RequestParam("id")String id,@RequestParam(value="collect",required=false)String collect,@RequestParam(value="needreported",required=false)boolean needreported) {
		List<ConstructionSchedule> scheduleList = new ArrayList<>();
		
		if(collect == null) {
			scheduleList.add(constructionScheduleService.GetConstructionSchedule(id));
		}else {
			PageUtil<ConstructionSchedule> pageUtil = new PageUtil<>();
			pageUtil.setPageIndex(1);
			pageUtil.setPageSize(Integer.MAX_VALUE);
			ConstructionSchedule param = new ConstructionSchedule();
			param.setYearMonth(collect);
			param.setCollect(1);
			if(needreported)
				param.setReported(1);
			pageUtil.setEntity(param);
			List<ConstructionSchedule> dataList = constructionScheduleService.ListLimitSchedule(pageUtil);
			List<String> ids = new ArrayList<>();
			for(ConstructionSchedule data : dataList)
				ids.add(data.getId());
			double approvedInvestmentTotal = 0,accumulateInvestmentTotal = 0,currentInvestmentTotal = 0;
			
			if(ids.size()==0){
				ids.add("");
			}
			dataList = constructionScheduleService.ListScheduleByIdArray(ids);
			for(ConstructionSchedule schedule : dataList) {
				approvedInvestmentTotal += schedule.getApprovedInvestmentSubtotal();
				accumulateInvestmentTotal += schedule.getAccumulateInvestmentSubtotal();
				currentInvestmentTotal += schedule.getCurrentInvestmentSubtotal();
				if(scheduleList.contains(schedule)) {
					int index = scheduleList.indexOf(schedule);
					ConstructionSchedule _schedule = scheduleList.get(index);
					_schedule.setApprovedInvestmentSubtotal(_schedule.getApprovedInvestmentSubtotal() + schedule.getApprovedInvestmentSubtotal());
					_schedule.setCurrentInvestmentSubtotal(_schedule.getCurrentInvestmentSubtotal() + schedule.getCurrentInvestmentSubtotal());
					_schedule.setAccumulateInvestmentSubtotal(_schedule.getAccumulateInvestmentSubtotal() + schedule.getAccumulateInvestmentSubtotal());
					_schedule.getScheduleDetail().addAll(schedule.getScheduleDetail());
				}else {
					scheduleList.add(schedule);
				}
			}
			model.addAttribute("approvedInvestmentTotal",approvedInvestmentTotal);
			model.addAttribute("accumulateInvestmentTotal",accumulateInvestmentTotal);
			model.addAttribute("currentInvestmentTotal",currentInvestmentTotal);
			model.addAttribute("collect",true);
			model.addAttribute("needreported",needreported);
		}
		
		model.addAttribute("schedules", scheduleList);
		return "Construction/scheduleconstruction_detail";
	}
	
	@RequestMapping(value="/Schedule/ExprotExcel",method=RequestMethod.GET)
	@ResponseBody
	public void ScheduleConstructionExport(HttpServletResponse response,@RequestParam("id")String id,@RequestParam(value="collect",required=false)String collect,
			@RequestParam(value="needreported",required=false)boolean needreported)throws IOException {
		List<ConstructionSchedule> scheduleList = new ArrayList<>();
		
		if(collect == null) {
			scheduleList.add(constructionScheduleService.GetConstructionSchedule(id));
		}else {
			PageUtil<ConstructionSchedule> pageUtil = new PageUtil<>();
			pageUtil.setPageIndex(1);
			pageUtil.setPageSize(Integer.MAX_VALUE);
			ConstructionSchedule param = new ConstructionSchedule();
			param.setYearMonth(collect);
			param.setCollect(1);
			if(needreported)
				param.setReported(1);
			pageUtil.setEntity(param);
			List<ConstructionSchedule> dataList = constructionScheduleService.ListLimitSchedule(pageUtil);
			List<String> ids = new ArrayList<>();
			for(ConstructionSchedule data : dataList)
				ids.add(data.getId());
			dataList = constructionScheduleService.ListScheduleByIdArray(ids);
			for(ConstructionSchedule schedule : dataList) {
				if(scheduleList.contains(schedule)) {
					int index = scheduleList.indexOf(schedule);
					ConstructionSchedule _schedule = scheduleList.get(index);
					_schedule.setApprovedInvestmentSubtotal(_schedule.getApprovedInvestmentSubtotal() + schedule.getApprovedInvestmentSubtotal());
					_schedule.setCurrentInvestmentSubtotal(_schedule.getCurrentInvestmentSubtotal() + schedule.getCurrentInvestmentSubtotal());
					_schedule.setAccumulateInvestmentSubtotal(_schedule.getAccumulateInvestmentSubtotal() + schedule.getAccumulateInvestmentSubtotal());
					_schedule.getScheduleDetail().addAll(schedule.getScheduleDetail());
				}else {
					scheduleList.add(schedule);
				}
			}
		}
		
		String title = scheduleList.get(0).getYearMonth() + "基建项目完成情况报表";
		
		response.setHeader("content-Type", "application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;filename=" +  java.net.URLEncoder.encode(title,"UTF-8") + ".xls");
		response.setCharacterEncoding("UTF-8");
		Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams(title, title),ConstructionSchedule.class, scheduleList);

		workbook.write(response.getOutputStream());
	}

	@SysLogAn("访问：基建管理-工程拨款")
	@RequestMapping(value="/Funds/View",method= {RequestMethod.GET})
	public String ListFundsConstruction(Model model,@RequestParam(value="identity",required=false)String identity) {
		PageUtil<ConstructionFunds> pageUtil = new PageUtil<>();
		pageUtil.setPageIndex(1);
		pageUtil.setPageSize(Integer.valueOf(prop.get("PageSize").toString()));
		
		if(TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl"))
			identity=null;
		else
			identity="base";
		
		ConstructionFunds info = new ConstructionFunds();
		if(identity!=null&&identity.equals("base")) {
			SysUser user = TokenManager.getToken();
			info.setProjectUnit(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort());
			session.setAttribute("ident", "base");
		}else {
			Map<String,Object> otherParam = new HashMap<>();
			otherParam.put("symbol", ">=");
			otherParam.put("plannedInvestment", 10);
			
//			if(TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")){
//				otherParam.put("status", "已通过");	// 条件有问题   已通过 已完成 已上报
//			}
			
			pageUtil.setOtherPram(otherParam);
			session.removeAttribute("ident"); 
		}
		pageUtil.setEntity(info);
		
		pageUtil.setResult(constructionFundsService.ListLimitFunds(pageUtil));
		model.addAttribute("fundslist",pageUtil);
		
		return "Construction/fundsconstruction_view";
	}
	
	@RequestMapping(value="/Funds/View",method= {RequestMethod.POST})
	@ResponseBody
	public PageUtil ListFundsConstruction(ConstructionFunds constructionFunds,@RequestParam("pageindex")int pageindex,
			@RequestParam("pagesize")int pagesize) {
		PageUtil<ConstructionFunds> pageUtil = new PageUtil<>();
		pageUtil.setPageIndex(pageindex);
		pageUtil.setPageSize(pagesize);
		pageUtil.setEntity(constructionFunds);
		
		if(session.getAttribute("ident")!=null&&session.getAttribute("ident").equals("base")) {
			SysUser user = TokenManager.getToken();
			constructionFunds.setWarehouseId(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseCode());
			/*constructionFunds.setProjectUnit(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort());*/
			session.setAttribute("ident", "base");
		}else {
			Map<String,Object> otherParam = new HashMap<>();
			otherParam.put("symbol", ">=");
			otherParam.put("plannedInvestment", 10);
			
//			if(TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")){
//				otherParam.put("status", "已通过");	// 条件有问题
//			}
			
			pageUtil.setOtherPram(otherParam);
			session.removeAttribute("ident"); 
		}
		pageUtil.setResult(constructionFundsService.ListLimitFunds(pageUtil));
		return pageUtil;
	}
	
	@RequestMapping(value="/Funds/{enter}",method= {RequestMethod.GET})
	public String AddFundsConstruction(Model model,@PathVariable("enter")String enter,@RequestParam(value="cid",required=false)String cid) {
		PageUtil<ConstructionProject> pageUtil = new PageUtil<>();
		ConstructionProject param = new ConstructionProject();
		param.setProjectUnit(TokenManager.getToken().getShortName());
		pageUtil.setEntity(param);
		pageUtil.setPageIndex(1);
		pageUtil.setPageSize(Integer.MAX_VALUE);
		
		List<ConstructionProject> projectList = construectionProjectService.ListLimitConstruction(pageUtil);

		Map<String,Object> alreadyDialedMap = new HashMap<>();
		List<ConstructionFunds> fundsList = constructionFundsService.GetLastInvestment();
		Map<String,ConstructionFunds> fundsMap = new HashMap<>();
		for(ConstructionFunds item : fundsList)
			fundsMap.put(item.getProjectName(), item);
		
		for (ConstructionProject project : projectList)
			alreadyDialedMap.put(project.getProjectName(), fundsMap.get(project.getProjectName())==new ConstructionFunds()?0:fundsMap.get(project.getProjectName()));

		SysUser user = TokenManager.getToken();
		ConstructionFunds defaultFunds = new ConstructionFunds();
		defaultFunds.setOperator(user.getName());
		defaultFunds.setReportDept(user.getDepartment());
		//defaultFunds.setReportUnit(storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort());
		defaultFunds.setReportUnit(storageWarehouseService.getStorageWarehouse(user.getOriginCode()) == null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort());
		defaultFunds.setWarehouseId(storageWarehouseService.getStorageWarehouse(user.getOriginCode()) == null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseCode());
		model.addAttribute("funds", defaultFunds);
		
		if(enter.toLowerCase().equals("edit")) {
			ConstructionFunds funds = constructionFundsService.GetConstructionFunds(cid);
			
		//	funds.setInvestmentTotalLittle(new NumberConverter().convertToDigit(funds.getInvestmentTotal())/10000);
			funds.setInvestmentTotalLittle(funds.getInvestmentTotalLittle());
			model.addAttribute("funds", funds);
		}
		
		
		model.addAttribute("alreadyDialedMap",alreadyDialedMap);
		model.addAttribute("projectList",projectList);
		return "Construction/fundsconstruction_add";
	}

	@SysLogAn("基建管理-工程拨款-新增")
	@RequestMapping(value="/Funds/Add",method= {RequestMethod.POST})
	@ResponseBody
	public Map AddFundsConstruction(ConstructionFunds constructionFunds) {
		Calendar calendar = Calendar.getInstance();
		
		SysUser user = TokenManager.getToken();
		
		constructionFunds.setOperator(user.getName());
		constructionFunds.setReportTime(new SimpleDateFormat("yyyy年MM月dd日").format(calendar.getTime()));
		constructionFunds.setReportDept(user.getDepartment()==null?"":user.getDepartment());
		//constructionFunds.setReportUnit(storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort() == null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort());
		constructionFunds.setReportUnit(storageWarehouseService.getStorageWarehouse(user.getOriginCode()) == null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseShort());
		constructionFunds.setWarehouseId(storageWarehouseService.getStorageWarehouse(user.getOriginCode())==null?"":storageWarehouseService.getStorageWarehouse(user.getOriginCode()).getWarehouseCode());
//		constructionFunds.setThisAppropriation(new NumberConverter().convertToUpper(String.valueOf(((int)(constructionFunds.getThisAppropriationLittle())))));
//		constructionFunds.setInvestmentTotal(new NumberConverter().convertToUpper(String.valueOf(((int)(constructionFunds.getInvestmentTotalLittle())))));
		
		constructionFunds.setThisAppropriation(new NumberToCN().number2CNMontrayUnit(new BigDecimal(constructionFunds.getThisAppropriationLittle() * 10000)).toString());
		
		constructionFunds.setInvestmentTotal(new NumberToCN().number2CNMontrayUnit(new BigDecimal(constructionFunds.getInvestmentTotalLittle() * 10000)).toString());
		constructionFunds.setCreateTime(Calendar.getInstance().getTime());
		
		constructionFundsService.AddConstructionFunds(constructionFunds);
		
		if(constructionFunds.getStatus().equals("审核中")) {
			
			/* 文件导出步骤 */
			List<ConstructionFunds> list = new ArrayList<>();
			list.add(constructionFunds);
			String title = "基建工程拨款";
			Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams(title, title),ConstructionFunds.class, list);
			
			File file = new File(request.getSession().getServletContext().getRealPath("/") + Constant.EXPORT_PATH);
    		if(!file.exists())
    			file.mkdirs();
			
    		String fileCode = UUID.randomUUID().toString().replace("-", "") + ".xls";
			FileOutputStream fos;
			try {
				fos = new FileOutputStream(file.getPath() + "/" + fileCode);
				workbook.write(fos);
        		fos.flush();
        		workbook.close();
        		fos.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			/* 文件导出结束 */
			
			sysOAService.LaunchedAudit(
					constructionFunds.getId(), 
					TokenManager.getSysUserId(),
					constructionFunds.getProjectName().concat("工程拨款"),
					String.format("http://%s:%s%s/", request.getServerName(),request.getServerPort(),request.getContextPath()) + "files/code/" + fileCode,
					new SysProcessMapper("T_CONSTRUCTION_FUNDS","STATUS","已通过:驳回"));
		}
		
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("success", true);
		return result;
	}
	
	@RequestMapping(value="/Funds/Detail",method= {RequestMethod.GET},params="id")
	public String FundsConstructionDetail(Model model,@RequestParam("id")String id) {
		
		model.addAttribute("funds", constructionFundsService.GetConstructionFunds(id));
		return "Construction/fundsconstruction_detail";
	}
	
	@RequestMapping(value="/Funds/Edit",method= {RequestMethod.POST})
	@ResponseBody
	public Map EditFundsConstruction(HttpServletRequest request,ConstructionFunds constructionFunds) {
		ConstructionFunds fundsBase = constructionFundsService.GetConstructionFunds(constructionFunds.getId());
		try {
			UpdateUtil.UpdateField(constructionFunds, fundsBase, new String[] {"id"});
		} catch (IllegalArgumentException | IllegalAccessException e) {
			e.printStackTrace();
		}
		
		fundsBase.setThisAppropriation(new NumberToCN().number2CNMontrayUnit(new BigDecimal(fundsBase.getThisAppropriationLittle() * 10000)).toString());
	
		fundsBase.setInvestmentTotal(new NumberToCN().number2CNMontrayUnit(new BigDecimal(fundsBase.getInvestmentTotalLittle() * 10000)).toString());
		
		//fundsBase.setThisAppropriation(new NumberConverter().convertToUpper(String.valueOf(((double)fundsBase.getThisAppropriationLittle() * 10000))));
		String isEdit=request.getParameter("isEdit");
		if(isEdit==null){
			fundsBase.setThisAppropriationLittle(constructionFunds.getThisAppropriationLittle());
			//fundsBase.setInvestmentTotal(new NumberConverter().convertToUpper(String.valueOf(((double)fundsBase.getInvestmentTotalLittle() * 10000))));
			fundsBase.setInvestmentTotalLittle(constructionFunds.getInvestmentTotalLittle());
		}

		constructionFundsService.UpdateConstructionFunds(fundsBase);
		
		if(fundsBase.getStatus().equals("审核中") || fundsBase.getStatus().equals("上报中")) {
			String status = "";
			if(fundsBase.getStatus().equals("审核中"))
				status = "已通过:驳回";
			else
				status = "已上报:驳回";
			
			/* 文件导出步骤 */
			List<ConstructionFunds> list = new ArrayList<>();
			list.add(fundsBase);
			String title = "基建工程拨款";
			Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams(title, title),ConstructionFunds.class, list);
			
			File file = new File(request.getSession().getServletContext().getRealPath("/") + Constant.EXPORT_PATH);
    		if(!file.exists())
    			file.mkdirs();
			
    		String fileCode = UUID.randomUUID().toString().replace("-", "") + ".xls";
			FileOutputStream fos;
			try {
				fos = new FileOutputStream(file.getPath() + "/" + fileCode);
				workbook.write(fos);
        		fos.flush();
        		workbook.close();
        		fos.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			/* 文件导出结束 */
			
			sysOAService.LaunchedAudit(
					fundsBase.getId(), 
					TokenManager.getSysUserId(),
					fundsBase.getProjectName().concat("工程拨款"),
					String.format("http://%s:%s%s/", request.getServerName(),request.getServerPort(),request.getContextPath()) + "files/code/" + fileCode,
					new SysProcessMapper("T_CONSTRUCTION_FUNDS","STATUS",status));
		}

		if("待提交".equals(fundsBase.getStatus())){
			sysLogService.add(request, "基建管理-工程拨款-修改");
		}else if("审核中".equals(fundsBase.getStatus())){
			sysLogService.add(request, "基建管理-工程拨款-提交");
		}else if("已完成".equals(fundsBase.getStatus())){
			sysLogService.add(request, "基建管理-工程拨款-拨款");
		}else{
			sysLogService.add(request, "基建管理-工程拨款-"+fundsBase.getStatus());
		}
		
		Map<String,Object> result = new HashMap<String, Object>();
		result.put("success", true);
		return result;
	}
	
	@RequestMapping(value="/Funds/ExportExcel")
	@ResponseBody
	public void ExportExcelFunds(HttpServletResponse response,@RequestParam("id")String id) throws IOException {
		List<ConstructionFunds> list = new ArrayList<>();
		
		list.add(constructionFundsService.GetConstructionFunds(id));
		String title = "基建工程拨款";
		
		response.setHeader("content-Type", "application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;filename=" +  java.net.URLEncoder.encode(title,"UTF-8") + ".xls");
		response.setCharacterEncoding("UTF-8");
		Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams(title, title),ConstructionFunds.class, list);

		workbook.write(response.getOutputStream());
	}

	@SysLogAn("访问：基建管理-工程资料")
	@RequestMapping(value="/Info/View",method= {RequestMethod.GET})
	public String ListInfoConstruction(Model model) {
		PageUtil<ConstructionProject> pageUtil = new PageUtil<>();
		pageUtil.setPageIndex(1);
		pageUtil.setPageSize(Integer.valueOf(prop.get("PageSize").toString()));
		ConstructionProject info = new ConstructionProject();
		if(!TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl"))
			info.setProjectUnit(TokenManager.getToken().getShortName());
		pageUtil.setEntity(info);
		
		pageUtil.setResult(construectionProjectService.ListLimitConstruction(pageUtil));
		model.addAttribute("projectlist",pageUtil);
		
		return "Construction/Infoconstruction_view";
	}
	
	@RequestMapping(value="/Info/View",method= {RequestMethod.POST})
	@ResponseBody
	public PageUtil ListInfoConstruction(ConstructionProject constructionProject,@RequestParam("pageindex")int pageindex,
			@RequestParam("pagesize")int pagesize) {
		PageUtil<ConstructionProject> pageUtil = new PageUtil<>();
		pageUtil.setPageIndex(pageindex);
		pageUtil.setPageSize(pagesize);
		if(!TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl"))
			constructionProject.setProjectUnit(TokenManager.getToken().getShortName());
		pageUtil.setEntity(constructionProject);
		
		pageUtil.setResult(construectionProjectService.ListLimitConstruction(pageUtil));
		return pageUtil;
	}
	
	@RequestMapping(value="/Info/ViewFile",method= {RequestMethod.GET},params="id")
	@ResponseBody
	public List<SysFile> InfoConstruction(@RequestParam("id")String id) {
		ConstructionProject project = construectionProjectService.GetConstructionDetail(id);
		
		List<SysFile> fileList = new ArrayList<>();
		if(project.getFileGroupId() != null) 
			fileList.addAll(sysFileService.getFilesByGroupId(project.getFileGroupId()));
		if(project.getImageGroupId() != null)
			fileList.addAll(sysFileService.getFilesByGroupId(project.getImageGroupId()));
		if(project.getDataGroupId() != null)
			fileList.addAll(sysFileService.getFilesByGroupId(project.getDataGroupId()));
		if(project.getOtherFileGroupId() != null)
			fileList.addAll(sysFileService.getFilesByGroupId(project.getOtherFileGroupId()));
		return fileList;
	}

	@SysLogAn("基建管理-工程资料-上传资料")
	@RequestMapping(value="/Info/Upload",method= {RequestMethod.POST})
	@ResponseBody
	public Map InfoConstruction(@RequestParam("id")String id,@RequestParam("file")MultipartFile[] file) {
		ConstructionProject project = construectionProjectService.GetConstructionDetail(id);
		
		List<SysFile> fileList = sysFileService.getFilesByGroupId(project.getOtherFileGroupId());
		List<String> fileIds = new ArrayList<>();
		
		for(SysFile sysFile : fileList)
			fileIds.add(sysFile.getId());
		
		String uuid = sysFileService.uploadFiles(request, project.getOtherFileGroupId(), file, "ConstructionProject", fileIds.toArray(new String[] {}));
		
		project.setOtherFileGroupId(uuid);
		
		construectionProjectService.UpdateConstruction(project);
		
		Map<String,Object> result = new HashMap<>();
		result.put("success", true);
		return result;
	}
	
	@RequestMapping(value="/Delete/{tableName}/{mainId}",method=RequestMethod.POST)
	@ResponseBody
	public Map DeleteConstructionData(@PathVariable("tableName")String tableName,@PathVariable("mainId")String mainId,
			@RequestParam(value="childTable",required=false)String childTable,@RequestParam(value="forignKey",required=false)String forignKey) {
		
		Map<String,String> deleteConf = new HashMap<>();
		deleteConf.put("tableName", TableMapper.get(tableName));
		deleteConf.put("mainId", mainId);
		if(childTable!=null) {
			deleteConf.put("childTable", TableMapper.get(childTable));
			deleteConf.put("forignKey", forignKey);
		}

		if(StringUtils.equals("Project",tableName)){
			if(construectionProjectService.isHashChildProject(mainId)){
				Map<String,Object> map = new HashMap<>();
				map.put("success",false);
				map.put("msg","存在子项目无法删除");
				return map;
			}
		}

		construectionProjectService.DeleteData(deleteConf);
		if("Project".equals(tableName)){
			sysLogService.add(request, "基建管理 新增基建项目-删除");
		}else if("Plan".equals(tableName)){
			sysLogService.add(request, "基建管理-年度计划-删除");
		}else if("Info".equals(tableName)){
			sysLogService.add(request, "基建管理-招投标/项目变更/工程验收-删除");
		}else if("Schedule".equals(tableName)){
			sysLogService.add(request, "基建管理-工程进度-删除");
		}else if("Balance".equals(tableName)){
			sysLogService.add(request, "基建管理-工程结算-删除");
		}else if("Funds".equals(tableName)){
			sysLogService.add(request, "基建管理-工程拨款-删除");
		}

		Map<String,Object> result = new HashMap<String, Object>();
		result.put("success", true);
		return result;
	}

	@RequestMapping(value = "/Acceptance/getConstructionProject",method = RequestMethod.POST)
	@ResponseBody
	public List getConstructionProjectByProjectUnit(@RequestParam String projectUnit) {
		PageUtil<ConstructionProject> pageUtil = new PageUtil<>();

		ConstructionProject project = new ConstructionProject();
		pageUtil.setPageIndex(1);
		pageUtil.setPageSize(Integer.MAX_VALUE);
		project.setProjectUnit(projectUnit);
		pageUtil.setEntity(project);
		List<ConstructionProject> constructionProjectList = construectionProjectService.ListLimitConstruction(pageUtil);
		if(constructionProjectList != null && constructionProjectList.size() > 0)
			return constructionProjectList;
		else
			return Collections.EMPTY_LIST;
	}
}
