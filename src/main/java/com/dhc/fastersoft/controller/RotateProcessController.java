package com.dhc.fastersoft.controller;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.*;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysFile;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.*;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysFileService;
import com.dhc.fastersoft.service.system.SysUserService;
import com.dhc.fastersoft.utils.JsonUtil;
import com.dhc.fastersoft.utils.PageUtil;
import com.dhc.fastersoft.utils.UpdateUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.*;

@Controller
@RequestMapping("/RotateProcess")
public class RotateProcessController extends BaseController{
	@Autowired
	private RotateConcluteService concluteService;
	@Autowired
	private RotateProcessService rotateProcessService;
	@Autowired
	private RotateConcluteService rotateConcluteService;
	@Autowired
	private RotatePerformanceService rotatePerformanceService;
	@Autowired
	private SysFileService fileService;
	@Autowired
	private SysDictService sysDictService;

	@Autowired
	private SysUserService sysUserService;

	@Autowired
	private StorageWarehouseService storageWarehouseService;
	@Autowired
	CustomerInformationService customerService;

	
	@Autowired
	private HttpServletRequest httpServletRequest;
	
	Properties prop = new Properties();
	
	{
		try {
			prop.load(this.getClass().getResourceAsStream("/limitPage.properties"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@SysLogAn("访问：轮换业务-商务处理-商务处理记录")
	@RequestMapping(value="/Recording",method=RequestMethod.GET)
	public String RecordingIndex(Model model,@RequestParam("type")String type) {
		PageUtil<RotateProcess> pageUtil = new PageUtil<>();
		pageUtil.setPageIndex(1);
		pageUtil.setPageSize(Integer.valueOf(prop.get("PageSize").toString()));
		
		if("业务部".equals(TokenManager.getToken().getDepartment()))
			type="total";
		else
			type="onlypass";
		
		RotateProcess process = new RotateProcess();
		if(type != null && type.toLowerCase().equals("total")) {
			//查看全部 不做数据处理
		}else if(type != null && type.toLowerCase().equals("onlypass")){
			process.setStatus("已通过");
		}
		pageUtil.setEntity(process);
		List<RotateProcess> list=rotateProcessService.ListLimitProcess(pageUtil);
		//根据买方卖方id设置对应的名称
		if(list.size()>0&& null != list) {
			for (int i = 0; i < list.size(); i++) {
				String buyerId = list.get(i).getBuyerId();
				String sellerId = list.get(i).getSellerId();
				CustomerInformation customerInformation=customerService.getCIById(buyerId);
				StorageWarehouse storageWarehouse = storageWarehouseService.get(buyerId);
				CustomerInformation customerInformation1=customerService.getCIById(sellerId);
				StorageWarehouse storageWarehouse1 = storageWarehouseService.get(sellerId);
				if(null == customerInformation){
					//买方为库点
					if(null !=storageWarehouse) {
						list.get(i).setBuyer(storageWarehouse.getWarehouseShort());
					}
					//卖方为客户表的数据
					if(null != customerInformation1) {
						list.get(i).setSeller(customerInformation1.getClientName());
					}
				}else{
					//买方为客户表的数据
					if(null != customerInformation){
						list.get(i).setBuyer(customerInformation.getClientName());
					}
					//卖方为库点
					if(null != storageWarehouse1){
						list.get(i).setSeller(storageWarehouse1.getWarehouseShort());
					}
				}

			}
		}
		pageUtil.setResult(list);
		
		model.addAttribute("type",type);
		model.addAttribute("processlist", pageUtil);
		return "RotateProcess/recordingrotateprocess_view";
	}
	
	@RequestMapping(value="/{type}/Recording",method=RequestMethod.POST)
	@ResponseBody
	public PageUtil RecordingIndex(RotateProcess rotateProcess,@PathVariable("type")String type,
			@RequestParam("pageindex")int pageindex,@RequestParam("pagesize")int pagesize) {
		PageUtil<RotateProcess> pageUtil = new PageUtil<>();
		pageUtil.setPageIndex(pageindex);
		pageUtil.setPageSize(pagesize);
		pageUtil.setEntity(rotateProcess);
		SysUser str=TokenManager.getToken();
		if(TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")&&TokenManager.getToken().getDepartment().equals("业务部"))
			type="total";
		else
			type="onlypass";
		
		if(type != null && type.toLowerCase().equals("total")) {
			//查看全部 不做数据处理
		}else if(type != null && type.toLowerCase().equals("onlypass")){
			rotateProcess.setStatus("已通过");
		}
		List<RotateProcess> list=rotateProcessService.ListLimitProcess(pageUtil);
		//根据买方卖方id设置对应的名称
		if(list.size()>0&& null != list) {
			for (int i = 0; i < list.size(); i++) {
				String buyerId = list.get(i).getBuyerId();
				String sellerId = list.get(i).getSellerId();
				CustomerInformation customerInformation=customerService.getCIById(buyerId);
				StorageWarehouse storageWarehouse = storageWarehouseService.get(buyerId);
				CustomerInformation customerInformation1=customerService.getCIById(sellerId);
				StorageWarehouse storageWarehouse1 = storageWarehouseService.get(sellerId);
				if(null == customerInformation){
					//买方为库点
					if(null !=storageWarehouse) {
						list.get(i).setBuyer(storageWarehouse.getWarehouseShort());
					}
					//卖方为客户表的数据
					if(null != customerInformation1) {
						list.get(i).setSeller(customerInformation1.getClientName());
					}
				}else{
					//买方为客户表的数据
					if(null != customerInformation){
						list.get(i).setBuyer(customerInformation.getClientName());
					}
					//卖方为库点
					if(null != storageWarehouse1){
						list.get(i).setSeller(storageWarehouse1.getWarehouseShort());
					}
				}

			}
		}
		pageUtil.setResult(list);
		
		return pageUtil;
	}
	
	@RequestMapping(value="/Recording/Detail",method=RequestMethod.POST)
	@ResponseBody
	public RotateProcess RecordingIndex(@RequestParam("id")String id) {
		return rotateProcessService.GetRotateProcess(id);
	}
	
	@RequestMapping(value="/Recording/Add",method=RequestMethod.GET)
	public String AddRecording(Model model,@RequestParam(value="id",required=false)String id) {
		RotateProcess rotateProcess = null;
		if(id != null)
			rotateProcess = rotateProcessService.GetRotateProcess(id);
		else {
			SysUser user = TokenManager.getToken();
			rotateProcess = new RotateProcess();
			rotateProcess.setOperator(user.getName());
			rotateProcess.setHandleTime(Calendar.getInstance().getTime());
		}
		model.addAttribute("recording", rotateProcess);

		List<SysDict> varietyList = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("varietyList",varietyList);
		List<SysDict> processTypes = sysDictService.getSysDictListByType("商务处理类型");
		model.addAttribute("processTypes",processTypes);
		List<String> warehouse = new ArrayList<>();
		for (StorageWarehouse item : storageWarehouseService.limitList()) {
			warehouse.add(item.getWarehouseShort());
		}
		HashMap<String,Object> param = new HashMap<String,Object>();
		/*获取标的物明细*/
//		if(way.equals("In")) {
//			param.put("inviteType", "采购");
//		}else if(way.equals("Out")){
//			param.put("inviteType", "销售");
//		}

//		List<RotateConclute> concluteList = rotateConcluteService.list(param);

		RotateNotice notice = new RotateNotice();
		notice.setCreater(TokenManager.getNickname());
		notice.setCreateTime(Calendar.getInstance().getTime());

		SysUser temp;
		notice.setSender((temp = sysUserService.getUserByPosition("总经理"))==null?"":temp.getName());
		temp = null;
		notice.setAudit((temp = sysUserService.getUserByPosition("仓储部经理"))==null?"":temp.getName());
		if(!TokenManager.getToken().getOriginCode().equals("CBL"))
			model.addAttribute("targetIdentity","warehouse");
		else
			model.addAttribute("targetIdentity","company");

//		model.addAttribute("concluteList",concluteList);
		model.addAttribute("basepoint",warehouse);
		model.addAttribute("notice",notice);
			return "RotateProcess/recordingrotateprocess_add";
	}
	
	@RequestMapping(value="/Recording/Detail",method=RequestMethod.GET)
	public String RecordingDetail(Model model,@RequestParam(value="id")String id) {
		RotateProcess rotateProcess = rotateProcessService.GetRotateProcess(id);
		model.addAttribute("recording", rotateProcess);
		return "RotateProcess/recordingrotateprocess_detail";
	}

	@SysLogAn("轮换业务-商务处理-商务处理记录-新增")
	@RequestMapping(value="/Recording/Add",method=RequestMethod.POST)
	@ResponseBody
	public Map AddRecording(RotateProcess rotateProcess,@RequestParam("detailList")String detailList) {
		rotateProcess.setOperator(TokenManager.getSysUserId());
		List<RotateProcessDetail> list = JsonUtil.toObject(detailList, RotateProcessDetail.class);
		for(RotateProcessDetail detail:list)
			detail.setId(UUID.randomUUID().toString().replace("-", ""));
		rotateProcess.setProcessDetail(list);
		//获取买卖id

//		map.put("")
		String tagId=rotateProcess.getTagId();
		if(!tagId.equals("")){
			RotateConcluteDetail rotateConcluteDetail=concluteService.getRotateConcluteDetailById(tagId);
			String inviteType = rotateConcluteDetail.getInviteType();
			rotateProcess.setSellerId(rotateConcluteDetail.getDeliveryId());
			rotateProcess.setBuyerId(rotateConcluteDetail.getReceiveId());
			//入库
			/*if("招标采购".equals(inviteType)||"订单采购".equals(inviteType)||"进口粮采购".equals(inviteType) ){
				rotateProcess.setSellerId(rotateConcluteDetail.getDeliveryId());
				rotateProcess.setBuyerId(rotateConcluteDetail.getReceiveId());
			}else {
				rotateProcess.setBuyerId(rotateConcluteDetail.getReceiveId());
				rotateProcess.setSellerId(rotateConcluteDetail.getReceiveId());
			}*/
		}

		rotateProcessService.AddRotateProcess(rotateProcess);
		
		Map<String,Object> result = new HashMap<>();
		result.put("success", true);
		return result;
	}

	@SysLogAn("轮换业务-商务处理-商务处理记录-修改状态")
	@RequestMapping(value="/Recording/updateState",method=RequestMethod.POST)
	@ResponseBody
	public Map updateState(HttpServletRequest request) {
		String state=request.getParameter("state");
		String id=request.getParameter("id");
		RotateProcess rotateProcess = new RotateProcess();
		rotateProcess.setId(id);
		rotateProcess.setStatus(state);
		if(state.equals("删除")){
			rotateProcessService.deleteRotateProcess(id);
		}else {
			rotateProcessService.UpdateRotateProcessState(rotateProcess);
		}

		Map<String,Object> result = new HashMap<>();
		result.put("success", true);
		return result;
	}

	
	@RequestMapping(value="/Recording/Edit",method=RequestMethod.POST)
	@ResponseBody
	public Map EditRecording(RotateProcess rotateProcess,@RequestParam(value="detailList",required=false)String detailList) {
		RotateProcess processBase = rotateProcessService.GetRotateProcess(rotateProcess.getId());

		// 不知道哪个天才存的时候用的用户ID  查的时候变成了用户名称	就不会用用户对象进行封装？
		processBase.setOperator(processBase.getOperatorId());

		processBase.setModifier(TokenManager.getToken().getId());
		processBase.setModifyTime(Calendar.getInstance().getTime());
		if(detailList != null) {
			SysUser user = TokenManager.getToken();
			processBase.setModifier(user.getName());
			processBase.setModifyTime(Calendar.getInstance().getTime());
			List<RotateProcessDetail> list = JsonUtil.toObject(detailList, RotateProcessDetail.class);
			for(RotateProcessDetail detail:list)
				detail.setId(UUID.randomUUID().toString().replace("-", ""));
			rotateProcess.setProcessDetail(list);
		}
		
		try {
			UpdateUtil.UpdateField(rotateProcess, processBase, new String[] {"id"});
		} catch (IllegalArgumentException | IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if("审核中".equals(rotateProcess.getStatus())){
			sysLogService.add(request, "轮换业务-商务处理-商务处理记录-提交");
		}else{
			sysLogService.add(request, "轮换业务-商务处理-商务处理记录-修改");
		}
		String tagId=rotateProcess.getTagId();
		if(!tagId.equals("")){
			RotateConcluteDetail rotateConcluteDetail=concluteService.getRotateConcluteDetailById(tagId);
			rotateProcess.setSellerId(rotateConcluteDetail.getDeliveryId());
			rotateProcess.setBuyerId(rotateConcluteDetail.getReceiveId());
			//入库
			/*if(rotateConcluteDetail.getReceiveId()!=null){
				rotateProcess.setSellerId(rotateConcluteDetail.getReceiveId());
				rotateProcess.setBuyerId(rotateConcluteDetail.getWarehouseId());
			}else {
				rotateProcess.setBuyerId(rotateConcluteDetail.getDeliveryId());
				rotateProcess.setSellerId(rotateConcluteDetail.getWarehouseId());
			}*/
		}
		rotateProcessService.UpdateRotateProcess(processBase);
		
		Map<String,Object> result = new HashMap<>();
		result.put("success", true);
		return result;
	}

	@SysLogAn("访问：轮换业务-商务处理-合同履约管理")
	@RequestMapping(value="/Performance",method=RequestMethod.GET)
	public String PerformanceIndex(Model model,@RequestParam("type")String type) {
		PageUtil<RotatePerformance> pageUtil = new PageUtil<>();
		pageUtil.setPageIndex(1);
		pageUtil.setPageSize(Integer.valueOf(prop.get("PageSize").toString()));
		RotatePerformance rotatePerformance = new RotatePerformance();
		rotatePerformance.setType("出库");
		
		if(!TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")){

			//rotatePerformance.setDeliveryPlace(TokenManager.getToken().getShortName());

            StorageWarehouse storageWarehouse = storageWarehouseService.getStorageWarehouse(TokenManager.getToken().getOriginCode());
            rotatePerformance.setWarehouseId(storageWarehouse.getId());
		}
		pageUtil.setEntity(rotatePerformance);
		
		/*if(TokenManager.getToken().getDepartment().equals("业务部"))
			type="total";
		else
			type="onlypass";
		
		if(type != null && type.toLowerCase().equals("total")) {
			//查看全部 不做数据处理
		}else if(type != null && type.toLowerCase().equals("onlypass")){
			rotatePerformance.setStatus("审核通过");
		}*/
		
		
		
		
		
		
		
		pageUtil.setResult(rotatePerformanceService.ListLimitPerformance(pageUtil));
		List<SysDict> varietyList = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("varietyList",varietyList);
		
		model.addAttribute("type",type);
		model.addAttribute("performancelist", pageUtil);
		return "RotateProcess/performancerotateprocess_view";
	}
	
	@RequestMapping(value="/{type}/Performance",method=RequestMethod.POST)
	@ResponseBody
	public PageUtil PerformanceIndex(RotatePerformance rotatePerformance,@PathVariable("type")String type,
			@RequestParam("pageindex")int pageindex,@RequestParam("pagesize")int pagesize) {
		PageUtil<RotatePerformance> pageUtil = new PageUtil<>();
		pageUtil.setPageIndex(pageindex);
		pageUtil.setPageSize(pagesize);
		pageUtil.setEntity(rotatePerformance);
		if(!TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")){
			StorageWarehouse storageWarehouse = storageWarehouseService.getStorageWarehouse(TokenManager.getToken().getOriginCode());
			if("出库".equals(rotatePerformance.getType())){
				//出库时库点是承储单位
				rotatePerformance.setWarehouseId(storageWarehouse.getId());
			}else{
				//入库时库点是接收单位
				rotatePerformance.setDealUnitId(storageWarehouse.getId());
			}
		}
		
/*		if(TokenManager.getToken().getDepartment().equals("仓储部"))
			type="total";
		else
			type="onlypass";
		
		if(type != null && type.toLowerCase().equals("total")) {
			//查看全部 不做数据处理
		}else if(type != null && type.toLowerCase().equals("onlypass")){
			rotatePerformance.setStatus("审核通过");
		}*/
		List<RotatePerformance> list=rotatePerformanceService.ListLimitPerformance(pageUtil);
		pageUtil.setTotalCount(list.size());
		pageUtil.setResult(list);
		return pageUtil;
	}
	
	@RequestMapping(value="/Performance/Add",method=RequestMethod.GET)
	public String AddLunch(Model model,@RequestParam(value="id",required=false)String id) {
		RotatePerformance rotatePerformance = null;
		if(StringUtils.isNotEmpty(id)) {
			rotatePerformance = rotatePerformanceService.GetRotatePerformance(id);
		} 
		else {
			SysUser user = TokenManager.getToken();
			rotatePerformance = new RotatePerformance();
			rotatePerformance.setOperator(user.getName());
			rotatePerformance.setDepartment(user.getDepartment());
			rotatePerformance.setHandleTime(Calendar.getInstance().getTime());
		}
		model.addAttribute("performance",rotatePerformance);

		List<SysDict> varietyList = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("varietyList",varietyList);
		List<String> warehouse = new ArrayList<>();
		for (StorageWarehouse item : storageWarehouseService.listHostWareHouse()) {
			warehouse.add(item.getWarehouseShort());
		}
		HashMap<String,Object> param = new HashMap<String,Object>();
		/*获取标的物明细*/
//		if(way.equals("In")) {
//			param.put("inviteType", "采购");
//		}else if(way.equals("Out")){
//			param.put("inviteType", "销售");
//		}
		
		List<SysFile> files = null;
		if(rotatePerformance.getAnnex() != null) {
			files = fileService.getFilesByGroupId(rotatePerformance.getAnnex());
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


		List<RotateConclute> concluteList = rotateConcluteService.list(param);

		RotateNotice notice = new RotateNotice();
		notice.setCreater(TokenManager.getNickname());
		notice.setCreateTime(Calendar.getInstance().getTime());
		
		String defaultProjectUnit="";
		
		if(TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")){
			defaultProjectUnit = "";
		}else{
			defaultProjectUnit = TokenManager.getToken().getShortName();
		}

		SysUser temp;
		notice.setSender((temp = sysUserService.getUserByPosition("总经理"))==null?"":temp.getName());
		temp = null;
		notice.setAudit((temp = sysUserService.getUserByPosition("仓储部经理"))==null?"":temp.getName());
		if(!TokenManager.getToken().getOriginCode().equals("CBL"))
			model.addAttribute("targetIdentity","warehouse");
		else
			model.addAttribute("targetIdentity","company");

		model.addAttribute("concluteList",concluteList);
		model.addAttribute("basepoint",warehouse);
		model.addAttribute("notice",notice);
		model.addAttribute("files",files);
		model.addAttribute("defaultProjectUnit",defaultProjectUnit);
		


		return "RotateProcess/performancerotateprocess_add";
	}

	@SysLogAn("轮换业务-商务处理-合同履约管理-新增")
	@RequestMapping(value="/Performance/Add",method=RequestMethod.POST)
	@ResponseBody
	public Map AddLunch(RotatePerformance rotatePerformance,@RequestParam(value="file",required=false)MultipartFile[] file) {
		SysUser user = TokenManager.getToken();
		rotatePerformance.setOperator(user.getId());
		rotatePerformance.setDepartment(user.getDepartment());
		
		String fileId = null;
//		if(file != null) {
//			fileId = UUID.randomUUID().toString().replace("-", "");
//			if(!fileService.uploadFile(httpServletRequest, fileId, file, null).equals("上传成功！")) {
//				Map<String,Object> result = new HashMap<>();
//				result.put("msg", "文件上传失败");
//				result.put("success", false);
//				return result;
//			}else
//				rotatePerformance.setAnnex(fileId);
//		}
		
		
		if(file != null && file.length > 0) 
			rotatePerformance.setAnnex(fileService.uploadFiles(request, null, file, "RotateProcess"));


		rotatePerformanceService.AddRotatePerformance(rotatePerformance);
		
		Map<String,Object> result = new HashMap<>();
		result.put("success", true);
		return result;
	}
	
	@RequestMapping(value="/Performance/Edit",method=RequestMethod.POST)
	@ResponseBody
	public Map EditLunch(RotatePerformance rotatePerformance,@RequestParam(value="file",required=false)MultipartFile[] file,@RequestParam(value="fileIds",required=false)String fileIds) {
		//这个查询有什么用？不太明白
		//RotatePerformance performanceBase = rotatePerformanceService.GetRotatePerformance(rotatePerformance.getId());
		
//		try {
//			UpdateUtil.UpdateField(rotatePerformance, performanceBase, new String[] {"id","operator","handleTime","department"});
//		} catch (IllegalArgumentException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (IllegalAccessException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		String fileId = null;
//		if(file != null) {
//			fileId = UUID.randomUUID().toString().replace("-", "");
//			if(!fileService.uploadFile(httpServletRequest, fileId, file, null).equals("上传成功！")) {
//				Map<String,Object> result = new HashMap<>();
//				result.put("msg", "文件上传失败");
//				result.put("success", false);
//				return result;
//			}else
//				performanceBase.setAnnex(fileId);
//		}
		if("待提交".equals(rotatePerformance.getStatus())){
			if((file != null && file.length > 0)||fileIds != null) {
				String [] _fileIds = (JsonUtil.toObject(fileIds, String.class)).toArray(new String[] {});
				rotatePerformance.setAnnex(fileService.uploadFiles(request, rotatePerformance.getAnnex(), file, "RotateProcess",_fileIds));
			}
		}

		rotatePerformanceService.UpdateRotatePerformance(rotatePerformance);
		if("审核通过".equals(rotatePerformance.getStatus())){
			sysLogService.add(request, "轮换业务-商务处理-合同履约管理-通过");
		}else
		if("驳回".equals(rotatePerformance.getStatus())){
			sysLogService.add(request, "轮换业务-商务处理-合同履约管理-驳回");
		}else
		if("审核中".equals(rotatePerformance.getStatus())){
			sysLogService.add(request, "轮换业务-商务处理-合同履约管理-提交");
		}else{
			sysLogService.add(request, "轮换业务-商务处理-合同履约管理-修改");
		}
		
		Map<String,Object> result = new HashMap<>();
		result.put("success", true);
		return result;
	}
	
	@RequestMapping(value="/Performance/Detail",method=RequestMethod.GET)
	public String PerformanceDetail(Model model,@RequestParam("id")String id) {
		RotatePerformance performance = rotatePerformanceService.GetRotatePerformance(id);
//		String filename = null;
//		if(performance.getAnnex()!=null) {
//			filename = fileService.selectById(performance.getAnnex()).getFileName();
//		}
		
		
		model.addAttribute("performance",performance);
		/*model.addAttribute("files",fileService.getFilesByGroupId(performance.getAnnex()));*/

		List<SysFile> files = null;
		if(performance.getAnnex() != null) {
			files = fileService.getFilesByGroupId(performance.getAnnex());
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
		model.addAttribute("files",files);
		return "RotateProcess/performancerotateprocess_detail";
	}
	
	@RequestMapping(value="/GetRotateProcessByDealSerial")
	@ResponseBody
	public ActionResultModel GetRotateProcessByDealSerial(
			@RequestParam("dealSerial")String dealSerial) {

		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		actionResultModel.setData(rotateProcessService.GetRotateProcessDetailByDealSerial(dealSerial));
		return actionResultModel;
	}
}
