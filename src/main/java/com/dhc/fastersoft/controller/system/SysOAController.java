package com.dhc.fastersoft.controller.system;

import java.io.IOException;
import java.util.*;

import com.dhc.fastersoft.dao.RotateScheduleDao;
import com.dhc.fastersoft.dao.system.SysOAProcessHistoryDao;
import com.dhc.fastersoft.entity.QualityResult;
import com.dhc.fastersoft.entity.QualitySample;
import com.dhc.fastersoft.entity.RotateSchedule;
import com.dhc.fastersoft.entity.report.ReportMonth;
import com.dhc.fastersoft.entity.system.SysOAProcessHistory;
import com.dhc.fastersoft.service.*;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.controller.RotatePlanController;
import com.dhc.fastersoft.entity.system.SysProcessMapper;
import com.dhc.fastersoft.service.system.SysOAService;
import com.dhc.fastersoft.service.system.SysProcessMapperService;

@RequestMapping(value="SysOA")
@Controller
public class SysOAController {
	
	private static Logger log = Logger.getLogger(RotatePlanController.class);
	
	@Autowired	  
	private SysOAService sysOAService;
	@Autowired
	private SysProcessMapperService processMapperService;
	@Autowired
	private QualitySampleService qualitySampleService;
	@Autowired
	private QualityResultService qualityResultService;
	@Autowired
	private ReportMonthService reportMonthService;
	@Autowired
	private RotateFreightAPRVService aprvService;
	@Autowired
	private SysOAProcessHistoryDao oaProcessHistoryDao;
	@Autowired
	private RotateScheduleService rotateScheduleService;

	private Properties prop = new Properties();
	
	{
		try {
			prop.load(this.getClass().getResourceAsStream("/OATable.properties"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * OA回调
	 * @param info  json字符串接收反馈信息
	 * @return
	 */
	@RequestMapping(value="audit",method=RequestMethod.POST)
	@ResponseBody
	public ActionResultModel updateStatus(
			@RequestParam("processInstanceId") String processInstanceId, boolean isBack,
		@RequestParam(value="info",required=false) String info) {

		boolean isOK = true;
		log.info("isBack"+isBack);
		log.info("OA回调,"+" processInstanceId:"+processInstanceId+" "+"info:"+info);
		ActionResultModel actionResultModel =new ActionResultModel();


		Date endTime = Calendar.getInstance().getTime();

		SysOAProcessHistory sysOAProcessHistory = new SysOAProcessHistory(endTime, endTime, processInstanceId);
		sysOAProcessHistory.setStrackTrace("oaisBack="+isBack);
		oaProcessHistoryDao.AddLog(sysOAProcessHistory);

			SysProcessMapper processMapper = processMapperService.GetSysProcessMapper(processInstanceId);
		if(null == processMapper) {
			actionResultModel.setSuccess(false);
			actionResultModel.setMsg("NULLPOINTEXCEPTION");
			return actionResultModel;
		}
		String tableName = processMapper.getTableMapper();
		String bussinessId = processMapper.getBussinessId();
		String fieldName = processMapper.getFieldName();
		String fieldValue = processMapper.getFieldValue().split(":")[0];
		if("T_REPORT_MONTH".equals(tableName) && isBack && processMapper.getFieldValue().contains(":")){
			fieldValue = processMapper.getFieldValue().split(":")[1];
		}

		
		HashMap<String, String> map = new HashMap<>();
		map.put("tableName", tableName);//表名
		map.put("id", bussinessId);//表主键id
		map.put("field", fieldName);//表主键id
		map.put("status", fieldValue);//状态
		
		//运费汇总审批
		if("T_ROTATE_FREIGHT_APRV_GATHER".equals(tableName)) {
//			map.put("childTableName", "T_ROTATE_FREIGHT_APRV");//要更新的子表名
//			map.put("childField", "STATUS");//要更新的子表字段
//			map.put("childStatus", "审核通过");//更新的字段值
//			map.put("foreignKey", "GATHER_ID");//子表对应主表的外键



			if(isBack){
				map.put("status","已驳回");
			}


		}

		//运费管理审批
		if("T_ROTATE_FREIGHT_APRV".equals(tableName)) {

			if(isBack){
				map.put("status","已驳回");
			}

		}

		//当点了退回后，OA再点通过时不更新状态
		if("T_REPORT_MONTH".equals(tableName)){
			ReportMonth report = reportMonthService.getReportMonthById(bussinessId);
			if(!"待审核".equals(report.getReportStatus()) &&
					  !"汇总待审".equals(report.getReportStatus()) && !isBack){
				isOK = false;
			}
			if("OA汇总送审".equals(report.getReportStatus())){
				log.info("OA回调,"+" fieldValue:"+fieldValue+" "+"getReportMonth:"+report.getReportMonth()+"getReportName"+report.getReportName());
				reportMonthService.updateStatus(fieldValue,report.getReportMonth(),report.getReportName());

//				map.put("status","汇总通过");
				//汇总通过改变全局状态
			}
		}

		if(StringUtils.equals("T_ROTATE_SCHEME",tableName)){
			if(isBack){
				map.put("status","已驳回");
			}
		}

		if("T_QUALITY_RESULT".equals(tableName)){

			if(isBack){
				map.put("testStatus","已驳回");
			}else {
			   QualityResult qualityResult= qualityResultService.getByID(bussinessId);

				Map<String, Object> param = new HashMap();
				param.put("sampleNo", qualityResult.getSampleNo());
				List list = qualitySampleService.query(param);
				QualitySample sample = new QualitySample();
				if(list.size()>0){
					sample = qualitySampleService.query(param).get(0);
				}
				//更新样品状态为检毕
				Map<String, String> param1 = new HashMap();
				param1.put("sampleNo", qualityResult.getSampleNo());
				param1.put("testStatus","检毕");
				qualitySampleService.updateSampleStatus(param1);

				// 下发给库平台
				try {
					qualityResultService.sendMessage(bussinessId, "1");
				} catch (Exception e){

				}
			}

		}


		try {
			if(isOK){
				sysOAService.updateStatus(map);

				if(!isBack){
					//审批通过就删除记录,目的为了公司或者库点驳回重新生成工单流程
					HashMap  map1 = new HashMap();
					map1.put("processId",processInstanceId);
					processMapperService.delete(map1);
				}

			}

		}catch (Exception e) {
			// TODO: handle exception
			actionResultModel.setSuccess(false);
			actionResultModel.setMsg("更新服务出错");
			return actionResultModel;
		}
		
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}
	
}
