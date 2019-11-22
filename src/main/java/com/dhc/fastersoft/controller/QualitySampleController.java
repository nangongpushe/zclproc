package com.dhc.fastersoft.controller;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.*;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.*;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.utils.excel.ExcelImportUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 样品信息类
 * @author dell
 * @date
 */
@RequestMapping("/QualitySample")
@Controller
public class QualitySampleController extends BaseController{

	private static Logger log = Logger.getLogger(CustomerInformationController.class);
	@Autowired
	QualitySampleService service;
	@Autowired
	SysDictService sysService;
	@Autowired
	private RotateConcluteService rotateConcluteService;
	@Autowired
	private QualityTaskService qualityTaskService;
	@Autowired
	private QualityResultService  qualityResultService;
	@Autowired
	StorageWarehouseService storageWarehouseService;
    @Autowired
    private QualitySampleService qualitySampleService;


	/**
	 * 列表页面
	 * 
	 * @param
	 * @return
	 */
	@SysLogAn("访问：质量管理-样品信息")
	@RequestMapping()
	private String list(ModelMap map) {
		// TODO Auto-generated method stub
		SysUser user = TokenManager.getToken();
		List<StorageWarehouse> storageWarehouses = null;
		if(StringUtils.equals(user.getOriginCode().toUpperCase(),"CBL")){
			storageWarehouses= storageWarehouseService.getAllWarehouseOrderBy();
		} else {
			storageWarehouses = Arrays.asList(storageWarehouseService.getWarehouseById(user.getWareHouseId()));
		}

		List<SysDict> validTypes=sysService.getSysDictListByType("质检类型");
		map.addAttribute("validTypes",validTypes);
		List<SysDict> variety=sysService.getSysDictListByType("粮油品种");
		map.addAttribute("variety",variety);
		map.addAttribute("storageWarehouses",storageWarehouses);
		return "QualitySample/list";
	}


	@RequestMapping("/pageQuery")
	@ResponseBody()
	public LayPage<QualitySample> list(HttpServletRequest request,@RequestParam(value="nResult",required=false)boolean nResult) {
		// TODO Auto-generated method stub
		LayPage<QualitySample> list=service.list(request);
		if(nResult && list!=null && list.getData()!=null) {
			List<String> sampleNameList = new ArrayList<>();
			for(QualitySample item : list.getData())
				sampleNameList.add(item.getSampleNo());
			Map<String,QualityResult> result = qualityResultService.queryBySampleNo(sampleNameList);
			if(result != null) {
				for(QualitySample item : list.getData()) {
					if(result.get(item.getSampleNo()) != null) {
						item.setQualityThird(result.get(item.getSampleNo()));
					}
				}
			}
		}
		return list;
	}
	
	/***
	 * 跳转到登记页面
	 * @param
	 * @return
	 */
	@RequestMapping("/addPage")
	public String addPage(ModelMap map){
		List<StorageStoreHouse> storageStoreHouses=service.getStoreEncode();
		map.addAttribute("storageStoreHouses",storageStoreHouses);
		List<SysDict> variety=sysService.getSysDictListByType("粮油品种");
		map.addAttribute("variety",variety);
		List<SysDict> origin=sysService.getSysDictListByType("产地");
		map.addAttribute("origin",origin);
		List<SysDict> validTypes=sysService.getSysDictListByType("质检类型");
		map.addAttribute("validTypes",validTypes);
		List<SysDict> storeType=sysService.getSysDictListByType("粮油存储方式");
		map.addAttribute("storeType",storeType);
		QualitySample qs=new QualitySample();
		qs.setStoreNature("省级储备");
		qs.setStoreType("散装");
		map.put("QualitySample", qs);
		map.put("auvp", "a");
		map.put("isEdit",true);
		SysUser user = TokenManager.getToken();
		if(StringUtils.equals(user.getOriginCode(),"CBL"))
			map.put("isEditSampleSouce",true);

        // 库点列表
        Map<String, String> maps = new HashMap<>();
        if(!user.getOriginCode().toUpperCase().equals("CBL")) {
            //非公司人员只能看到自己的所属库
            maps.put("warehouseCode",user.getOriginCode());
        }

        List<StorageWarehouse> data= storageWarehouseService.limitPageQuery(maps);

        map.put("warehouse",data);
        return "QualitySample/add";
		}
	/**
	 * 添加或修改
	 * 
	 * @param auvp
	 * @param
	 * @return
	 */
	@RequestMapping("/save") 
	@ResponseBody
	public ActionResultModel save(@RequestParam(value = "auvp")String auvp,QualitySample entity){
		ActionResultModel actionResultModel = new ActionResultModel();
		if (auvp.equals("a")) {
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
			String date=df.format(new Date());
			entity.setCreator(TokenManager.getSysUserId());
			entity.setCreateDate(date);
			entity.setCompany(TokenManager.getToken().getShortName());
			entity.setTestStatus("未检");
			service.add(entity);
			sysLogService.add(request, "质量管理-样品信息-新增");
		}else if (auvp.equals("u")) {
			if (entity.getCreator()==""||entity.getCreator()==null) {
				entity.setCreator(TokenManager.getSysUserId());
			}
			if (entity.getCreateDate()==""||entity.getCreateDate()==null) {
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
				String date=df.format(new Date());
				entity.setCreateDate(date);
			}
			if (entity.getCompany()==""||entity.getCompany()==null) {
				entity.setCompany(TokenManager.getToken().getShortName());
			}
			service.update(entity);
			sysLogService.add(request, "质量管理-样品信息-修改");
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
	public String editPage(ModelMap map, String id, String Projectile) {
		QualitySample qs=service.getQSById(id);
		map.put("QualitySample", qs);
		List<StorageStoreHouse> storageStoreHouses=service.getStoreEncode();
		map.addAttribute("storageStoreHouses",storageStoreHouses);
		List<SysDict> variety=sysService.getSysDictListByType("粮油品种");
		map.addAttribute("variety",variety);
		List<SysDict> origin=sysService.getSysDictListByType("产地");
		map.addAttribute("origin",origin);
		List<SysDict> validTypes=sysService.getSysDictListByType("质检类型");
		map.addAttribute("validTypes",validTypes);
		List<SysDict> storeType=sysService.getSysDictListByType("粮油存储方式");
		map.addAttribute("storeType",storeType);		
		//成交(交易)明细
		HashMap<String, Object> searchMap = new HashMap<>();
		searchMap.put("status", "已分发");
		List<RotateConclute> conclutes=rotateConcluteService.listConclute(searchMap);
		map.addAttribute("conclutes",conclutes);
		//判断是否被分配了任务
		boolean hasTask = qualityTaskService.checkBySampleNo(qs.getSampleNo());
		map.put("hasTask", hasTask);
		map.put("auvp", "u");
		map.put("isEdit",true);
		SysUser user = TokenManager.getToken();
		if(StringUtils.equals(user.getOriginCode(),"CBL"))
			map.put("isEditSampleSouce",true);
		//return "QualitySample/add";
		return Projectile.equals("Projectile")?"QualitySample/add_dialog":"QualitySample/add";
	}
	/**
	 * 查看
	 * @param map
	 * @param id
	 * @return
	 */
	@RequestMapping("/detailPage")
	public String detailPage(ModelMap map, String id, String Projectile) {
		QualitySample qs=service.getQSById(id);
		map.put("QualitySample", qs);
		List<StorageStoreHouse> storageStoreHouses=service.getStoreEncode();
		map.addAttribute("storageStoreHouses",storageStoreHouses);
		List<SysDict> variety=sysService.getSysDictListByType("粮油品种");
		map.addAttribute("variety",variety);
		List<SysDict> origin=sysService.getSysDictListByType("产地");
		map.addAttribute("origin",origin);
		List<SysDict> validTypes=sysService.getSysDictListByType("质检类型");
		map.addAttribute("validTypes",validTypes);
		List<SysDict> storeType=sysService.getSysDictListByType("粮油存储方式");
		map.addAttribute("storeType",storeType);
		map.put("auvp", "v");
		map.put("isEdit",false);
		SysUser user = TokenManager.getToken();
		if(StringUtils.equals(user.getOriginCode(),"CBL"))
			map.put("isEditSampleSouce",true);
		//return "QualitySample/add";
		return Projectile.equals("Projectile")?"QualitySample/add_dialog":"QualitySample/add";
	}
	/**
	 * 打印
	 * @param map
	 * @param id
	 * @return
	 */
	@SysLogAn("质量管理-样品信息-打印")
	@RequestMapping("/print")
	public String print(ModelMap map, String id) {
		QualitySample qs=service.getQSById(id);
		map.put("QualitySample", qs);
		List<StorageStoreHouse> storageStoreHouses=service.getStoreEncode();
		map.addAttribute("storageStoreHouses",storageStoreHouses);
		List<SysDict> variety=sysService.getSysDictListByType("粮油品种");
		map.addAttribute("variety",variety);
		List<SysDict> origin=sysService.getSysDictListByType("产地");
		map.addAttribute("origin",origin);
		map.put("auvp", "p");
		return "QualitySample/print";
	}
		// 导入excel方法
		@RequestMapping(value="/importExcel",produces="text/html;charset=UTF-8")
		public String importExcel(@RequestParam(value="file",required=true) MultipartFile file,HttpServletRequest request){
			try {
				Workbook wb = WorkbookFactory.create(file.getInputStream());
				Sheet sheet = wb.getSheetAt(0);
				List<QualitySample> list=ExcelImportUtils.parseSheet(QualitySample.class, QualitySampleVerifyBuilder.getInstance(), sheet, 1);
				service.importExcel(list);
				request.setAttribute("message", "成功导入"+list.size()+"条");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				request.setAttribute("message", e.getMessage().split("\r\n"));
				e.printStackTrace();
			}
			request.setAttribute("path", "/list.shtml");
			return "common/uploadfileMessage";
		}
		// 导出excel方法
	@SysLogAn("质量管理-样品信息-导出")
		@RequestMapping("/exportExcel")
		public String export(HttpServletRequest request, HttpServletResponse response) {
			List<QualitySample> list = new ArrayList<QualitySample>();
			try {
				list=service.list(request).getData();
			} catch (Exception e) {
				e.printStackTrace();
			}
			String fileName = "样品信息.xls";
			try {
				fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
			request.setAttribute("exportList", list);
			return "/QualitySample/export";
		}
		/**
		 * 删除
		 * @param id
		 * @return
		 */
		@SysLogAn("质量管理-样品信息-删除")
		@RequestMapping(value="/remove",method=RequestMethod.POST)
		@ResponseBody
		public ActionResultModel delete(String id) {
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

	/**
	 * 删除
	 * @param id
	 * @return
	 */
	@SysLogAn("质量管理-样品信息-销毁")
	@RequestMapping("destroy")
	@ResponseBody
	public ActionResultModel destroy(String id) {
		ActionResultModel actionResultModel = new ActionResultModel();
		QualitySample  qualitySample=service.getQSById(id);
		qualitySample.setTestStatus("销毁");
		service.update(qualitySample);

		actionResultModel.setSuccess(true);
        actionResultModel.setMsg("销毁成功");
		return actionResultModel;
	}

		@RequestMapping("/check")
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


    @RequestMapping("/findErlySample")
    @ResponseBody()
    private QualitySample findErlySample(HttpServletRequest request) {
        Map<String,Object> paramSample = new HashMap<>();
        String dealSerial = request.getParameter("dealSerial");
        paramSample.put("dealSerial", dealSerial);
        paramSample.put("sort", "ASC");
        QualitySample qualitySample = qualitySampleService.getSampleInfo(paramSample);

        return qualitySample;
    }
}
