package com.dhc.fastersoft.controller.system;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.entity.StorageGrainInspection;
import com.dhc.fastersoft.entity.report.ReportSwtz;
import com.dhc.fastersoft.service.ReportSwtzService;
import com.dhc.fastersoft.service.StorageGrainInspectionService;
import com.dhc.fastersoft.utils.StringUtils;
import com.dhc.fastersoft.vo.KCTJChartsVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@RequestMapping(value="SysSwtz")
@Controller
public class SysSwtzController {
	
	@Autowired	  
	private ReportSwtzService reportSwtzService;

	@Autowired
	StorageGrainInspectionService service;

	
	/**
	 * 
	 * @return
	 */
	@RequestMapping(value="ReportSwtz",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel reportSwtz(
			@RequestParam(value="reportMonth") String reportMonth,
			@RequestParam(value="reportWarehouse",required=false) String reportWarehouse) {
		ActionResultModel actionResultModel =new ActionResultModel();
		
		HashMap<String, Object> map =new HashMap<>();
		map.put("reportMonth", reportMonth);
		map.put("reportWarehouse", reportWarehouse);
		List<ReportSwtz> reportSwtzs = reportSwtzService.listSwtzForWebApi(map);
		actionResultModel.setData(reportSwtzs);
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}
	
	@RequestMapping(value="ReportKCTJ",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel reportKCTJ(
			@RequestParam(value="reportWarehouse",required=false) String reportWarehouse,
			HttpServletRequest request,HttpServletResponse response) {
		
		response.setHeader("Access-Control-Allow-Origin", "*");
		ActionResultModel actionResultModel =new ActionResultModel();
		String reportMonth = "";
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
		calendar.setTime(new Date());
		calendar.add(calendar.MONTH, -1);
		reportMonth = sdf.format(calendar.getTime());
		HashMap<String,String> map = new HashMap<String, String>();
		reportWarehouse = reportWarehouse.trim();
		map.put("reportWarehouse", reportWarehouse);
		map.put("month", reportMonth);
		List<KCTJChartsVO> kctjChartsVOs = reportSwtzService.listKCTJCharts(map);
		if(kctjChartsVOs.size()<=0){
			//获取符合条件的最大日期
			reportMonth = reportSwtzService.listMaxKCTJMonth(map);
			if(StringUtils.isEmpty(reportMonth)){

			}else{
				map.put("month", reportMonth);
				kctjChartsVOs = reportSwtzService.listKCTJCharts(map);
			}
		}
		actionResultModel.setData(kctjChartsVOs);
		actionResultModel.setSuccess(true);
		return actionResultModel;
		
	}

	@RequestMapping(value="listByWarehouse",method=RequestMethod.POST)
	@ResponseBody
	public List<StorageGrainInspection> list(@RequestParam(value="craindeport",required = true) String craindeport,
			HttpServletRequest request,HttpServletResponse response) {
		response.setHeader("Access-Control-Allow-Origin", "*");
		HashMap<String, String> map = new HashMap<>();
		String reportDate = "";
		map.put("warehouse",craindeport);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		reportDate = sdf.format(calendar.getTime());
		map.put("reportDate",reportDate);

		List<StorageGrainInspection> storageGrainInspections = service.listByWarehouse(map);
		if(storageGrainInspections.size()<=0){
			//如果没有查到粮情，则查出符合条件的最大日期
			reportDate = service.findMaxDateByWarehouse(map);
			if(StringUtils.isEmpty(reportDate)){
				//如果没有日期，则
			}else{
				map.put("reportDate",reportDate);
				storageGrainInspections = service.listByWarehouse(map);
			}

		}
		return storageGrainInspections;
	}
}
