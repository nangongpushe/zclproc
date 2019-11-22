package com.dhc.fastersoft.controller;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.RotateArrive;
import com.dhc.fastersoft.entity.RotateArriveAudit;
import com.dhc.fastersoft.entity.system.SysFile;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.CustomerInformationService;
import com.dhc.fastersoft.service.RotateArriveService;
import com.dhc.fastersoft.service.system.SysFileService;
import com.dhc.fastersoft.service.system.SysOAService;
import com.dhc.fastersoft.utils.LayPage;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;


/**
 * 标的物
 * @author lay
 *
 */
@Controller
@RequestMapping("/rotateArrive")
public class RotateArriveController extends BaseController{
	private static Logger log = Logger.getLogger(RotateArriveController.class);
	
	@Autowired
	private RotateArriveService arriveService;
	@Autowired
	private SysOAService sysOAService;
	@Autowired
	private SysFileService sysFileService;
	@Autowired
	private CustomerInformationService customService;
	
	
	@RequestMapping("/add")
	public String add(Model model) {
		RotateArrive rotateArrive = new RotateArrive();
		SysUser user = TokenManager.getToken();
		rotateArrive.setReporter(user.getName());
		rotateArrive.setReportDate(new Date());
		rotateArrive.setReportDept(user.getDepartment());
		rotateArrive.setArriveAmount(0.00);
		HashMap<String, String> map = new HashMap<>();
		model.addAttribute("customers", customService.listCustomer(map));
		model.addAttribute("model", rotateArrive);
		model.addAttribute("isEdit", false);
		return "RotateArrive/rotatearrive_add";
	}
	
	@RequestMapping(value="/edit",params="sid")
	public String update(Model model,@RequestParam("sid") String sid) {
		RotateArrive rotateArrive = arriveService.get(sid);
		SysUser user = TokenManager.getToken();
		rotateArrive.setModifier(user.getName());
		rotateArrive.setModifyDate(new Date());
		HashMap<String, String> map = new HashMap<>();
		SysFile filename = sysFileService.selectById(rotateArrive.getGroupId());
		model.addAttribute("filename",filename== null?null:filename);
		model.addAttribute("customers", customService.listCustomer(map));
		model.addAttribute("model", rotateArrive);
		model.addAttribute("isEdit", true);
		if(filename!=null){
			String downloadUrl = filename.getDownloadUrl();
			String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
			model.addAttribute("suffix", suffix);
		}
		return "RotateArrive/rotatearrive_add";
	}

	@SysLogAn("访问：轮换业务-货款管理-货款到账单")
	@RequestMapping("/main")
	public String main(Model model) {

		return "RotateArrive/rotatearrive_main";
	}
	
	@RequestMapping(value="/view",params="sid")
	public String view(Model model,@RequestParam("sid") String sid) {
		RotateArrive rotateArrive = arriveService.get(sid);		
		model.addAttribute("model",rotateArrive);
		SysFile myFile = sysFileService.selectById(rotateArrive.getGroupId());
		model.addAttribute("myFile",myFile);
		if(myFile!=null){
			String downloadUrl = myFile.getDownloadUrl();
			String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
			model.addAttribute("suffix", suffix);
		}
		return "RotateArrive/rotatearrive_view";
	}
	
	@RequestMapping(value="/audit",params="sid")
	public String audit(Model model,@RequestParam("sid") String sid) {
		RotateArrive rotateArrive = arriveService.get(sid);
		/*if("审核中(财务总监)".equals(rotateArrive.getStatus()))*/
		if("审核中(财务经理)".equals(rotateArrive.getStatus())) {
			HashMap<String, Object> map = new HashMap<>();
			map.put("arriveId", sid);
			map.put("auditStep", 1);
			map.put("auditorId", TokenManager.getToken().getId());
			model.addAttribute("audit", arriveService.getAudit(map));
		}	
		model.addAttribute("model",rotateArrive);
		model.addAttribute("myFile",sysFileService.selectById(rotateArrive.getGroupId()));
		return "RotateArrive/rotatearrive_audit";
	}
	
	@RequestMapping(value = "/auditHistory",params="arriveId")
	public String  listAuditHistory(Model model,@RequestParam(value="arriveId") String arriveId) throws IOException {
		HashMap<String, Object> map =new HashMap<>();
		map.put("arriveId", arriveId);
		model.addAttribute("auditList", arriveService.listAudit(map));
		return "RotateArrive/rotatearrive_audit_history";
	}
	
	//---接口----
	/**
	 * 新建、编辑
	 * @param rotateArrive
	 * @param isedit
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Object  saveOrUpdate(RotateArrive rotateArrive,
			@RequestParam(value="isedit",required=false) Boolean isedit){
		SysUser user = TokenManager.getToken();

		if(!isedit) {
			arriveService.save(rotateArrive);
			sysLogService.add(request, "轮换业务-货款管理-货款到账单-新增");
		} else {
			rotateArrive.setModifier(user.getId());
			arriveService.update(rotateArrive);
			sysLogService.add(request, "轮换业务-货款管理-货款到账单-修改");
		}
		if ("审核中(财务经理)".equals(rotateArrive.getStatus())){
			sysLogService.add(request, "轮换业务-货款管理-货款到账单-提交");
		}
		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		
		return actionResultModel;
	}
	

	/**
	 * 删除
	 * @param sid
	 * @return
	 */
	@SysLogAn("轮换业务-货款管理-货款到账单-删除")
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel remove(@RequestParam(value="sid",required=false) String sid) {
		arriveService.remove(sid);
		arriveService.removeAudit(sid);//删除审核记录
		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}


	/**
	 * 分页列表
	 * @param pageIndex
	 * @param pageSize
	 * @param arriveDate
	 * @param status
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value="/listPagination")
	@ResponseBody
	public LayPage<RotateArrive> listPagination(
			@RequestParam(value="pageIndex",required=false) int pageIndex,
			@RequestParam(value="pageSize",required=false) int pageSize,
			@RequestParam(value="arriveDate",required=false) String arriveDate,
			@RequestParam(value="status",required=false) String status,
			@RequestParam(value="claimStatus",required=false) String claimStatus,
			@RequestParam(value="type",required=false) String type,
			@RequestParam(value="payUnit",required=false) String payUnit,
			@RequestParam(value="payer",required = false) String payer,
			@RequestParam(value="beginArriveDate",required = false) String beginArriveDate,
			@RequestParam(value = "endArriveDate",required = false) String endArriveDate,
			@RequestParam(value="minArriveAmount",required=false) Double minArriveAmount,
			@RequestParam(value="maxArriveAmount",required=false) Double maxArriveAmount,
			@RequestParam(value="minBalance",required=false) Double minBalance,
			@RequestParam(value="maxBalance",required=false) Double maxBalance) throws UnsupportedEncodingException {
		
		
		HashMap<String, Object> map=new HashMap<>();
		map.put("pageIndex", pageIndex);
		map.put("pageSize", pageSize);
		map.put("arriveDate", arriveDate);
		map.put("status", status);
		map.put("claimStatus", claimStatus);
		map.put("payUnit", payUnit);
		map.put("beginArriveDate",beginArriveDate);
		map.put("endArriveDate",endArriveDate);
		map.put("minArriveAmount", minArriveAmount);
		map.put("maxArriveAmount", maxArriveAmount);
		map.put("minBalance", minBalance);
		map.put("maxBalance", maxBalance);
		map.put("payer",payer);
		
		//审核通过,指定部门查看
		if(null!=status&&"审核通过".equals(status)) {
			//对数据进行权限上的控制
			if(type!=null && type.toLowerCase().equals("proviceunit")) {
				//可查看所有数据 所以不需要对数据做过滤操作

			}else if(type != null && type.toLowerCase().equals("base")) {
				SysUser user = TokenManager.getToken();
				String department = user.getDepartment();

			}
		}
		
		int total=arriveService.count(map);
		List<RotateArrive> list=null;
		if(total>0)
			list = arriveService.list(map);
		LayPage<RotateArrive> pageUtil=new LayPage<>(list,total);

		return pageUtil;
	}
	/**
	 * 更新状态
	 * @param id
	 * @param status
	 * @return
	 */
	@RequestMapping(value="/updateStatus",method=RequestMethod.POST)
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
	 * 审核
	 * @param audit
	 * @param status
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/saveAudit", method = RequestMethod.POST)
	@ResponseBody
	public Object  saveAudit(RotateArriveAudit audit,
			@RequestParam(value="status") String status) throws IOException {
		
		SysUser user = TokenManager.getToken();
		audit.setAuditorId(user.getId());
		audit.setAuditorName(user.getName());
		audit.setAuditDate(new Date());

		if("已通过".equals(status)){
//			audit.setAuditCompleteDate(new Date());

			audit.setAuditCompleteDate(new Date());
		}
		arriveService.saveAudit(audit);
		arriveService.updateStatus(audit.getArriveId(), status);
		if("已驳回".equals(status)) {
			RotateArrive arrive = arriveService.get(audit.getArriveId());
			sysOAService.SendMessage(arrive.getReporterId(), "msg", "货款到账单驳回通知", "驳回原因:"+audit.getReason(), "");
		}

		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		
		return actionResultModel;
	}
	
}
