package com.dhc.fastersoft.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.entity.system.SysFile;
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
import com.dhc.fastersoft.entity.RotatePayment;
import com.dhc.fastersoft.entity.RotatePaymentDetail;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.service.CustomerInformationService;
import com.dhc.fastersoft.service.RotatePaymentService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysFileService;
import com.dhc.fastersoft.service.system.SysOAService;
import com.dhc.fastersoft.utils.LayPage;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.type.TypeFactory;


/**
 * 轮换计划
 * @author lay
 *
 */
@Controller
@RequestMapping("/rotatePayment")
public class RotatePaymentController extends BaseController{
	private static Logger log = Logger.getLogger(RotatePaymentController.class);
	
	@Autowired
	private RotatePaymentService paymentService;
	@Autowired
	private SysFileService fileService;
	@Autowired
	private SysDictService sysDictService;
	@Autowired
	private CustomerInformationService customService;
	@Autowired
	private SysOAService sysOAService;
	
	@RequestMapping("/add")
	public String add(Model model) {
		RotatePayment payment= new RotatePayment();
		payment.setOperator(TokenManager.getNickname());
		payment.setReportDate(Calendar.getInstance().getTime());
		//付款方式
		List<SysDict> payTypes = sysDictService.getSysDictListByType("付款方式");
		//货款类型
		List<SysDict> proceedTypes = sysDictService.getSysDictListByType("货款类型");
		model.addAttribute("grainType",sysDictService.getSysDictListByType("粮油品种"));
		model.addAttribute("payTypes", payTypes);
		model.addAttribute("proceedTypes", proceedTypes);
		HashMap<String, String> map = new HashMap<>();
		model.addAttribute("customers", customService.listCustomer(map));
		model.addAttribute("model", payment);
		model.addAttribute("isEdit", false);
		return "RotatePayment/rotatepayment_add";
	}
	
	@RequestMapping(value="/edit",params="sid")
	public String edt(Model model,@RequestParam("sid") String sid) {

		RotatePayment payment=paymentService.getPayment(sid);
		//付款方式
		List<SysDict> payTypes = sysDictService.getSysDictListByType("付款方式");
		//货款类型
		List<SysDict> proceedTypes = sysDictService.getSysDictListByType("货款类型");
		model.addAttribute("grainType",sysDictService.getSysDictListByType("粮油品种"));
        SysFile filename = fileService.selectById(payment.getGroupId());
        model.addAttribute("filename",filename== null?null:filename);
		if(filename!=null){
			String downloadUrl = filename.getDownloadUrl();
			String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
			model.addAttribute("suffix", suffix);
		}
		model.addAttribute("payTypes", payTypes);
		model.addAttribute("proceedTypes", proceedTypes);
		HashMap<String, String> map = new HashMap<>();
		model.addAttribute("customers", customService.listCustomer(map));
		model.addAttribute("model", payment);
		model.addAttribute("isEdit", true);
		return "RotatePayment/rotatepayment_add";
	}

	@SysLogAn("访问：轮换业务-商务处理-货款支付审批")
	@RequestMapping("/main")
	public String main(Model model) {
		//付款方式
		List<SysDict> payTypes = sysDictService.getSysDictListByType("付款方式");
		//货款类型
		List<SysDict> proceedTypes = sysDictService.getSysDictListByType("货款类型");
		model.addAttribute("payTypes", payTypes);
		model.addAttribute("proceedTypes", proceedTypes);
		return "RotatePayment/rotatepayment_main";
	}

	
	@RequestMapping(value="/view",params="sid")
	public String RotatePlanDetail(Model model,@RequestParam("sid") String sid) {

		RotatePayment payment=paymentService.getPayment(sid);
		SysFile filename = fileService.selectById(payment.getGroupId());
		model.addAttribute("filename",filename);
		model.addAttribute("model", payment);
		if(filename!=null){
			String downloadUrl = filename.getDownloadUrl();
			String suffix = downloadUrl.substring(downloadUrl.indexOf(".")+1);
			model.addAttribute("suffix", suffix);
		}
		return "RotatePayment/rotatepayment_view";
	}

	
	/**
	 *
	 * @param isedit
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Object  saveOrUpdate(RotatePayment payment,
			@RequestParam(value="detailListStr") String detailListStr,
			@RequestParam(value="isedit") Boolean isedit) throws IOException {
		
		ActionResultModel actionResultModel = new ActionResultModel();
		ObjectMapper mapper = new ObjectMapper();
		List<RotatePaymentDetail> detailList = mapper.readValue(detailListStr,TypeFactory.defaultInstance().constructCollectionType(List.class,RotatePaymentDetail.class));

		payment.setDetailList(detailList);

		if(null == isedit || !isedit) {
			payment.setReporterId(TokenManager.getSysUserId());
			payment.setOperator(TokenManager.getSysUserId());
			paymentService.savePayment(payment);
			sysLogService.add(request, "轮换业务-商务处理-货款支付审批-新增");
		}
		else {
			paymentService.updatePayment(payment);
			sysLogService.add(request, "轮换业务-商务处理-货款支付审批-修改");
		}
		actionResultModel.setSuccess(true);
		
		return actionResultModel;
	}
	/**
	 * 
	 * @param sid
	 * @return
	 */
	@SysLogAn("轮换业务-商务处理-货款支付审批-删除")
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel remove(@RequestParam(value="sid") String sid) {
		ActionResultModel actionResultModel = new ActionResultModel();
		int row=paymentService.removePayment(sid);
		int row2=paymentService.removeDetail(sid);
		if(row>0&&row2>0) {
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
	 * 
	 * @param sid
	 * @return
	 */
	@RequestMapping(value="/removeDetail",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel deleteDetail(String sid) {
		ActionResultModel actionResultModel = new ActionResultModel();
		int row=paymentService.removeDetail(sid);
		if(row>0) {
			actionResultModel.setSuccess(true);
			actionResultModel.setMsg("删除成功");
		}else {
			actionResultModel.setSuccess(false);
			actionResultModel.setMsg("删除失败");
		}
		return actionResultModel;
	}
	/**
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value="/list")
	@ResponseBody
	public LayPage<RotatePayment> list(
			@RequestParam(value="pageIndex") int pageIndex,
			@RequestParam(value="pageSize") int pageSize,
			@RequestParam(value="paySerial",required=false) String paySerial,
			@RequestParam(value="reportDate",required=false) String reportDate,
			@RequestParam(value="clientName",required=false) String clientName,
			@RequestParam(value="depositBank",required=false) String depositBank,
			@RequestParam(value="depositAccount",required=false) String depositAccount,
			@RequestParam(value="payType",required=false) String payType,
			@RequestParam(value="proceedType",required=false)String proceedType,
			@RequestParam(value="status",required=false)String status) throws UnsupportedEncodingException {
		
		HashMap<String, Object> map=new HashMap<>();
		map.put("pageIndex", pageIndex);
		map.put("pageSize", pageSize);
		map.put("paySerial", paySerial);
		map.put("reportDate", reportDate);
		map.put("clientName", clientName);
		map.put("depositBank", depositBank);
		map.put("depositAccount",depositAccount);
		map.put("payType", payType);
		map.put("proceedType", proceedType);
		map.put("status", status);

		int total =paymentService.count(map);
		List<RotatePayment> list=null;
		if(total>0)
			list = paymentService.list(map);
//			String  dep=	TokenManager.getToken().getDepartment();
//		for (RotatePayment rotatePayment:list
//			 ) {
//			rotatePayment.setIsAduit("N");
//			if(rotatePayment.getStatus().contains(dep)){
//				rotatePayment.setIsAduit("Y");
//			}
//		}
		LayPage<RotatePayment> pageUtil=new LayPage<>(list, total);

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
	public ActionResultModel updateStatus(
			@RequestParam(value="id")String id,
			@RequestParam(value="status")String status) {
		HashMap<String, Object> map =new HashMap<>();
		map.put("id", id);
		map.put("status", status);
		paymentService.updateStatus(map);
		if("驳回".equals(status)) {
			RotatePayment payment = paymentService.getPayment(id);
			sysOAService.SendMessage(payment.getReporterId(), "msg", "货款支付审批驳回通知", "货款支付审批已驳回", "");
		}
		if("审核中(业务部经理)".equals(status)){
			sysLogService.add(request, "轮换业务-商务处理-货款支付审批-提交");
		}else if("驳回".equals(status)){
			sysLogService.add(request, "轮换业务-商务处理-货款支付审批-提交");
		}else{
			sysLogService.add(request, "轮换业务-商务处理-货款支付审批-审核通过");
		}
		ActionResultModel actionResultModel = new ActionResultModel();
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}
	
}
