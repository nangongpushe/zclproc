package com.dhc.fastersoft.controller;

import cn.afterturn.easypoi.excel.ExcelImportUtil;
import cn.afterturn.easypoi.excel.entity.ImportParams;
import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.*;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.CustomerInformationService;
import com.dhc.fastersoft.service.RotateBIDService;
import com.dhc.fastersoft.service.RotateConcluteService;
import com.dhc.fastersoft.service.RotateInviteService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.utils.JsonUtil;
import com.dhc.fastersoft.utils.LayPage;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.*;


/**
 * 标的物
 * @author lay
 *
 */
@Controller
@RequestMapping("/rotateInvite")
public class RotateInviteController extends BaseController{
	private static Logger log = Logger.getLogger(RotateInviteController.class);
	
	@Autowired
	private RotateInviteService inviteService;
	@Autowired
	private RotateConcluteService concluteService;
	@Autowired
	private RotateBIDService bidService;
	@Autowired
	private SysDictService sysDictService;
	@Autowired
	private CustomerInformationService customerInformationService;


	@RequestMapping("/add")
	public String add(Model model) {
		RotateInvite rotateInvite= new RotateInvite();
		SysUser user = TokenManager.getToken();
		rotateInvite.setOperator(user.getName());
		rotateInvite.setDepartment(user.getDepartment());
		rotateInvite.setHandleTime(new Date());
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("grainTypes", grainTypes);
		model.addAttribute("model", rotateInvite);
		model.addAttribute("isEdit", false);
		return "RotateInvite/rotateinvite_add";
	}

	@RequestMapping(value="/edit",params="sid")
	public String update(Model model,@RequestParam("sid") String sid) {
		RotateInvite rotateInvite=inviteService.get(sid);
		RotateBID rotateBID = bidService.get(rotateInvite.getBidId());
		//粮油品种
		List<SysDict> grainTypes = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("grainTypes", grainTypes);
		model.addAttribute("model", rotateInvite);
		model.addAttribute("inviteDetail", inviteService.listDetail(sid));
		model.addAttribute("currentBid", rotateBID);
		model.addAttribute("isEdit", true);
		return "RotateInvite/rotateinvite_add";
	}

	@SysLogAn("访问：轮换业务-竞标管理-招标结果管理")
	@RequestMapping("/main")
	public String main(Model model) {
		return "RotateInvite/rotateinvite_main";
	}
	
	@RequestMapping(value="/view",params="sid")
	public String view(Model model,@RequestParam("sid") String sid) {
		model.addAttribute("model", inviteService.get(sid));
		return "RotateInvite/rotateinvite_view";
	}
	
	//---接口----
	/**
	 * import excel
	 * @param file
	 * @return
	 * @throws IOException
	 * @throws Exception
	 */
	@RequestMapping(value = "/importExcel",method=RequestMethod.POST)
	@ResponseBody
	public Object importExcel(RotateInvite rotateInvite,@RequestParam(value="file") MultipartFile file) throws IOException, Exception {
		String bidSerial;
		ActionResultModel actionResultModel = new ActionResultModel();
		ImportParams params = new ImportParams();
		params.setHeadRows(2);
		List<RotateInvite> rotateInvitelist = ExcelImportUtil.importExcel(file.getInputStream(), RotateInvite.class, params);
		// 查询所有客户名称
		List<String> clientNameList = customerInformationService.clientNameList();

		//	判断数据是否为空 为空删除
		for(RotateInvite  ri:rotateInvitelist){
			int len = ri.getInviteDetails().size();
			for(int i = 0; i < len; i++){
				RotateInviteDetail rotateInviteDetail = ri.getInviteDetails().get(i);
				if(rotateInviteDetail.getBail() == null && rotateInviteDetail.getBidPrice() == null
						&& rotateInviteDetail.getBidSerial() == null && rotateInviteDetail.getCompetitivePrice() == null
						&& rotateInviteDetail.getCompetitiveUnit() == null && rotateInviteDetail.getInviteID() == null
						&& rotateInviteDetail.getNum() == null && rotateInviteDetail.getStartingPrice() == null){
					ri.getInviteDetails().remove(i);
					i--;
					len--;
					continue;
				}
				// 如果公司在表中不存在 并且 信息不存在
				if((!clientNameList.contains(rotateInviteDetail.getCompetitiveUnit())) && StringUtils.isEmpty(actionResultModel.getMsg())){
					actionResultModel.setMsg("部分竞得单位未存在在客户信息中");
				}
			}

		}
		actionResultModel.setData(rotateInvitelist);
		actionResultModel.setSuccess(true);


		return actionResultModel;
	} 
	/**
	 * 保存、更新
	 * @param rotateInvite
	 * @param isedit
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Object  saveOrUpdate(RotateInvite rotateInvite,
			@RequestParam(value="invitedetail",required=false) String invitedetail,
			@RequestParam(value="isedit",required=false) Boolean isedit,
			@RequestParam(value="reimport",required=false) Boolean reimport,
			@RequestParam(value="isgather",required=false) String isGather) {
		SysUser user = TokenManager.getToken();
		ActionResultModel actionResultModel = new ActionResultModel();


		List<RotateInviteDetail> inviteDetail=JsonUtil.toObject(invitedetail, RotateInviteDetail.class);
		for(RotateInviteDetail inviteDetailItem : inviteDetail){
			String inviteDetailId = UUID.randomUUID().toString().replaceAll("-", "");
			inviteDetailItem.setId(inviteDetailId);
			if(StringUtils.isNotEmpty(inviteDetailItem.getCompetitiveUnit()))
				inviteDetailItem.setCompetitiveUnitId(
						customerInformationService.getClientIdByName(inviteDetailItem.getCompetitiveUnit()));
		}

		rotateInvite.setInviteDetails(inviteDetail);

		if(null == isedit || !isedit) {

			rotateInvite.setHandleTime(new Date());
			rotateInvite.setIsGather(isGather);
			rotateInvite.setOperator(user.getId());
			
			
			double totalNum = Double.valueOf(rotateInvite.getTotalNum());//数量合计
			
			double listTotalNum=0.00;

			double totalCompetitivePrice = Double.valueOf(rotateInvite.getTotalCompetitivePrice());//竞得价合计
			
			double listTotalCompetitivePrice = 0.00;
			
			double totalBidPrice = Double.valueOf(rotateInvite.getTotalBidPrice());//标的物总价合计
			
			double listTotalBidPrice = 0.00;
			
			double totalBail = Double.valueOf(rotateInvite.getTotalBail());//保证金合计
			
			double listTotalBail = 0.00;
			
			int listSize = rotateInvite.getInviteDetails().size();
			
			
			for(int i=0;i<listSize;i++){
				listTotalNum += Double.valueOf(rotateInvite.getInviteDetails().get(i).getNum());
//				listTotalCompetitivePrice += Double.valueOf(rotateInvite.getInviteDetails().get(i).getCompetitivePrice());
				listTotalBidPrice += Double.valueOf(rotateInvite.getInviteDetails().get(i).getBidPrice());
				listTotalBail += Double.valueOf(rotateInvite.getInviteDetails().get(i).getBail());
			}

			if(listTotalNum!=0)
				listTotalCompetitivePrice = listTotalBidPrice/listTotalNum;
			
			 BigDecimal bd1 = new BigDecimal(totalNum); 
			 totalNum = bd1.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();

			 BigDecimal bd2 = new BigDecimal(listTotalNum); 
			 listTotalNum = bd2.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			 
			 BigDecimal bd3 = new BigDecimal(totalCompetitivePrice); 
			 totalCompetitivePrice = bd3.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			 
			 BigDecimal bd4 = new BigDecimal(listTotalCompetitivePrice); 
			 listTotalCompetitivePrice = bd4.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			 
			 BigDecimal bd5 = new BigDecimal(totalBidPrice); 
			 totalBidPrice = bd5.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			 
			 BigDecimal bd6 = new BigDecimal(listTotalBidPrice); 
			 listTotalBidPrice = bd6.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			 
			 BigDecimal bd7 = new BigDecimal(totalBail); 
			 totalBail = bd7.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			 
			 BigDecimal bd8 = new BigDecimal(listTotalBail); 
			 listTotalBail = bd8.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();

			
			if(totalNum!=listTotalNum){
				actionResultModel.setMsg("ERROR:数量合计与清单数量汇总不一致!");
				actionResultModel.setSuccess(false);
				return actionResultModel;
			}
			
			if(totalCompetitivePrice!=listTotalCompetitivePrice){
				actionResultModel.setMsg("ERROR:竞得价合计与清单竞得价汇总不一致!");
				actionResultModel.setSuccess(false);
				return actionResultModel;
			}
			
			if(totalBidPrice!=listTotalBidPrice){
				actionResultModel.setMsg("ERROR:标的物总价与清单标的物总价汇总不一致!");
				actionResultModel.setSuccess(false);
				return actionResultModel;
			}
			
			if(totalBail!=listTotalBail){
				actionResultModel.setMsg("ERROR:占用保证金合计与清单占用保证金汇总不一致!");
				actionResultModel.setSuccess(false);
				return actionResultModel;
			}

			List<RotateConcluteDetail> concluteDetails= new ArrayList<>();
			List<RotateInviteDetail> inviteDetails=rotateInvite.getInviteDetails();
			String inviteType=rotateInvite.getInviteType();
			HashMap<String, String> conditionMap=new HashMap<>();
			conditionMap.put("bidID", rotateInvite.getBidId());

			for(RotateInviteDetail inviteDetail1:inviteDetails) {
				conditionMap.put("bidSerial", inviteDetail1.getBidSerial());
				if(null!=inviteType&&"招标采购".equals(inviteType)) {
					RotateBIDPurchase bidDetail = bidService.getSinglePurchase(conditionMap);
					if(null!=bidDetail){
						inviteDetail1.setLoanPaymentEndDate(bidDetail.getLoanPaymentEndDate());
					}
				}
			}
			rotateInvite.setInviteDetails(inviteDetails);
			String id = inviteService.save(rotateInvite);

			/*List<RotateConcluteDetail> concluteDetails= new ArrayList<>();
			List<RotateInviteDetail> inviteDetails=inviteService.listDetail(rotateInvite.getId());
			String inviteType=rotateInvite.getInviteType();
			HashMap<String, String> conditionMap=new HashMap<>();
			conditionMap.put("bidID", rotateInvite.getBidId());*/

			int count = 1;
			for(RotateInviteDetail inviteDetail1:inviteDetails) {
				conditionMap.put("bidSerial", inviteDetail1.getBidSerial());
				if(null!=inviteType&&"招标采购".equals(inviteType)) {
					RotateBIDPurchase bidDetail = bidService.getSinglePurchase(conditionMap);
					if(null==bidDetail){
						// TODO: handle exception
						inviteService.remove(id);
						inviteService.removeDetail(id);
						actionResultModel.setMsg("ERROR:没有此标号");
						actionResultModel.setSuccess(false);
						return actionResultModel;
					}
//
				}else {
					RotateBIDSale bidDetail = bidService.getSingleSale(conditionMap);
					if(null==bidDetail){
						// TODO: handle exception
						inviteService.remove(id);
						inviteService.removeDetail(id);
						actionResultModel.setMsg("ERROR:没有此标号");
						actionResultModel.setSuccess(false);
						return actionResultModel;
					}
				}


			}
//
			if("1".equals(isGather)) {
				try {
					concluteService.gather(rotateInvite.getId());//汇总成交结果
				} catch (Exception e) {
					// TODO: handle exception
					inviteService.remove(id);
					inviteService.removeDetail(id);
					actionResultModel.setMsg("ERROR:生成成交结果时出错!请检查招标结果与标的物明细是否对应!");
					actionResultModel.setSuccess(false);
					return actionResultModel;
				}
				//

			}
			sysLogService.add(request, "轮换业务-竞标管理-招标结果管理-新增");
		} else {

			if(reimport) {
				
				double totalNum = Double.valueOf(rotateInvite.getTotalNum());//数量合计
				
				double listTotalNum=0.00;
				
				double totalCompetitivePrice = Double.valueOf(rotateInvite.getTotalCompetitivePrice());//竞得价合计
				
				double listTotalCompetitivePrice = 0.00;
				
				double totalBidPrice = Double.valueOf(rotateInvite.getTotalBidPrice());//标的物总价合计
				
				double listTotalBidPrice = 0.00;
				
				double totalBail = Double.valueOf(rotateInvite.getTotalBail());//保证金合计
				
				double listTotalBail = 0.00;
				
				int listSize = inviteDetail.size();
				
				
				for(int i=0;i<listSize;i++){
					listTotalNum += Double.valueOf(rotateInvite.getInviteDetails().get(i).getNum());
					//listTotalCompetitivePrice += Double.valueOf(rotateInvite.getInviteDetails().get(i).getCompetitivePrice());
					listTotalBidPrice += Double.valueOf(rotateInvite.getInviteDetails().get(i).getBidPrice());
					listTotalBail += Double.valueOf(rotateInvite.getInviteDetails().get(i).getBail());
					
				}
				if(listTotalNum!=0)
					listTotalCompetitivePrice = listTotalBidPrice/listTotalNum;
//				listTotalCompetitivePrice=listTotalCompetitivePrice/listSize;
				
				BigDecimal bd1 = new BigDecimal(totalNum); 
				 totalNum = bd1.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();

				 BigDecimal bd2 = new BigDecimal(listTotalNum); 
				 listTotalNum = bd2.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
				 
				 BigDecimal bd3 = new BigDecimal(totalCompetitivePrice); 
				 totalCompetitivePrice = bd3.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
				 
				 BigDecimal bd4 = new BigDecimal(listTotalCompetitivePrice); 
				 listTotalCompetitivePrice = bd4.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
				 
				 BigDecimal bd5 = new BigDecimal(totalBidPrice); 
				 totalBidPrice = bd5.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
				 
				 BigDecimal bd6 = new BigDecimal(listTotalBidPrice); 
				 listTotalBidPrice = bd6.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
				 
				 BigDecimal bd7 = new BigDecimal(totalBail); 
				 totalBail = bd7.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
				 
				 BigDecimal bd8 = new BigDecimal(listTotalBail); 
				 listTotalBail = bd8.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
				
				if(totalNum!=listTotalNum){
					actionResultModel.setMsg("ERROR:数量合计与清单数量汇总不一致!");
					actionResultModel.setSuccess(false);
					return actionResultModel;
				}
				
				if(totalCompetitivePrice!=listTotalCompetitivePrice){
					actionResultModel.setMsg("ERROR:竞得价合计有误!");
					actionResultModel.setSuccess(false);
					return actionResultModel;
				}
				
				if(totalBidPrice!=listTotalBidPrice){
					actionResultModel.setMsg("ERROR:标的物总价与清单标的物总价汇总不一致!");
					actionResultModel.setSuccess(false);
					return actionResultModel;
				}
				
				if(totalBail!=listTotalBail){
					actionResultModel.setMsg("ERROR:占用保证金合计与清单占用保证金汇总不一致!");
					actionResultModel.setSuccess(false);
					return actionResultModel;
				}
			}

			List<RotateConcluteDetail> concluteDetails= new ArrayList<>();
			List<RotateInviteDetail> inviteDetails=rotateInvite.getInviteDetails();
			String inviteType=rotateInvite.getInviteType();
			HashMap<String, String> conditionMap=new HashMap<>();
			conditionMap.put("bidID", rotateInvite.getBidId());

			for(RotateInviteDetail inviteDetail1:inviteDetails) {
				conditionMap.put("bidSerial", inviteDetail1.getBidSerial());
				if(null!=inviteType&&"招标采购".equals(inviteType)) {
					RotateBIDPurchase bidDetail = bidService.getSinglePurchase(conditionMap);
					if(null!=bidDetail){
						inviteDetail1.setLoanPaymentEndDate(bidDetail.getLoanPaymentEndDate());
					}
				}
			}
			rotateInvite.setInviteDetails(inviteDetails);



			inviteService.update(rotateInvite);
			/*List<RotateConcluteDetail> concluteDetails= new ArrayList<>();
			List<RotateInviteDetail> inviteDetails=inviteService.listDetail(rotateInvite.getId());
			String inviteType=rotateInvite.getInviteType();
			HashMap<String, String> conditionMap=new HashMap<>();
			conditionMap.put("bidID", rotateInvite.getBidId());*/

			int count = 1;
			for(RotateInviteDetail inviteDetail1:inviteDetails) {
				conditionMap.put("bidSerial", inviteDetail1.getBidSerial());
				if(null!=inviteType&&"招标采购".equals(inviteType)) {
					RotateBIDPurchase bidDetail = bidService.getSinglePurchase(conditionMap);
					if(null==bidDetail){
						// TODO: handle exception
						inviteService.remove(rotateInvite.getId());
						inviteService.removeDetail(rotateInvite.getId());
						actionResultModel.setMsg("ERROR:没有此标号");
						actionResultModel.setSuccess(false);
						return actionResultModel;
					}
//
				}else {
					RotateBIDSale bidDetail = bidService.getSingleSale(conditionMap);
					if(null==bidDetail){
						// TODO: handle exception
						inviteService.remove(rotateInvite.getId());
						inviteService.removeDetail(rotateInvite.getId());
						actionResultModel.setMsg("ERROR:没有此标号");
						actionResultModel.setSuccess(false);
						return actionResultModel;
					}
				}


			}
//
			if("1".equals(isGather)) {
				try {
					concluteService.gather(rotateInvite.getId());//汇总成交结果
				} catch (Exception e) {
					inviteService.remove(rotateInvite.getId());
					inviteService.removeDetail(rotateInvite.getId());
					actionResultModel.setMsg("ERROR:生成成交结果时出错!请检查招标结果与标的物明细是否对应!");
					actionResultModel.setSuccess(false);
					return actionResultModel;
				}
				HashMap<String, String> map =new HashMap<>();
				map.put("id", rotateInvite.getId());
				map.put("isGather", "1");
				inviteService.updateIsGather(map);
			}
			sysLogService.add(request, "轮换业务-竞标管理-招标结果管理-修改");
		}
		
		actionResultModel.setSuccess(true);
		
		return actionResultModel;
	}

	@RequestMapping(value="/updateIsGather")
	@ResponseBody
	public Object updateIsGather(@RequestParam(value="sid") String sid, HttpServletRequest request) throws UnsupportedEncodingException {
		
		ActionResultModel actionResultModel = new ActionResultModel();
		try {
			concluteService.gather(sid);//汇总成交结果
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			actionResultModel.setMsg("ERROR:生成成交结果时出错!请检查招标结果与标的物明细是否对应!");
			actionResultModel.setSuccess(false);
			return actionResultModel;
		}
		HashMap<String, String> map =new HashMap<>();
		map.put("id", sid);
		map.put("isGather", "1");
		inviteService.updateIsGather(map);
		
		actionResultModel.setSuccess(true);
		sysLogService.add(request, "轮换业务-竞标管理-招标结果管理-提交");
		return actionResultModel;
	}
	

	/**
	 * 分页
	 * @param pageIndex
	 * @param pageSize
	 * @param inviteName
	 * @param inviteType
	 * @param handleTime
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value="/listPagination")
	@ResponseBody
	public LayPage<RotateInvite> list(@RequestParam(value="pageIndex",required=false) int pageIndex,
			@RequestParam(value="pageSize",required=false) int pageSize,
			@RequestParam(value="inviteName",required=false) String inviteName,
			@RequestParam(value="inviteType",required=false) String inviteType,
			@RequestParam(value="handleTime",required=false) String handleTime) throws UnsupportedEncodingException {
		

		int total=inviteService.count(pageIndex, pageSize, inviteName, inviteType, handleTime,null);
		List<RotateInvite> list=null;
		if(total>0)
			list = inviteService.list(pageIndex, pageSize, inviteName, inviteType, handleTime);
		
		
		LayPage<RotateInvite> pageUtil=new LayPage<>(list,total);

		return pageUtil;
	}
	
}
