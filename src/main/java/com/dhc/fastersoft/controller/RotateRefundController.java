package com.dhc.fastersoft.controller;

import com.alibaba.fastjson.JSON;
import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.RotateRefund;
import com.dhc.fastersoft.entity.RotateRefundMain;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.CustomerInformationService;
import com.dhc.fastersoft.service.RotateRefundMainService;
import com.dhc.fastersoft.service.RotateRefundService;
import com.dhc.fastersoft.utils.LayPage;
import com.dhc.fastersoft.utils.StringUtil;
import com.dhc.fastersoft.utils.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * 标的物
 * @author lay
 *
 */
@Controller
@RequestMapping("/rotateRefund")
public class RotateRefundController extends BaseController{
	private static Logger log = Logger.getLogger(RotateRefundController.class);
	@Autowired
	private RotateRefundService refundService;
	@Autowired
	private CustomerInformationService customService;
	@Autowired
	private RotateRefundMainService refundMainService;
	
	@RequestMapping("/add")
	public String add(Model model) {
		SysUser user = TokenManager.getToken();
		RotateRefundMain rotateRefundMain=new RotateRefundMain();
		//RotateRefund rotateRefund = new RotateRefund();
		rotateRefundMain.setOperator(user.getName());
		rotateRefundMain.setDepartment(user.getDepartment());
		rotateRefundMain.setHandleTime(new Date());
		HashMap<String, String> map = new HashMap<>();
		/*自动生成编号（年份+001）（取出最大的一个，取出前4位，判断当前年份是否等于
            前四位，如果等于则后三位+1，如果不等于则年份+001）*/
		String maxSerial = refundMainService.getMaxSerial();
		String serial = null;
		Calendar calendar = Calendar.getInstance();
		String nowYear = String.valueOf(calendar.get(Calendar.YEAR));
		if(maxSerial!=null && maxSerial.length() == 7){
			//获取当前年份
			String year = maxSerial.substring(0,4);
			String flowNum = maxSerial.substring(4,maxSerial.length());

			if(!nowYear.equals(year)){
				serial = nowYear+"001";
			}else{
				int length = String.valueOf(Integer.parseInt(flowNum) + 1).length();
				if(length==1) {
					serial = year + "00"+(Integer.parseInt(flowNum) + 1);
				}else if(length == 2){
					serial = year + "0"+(Integer.parseInt(flowNum) + 1);
				}else if(length == 3){
					serial = year + (Integer.parseInt(flowNum) + 1);
				}
			}
			rotateRefundMain.setSerial(serial);
		}else {
			serial=nowYear+"001";
		}
		model.addAttribute("serial",serial);
		model.addAttribute("customers", customService.listCustomer(map));
		model.addAttribute("modelMain", rotateRefundMain);
		model.addAttribute("isEdit", false);
		return "RotateRefund/rotaterefund_add";
	}

	@RequestMapping(value="/edit",params="sid")
	public String update(Model model,@RequestParam("sid") String sid) {
		RotateRefundMain rotateRefundMain = refundMainService.get(sid);//主表数据
		SysUser user = TokenManager.getToken();
		rotateRefundMain.setModifier(user.getName());
		rotateRefundMain.setModifyTime(new Date());
		SimpleDateFormat s=new SimpleDateFormat("yyyy-MM-dd");
        List<RotateRefund> rotateRefunds=refundService.get(sid);//子表数据
		String maxGroupId=refundService.getMaxGroupId(sid);//获得子表数据中最大的分组号
		for(int i=0;i<rotateRefunds.size();i++){
			rotateRefunds.get(i).setInviteName(refundService.getInviteName(rotateRefunds.get(i)));
			rotateRefunds.get(i).setDealDates(s.format(rotateRefunds.get(i).getDealDate()));
		}
        List<RotateRefund> rotateRefunds1=new ArrayList<>();
        String concluteId=""; //concluteDetailId的字符串集合
        for(int i=1;i<=Integer.parseInt(maxGroupId);i++){    //分组筛选，整合数据
			String bidSerial="";
			double dealNumber=0;
			double dealAmount=0;
			BigDecimal surplusBail=new BigDecimal("0");
			double refundAmount=0;
			RotateRefund rotateRefund=new RotateRefund();
			String concluteDetailId="";
            for(int j=0;j<rotateRefunds.size();j++){
                if(Integer.parseInt(rotateRefunds.get(j).getGroupId())==i){
					rotateRefund.setCompany(rotateRefunds.get(j).getCompany());
					rotateRefund.setDealDates(s.format(rotateRefunds.get(j).getDealDate()));
                    if(judgeType(rotateRefunds.get(j).getDealType())){
                        rotateRefund.setType("购");}
                    else {
                        rotateRefund.setType("销");
                    }
                    rotateRefund.setDealType(rotateRefunds.get(j).getDealType());
					if(bidSerial==""){
						rotateRefund.setBidSerial(rotateRefunds.get(j).getBidSerial());
						bidSerial=rotateRefunds.get(j).getBidSerial();
					}else{
						rotateRefund.setBidSerial(bidSerial+","+rotateRefunds.get(j).getBidSerial());
						bidSerial=bidSerial+","+rotateRefunds.get(j).getBidSerial();
					}
					rotateRefund.setDealNumber(doubleTrans(dealNumber+Double.parseDouble(rotateRefunds.get(j).getDealNumber())));
                    dealNumber=dealNumber+Double.parseDouble(rotateRefunds.get(j).getDealNumber());
					rotateRefund.setDealAmount(doubleTrans(dealAmount+Double.parseDouble(rotateRefunds.get(j).getDealAmount())));
                    dealAmount=dealAmount+Double.parseDouble(rotateRefunds.get(j).getDealAmount());
                    surplusBail=surplusBail.add(rotateRefunds.get(j).getSurplusBail());
					rotateRefund.setSurplusBail(surplusBail);
					rotateRefund.setRefundAmount(doubleTrans(refundAmount+Double.parseDouble(rotateRefunds.get(j).getRefundAmount())));
					refundAmount=refundAmount+Double.parseDouble(rotateRefunds.get(j).getRefundAmount());
					rotateRefund.setRemark(rotateRefunds.get(j).getRemark());
					rotateRefund.setGroupId(rotateRefunds.get(j).getGroupId());
					concluteId=concluteId+rotateRefunds.get(j).getConcluteDetailId()+",";
					if(concluteDetailId==""){
						rotateRefund.setConcluteDetailId(rotateRefunds.get(j).getConcluteDetailId());
						concluteDetailId=rotateRefunds.get(j).getConcluteDetailId();
					}else{
					    rotateRefund.setConcluteDetailId(concluteDetailId+","+rotateRefunds.get(j).getConcluteDetailId());
						concluteDetailId=concluteDetailId+","+rotateRefunds.get(j).getConcluteDetailId();
					}

					rotateRefund.setGroupId(rotateRefunds.get(j).getGroupId());
                }
            }
            if(!StringUtil.isEmpty(rotateRefund.getGroupId()) ){
            rotateRefunds1.add(rotateRefund);}
        }
		HashMap<String, String> map = new HashMap<>();
		model.addAttribute("customers", customService.listCustomer(map));
		model.addAttribute("modelMain",rotateRefundMain);
		model.addAttribute("serial",rotateRefundMain.getSerial());
		model.addAttribute("concluteId",concluteId);
		model.addAttribute("model", rotateRefunds1);
		model.addAttribute("model2", rotateRefunds);
		model.addAttribute("isEdit", true);
		return "RotateRefund/rotaterefund_add";
	}

	@SysLogAn("访问：轮换业务-竞标管理-保证金退还")
	@RequestMapping("/main")
	public String main(Model model) {
		HashMap<String, String> map = new HashMap<>();
		model.addAttribute("customers", customService.listCustomer(map));
		return "RotateRefund/rotaterefund_main";
	}
	
	@RequestMapping(value="/view",params="sid")
	public String view(Model model,@RequestParam("sid") String sid) {
//		RotateRefund rotateRefund = refundService.view(sid);
//		model.addAttribute("model",rotateRefund);
//		return "RotateRefund/rotaterefund_view";
		RotateRefundMain rotateRefundMain = refundMainService.get(sid);//主表数据
		SimpleDateFormat s=new SimpleDateFormat("yyyy-MM-dd");
		List<RotateRefund> rotateRefunds=refundService.get(sid);//子表数据
		String maxGroupId=refundService.getMaxGroupId(sid);
		List<RotateRefund> rotateRefunds1=new ArrayList<>();
		String totalNumber="0";//总数量
		String totalAmount="0";//总退还金额
		for(int i=1;i<=Integer.parseInt(maxGroupId);i++){    //分组筛选，整合数据
			String bidSerial="";
			double dealNumber=0;
			double refundAmount=0;
			RotateRefund rotateRefund=new RotateRefund();
			for(int j=0;j<rotateRefunds.size();j++){
				if(Integer.parseInt(rotateRefunds.get(j).getGroupId())==i){
					rotateRefund.setCompany(rotateRefunds.get(j).getCompany());
					rotateRefund.setDealDates(s.format(rotateRefunds.get(j).getDealDate()));
					if(judgeType(rotateRefunds.get(j).getDealType())){
					rotateRefund.setDealType("购");}
					else {
                        rotateRefund.setDealType("销");
                    }
					if(bidSerial==""){
						rotateRefund.setBidSerial(rotateRefunds.get(j).getBidSerial());
						bidSerial=rotateRefunds.get(j).getBidSerial();
					}else{
						rotateRefund.setBidSerial(bidSerial+"、"+rotateRefunds.get(j).getBidSerial());
						bidSerial=bidSerial+"、"+rotateRefunds.get(j).getBidSerial();
					}
					totalNumber=doubleTrans(Double.parseDouble(totalNumber)+Double.parseDouble(rotateRefunds.get(j).getDealNumber()));//总数量
					rotateRefund.setDealNumber(doubleTrans(dealNumber+Double.parseDouble(rotateRefunds.get(j).getDealNumber())));
					dealNumber=dealNumber+Double.parseDouble(rotateRefunds.get(j).getDealNumber());
					totalAmount=doubleTrans(Double.parseDouble(totalAmount)+Double.parseDouble(rotateRefunds.get(j).getRefundAmount()));//总退还金额
					rotateRefund.setRefundAmount(doubleTrans(refundAmount+Double.parseDouble(rotateRefunds.get(j).getRefundAmount())));
					refundAmount=refundAmount+Double.parseDouble(rotateRefunds.get(j).getRefundAmount());
					rotateRefund.setRemark(rotateRefunds.get(j).getRemark());
					rotateRefund.setGroupId(rotateRefunds.get(j).getGroupId());
				}
			}
			if(!StringUtil.isEmpty(rotateRefund.getGroupId()) ){
				rotateRefunds1.add(rotateRefund);}
		}
		for (int i = rotateRefunds1.size(); i < 5; i++) {
			rotateRefunds1.add(new RotateRefund());
		}
		model.addAttribute("modelMain",rotateRefundMain);
		model.addAttribute("model", rotateRefunds1);
		model.addAttribute("totalNumber",totalNumber);
		model.addAttribute("totalAmount",totalAmount);
		return "RotateRefund/rotaterefund_detail";
	}

	//---接口----
	/**
	 * 新建、编辑
//	 * @param rotateRefund
//	 * @param isedit
//	 * @return
//	 * @throws IOException
	 */
	@RequestMapping(value = "/saveOrUpdate", method = RequestMethod.POST)
	@ResponseBody
	public Object saveOrUpdate(String main, String datas,boolean isedit,String mainId) {
        RotateRefundMain rotateRefundMain= JSON.parseObject(main,RotateRefundMain.class);
        List<RotateRefund> rotateRefunds=JSON.parseArray(datas,RotateRefund.class);
		SimpleDateFormat s=new SimpleDateFormat("yyyy-MM-dd");
		SysUser user = TokenManager.getToken();
        for(int i=0;i<rotateRefunds.size();i++) {
			if (StringUtils.isNotEmpty(rotateRefunds.get(i).getCompany()))
				rotateRefunds.get(i).setCompanyId(customService.getClientIdByName(rotateRefunds.get(i).getCompany()));
		}
		if (!isedit) {
        	String id_Main= UUID.randomUUID().toString().replaceAll("-", "");
        	rotateRefundMain.setId(id_Main);
			//rotateRefundMain.setOperator(user.getId());
			rotateRefundMain.setModifier(user.getName());
			rotateRefundMain.setModifyTime(new Date());
			String serial = rotateRefundMain.getSerial();
			String maxSerial = refundMainService.getMaxSerial();
			//判断是否需要重新生成

			boolean flag = checkSerial(serial,maxSerial);
			if(!flag){
				//自动生成
				String newSerial =  generateFlowNum(maxSerial);
				rotateRefundMain.setSerial(newSerial);
			}
			refundMainService.save(rotateRefundMain);
			for(int i=0;i<rotateRefunds.size();i++){
				rotateRefunds.get(i).setId(UUID.randomUUID().toString().replaceAll("-", ""));
				rotateRefunds.get(i).setMainId(id_Main);
				refundService.save(rotateRefunds.get(i));
			}
			sysLogService.add(request, "轮换业务-竞标管理-保证金退还-新增");
		} else {
			rotateRefundMain.setId(mainId);
			rotateRefundMain.setModifier(user.getName());
			rotateRefundMain.setModifyTime(new Date());
			refundService.updateMain((rotateRefundMain));//更新主表
        	refundService.remove(mainId);//删除子表数据
			for(int i=0;i<rotateRefunds.size();i++){
				rotateRefunds.get(i).setMainId(mainId);
				refundService.save(rotateRefunds.get(i));//插入子表数据
			}
			sysLogService.add(request, "轮换业务-竞标管理-保证金退还-编辑");
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
	@SysLogAn("轮换业务-竞标管理-保证金退还-删除")
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel remove(@RequestParam(value="sid",required=false) String sid) {
		refundService.remove(sid);
		refundService.removeMain(sid);
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
	public LayPage<RotateRefund> listPagination(
			@RequestParam(value="pageIndex") int pageIndex,
			@RequestParam(value="pageSize") int pageSize,
			@RequestParam(value="company",required=false) String company,
			@RequestParam(value="dealDate",required=false) String dealDate,
			@RequestParam(value="serial",required=false) String serial,
			@RequestParam(value="dealType",required=false) String dealType,
			@RequestParam(value="dealAmount",required=false) String dealAmount) {
		
		
		HashMap<String, Object> map=new HashMap<>();
		map.put("pageIndex", pageIndex);
		map.put("pageSize", pageSize);
		map.put("company", company);
		map.put("dealDate", dealDate);
		map.put("dealType", dealType);
		map.put("dealAmount", dealAmount);
		map.put("serial", serial);
	
		
		int total=refundService.count(map);
		List<RotateRefund> list=null;
		if(total>0)
			list = refundService.list(map);
		LayPage<RotateRefund> pageUtil=new LayPage<>(list,total);

		return pageUtil;
	}

	public boolean checkSerial(String serial,String maxSerial){
		//1、判断格式是否正确
		//长度是否合格
		if(serial.length() !=7){
			return false;
		}
		//是否当年
		String year = serial.substring(0,4);
		String flowNum = serial.substring(4,serial.length());//当前需要保存的序号
		Calendar calendar = Calendar.getInstance();
		String nowYear = String.valueOf(calendar.get(Calendar.YEAR));
		if(!year.equals(nowYear)){
			return false;
		}
		//判断是否大于等于最大流水号
		if(maxSerial!=null) {
			String maxFlowNum = maxSerial.substring(4, maxSerial.length());
			if(Integer.parseInt(flowNum)<=Integer.parseInt(maxFlowNum)){
				return false;
			}
		}
		//判断是否有重复
		RotateRefundMain bySerial = refundMainService.getBySerial(serial);
		if(bySerial != null){
			return false;
		}
		return true;
	}

	public String generateFlowNum(String maxSerial){
		//获取当前年份
		Calendar calendar = Calendar.getInstance();
		String nowYear = String.valueOf(calendar.get(Calendar.YEAR));
		String year = maxSerial.substring(0,4);
		String flowNum = maxSerial.substring(4,maxSerial.length());
		String serial = null;
		if(!nowYear.equals(year)){
			serial = nowYear+"001";
		}else{
			int length = String.valueOf(Integer.parseInt(flowNum) + 1).length();
			if(length==1) {
				serial = year + "00"+(Integer.parseInt(flowNum) + 1);
			}else if(length == 2){
				serial = year + "0"+(Integer.parseInt(flowNum) + 1);
			}else if(length == 3){
				serial = year + (Integer.parseInt(flowNum) + 1);
			}
		}
		return serial;
	}
	public boolean judgeType(String type){//判断轮换类型
	    boolean a=false;
        String[] type1={"招标采购","订单采购","进口粮采购"};
        for(int i=0;i<type1.length;i++){
            if(type1[i]==type){
                a=true;break;
            }
        }
        return a;
    }

	public static String doubleTrans(double num){//double型转化字符型
		String number1 = String.format("%.6f", num);//只保留小数点后6位
		double number2 = Double.parseDouble(number1);//类型转化
		if(Math.round(number2)-number2 == 0){
			return String.valueOf((long)number2);
		}
		return String.valueOf(number2);
	}
}
