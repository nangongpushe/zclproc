package com.dhc.fastersoft.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.common.constants.BusinessConstants;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.entity.TransferBusiness;
import com.dhc.fastersoft.entity.TransferBusinessDetail;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.TransferBusinessService;
import com.dhc.fastersoft.utils.PageUtil;
import com.dhc.fastersoft.utils.UpdateUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.type.TypeFactory;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;

@RequestMapping("/Transfer")
@Controller
public class TransferBusinessController extends BaseController{
	
	@Autowired
	private TransferBusinessService transferBusinessService;

	@SysLogAn("访问：中转业务-中转业务统计")
	@RequestMapping
	public String TransferList(Model model) {
		PageUtil<TransferBusiness> pageUtil = new PageUtil<>();
		TransferBusiness transferBusiness=new TransferBusiness();
		pageUtil.setEntity(transferBusiness);

		pageUtil.setPageIndex(1);
		pageUtil.setPageSize(10);
		if(BusinessConstants.CBL_CODE.equals(TokenManager.getToken().getOriginCode().toLowerCase())){
			transferBusiness.setStatus("已上报");
		}
		List<TransferBusiness> result = transferBusinessService.ListTransfer(pageUtil);
		pageUtil.setResult(result);
		model.addAttribute("transferlist",pageUtil);
		return "transit/transit_view";
	}

	@RequestMapping(value="/Add",method= {RequestMethod.GET})
	public String AddTransfer(Model model) {
		TransferBusiness transferBusiness = new TransferBusiness();
		
		SysUser user = TokenManager.getToken();
		
		transferBusiness.setUnitName(user.getCompany());
		transferBusiness.setReportTime(Calendar.getInstance().getTime());
		model.addAttribute("transfer",transferBusiness);
		return "transit/transit_add";
	}

	@SysLogAn("中转业务-中转业务统计-新增")
	@RequestMapping(value="/Add",method= {RequestMethod.POST})
	@ResponseBody
	public Map CreateTransfer(TransferBusiness transferBusiness,
			@RequestParam(value="detailList",required = false) String detailList) throws IOException{
		SysUser user = TokenManager.getToken();
		
		transferBusiness.setUnitName(user.getCompany() == null?"":user.getCompany());
		transferBusiness.setReportTime(Calendar.getInstance().getTime());
		transferBusiness.setCreator(user.getName());
		
		BigDecimal totalIncome = new BigDecimal(0),totalExpend = new BigDecimal(0),totalProfits = new BigDecimal(0),totalCount = new BigDecimal(0);
		ObjectMapper mapper = new ObjectMapper();
		List<TransferBusinessDetail> list = mapper.readValue(detailList,TypeFactory.defaultInstance().constructCollectionType(List.class,TransferBusinessDetail.class));
		for(TransferBusinessDetail detail : list) {
			detail.setId(UUID.randomUUID().toString().replace("-", ""));
			totalIncome = totalIncome.add(detail.getIncome());
			totalExpend = totalExpend.add(detail.getExpend());
			totalProfits = totalProfits.add(detail.getProfits());
			totalCount = totalCount.add(detail.getQuantity());
		}
		transferBusiness.setTransferDetail(list);
		transferBusiness.setTotalIncome(totalIncome);
		transferBusiness.setTotalExpend(totalExpend);
		transferBusiness.setTotalProfits(totalProfits);
		transferBusiness.setTotalCount(totalCount);
		
		transferBusinessService.SaveTransfer(transferBusiness);
		
		Map<String,Object> result = new HashMap<>();
		result.put("success", true);
		return result;
	}

	@RequestMapping(value="",method= {RequestMethod.POST})
	@ResponseBody
	public PageUtil<TransferBusiness> ListTransfer(TransferBusiness transferBusiness,int pageindex,int pagesize){
		PageUtil<TransferBusiness> pageUtil = new PageUtil<>();
		if(TokenManager.getToken().getOriginCode().toLowerCase().equals("cbl")){
			transferBusiness.setStatus("已上报");
		}
		if(transferBusiness.getStatus().equals(""))
			transferBusiness.setStatus(null);
		pageUtil.setEntity(transferBusiness);
		pageUtil.setPageIndex(pageindex);
		pageUtil.setPageSize(pagesize);
		
		pageUtil.setResult(transferBusinessService.ListTransfer(pageUtil));
		return pageUtil;
	}

	@RequestMapping(value="/Edit",params= {"tid"})
	public String EditTransfer(Model model,@RequestParam("tid")String tid) {
		model.addAttribute("transfer",transferBusinessService.GetTransfer(tid));
		return "transit/transit_add";
	}
	
	@RequestMapping(value="/Edit",method= {RequestMethod.POST})
	@ResponseBody
	public Map<String,Object> EditTransfer(TransferBusiness transferBusiness,
			@RequestParam(value="detailList",required = false) String detailList)throws IOException {
		TransferBusiness transferBase = transferBusinessService.GetTransfer(transferBusiness.getId());
		
		try {
			UpdateUtil.UpdateField(transferBusiness, transferBase, new String[] {"id"});
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(detailList != null) {
			BigDecimal totalIncome = new BigDecimal(0),totalExpend = new BigDecimal(0),totalProfits = new BigDecimal(0),totalCount = new BigDecimal(0);
			ObjectMapper mapper = new ObjectMapper();
			List<TransferBusinessDetail> list = mapper.readValue(detailList,TypeFactory.defaultInstance().constructCollectionType(List.class,TransferBusinessDetail.class));
			for(TransferBusinessDetail detail : list) {
				detail.setId(UUID.randomUUID().toString().replace("-", ""));
				totalIncome = totalIncome.add(detail.getIncome());
				totalExpend = totalExpend.add(detail.getExpend());
				totalProfits = totalProfits.add(detail.getProfits());
				totalCount = totalCount.add(detail.getQuantity());
			}
			transferBase.setTransferDetail(list);
			transferBase.setTotalIncome(totalIncome);
			transferBase.setTotalExpend(totalExpend);
			transferBase.setTotalProfits(totalProfits);
			transferBase.setTotalCount(totalCount);
		}

		if("审核中".equals(transferBusiness.getStatus())){
			sysLogService.add(request, "中转业务-中转业务统计-新增中转业务-提交");
		}else if("待提交".equals(transferBusiness.getStatus())){
			sysLogService.add(request, "中转业务-中转业务统计-新增中转业务-修改");
		}else{
			sysLogService.add(request, "中转业务-中转业务统计-新增中转业务-"+transferBusiness.getStatus());
		}
		
		transferBusinessService.UpdateTransfer(transferBase);
		
		Map<String,Object> result = new HashMap<>();
		result.put("success", true);
		return result;
	}
	
	@RequestMapping(value="/Detail",params= {"tid"})
	public String TransferDetail(Model model,@RequestParam("tid")String tid) {
		model.addAttribute("transfer",transferBusinessService.GetTransfer(tid));
		return "transit/transit_detail";
	}

	@SysLogAn("中转业务-中转业务统计-新增中转业务-删除")
	@RequestMapping(value="/Delete",params="id",method=RequestMethod.POST)
	@ResponseBody
	public Map DeleteTransfer(@RequestParam("id")String id) {
		transferBusinessService.DeleteTransfer(id);
		
		Map<String,Object> result = new HashMap<>();
		result.put("success", true);
		return result;
	}
	
	@RequestMapping(value="/ExportExcel")
	@ResponseBody
	public void ExportExcel(HttpServletResponse response,@RequestParam("id")String id) throws IOException {
		
		TransferBusiness transferBusiness = transferBusinessService.GetTransfer(id);
		
		String title = "中转业务记录";
		
		List<TransferBusiness> list = new ArrayList<>();
		list.add(transferBusiness);
		
		response.setHeader("content-Type", "application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "attachment;filename=" +  java.net.URLEncoder.encode(title,"UTF-8") + ".xls");
		response.setCharacterEncoding("UTF-8");
		Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams(title, title),TransferBusiness.class, list);

		workbook.write(response.getOutputStream());
	}
}
