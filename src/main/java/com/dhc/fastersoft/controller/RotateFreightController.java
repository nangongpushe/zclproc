package com.dhc.fastersoft.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;


import com.dhc.fastersoft.common.SysLogAn;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.RotateFreight;
import com.dhc.fastersoft.entity.RotateFreightDetail;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysFile;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.CustomerInformationService;
import com.dhc.fastersoft.service.RotateFreightService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysFileService;
import com.dhc.fastersoft.service.system.SysOAService;
import com.dhc.fastersoft.utils.JsonUtil;
import com.dhc.fastersoft.utils.LayPage;


/**
 * 标的物
 * @author lay
 *
 */
@Controller
@RequestMapping("/rotateFreight")
public class RotateFreightController extends BaseController{
	private static Logger log = Logger.getLogger(RotateFreightController.class);
	
	@Autowired
	private RotateFreightService freightService;

	@Autowired
	private SysDictService sysDictService;
	@Autowired
	private CustomerInformationService customService;
	@Autowired
	private SysOAService sysOAService;
	@Autowired
	private SysFileService sysFileService;

	@Autowired
	private CustomerInformationService customerInformationService;
	
	@RequestMapping("/add")
	public String add(Model model) {
		RotateFreight rotateFreight= new RotateFreight();
		SysUser user = TokenManager.getToken();
		rotateFreight.setOperator(user.getName());
		rotateFreight.setOperatorTime(new Date());
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("grainTypes", grainTypes);
		//运输方式
		List<SysDict> shipTypes = sysDictService.getSysDictListByType("运输方式");
		model.addAttribute("shipTypes", shipTypes);

		// 查询所有客户名称
//		List<String> clientNameList = customerInformationService.clientNameList();
//		model.addAttribute("clientNameList",clientNameList);

		model.addAttribute("model", rotateFreight);
		model.addAttribute("isEdit", false);
		return "RotateFreight/rotatefreight_add";
	}
	
	@RequestMapping(value="/edit",params="sid")
	public String update(Model model,@RequestParam("sid") String sid) {
		RotateFreight rotateFreight=freightService.getById(sid);
		List<RotateFreightDetail> freightDetails = rotateFreight.getFreightDetails();
		for(RotateFreightDetail detail:freightDetails) {
			if(null!=detail.getGroupId()&&!"".equals(detail.getGroupId())) {
				SysFile file = sysFileService.selectById(detail.getGroupId());
				detail.setFileName(file.getFileName());
			}
		}
		//运输方式
		List<SysDict> shipTypes = sysDictService.getSysDictListByType("运输方式");
		SysFile myFile = sysFileService.selectById(rotateFreight.getGroupId());
		model.addAttribute("shipTypes", shipTypes);
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("grainTypes", grainTypes);

		// 查询所有客户名称
//		List<String> clientNameList = customerInformationService.clientNameList();
//		model.addAttribute("clientNameList",clientNameList);

		model.addAttribute("model", rotateFreight);
		model.addAttribute("isEdit", true);
		model.addAttribute("myFile", myFile);
		if(myFile!=null){
			String downloadUrl = myFile.getDownloadUrl();
			String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
			model.addAttribute("suffix", suffix);
		}
		return "RotateFreight/rotatefreight_add";
	}

	@RequestMapping(value="/inviteEdit",params="sid")
	public String inviteEdit(Model model,@RequestParam("sid") String sid) {
		RotateFreight rotateFreight=freightService.getById(sid);
		HashMap<String, String> map = new HashMap<>();
		model.addAttribute("customers", customService.listCustomer(map));
		model.addAttribute("model", rotateFreight);
		return "RotateFreight/rotatefreight_invite_edit";
	}

	@RequestMapping("/main")
	public String main(Model model,@RequestParam(value="view_type",required=false) String viewType) {
		model.addAttribute("view_type", viewType);
		if ("invite".equals(viewType)){
			sysLogService.add(request, "访问：轮换业务-运费管理-运费成交结果");
		}else{
			sysLogService.add(request, "访问：轮换业务-运费管理-运费采购方案");
		}
		return "RotateFreight/rotatefreight_main";
	}
	
	@RequestMapping(value="/view",params="sid")
	public String view(Model model,@RequestParam("sid") String sid,
			@RequestParam(value="view_type",required=false) String viewType) {
		RotateFreight rotateFreight=freightService.getById(sid);
		SysFile myFile = sysFileService.selectById(rotateFreight.getGroupId());
		model.addAttribute("model", rotateFreight);
		model.addAttribute("view_type", viewType);
		model.addAttribute("myFile", myFile);
		HashMap<String, String> map = new HashMap<>();
		model.addAttribute("customers", customService.listCustomer(map));
		if(myFile!=null){
			String downloadUrl = myFile.getDownloadUrl();
			String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
			model.addAttribute("suffix", suffix);
		}
		return "RotateFreight/rotatefreight_view";
	}
	
	//---接口----

	/**
	 * 保存、更新
	 * @param rotateFreight
	 * @param isedit
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Object  saveOrUpdate(RotateFreight rotateFreight,
			@RequestParam(value="freightDetailsStr",required=false) String freightDetailsStr,
			@RequestParam(value="isedit",required=false) Boolean isedit) throws IOException {
		
		ActionResultModel actionResultModel = new ActionResultModel();
		if(null==freightDetailsStr||"".equals(freightDetailsStr)) {
			actionResultModel.setSuccess(false);
			actionResultModel.setMsg("请制定运费明细");
			return actionResultModel;
		}
		List<RotateFreightDetail> freightDetails=JsonUtil.toObject(freightDetailsStr, RotateFreightDetail.class);
		rotateFreight.setFreightDetails(freightDetails);
		if(null == isedit || !isedit) {
			rotateFreight.setReporterId(TokenManager.getSysUserId());
			freightService.saveFreight(rotateFreight);
			sysLogService.add(request, "轮换业务-运费管理-运费采购方案-新增");
		}
		else {
			freightService.updateFreight(rotateFreight);
			sysLogService.add(request, "轮换业务-运费管理-运费采购方案-修改");
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
	public LayPage<RotateFreight> list(@RequestParam(value="pageIndex",required=false) int pageIndex,
			@RequestParam(value="pageSize",required=false) int pageSize,
			@RequestParam(value="freightName",required=false) String freightName,
			@RequestParam(value="inviteTime",required=false) String inviteTime,
			@RequestParam(value="operator",required=false) String operator,
			@RequestParam(value="inviteUnit",required=false) String inviteUnit,
			@RequestParam(value="status",required=false) String status) throws UnsupportedEncodingException {
		

		HashMap<String, Object> map = new HashMap<>();
		map.put("pageIndex", pageIndex);
		map.put("pageSize",pageSize);
		map.put("freightName", freightName);
		map.put("inviteTime", inviteTime);
		map.put("status", status);
		map.put("operator",operator);
		map.put("inviteUnit",inviteUnit);
		int total=freightService.countFreight(map);
		List<RotateFreight> list=null;
		if(total>0)
			list = freightService.listFreight(map);
		
		LayPage<RotateFreight> pageUtil=new LayPage<>(list,total);

		return pageUtil;
	}
	
	@RequestMapping(value="/updateStatus")
	@ResponseBody
	public Object updateStatus(@RequestParam(value="id") String id,
			@RequestParam(value="status") String status) {
		freightService.updateStatus(id, status);
		if("已驳回".equals(status)) {
			RotateFreight freight = freightService.getById(id);
			sysOAService.SendMessage(freight.getReporterId(), "msg", "运费采购方案驳回通知", "运费采购方案已驳回", "");
		}
		if("审核中".equals(status)){
			sysLogService.add(request, "轮换业务-运费管理-运费采购方案-提交");
		}else{
			sysLogService.add(request, "轮换业务-运费管理-运费采购方案-"+status);
		}
		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}
	@SysLogAn("轮换业务-运费管理-运费招标结果录入")
	@RequestMapping(value="/updateClientNameAndPrice")
	@ResponseBody
	public Object updateClientNameAndPrice(@RequestParam(value="freightDetailsStr") String freightDetailsStr) {

		//System.err.println(">>>>"+freightDetailsStr);
		List<RotateFreightDetail> freightDetails=JsonUtil.toObject(freightDetailsStr, RotateFreightDetail.class);

		freightService.updateClientNameAndPrice(freightDetails);
		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}
}
