package com.dhc.fastersoft.controller;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.RotateArrive;
import com.dhc.fastersoft.entity.RotateClaim;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.CustomerInformationService;
import com.dhc.fastersoft.service.RotateArriveService;
import com.dhc.fastersoft.service.RotateClaimService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.utils.LayPage;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;



/**
 * 标的物
 * @author lay
 *
 */
@Controller
@RequestMapping("/rotateClaim")
public class RotateClaimController extends BaseController{
	private static Logger log = Logger.getLogger(RotateClaimController.class);
	
	@Autowired
	private RotateArriveService arriveService;
	@Autowired 
	private RotateClaimService claimService;
	@Autowired
	private SysDictService sysDictService;

	@Autowired
	private CustomerInformationService customService;
	
	@RequestMapping("/add")
	public String add(Model model,@RequestParam("id") String id) {
		RotateArrive rotateArrive=arriveService.get(id);
		SysUser user = TokenManager.getToken();
		RotateClaim rotateClaim = new RotateClaim();
		rotateClaim.setClaimMan(user.getName());
		rotateClaim.setClaimDate(new Date());
		rotateClaim.setUserId(user.getId());
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		HashMap<String, String> map = new HashMap<>();
		model.addAttribute("customers", customService.listCustomer(map));
		model.addAttribute("grainTypes", grainTypes);
		model.addAttribute("rotateArrive", rotateArrive);
		model.addAttribute("model", rotateClaim);
		return "RotateClaim/rotateclaim_add";
	}

	@RequestMapping(value="/returnStatus")
	public String returnStatus(Model model,@RequestParam("id") String id){
		RotateArrive rotateArrive=arriveService.get(id);
		rotateArrive.setReturnDate(new Date());
		rotateArrive.setStatus("已退回");
		arriveService.reUpdateStatus(rotateArrive);
		return "RotateClaim/rotateclaim_main";
	}
	

	@SysLogAn("访问：轮换业务-货款管理-货款认领单")
	@RequestMapping("/main")
	public String main(Model model) {

		return "RotateClaim/rotateclaim_main";
	}
	
	@RequestMapping(value="/view",params="sid")
	public String view(Model model,@RequestParam("sid") String sid) {
		model.addAttribute("model", arriveService.get(sid));
		return "RotateClaim/rotateclaim_view";
	}
	
	@RequestMapping(value="/view_claimofarrive")
	public String view2(Model model,@RequestParam("arriveId") String arriveId) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("arriveId", arriveId);
		model.addAttribute("claimsOfArrive", claimService.list(map));
		return "RotateClaim/rotateclaim_view2";
	}
	
	//---接口----
	/**
	 * 新建、编辑
	 * @param isedit
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Object  saveOrUpdate(RotateClaim rotateClaim,
			@RequestParam(value="isedit",required=false) Boolean isedit) throws IOException {
		
		if(null==isedit||!isedit) {
			rotateClaim.setClaimDate(Calendar.getInstance().getTime());
			claimService.save(rotateClaim);
			RotateArrive rotateArrive = arriveService.get(rotateClaim.getArriveId());

			double balance = new BigDecimal(rotateArrive.getBalance())
					.subtract(new BigDecimal(rotateClaim.getClaimAmount()))
					.setScale(2,BigDecimal.ROUND_HALF_UP).doubleValue();
			arriveService.updateBalance(rotateClaim.getArriveId(), balance);
			if(balance == 0)
				arriveService.updateClaimStatus(rotateClaim.getArriveId(), "已完成");
			sysLogService.add(request, "轮换业务-货款管理-货款认领单-新增");
		}	
		else {
			claimService.update(rotateClaim);
			sysLogService.add(request, "轮换业务-货款管理-货款认领单-修改");
		}
		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		
		return actionResultModel;
	}

	/**
	 * 删除
	 * @param
	 * @return
	 */
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel remove(@RequestBody RotateClaim rotateClaim) {
		claimService.remove(rotateClaim.getId());
		String arriveId = rotateClaim.getArriveId();
		RotateArrive rotateArrive = arriveService.get(arriveId);
		double balance = BigDecimal.valueOf(rotateArrive.getBalance())
				.add(new BigDecimal(rotateClaim.getClaimAmount()))
				.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
		arriveService.updateBalance(arriveId, balance);
		if(rotateArrive.getBalance() == 0)
			arriveService.updateClaimStatus(arriveId, "未完成");
		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}


	/**
	 * 分页列表
	 * @param pageIndex
	 * @param pageSize
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value="/listPagination")
	@ResponseBody
	public LayPage<RotateClaim> listPagination(
			@RequestParam(value="pageIndex",required=false) int pageIndex,
			@RequestParam(value="pageSize",required=false) int pageSize,
			@RequestParam(value="arriveId",required=false) String arriveId,
			@RequestParam(value="claimType",required=false) String claimType,
			@RequestParam(value="dealSerial",required=false) String dealSerial) throws UnsupportedEncodingException {
		

		HashMap<String, Object> map=new HashMap<>();
		map.put("pageIndex", pageIndex);
		map.put("pageSize", pageSize);
		map.put("arriveId", arriveId);
		map.put("claimType", claimType);
		map.put("dealSerial", dealSerial);

		
		int total=claimService.count(map);
		List<RotateClaim> list=null;
		if(total>0)
			list = claimService.list(map);
		LayPage<RotateClaim> pageUtil=new LayPage<>(list,total);

		return pageUtil;
}
	/**
	 * 更新状态
	 * @param id
	 * @param status
	 * @return
	 */
	@RequestMapping(value="/updateState")
	@ResponseBody
	public ActionResultModel updateState(
			@RequestParam(value="id",required=false) String id,
			@RequestParam(value="status",required=false) String status) {
		
		arriveService.updateStatus(id, status);
		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}
	/**
	 * 更新认领状态
	 * @param id
	 * @param claimStatus
	 * @return
	 */
	@RequestMapping(value="/updateClaimState")
	@ResponseBody
	public ActionResultModel updateClaimState(
			@RequestParam(value="id",required=false) String id,
			@RequestParam(value="claimStatus",required=false) String claimStatus) {

		arriveService.updateClaimStatus(id, claimStatus);
		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}
	/**
	 * 
	 * @param arriveId
	 * @param pageIndex
	 * @param pageSize
	 * @return
	 */
	@RequestMapping(value="/listClaimOfArrive")
	@ResponseBody
	public LayPage<RotateClaim> listClaimOfArrive(
			@RequestParam(value="arriveId",required=false) String arriveId,
			@RequestParam(value="pageIndex",required=false) int pageIndex,
		    @RequestParam(value="pageSize",required=false) int pageSize){
		HashMap<String, Object> map = new HashMap<>();
		map.put("pageIndex", String.valueOf(pageIndex));
		map.put("pageSize", String.valueOf(pageSize));
		map.put("arriveId", arriveId);
		
		int count = claimService.count(map);
		List<RotateClaim> list=null;
		if(count>0)
			list = claimService.list(map);
		LayPage<RotateClaim> page = new LayPage<>(list, count);
		return page;
	}
	
	@RequestMapping(value="/getTotalAmount")
	@ResponseBody
	public ActionResultModel getTotalAmount(
			@RequestParam(value="claimType") String claimType,
			@RequestParam(value="arriveId",required=false) String arriveId,
		    @RequestParam(value="dealSerial",required=false) String dealSerial){
	
		ActionResultModel actionResultModel = new ActionResultModel();
		HashMap<String, Object> map = new HashMap<>();
		map.put("claimType", claimType);
		map.put("arriveId", arriveId);
		map.put("dealSerial", dealSerial);
		Double totalAmount = claimService.getTotalAmount(map);

		actionResultModel.setData(null!=totalAmount?totalAmount:0);
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}
}
