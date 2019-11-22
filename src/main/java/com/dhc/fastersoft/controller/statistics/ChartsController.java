package com.dhc.fastersoft.controller.statistics;

import cn.afterturn.easypoi.excel.ExcelImportUtil;
import cn.afterturn.easypoi.excel.entity.ImportParams;
import com.dhc.fastersoft.common.Constant;
import com.dhc.fastersoft.common.SysLogAn;
import com.dhc.fastersoft.entity.echarts.EchartsData;
import com.dhc.fastersoft.entity.report.ReportXwsw;
import com.dhc.fastersoft.entity.system.SysDict;
import com.dhc.fastersoft.entity.system.SysFile;
import com.dhc.fastersoft.entity.yearReport.ReportYear;
import com.dhc.fastersoft.service.ReportSwtzService;
import com.dhc.fastersoft.service.ReportXwswService;
import com.dhc.fastersoft.service.StorageWarehouseService;
import com.dhc.fastersoft.service.system.SysDictService;
import com.dhc.fastersoft.service.system.SysFileService;
import com.dhc.fastersoft.service.yearReport.YearReportService;
import com.dhc.fastersoft.utils.LayEntity;
import com.dhc.fastersoft.utils.PropFileReader;
import com.dhc.fastersoft.utils.StringUtils;
import com.dhc.fastersoft.vo.KCTJChartsVO;
import com.dhc.fastersoft.vo.ReportPersonInfoVO;
import com.dhc.fastersoft.vo.ReportXwswResultVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/charts")
public class ChartsController {
	
	@Autowired
	private YearReportService yearReportService;
	
	@Autowired
	private SysFileService sysFileService;
	
	@Autowired
	private ReportSwtzService reportSwtzService;
	
	@Autowired
	private ReportXwswService reportXwswService;

	@Autowired
	private SysDictService sysDictService;

	@Autowired
	private StorageWarehouseService warehouseService;

	@SysLogAn("访问：报表台账-统计分析-人员统计")
	@RequestMapping("/personInfoIndex")
	private String personInfoIndex(){
		return "report/statistical/personInfo_charts";
	}

	@RequestMapping("/getPersonInfo")
	@ResponseBody
	public LayEntity getPersonInfo(HttpServletRequest request){
		LayEntity layEntity = new LayEntity();
		Map<String, Object> map = new HashMap<String, Object>();
		String year = request.getParameter("year");
		if(StringUtils.isBlank(year)){
			year = "2017";
		}
		ReportYear reportYear = new ReportYear();
		reportYear.setReportYear(year);
		reportYear.setReportName("人员基本情况");
		//查出报表的信息
		reportYear = yearReportService.selectByProperty(reportYear);
		if (StringUtils.isBlank(reportYear)) {
			layEntity.setCode(Constant.FAIL_CODE);
			layEntity.setMsg("没有"+year+"这个年份的人员信息报表");
			return layEntity;
		}
		//查询文件
		SysFile sysFile = sysFileService.selectById(reportYear.getId());
		if (StringUtils.isBlank(sysFile)) {
			layEntity.setCode(Constant.FAIL_CODE);
			layEntity.setMsg("无数据");
			return layEntity;
		}
		//下载文件路径
	       /*String realPath=request.getSession().getServletContext().getRealPath(sysFile.getDownloadUrl());*/
        StringBuilder realPath = new StringBuilder();
        PropFileReader propFileReader = new PropFileReader();
        String realPath1 = propFileReader.getPorpertyValue("filePaths.properties","update_url");
        realPath.append(realPath1).append("/"+sysFile.getDownloadUrl()) ;
	       //获取数据
	       ImportParams params = new ImportParams();
	        params.setTitleRows(3);
	        params.setHeadRows(1);
/*	        params.setStartSheetIndex(4);*/
	       List<ReportPersonInfoVO> list;
		try {
			File file = new File(realPath + File.separator);
			   list = ExcelImportUtil.importExcel(
					   file,
					   ReportPersonInfoVO.class, params);
			   map.put("personList", list);
			  layEntity.setData(map);
		} catch (Exception e) {
			layEntity.setCode(Constant.FAIL_CODE);
			layEntity.setMsg("此年份数据已丢失，请联系管理员。或重新上传");
			e.printStackTrace();
			return layEntity;
		}
	      
	      return layEntity;
	}

	@SysLogAn("访问：报表台账-统计分析-库存统计")
	@RequestMapping("/kctj")
	public String kctj(Model model,HttpServletRequest request){
		List<String> baseWarehouses = warehouseService.getWarehouseShortByTypeWithCBK();

		model.addAttribute("basepoint", baseWarehouses);
		List<SysDict> varietyList = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("userId",request.getParameter("userId"));
		model.addAttribute("varietyList",varietyList);
		return "report/statistical/KCTJ_charts";
	}

	@RequestMapping("/inventoryStatisticsPieChart")
	public String kctjY(Model model){
		List<String> baseWarehouses = warehouseService.getWarehouseShortByTypeWithCBK();
		model.addAttribute("basepoint", baseWarehouses);
		List<SysDict> varietyList = sysDictService.getSysDictListByType("粮油品种");
		model.addAttribute("varietyList",varietyList);
		return "report/statistical/kctjPie_charts";
	}
	
	@RequestMapping("/getKCTJCharts")
	@ResponseBody
	public Map<String,Object> getKCTJCharts(HttpServletRequest request){
		Map<String,Object> map1 = reportSwtzService.getKCTJCharts(request);
		return map1;
	}

	@RequestMapping("/getKCTJChartsY")
	@ResponseBody
	public List<KCTJChartsVO> getKCTJChartsY(HttpServletRequest request){
		List<KCTJChartsVO> list = reportSwtzService.getKCTJChartsY(request);
		return list;
	}

	@SysLogAn("访问：报表台账-统计分析-流通流向")
	@RequestMapping("/ltlx")
	public String ltlx(){
		return "report/statistical/LTLX_charts";
	}
	
	@RequestMapping("/getLTLXCharts")
	@ResponseBody
	public Map<String, List> getLTLXCharts(HttpServletRequest request){
		Map<String, List> map = new HashMap<String, List>();
		List<ReportXwswResultVO> reportXwswResultVOs = reportXwswService.getDataByProvince(request);
		List<ReportXwsw> reportXwsws = reportXwswService.getDataByTime(request);
		map.put("reportXwswResultVOs", reportXwswResultVOs);
		map.put("reportXwsws", reportXwsws);
		return map;
		
	}

	/**
	 * 库存趋势
	 * @param request
	 * @return
	 */
	@RequestMapping("/queryKCQSCharts")
	@ResponseBody
	public EchartsData queryKCQSCharts(HttpServletRequest request) {
		EchartsData echartsData = reportSwtzService.queryKCQSCharts(request);
		return echartsData;
	}

	@RequestMapping("/getKCTJPie")
	@ResponseBody
	public Map<String,Object> getKCTJPie(HttpServletRequest request){
		Map<String,Object> map1 = reportSwtzService.getKCTJPie(request);
		return map1;
	}
}
