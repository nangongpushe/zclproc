package com.dhc.fastersoft.controller;

import java.io.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dhc.fastersoft.common.Constant;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.dao.store.StoreEnterpriseDao;
import com.dhc.fastersoft.entity.*;
import com.dhc.fastersoft.entity.store.StoreEnterprise;
import com.dhc.fastersoft.service.store.StoreEnterpriseService;
import com.dhc.fastersoft.service.system.SysProcessMapperService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
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
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysProcessMapper;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.CustomerInformationService;
import com.dhc.fastersoft.service.RotateFreightAPRVService;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.service.StoreSuperviseService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysOAService;
import com.dhc.fastersoft.utils.DateUtil;
import com.dhc.fastersoft.utils.JsonUtil;
import com.dhc.fastersoft.utils.LayPage;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;


/**
 * 标的物
 * @author lay
 *
 */
@Controller
@RequestMapping("/rotateFreightAPRV")
public class RotateFreightAPRVController extends BaseController{
	private static Logger log = Logger.getLogger(RotateFreightAPRVController.class);
	
	@Autowired
	private RotateFreightAPRVService aprvService;
	@Autowired
	StoreEnterpriseService storeEnterpriseService;
	@Autowired
	private SysDictService sysDictService;
	@Autowired
	private CustomerInformationService customService;
	@Autowired
	private StorageWarehouseService storageWarehouseService;
	@Autowired
	private StoreSuperviseService storeSuperviseService;
	@Autowired
	private SysOAService sysOAService;
	@Autowired
	private SysProcessMapperService sysProcessMapperService;

	
	@RequestMapping("/add")
	public String add(Model model) {
		RotateFreightAPRV aprv= new RotateFreightAPRV();
		aprv.setReportDate(Calendar.getInstance().getTime());
		SysUser user = TokenManager.getToken();
		aprv.setReporter(user.getName());
		String shortName = user.getShortName();
		aprv.setCompany(user.getCompany());

		//运输方式
		List<SysDict> shipTypes = sysDictService.getSysDictListByType("运输方式");
		model.addAttribute("shipTypes", shipTypes);
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("grainTypes", grainTypes);
		
		//所属库的代储企业
		List<StoreSuperviseItem> superviseItems = storeSuperviseService.listStoreSuperviseItems(shortName);


		HashMap<String, String> addressMap = new HashMap<>();
		List<HashMap> reportUnits = new ArrayList<>();

//		reportUnits.add(shortName);
//		List<StorageWarehouse> ware = storageWarehouseService.listWareHouseByCondition(shortName,StorageWarehouseService.WAREHOUSE);
//		if(null!=ware&&ware.size()>0)
//			addressMap.put(shortName, ware.get(0).getProvince()+ware.get(0).getCity()+ware.get(0).getArea());
//		else
//			addressMap.put(shortName, "没有对应的地点信息");

		StorageWarehouse storageWarehouse= storageWarehouseService.getStorageWarehouse(TokenManager.getToken().getOriginCode());
		if(storageWarehouse!=null){
			HashMap map = new HashMap();
			StoreEnterprise storeEnterprise = storeEnterpriseService.getStoreEnterpriseByID(storageWarehouse.getEnterpriseId());
			map.put("shortName",storeEnterprise.getShortName());
			map.put("enterpriseId",storageWarehouse.getEnterpriseId());
			map.put("addressMap",storageWarehouse.getProvince()+storageWarehouse.getCity()+storageWarehouse.getArea()+storageWarehouse.getAddress());
			reportUnits.add(map);

			addressMap.put(shortName, storageWarehouse.getProvince()+storageWarehouse.getCity()+storageWarehouse.getArea()+storageWarehouse.getAddress());
		}
		for(StoreSuperviseItem item:superviseItems) {
			if(!reportUnits.contains(item.getEnterpriseName())) {
//				reportUnits.add(item.getEnterpriseName());
//				enterpriseIds.add(item.getEnterpriseId());
				HashMap map = new HashMap();
				map.put("shortName",item.getEnterpriseName());
				map.put("enterpriseId",item.getEnterpriseId());
				map.put("addressMap",item.getDivision());

				reportUnits.add(map);
				addressMap.put(item.getEnterpriseName(), item.getDivision());
			}

		}

		model.addAttribute("reportUnits", reportUnits);
		model.addAttribute("addressMap", addressMap);


		model.addAttribute("model", aprv);
		model.addAttribute("isEdit", false);
		return "RotateFreightAPRV/rotatefreightaprv_add";
	}
	
	@RequestMapping(value="/edit",params="sid")
	public String update(Model model,@RequestParam("sid") String sid) {
		SysUser user = TokenManager.getToken();
		RotateFreightAPRV aprv=aprvService.getById(sid);
		String shortName = user.getShortName();
		//运输方式
		List<SysDict> shipTypes = sysDictService.getSysDictListByType("运输方式");
		model.addAttribute("shipTypes", shipTypes);
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("grainTypes", grainTypes);

		//所属库的代储企业
		List<StoreSuperviseItem> superviseItems = storeSuperviseService.listStoreSuperviseItems(shortName);
		HashMap<String, String> addressMap = new HashMap<>();
		List<HashMap> reportUnits = new ArrayList<>();

//		reportUnits.add(shortName);
//		List<StorageWarehouse> ware = storageWarehouseService.listWareHouseByCondition(shortName,StorageWarehouseService.WAREHOUSE);
//		if(null!=ware&&ware.size()>0)
//			addressMap.put(shortName, ware.get(0).getProvince()+ware.get(0).getCity()+ware.get(0).getArea());
//		else
//			addressMap.put(shortName, "没有对应的地点信息");

		StorageWarehouse storageWarehouse= storageWarehouseService.getStorageWarehouse(TokenManager.getToken().getOriginCode());
		if(storageWarehouse!=null){
			HashMap map = new HashMap();
			map.put("shortName",shortName);
			map.put("enterpriseId",storageWarehouse.getEnterpriseId());
			map.put("addressMap",storageWarehouse.getProvince()+storageWarehouse.getCity()+storageWarehouse.getArea()+storageWarehouse.getAddress());
			reportUnits.add(map);

			addressMap.put(shortName, storageWarehouse.getProvince()+storageWarehouse.getCity()+storageWarehouse.getArea()+storageWarehouse.getAddress());
		}
		for(StoreSuperviseItem item:superviseItems) {
			if(!reportUnits.contains(item.getEnterpriseName())) {
//				reportUnits.add(item.getEnterpriseName());
//				enterpriseIds.add(item.getEnterpriseId());
				HashMap map = new HashMap();
				map.put("shortName",item.getEnterpriseName());
				map.put("enterpriseId",item.getEnterpriseId());
				map.put("addressMap",item.getDivision());

				reportUnits.add(map);
				addressMap.put(item.getEnterpriseName(), item.getDivision());
			}

		}

		model.addAttribute("reportUnits", reportUnits);

		model.addAttribute("addressMap", addressMap);
		
		model.addAttribute("model", aprv);
		model.addAttribute("isEdit", true);
		return "RotateFreightAPRV/rotatefreightaprv_add";
	}
	
	@SysLogAn("访问：轮换业务-运费管理-运费审批管理")
	@RequestMapping("/main")
	public String main(Model model,@RequestParam(value="type",required=false) String type) {
		SysUser user = TokenManager.getToken();
		if("cbl".equals(TokenManager.getToken().getOriginCode().toLowerCase())) {
			type="company";
		}else {
			type="Base";
		}
		//根据排序查询库点
		List<StorageWarehouse> storageWarehouses = storageWarehouseService.getAllWarehouseOrderBy();
		model.addAttribute("storageWarehouses",storageWarehouses);
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("grainTypes", grainTypes);
		model.addAttribute("type", type);
		return "RotateFreightAPRV/rotatefreightaprv_main";
	}
	
	@RequestMapping(value="/view",params="sid")
	public String view(Model model,@RequestParam("sid") String sid) {
		model.addAttribute("model", aprvService.getById(sid));
		return "RotateFreightAPRV/rotatefreightaprv_view";
	}

	@SysLogAn("访问：轮换业务-运费管理-运费审批汇总")
	@RequestMapping("/gather_main")
	public String gather_main(Model model,
			@RequestParam(value="type",required=false) String type) {
		SysUser user = TokenManager.getToken();
		if(TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")
				&&!"仓储部".equals(user.getDepartment())) {
			type="leader";
		}else {
			type="Base";
		}
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("grainTypes", grainTypes);
		model.addAttribute("type", type);
		return "RotateFreightAPRV/rotatefreightaprv_gather_main";
	}
	
	@RequestMapping(value="/gather_view",params="sid")
	public String gather_view(Model model,@RequestParam(value="sid",required=false) String sid) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("gatherId", sid);

		List<RotateFreightAPRVDetail> detailList = aprvService.listDetailGather(map);
		model.addAttribute("detailList", detailList);
		model.addAttribute("gatherId", sid);
		return "RotateFreightAPRV/rotatefreightaprv_gather_view";
	}
	
	//---接口----
	
	@RequestMapping(value="/exportExcel")
	@ResponseBody
	public void ExportExcel(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value="sid")String sid) throws IOException {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("gatherId", sid);
		List<RotateFreightAPRVDetail> detailList=aprvService.listDetailGather(map);
		String title = "运费审批汇总表";
		
		response.setHeader("content-Type", "application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;filename=" +  java.net.URLEncoder.encode(title,"UTF-8") + ".xls");
		response.setCharacterEncoding("UTF-8");
		Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams(title, title),
				RotateFreightAPRVDetail.class, detailList);

		workbook.write(response.getOutputStream());

	}


	/**
	 *
	 * @param id
	 * @return
	 */
	public String exprotAnyExcelRotateFreightAPRV(String id) {
		SysUser user = TokenManager.getToken();
		String fileCode = null;

//		RotateFreightAPRV  planmain = aprvService.getById(id);
//		if(planmain != null) {
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
			param.append("sid="+id);

			HttpGet get = new HttpGet(host + String.format("rotateFreightAPRV/exportExcel.shtml?%s", param.toString()));
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
//		}
		return fileCode;
	}


	/**
	 * 保存、更新
	 * @param isedit
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Object  saveOrUpdate(RotateFreightAPRV aprv,
			@RequestParam(value="detailListStr",required=false) String detailListStr,
			@RequestParam(value="isedit",required=false) Boolean isedit) throws IOException {
		
		ActionResultModel actionResultModel = new ActionResultModel();
		if(null==detailListStr||"".equals(detailListStr)) {
			actionResultModel.setSuccess(false);
			actionResultModel.setMsg("请填写审批明细");
			return actionResultModel;
		}
		List<RotateFreightAPRVDetail> detailList=JsonUtil.toObject(detailListStr, RotateFreightAPRVDetail.class);
		aprv.setDetailList(detailList);
		if(null == isedit || !isedit) {
			SysUser user = TokenManager.getToken();
			if(StringUtils.isNotEmpty(user.getShortName()))
				aprv.setCompany(user.getShortName());
			else
				aprv.setCompany(user.getCompany());
			aprv.setReporterId(user.getId());
			aprv.setWarehouseId(user.getWareHouseId());
			aprvService.save(aprv);
			sysLogService.add(request, "轮换业务-运费管理-运费审批管理-新增");
		}
		else {
			SysUser user = TokenManager.getToken();
			if(StringUtils.isNotEmpty(user.getShortName()))
				aprv.setCompany(user.getShortName());
			else
				aprv.setCompany(user.getCompany());
			aprv.setReporterId(user.getId());
			aprv.setWarehouseId(user.getWareHouseId());
			aprvService.update(aprv);
			sysLogService.add(request, "轮换业务-运费管理-运费审批管理-修改");
		}
		//OA审核
		if(aprv.getStatus() != null && aprv.getStatus().contains("OA")) {

			sysOAService.LaunchedAudit(
					aprv.getId(), 
					TokenManager.getToken().getId(), 
					String.format("%s%s运费审批", DateUtil.DateToString(aprv.getReportDate(), DateUtil.LONG_DATE_FORMAT),aprv.getReportUnit()),
					null,
					new SysProcessMapper("T_ROTATE_FREIGHT_APRV", "STATUS", "未上报:"));
			sysLogService.add(request, "轮换业务-运费管理-运费审批管理-提交");
		}	
		
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}
	

	/**
	 * 分页
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value="/listPagination")
	@ResponseBody
	public LayPage<RotateFreightAPRV> list(@RequestParam(value="pageIndex",required=false) int pageIndex,
			@RequestParam(value="pageSize",required=false) int pageSize,
			@RequestParam(value="reportUnit",required=false) String reportUnit,
			@RequestParam(value="grainType",required=false) String grainType,
			@RequestParam(value="reportDate",required=false) String reportDate,
			@RequestParam(value="status",required=false) String status,
			@RequestParam(value="company",required=false) String company,
			@RequestParam(value="outUnit",required=false) String outUnit,
			@RequestParam(value="type",required=false) String type) throws UnsupportedEncodingException {
		

		HashMap<String, Object> map = new HashMap<>();
		map.put("pageIndex", pageIndex);
		map.put("pageSize",pageSize);
		map.put("reportUnit", reportUnit);
		map.put("grainType", grainType);
		map.put("reportDate", reportDate);
		map.put("status", status);
		map.put("outUnit", outUnit);
		map.put("company", TokenManager.getToken().getShortName());
		List<String> exceptStatus = null;
		if(null!=type&&"company".equals(type)) {
			map.put("company", null);
			map.put("cblCompany",TokenManager.getToken().getCompany());
			exceptStatus = new ArrayList<>();
			exceptStatus.add("未提交");
			exceptStatus.add("OA审核流程");
			exceptStatus.add("未上报");
		}
		map.put("exceptStatus", exceptStatus);
		int total=aprvService.count(map);
		List<RotateFreightAPRV> list=null;
		if(total>0)
			list = aprvService.list(map);
		
		LayPage<RotateFreightAPRV> pageUtil=new LayPage<>(list,total);

		return pageUtil;
	}
	
	@RequestMapping(value="/updateStatus")
	@ResponseBody
	public Object updateStatus(@RequestParam(value="id") String id,
			@RequestParam(value="status") String status,
			@RequestParam(value="isGather",required=false) String isGather,
			@RequestParam(value="isReport",required=false) String isReport) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("status",status);

		aprvService.updateStatus(map);
		String  fileCode=this.exprotAnyExcelRotateFreightAPRV(id);
		//OA审核
		if(status.contains("OA")) {

			RotateFreightAPRV aprv = aprvService.getById(id);
			sysOAService.LaunchedAudit(
					id,
					TokenManager.getToken().getId(), 
					String.format("%s%s运费审批", DateUtil.DateToString(aprv.getReportDate(), DateUtil.LONG_DATE_FORMAT),aprv.getReportUnit()),
					String.format("http://%s:%s%s/", request.getServerName(),request.getServerPort(),request.getContextPath()) + "files/code/" + fileCode,

					new SysProcessMapper("T_ROTATE_FREIGHT_APRV", "STATUS", "未上报:"));
			sysLogService.add(request, "轮换业务-运费管理-运费审批管理-提交");
		}else if("已驳回".equals(status)) {
			RotateFreightAPRV aprv = aprvService.getById(id);
			sysOAService.SendMessage(aprv.getReporterId(), "msg", "运费审批驳回通知", "运费审批已驳回", "");
			sysLogService.add(request, "轮换业务-运费管理-运费审批管理-驳回");
			HashMap  map1 = new HashMap();
			map1.put("bussinessId",id);
			sysProcessMapperService.delete(map1);
		}else if("待汇总".equals(status)){
			sysLogService.add(request, "轮换业务-运费管理-运费审批管理-上报");
		}
		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}

	@SysLogAn("轮换业务-运费管理-运费审批管理-删除")
	@RequestMapping(value="/remove")
	@ResponseBody
	public Object remove(@RequestParam(value="sid") String sid) {

		aprvService.remove(sid);
		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}

	@SysLogAn("轮换业务-运费管理-运费审批管理-汇总")
	@RequestMapping(value="/updateGather")
	@ResponseBody
	public Object updateGather(@RequestParam(value="id") String id,
			@RequestParam(value="grainType") String grainType) {
		//----获取汇总记录,若没有则新增-----
		//现查找是否存在

		HashMap<String, Object> map = new HashMap<>();
//		map.put("grainType",grainType);
//		map.put("gatherMan",TokenManager.getNickname());
//		map.put("status","未上报");
		map.put("freightAprvId",id);
		RotateFreightAPRVGather gather = aprvService.getGather(map);
		if(null == gather) {
			gather = new RotateFreightAPRVGather();
			gather.setGrainType(grainType);
			gather.setGatherMan(TokenManager.getNickname());
			gather.setGatherTime(Calendar.getInstance().getTime());
			gather.setStatus("未上报");
			gather.setFreightAprvId(id);
			aprvService.saveGather(gather);
			gather = aprvService.getGather(map);
		}else {
			//更新
			map.put("status","未上报");
			aprvService.updateGatherStatus(map);
		}
		//----更新审批状态、汇总id--------
		HashMap<String, Object> map2 = new HashMap<>();
		map2.put("id",id);
		map2.put("gatherId",gather.getId());
		map2.put("status","已汇总");
		aprvService.updateGatherId(map2);
		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}
	
	
	@RequestMapping(value="/listGather")
	@ResponseBody
	public LayPage<RotateFreightAPRVGather> listGather(@RequestParam(value="pageIndex",required=false) int pageIndex,
			@RequestParam(value="pageSize",required=false) int pageSize,
			@RequestParam(value="grainType",required=false) String grainType,
			@RequestParam(value="gatherMan",required=false) String gatherMan,
			@RequestParam(value="gatherTime",required=false) String gatherTime,
			@RequestParam(value="status",required=false) String status,
			@RequestParam(value="type",required=false) String type) throws UnsupportedEncodingException {
		

		HashMap<String, Object> map = new HashMap<>();
		map.put("pageIndex", pageIndex);
		map.put("pageSize",pageSize);
		map.put("grainType", grainType);
		map.put("gatherMan", gatherMan);
		map.put("gatherTime", gatherTime);
		map.put("status", status);
		List<String> exceptStatus = null;
		if(null!=type&&"leader".equals(type)) {
			exceptStatus=new ArrayList<>();
			exceptStatus.add("未上报");
		}
		map.put("exceptStatus", exceptStatus);
		int total=aprvService.countGather(map);
		List<RotateFreightAPRVGather> list=null;
		if(total>0)
			list = aprvService.listGather(map);
		
		LayPage<RotateFreightAPRVGather> pageUtil=new LayPage<>(list,total);

		return pageUtil;
	} 
	
	@RequestMapping(value="/updateGatherStatus")
	@ResponseBody
	public Object updateGatherStatus(
			@RequestParam(value="id") String id,
			@RequestParam(value="status") String status) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("status",status);

		aprvService.updateGatherStatus(map);
		
		//更新审批状态
		HashMap<String, Object> map2 = new HashMap<>();
		map2.put("gatherId", id);
		map2.put("status", status);
		if(status.equals("已驳回")){
			aprvService.updateStatus(map2);
		}



		String  fileCode=this.exprotAnyExcelRotateFreightAPRV(id);
		/* 文件导出结束 */
		//OA汇总审核
		if(status.contains("OA")) {

			sysOAService.LaunchedAudit(
				id, 
				TokenManager.getToken().getId(), 
				"运费汇总审批",
					String.format("http://%s:%s%s/", request.getServerName(),request.getServerPort(),request.getContextPath()) + "files/code/" + fileCode,

					new SysProcessMapper("T_ROTATE_FREIGHT_APRV_GATHER", "STATUS", "待汇总:"));
			sysLogService.add(request, "轮换业务-运费管理-运费审批汇总-上报");
		}else if("已驳回".equals(status)) {
			List<RotateFreightAPRV> list = aprvService.list(map2);
			for(RotateFreightAPRV aprv:list) {
				sysOAService.SendMessage(aprv.getReporterId(), "msg", "运费审批驳回通知", "运费审批已驳回", "");
			}
			HashMap  map1 = new HashMap();
			map1.put("bussinessId",id);
			sysProcessMapperService.delete(map1);
			sysLogService.add(request, "轮换业务-运费管理-运费审批汇总-驳回");
		}
		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}

	@SysLogAn("轮换业务-运费管理-运费审批汇总-删除")
	@RequestMapping(value="/removeGather")
	@ResponseBody
	public Object removeGather(
			@RequestParam(value="id") String id) {
		aprvService.removeGather(id);
		
		//更新审批状态
		HashMap<String, Object> map2 = new HashMap<>();
		map2.put("gatherId", id);
		map2.put("status", "已驳回");
		aprvService.updateStatus(map2);
	
		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}

	/**
	 * 代储运费审批管理
	 */
	@SysLogAn("访问：轮换业务-运费管理-[代储]运费审批管理")
	@RequestMapping("/agent_main")
	public String agentMain(Model model){
		SysUser user = TokenManager.getToken();
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("grainTypes", grainTypes);
		return "RotateFreightAPRV/rotatefreightaprv_agent_main";
	}

	/**
	 * 代储运费审批管理列表
	 */
	@RequestMapping(value = "/agentList")
	@ResponseBody
	public LayPage<RotateFreightAPRV> agentList(@RequestParam(value = "pageIndex", required = false, defaultValue = "1") Integer pageIndex,
												@RequestParam(value = "pageSize", required = false, defaultValue = "10") Integer pageSize,
												@RequestParam(value = "reportUnit", required = false) String reportUnit,
												@RequestParam(value = "grainType", required = false) String grainType,
												@RequestParam(value = "status", required = false) String status,
												@RequestParam(value = "outUnit", required = false) String outUnit) {

		HashMap<String, Object> map = new HashMap<>();
		map.put("reportUnit", reportUnit);
		map.put("grainType", grainType);
		map.put("status", status);
		map.put("outUnit", outUnit);
		map.put("company",TokenManager.getToken().getCompany());
		Page page = PageHelper.startPage(pageIndex,pageSize);
		List list = aprvService.list(map);
		LayPage<RotateFreightAPRV> pageUtil = new LayPage<>(list, (int)page.getTotal());
		return pageUtil;
	}

	@RequestMapping("/agent_add")
	public String agentAdd(Model model) {
		RotateFreightAPRV aprv= new RotateFreightAPRV();
		aprv.setReportDate(Calendar.getInstance().getTime());
		SysUser user = TokenManager.getToken();
		aprv.setReporter(user.getName());
		String shortName = user.getShortName();
		aprv.setCompany(user.getCompany());

		//运输方式
		List<SysDict> shipTypes = sysDictService.getSysDictListByType("运输方式");
		model.addAttribute("shipTypes", shipTypes);
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("grainTypes", grainTypes);

		//所属库的代储企业
		List<StoreSuperviseItem> superviseItems = storeSuperviseService.listStoreSuperviseItems(shortName);


		HashMap<String, String> addressMap = new HashMap<>();
		List<HashMap> reportUnits = new ArrayList<>();

		StorageWarehouse storageWarehouse= storageWarehouseService.getStorageWarehouse(TokenManager.getToken().getOriginCode());
		if(storageWarehouse!=null){
			HashMap map = new HashMap();
			StoreEnterprise storeEnterprise = storeEnterpriseService.getStoreEnterpriseByID(storageWarehouse.getEnterpriseId());
			map.put("shortName",storeEnterprise.getShortName());
			map.put("enterpriseId",storageWarehouse.getEnterpriseId());
			map.put("addressMap",storageWarehouse.getProvince()+storageWarehouse.getCity()+storageWarehouse.getArea()+storageWarehouse.getAddress());
			reportUnits.add(map);

			addressMap.put(shortName, storageWarehouse.getProvince()+storageWarehouse.getCity()+storageWarehouse.getArea()+storageWarehouse.getAddress());
		}
		for(StoreSuperviseItem item:superviseItems) {
			if(!reportUnits.contains(item.getEnterpriseName())) {
				HashMap map = new HashMap();
				map.put("shortName",item.getEnterpriseName());
				map.put("enterpriseId",item.getEnterpriseId());
				map.put("addressMap",item.getDivision());

				reportUnits.add(map);
				addressMap.put(item.getEnterpriseName(), item.getDivision());
			}

		}

		model.addAttribute("reportUnits", reportUnits);
		model.addAttribute("addressMap", addressMap);

		model.addAttribute("model", aprv);
		model.addAttribute("isEdit", false);
		return "RotateFreightAPRV/rotatefreightaprv_agent_add";
	}

	@RequestMapping(value="/updateAgentStatus")
	@ResponseBody
	public ActionResultModel updateAgentStatus(@RequestParam(value="id") String id,
							   @RequestParam(value="status") String status) {

		HashMap<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("status",status);

		aprvService.updateStatus(map);

		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}

	@RequestMapping(value="/agent_edit",params="sid")
	public String edit(Model model,@RequestParam("sid") String sid) {
		SysUser user = TokenManager.getToken();
		RotateFreightAPRV aprv=aprvService.getById(sid);
		String shortName = user.getShortName();
		//运输方式
		List<SysDict> shipTypes = sysDictService.getSysDictListByType("运输方式");
		model.addAttribute("shipTypes", shipTypes);
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("grainTypes", grainTypes);

		//所属库的代储企业
		List<StoreSuperviseItem> superviseItems = storeSuperviseService.listStoreSuperviseItems(shortName);
		HashMap<String, String> addressMap = new HashMap<>();
		List<HashMap> reportUnits = new ArrayList<>();

		StorageWarehouse storageWarehouse= storageWarehouseService.getStorageWarehouse(TokenManager.getToken().getOriginCode());
		if(storageWarehouse!=null){
			HashMap map = new HashMap();
			map.put("shortName",shortName);
			map.put("enterpriseId",storageWarehouse.getEnterpriseId());
			map.put("addressMap",storageWarehouse.getProvince()+storageWarehouse.getCity()+storageWarehouse.getArea()+storageWarehouse.getAddress());
			reportUnits.add(map);

			addressMap.put(shortName, storageWarehouse.getProvince()+storageWarehouse.getCity()+storageWarehouse.getArea()+storageWarehouse.getAddress());
		}
		for(StoreSuperviseItem item:superviseItems) {
			if(!reportUnits.contains(item.getEnterpriseName())) {
//				reportUnits.add(item.getEnterpriseName());
//				enterpriseIds.add(item.getEnterpriseId());
				HashMap map = new HashMap();
				map.put("shortName",item.getEnterpriseName());
				map.put("enterpriseId",item.getEnterpriseId());
				map.put("addressMap",item.getDivision());

				reportUnits.add(map);
				addressMap.put(item.getEnterpriseName(), item.getDivision());
			}

		}

		model.addAttribute("reportUnits", reportUnits);

		model.addAttribute("addressMap", addressMap);

		model.addAttribute("model", aprv);
		model.addAttribute("isEdit", true);
		return "RotateFreightAPRV/rotatefreightaprv_agent_add";
	}
}
