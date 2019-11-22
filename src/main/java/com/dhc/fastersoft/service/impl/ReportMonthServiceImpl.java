package com.dhc.fastersoft.service.impl;

import com.dhc.fastersoft.common.ActionResultModel;
import com.dhc.fastersoft.common.Constant;
import com.dhc.fastersoft.common.constants.BusinessConstants;
import com.dhc.fastersoft.common.page.QueryUtil;
import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.StorageWarehouseDao;
import com.dhc.fastersoft.dao.report.*;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.enumdata.ReportStatusEnum;
import com.dhc.fastersoft.entity.report.ReportMonth;
import com.dhc.fastersoft.entity.report.ReportSwtz;
import com.dhc.fastersoft.entity.system.SysProcessMapper;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.ReportMonthService;
import com.dhc.fastersoft.service.system.SysOAService;
import com.dhc.fastersoft.util.HttpUtil;
import com.dhc.fastersoft.utils.LayPage;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.util.*;

@Service("reportMonthService")
public class ReportMonthServiceImpl implements ReportMonthService {

	@Autowired
	public ReportMonthDao dao;
	@Autowired
	public ReportCblyDao cblyDao;
	@Autowired
	public ReportSplyDao splyDao;
	@Autowired
	public ReportXwswDao xwswDao;
	@Autowired
	public ReportSwtzDao swtzDao;
	@Autowired
	public ReportBzwDao bzwDao;
	@Autowired
	private SysOAService sysOAService;
	@Autowired
	public StorageWarehouseDao warehouseDao;


	
	@Autowired
	private HttpServletRequest request;
	
	static Map<String,String> reportNameMapper;
	static{
		reportNameMapper = new HashMap<String,String>();
		reportNameMapper.put("储备粮油收支月报表", "cbly");
		reportNameMapper.put("商品粮油收支月报表", "sply");
		reportNameMapper.put("销往省外", "xwsw");
		reportNameMapper.put("省外购进", "xwsw");
		reportNameMapper.put("粮油库存实物台账月报表", "swtz");
		reportNameMapper.put("包装物库存月报表", "bzw");
		reportNameMapper.put("库存包装物出入库明细表", "bzwcrmx");
	}

	@Override
	public int updateStatus(String id, String status, String reportMonth, String reportName) {
		Map map = new HashMap();
		map.put("id", id);
		map.put("status", status);
		if(ReportStatusEnum.DSH.getValue().equals(status)){ //发送AO审核流程
			String fileCode = exprotAnyExcel(id,"");
			if(fileCode != null) {
				sysOAService.LaunchedAudit(
						id,
						TokenManager.getToken().getId(),
						reportMonth+reportName+"待审核",
						String.format("http://%s:%s%s/", request.getServerName(),request.getServerPort(),request.getContextPath()) + "files/code/" + fileCode,
						new SysProcessMapper("T_REPORT_MONTH", "REPORT_STATUS", "审核通过:审核驳回"));
			}else {
				throw new RuntimeException("未生成附件");
			}
		}
		return dao.updateStatus(map);
	}

	@Override
	public int updateStatus(String status, String reportMonth, String reportName) {
		Map map = new HashMap();
		map.put("status", status);
		map.put("reportMonth", reportMonth);
		map.put("reportName", reportName);
		return dao.updateStatusByMonthAndName(map);
	}

	public String exprotAnyExcel(String id, String flag) {
		SysUser user = TokenManager.getToken();
		String fileCode = null;
		
		ReportMonth mainReport = dao.getReportMonthById(id);
		String reportType = reportNameMapper.get(mainReport.getReportName());
		if(reportType != null) {
			String host = String.format("http://%s:%s%s/", request.getServerName(),request.getServerPort(),request.getContextPath());
			HttpClient client = HttpClients.createDefault();
			//模拟进行一次登陆以绕过验证
			HttpPost post = new HttpPost(host + "sign/submitLogin.shtml");
			List<NameValuePair> list = new ArrayList<>();
			list.add(new BasicNameValuePair("account",user.getAccount()));
			list.add(new BasicNameValuePair("password",user.getPassword()));
			UrlEncodedFormEntity entity = null;
			try {
				entity = new UrlEncodedFormEntity(list,"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}  
			post.setEntity(entity);  
			HttpResponse response = null;
			try {
	        	response = client.execute(post);
			} catch (IOException e) {
				e.printStackTrace();
			}
	        if(response != null) {
	        	HttpEntity httpEntity = response.getEntity();
	        	try {
					JSONObject returnData = JSONObject.fromObject(EntityUtils.toString(httpEntity,"utf-8"));
					if(!(returnData.get("message").equals("登录成功"))) {
						return fileCode;
					}
				}  catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        }
			
			reportType = reportType.replaceFirst(String.valueOf(reportType.toCharArray()[0]), String.valueOf(reportType.toCharArray()[0]).toUpperCase());
			StringBuilder param = new StringBuilder();
			param.append("reportId="+id);
			if(flag.equals("sum")){
				param.append("&flag="+"sum");
			}

			HttpGet get = new HttpGet(host + String.format("report%s/export%s.shtml?%s", reportType,reportType,param.toString()));
	        try {
	        	response = client.execute(get);
			} catch (IOException e) {
				e.printStackTrace();
			}
	        if(response != null) {
	        	HttpEntity httpEntity = response.getEntity();
	        	try {
	        		if(response.getStatusLine().getStatusCode() == HttpStatus.OK.value()) {
	        			InputStream in = httpEntity.getContent();
		        		File file = new File(request.getSession().getServletContext().getRealPath("/") + Constant.EXPORT_PATH);
		        		if(!file.exists())
		        			file.mkdirs();
		        		fileCode = UUID.randomUUID().toString().replace("-", "") + ".xls";
		        		FileOutputStream fos = new FileOutputStream(file.getPath() + "/" + fileCode);
		        		byte[] buffer = new byte[4096];
		        		int readLength = 0;
		        		while ((readLength=in.read(buffer)) > 0) {
        		           byte[] bytes = new byte[readLength];
    		                System.arraycopy(buffer, 0, bytes, 0, readLength);
    		                fos.write(bytes);
    		            }
		        		fos.flush();
		        		in.close();
		        		fos.close();
	        			return fileCode;
	        		}
				} catch (IOException e) {
					e.printStackTrace();
				}
	        }
		}
		return fileCode;
	}

	@Override
	public ReportMonth getReportMonthById(String reportId) {
		return dao.getReportMonthById(reportId);
	}

	@Override
	public ReportMonth getReport(ReportMonth reportMonth) {
		return dao.getReport(reportMonth);
	}

	@Override
	public ActionResultModel checkSummary(ReportMonth report) {
		ActionResultModel actionResultModel = new ActionResultModel();
		//查询各库月报表
//		List<StorageWarehouse> storageWarehouses = storageWarehouseService.limitList();

		//过滤掉停用的企业,停用但是上报了的除外

		Map<String,Object> param = new HashMap();
		param.put("pageIndex", 1);
		param.put("pageSize", 1000);
		param.put("entity", report);
		param.put("isHost", "Y");
		List<ReportMonth> reportMonthss=	dao.fillTableQuery(param);

//		List<StorageWarehouse> reportMonthss=warehouseDao.listHostWareHouse();

		String[] basepoint = new String[reportMonthss.size()];
		int i=0;
		for (ReportMonth storageWarehouse : reportMonthss) {
			basepoint[i++]=storageWarehouse.getReportWarehouse();
		}
		String reportName = report.getReportName();
		report.setReportStatus("SBDSTGBH"); //上报待审、上报通过、汇总驳回
		report.setReportWarehouse(null);
		List<ReportMonth> reportMonths = dao.listReport(report);//所有库上报待审、上报通过的
		List<String> sbds = new ArrayList<>();//上报待审的库
		List<String> wsb = new ArrayList<>();//未上报的库
		List<String> sbtg = new ArrayList<>();//上报通过的库
		for (int j = 0; j <reportMonthss.size() ; j++) {
			ReportMonth reportMonth1=reportMonthss.get(j);
			boolean flag = false; //该库是否已上报通过
			for (ReportMonth reportMonth : reportMonths) {
				if (reportMonth1.getReportWarehouseId().equals(reportMonth.getReportWarehouseId())){
					if(ReportStatusEnum.SBDS.getValue().equals(reportMonth.getReportStatus()) || ReportStatusEnum.HZBH.getValue().equals(reportMonth.getReportStatus()))
						sbds.add(basepoint[j]);
					else
						sbtg.add(basepoint[j]);
					flag = true;
					break;
				}
			}
			if (!flag){
				wsb.add(basepoint[j]);
			}
		}
		for (String point : basepoint) {

		}

		String msg = "";
		if (sbds.size()>0){
			StringBuffer sb = new StringBuffer();
			for (String point : sbds) {
				sb.append(",").append(point);
			}
			msg = "以下库已上报但未审：" + sb.toString().substring(1)+"；";
		}else{
			msg += "；";
		}

		if (wsb.size()>0){
			StringBuffer sb = new StringBuffer();
			for (String point : wsb) {
				sb.append(",").append(point);
			}
			msg += "以下库未上报：" + sb.toString().substring(1)+"；";
		}else{
			msg += "；";
		}

		if (sbtg.size()>0){
			StringBuffer sb = new StringBuffer();
			for (String point : sbtg) {
				sb.append(",").append(point);
			}
			msg += "以下库上报通过：" + sb.toString().substring(1)+"；";
		}else{
			msg += "；";
		}

		actionResultModel.setMsg(msg);
		actionResultModel.setSuccess(true);
		return actionResultModel;
	}

	@Override
	public ActionResultModel summary(ReportMonth report, String sumManager) {
		ActionResultModel actionResultModel = new ActionResultModel();
		//查询各库月报表
		List<StorageWarehouse> storageWarehouses = warehouseDao.listHostWareHouse();
		String[] basepoint = new String[storageWarehouses.size()];
		int i=0;
		for (StorageWarehouse storageWarehouse : storageWarehouses) {
			basepoint[i++]=storageWarehouse.getId();
		}
		report.setReportStatus(ReportStatusEnum.SBTG.getValue()); //上报通过
		report.setReportWarehouse(null);
		List<ReportMonth> reportMonths = dao.listReport(report);//所有库已上报通过的月报表
		String reportids = "";//已上报通过的库
		for (String point : basepoint) {
			for (ReportMonth reportMonth : reportMonths) {
				if (point.equals(reportMonth.getReportWarehouseId())){
					reportids += "," + reportMonth.getId();
					break;
				}
			}
		}
		report.setReportWarehouse(Constant.HOME_WAREHOUSE);
		report.setReportWarehouseId("0");
		//执行汇总
		reportids = reportids.substring(1);
		reportids = "'" + reportids.replace(",","','") + "'";
		report.setReportIds(reportids);//设置子库报表ID
		String monthId = report.getId();
		//保存或更新主表
		if (StringUtils.isEmpty(monthId)){
			monthId = UUID.randomUUID().toString().replace("-","");
			report.setId(monthId);
			report.setReportStatus(ReportStatusEnum.HZDS.getValue());
			report.setCreator(TokenManager.getToken().getAccount());
			report.setManager(sumManager);
			dao.add(report);
			//更新汇总ID
			dao.updateGatherId(report);
		} else {
			//更新状态
			report.setReportStatus(ReportStatusEnum.HZDS.getValue());
			report.setManager(sumManager);
			report.setCreator(TokenManager.getToken().getAccount());
			dao.update(report);


			//清楚汇总ID
			dao.clearGatherId(report.getId());
			//更新汇总ID
			dao.updateGatherId(report);
		}

//				if(reportName.equals(ReportNameEnum.SWTZ.getValue()) || reportName.equals(ReportNameEnum.BZW.getValue())){
//
//				} else {
//					//发送OA审核流程
//					sysOAService.LaunchedAudit(
//							monthId,
//							TokenManager.getToken().getId(),
//							report.getReportMonth()+report.getReportName()+"汇总待审",
//							new SysProcessMapper("T_REPORT_MONTH", "REPORT_STATUS", "汇总通过:汇总驳回"));
//				}

		actionResultModel.setSuccess(true);
		return actionResultModel;
	}

	@Override
	public int appSumBack(String reportMonth, String reportName) {
		Map map = new HashMap();
		map.put("reportMonth", reportMonth);
		map.put("reportName", reportName);
		return dao.appSumBack(map);
	}

	@Override
	public int sumOA(ReportMonth report) {
		Map map = new HashMap();
		map.put("id", report.getId());
		map.put("status", ReportStatusEnum.OASUM.getValue());
		String fileCode = exprotAnyExcel(report.getId(),"sum");
				//发送OA审核流程
		sysOAService.LaunchedAudit(report.getId(), TokenManager.getToken().getId(),
							report.getReportMonth()+report.getReportName()+"汇总待审",
				String.format("http://%s:%s%s/", request.getServerName(),request.getServerPort(),request.getContextPath()) + "files/code/" + fileCode,

							new SysProcessMapper("T_REPORT_MONTH", "REPORT_STATUS", "汇总通过:汇总驳回"));
		return dao.updateStatus(map);
	}

	@Override
	public SysUser getUserInfoByAccount(String account) {
		return dao.getUserInfoByAccount(account);
	}

	@Override
	public List<ReportMonth> fillTableQuery(Map<String, Object> param) {
		return dao.fillTableQuery(param);
	}

	@Override
	public int fillTableQueryCount(Map<String, Object> param) {
		return dao.fillTableQueryCount(param);
	}

	@Override
	public int queryReportMonthCount(Map<String, Object> param) {
		return dao.queryReportMonthCount(param);
	}

	@Override
	public LayPage<StorageWarehouse> kudianPageQuery(HttpServletRequest request) {
		LayPage<StorageWarehouse> page=new LayPage<>();
		HashMap<String,String> maps = QueryUtil.pageQuery(request);
		maps.put("warehouseName", request.getParameter("warehouseName"));
		maps.put("warehouseShort", request.getParameter("warehouseShort"));
		maps.put("enterpriseName", request.getParameter("enterpriseName"));
		int count = dao.kudianPageCount(maps);

		if (count<=0) {
			return page;
		}

		List<StorageWarehouse> data= dao.kudianPageQuery(maps);

		page.setCount(count);
		page.setData(data);
		page.setCode(0);
		page.setMsg("");
		return page;
	}

	@Override
	public List<ReportMonth> queryReportMonth(Map<String, Object> param) {
		return dao.queryReportMonth(param);
	}


	@Override
	public void reportSwtz(String reportId){
		String url = BusinessConstants.REMOTE_BASE_URL + "/api/receive/swtz.do";

		List<ReportSwtz> reportSwtzList = swtzDao.listSumSwtzByReportId(reportId);
		List<Map<String, Object>> body = new ArrayList<>();
		for(ReportSwtz reportSwtz : reportSwtzList){
			Map<String, Object> data = new HashMap<>();
			data.put("reportMonth",reportSwtz.getReportMonth());
			data.put("reportName",reportSwtz.getReportName());
			data.put("bgrainWarehouseId",reportSwtz.getExtendsWarehouseId());
			data.put("warehouseName",reportSwtz.getReportWarehouse());	    // 库点名称不确定
			data.put("storehouseName", reportSwtz.getStorehouse());	// 仓号
			data.put("variety",reportSwtz.getVariety());
			data.put("varietyType",StringUtils.indexOf("油", reportSwtz.getVariety())==-1?"01":"02");	// 判断粮食还是油
			data.put("quantity",reportSwtz.getQuantity());
			data.put("origin",reportSwtz.getOrigin());
			data.put("harvestYear",reportSwtz.getHarvestYear());
			data.put("brown",reportSwtz.getBrown());
			data.put("unitWeight",reportSwtz.getUnitWeight());
			data.put("impurity",reportSwtz.getImpurity());
			data.put("dew",reportSwtz.getDew());
			data.put("yellowRice",reportSwtz.getYellowRice());
			data.put("unsoundGrain",reportSwtz.getUnsoundGrain());
			data.put("wetGluten",reportSwtz.getWetGluten());
			data.put("koh",reportSwtz.getKoh());
			data.put("mmol",reportSwtz.getMmol());
			data.put("advisedDeposit",reportSwtz.getAdvisedDeposit());
			data.put("slightlyUnsuitable",reportSwtz.getSlightlyUnsuitable());
			data.put("severeUnsuitable",reportSwtz.getSevereUnsuitable());
			data.put("ordernum",reportSwtz.getOrdernum());
			data.put("packing",reportSwtz.getPacking());
			data.put("bulk", reportSwtz.getPacking());
			data.put("dealSerial", reportSwtz.getDealSerial());
			data.put("enterpriseId", BusinessConstants.ENTERPRISE_ID);
			body.add(data);
		}
		HttpUtil.postJson(url, com.alibaba.fastjson.JSONObject.toJSONString(body));


	}

	@Override
	public int changeStatus(Map<String,Object> ids) {
		return dao.changeStatus(ids);
	}
}
