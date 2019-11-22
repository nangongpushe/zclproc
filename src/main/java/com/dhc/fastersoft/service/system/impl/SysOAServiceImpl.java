package com.dhc.fastersoft.service.system.impl;

import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.system.SysOADao;
import com.dhc.fastersoft.dao.system.SysOAProcessHistoryDao;
import com.dhc.fastersoft.dao.system.SysProcessMapperDao;
import com.dhc.fastersoft.entity.system.SysOAProcessHistory;
import com.dhc.fastersoft.entity.system.SysProcessMapper;
import com.dhc.fastersoft.service.system.SysOAService;
import com.dhc.fastersoft.utils.DateUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
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

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.*;

@Service("SysOAService")
public class SysOAServiceImpl implements SysOAService {
	
	@Autowired
	private SysOADao sysOADao;
	@Autowired
	private SysProcessMapperDao sysProcessMapperDao;
	@Autowired
	private SysOAProcessHistoryDao oaProcessHistoryDao; 
	
	private HttpClient request;
	private Properties prop = new Properties();
	private String Host = new String();
	static File logFile = new File("OAProcessLog.txt");
	{
		request = HttpClients.createDefault();
		try {
			prop.load(this.getClass().getResourceAsStream("/OATable.properties"));
			Host = prop.getProperty("OA_HOST").toString().trim();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	@Override
	public boolean LaunchedAuditAndFileAndParam(String parameterType,String businessKey,String initiator,String bt,String annex,String file,SysProcessMapper processMapper){
		//获取该流程是否已走过OA审核流程，如果存在则更新OA的流程ID
		HashMap<String, Object> map = new HashMap<>();
		map.put("bussinessId", businessKey);
		map.put("tableMapper", processMapper.getTableMapper());
//		map.put("tableMapper", "T_REPORT_MONTH");//退回只针对报表操作
		map.put("fieldName", processMapper.getFieldName());
		map.put("fieldValue", processMapper.getFieldValue());
		SysProcessMapper sysProcessMapper = sysProcessMapperDao.GetSysProcessMapper(map);
		String processId = "";
		if (sysProcessMapper != null){
			processId = sysProcessMapper.getProcessId();
		}
		//设置请求URI和请求方式
		HttpPost post = new HttpPost(Host + "oa/rs/bpm/startProcess");
		List<NameValuePair> list = new ArrayList<>();
		//设置传输数据
		String dateStr = DateUtil.DateToString(Calendar.getInstance().getTime(), DateUtil.LONG_DATE_FORMAT);
		String fwzh = dateStr.replaceAll("-", "");
		switch(TokenManager.getToken().getOriginCode().toUpperCase()) {
			case "CBL":
				if(annex==null) {
					list.add(new BasicNameValuePair("processDefinitionKey","companyfawen_v1"));
					list.add(new BasicNameValuePair("parameters",String.format(SysOAService.COMPANYFAWEN_PARAMETERS, fwzh,bt)));
				}else {
					if("1".equals(parameterType)){
						list.add(new BasicNameValuePair("processDefinitionKey","companyfawen_v1"));
						list.add(new BasicNameValuePair("parameters", String.format(SysOAService.COMPANYASKING_PARAMETERS1, TokenManager.getToken().getId(), TokenManager.getToken().getDepartment(), bt, dateStr, annex != null ? annex : "", file != null ? file : "")));
					}else {
						list.add(new BasicNameValuePair("processDefinitionKey", "companyAsking_v1"));
						list.add(new BasicNameValuePair("parameters", String.format(SysOAService.COMPANYASKING_PARAMETERS1, TokenManager.getToken().getId(), TokenManager.getToken().getDepartment(), bt, dateStr, annex != null ? annex : "", file != null ? file : "")));
					}
					}
				break;
			default:
				list.add(new BasicNameValuePair("processDefinitionKey","librarycompanyAsking_v1"));
				list.add(new BasicNameValuePair("parameters",String.format(SysOAService.LIBRARYFAWEN_PARAMETERS1,TokenManager.getToken().getId(),TokenManager.getToken().getDepartment(), fwzh,bt,dateStr,annex!=null?annex:"",file!=null?file:"")));

				break;
		}
		System.out.println(annex);
		list.add(new BasicNameValuePair("businessKey",businessKey));
		list.add(new BasicNameValuePair("initiator",initiator));

//		list.add(new BasicNameValuePair("processVersion","0"));
		System.out.println(list.toString());


		UrlEncodedFormEntity entity = null;
		try {
			//设置默认编码为
			entity = new UrlEncodedFormEntity(list,SysOAService.CHARSET_ENCODING);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		post.setEntity(entity);
		HttpResponse response = null;
		Date startTime = Calendar.getInstance().getTime();
		try {
			response = request.execute(post);
		} catch (IOException e) {
			e.printStackTrace();
		}
		post.releaseConnection();
		if(response != null) {
			HttpEntity httpEntity = response.getEntity();
			Date endTime = Calendar.getInstance().getTime();
			JSONObject returnData = null;
			try {
				returnData = JSONObject.fromObject(EntityUtils.toString(httpEntity,"utf-8"));
				SysOAProcessHistory log = new SysOAProcessHistory(startTime, endTime, returnData.toString());
				Throwable ex = new Throwable();
				StackTraceElement[] stackElements = ex.getStackTrace();
				for (StackTraceElement item : stackElements) {
					if(item.getClassName().indexOf("Controller") != -1) {
						String strackTrace = "类:"+item.getClassName()+"  "+
								"方法:"+item.getMethodName()+"  "+
								"行:"+item.getLineNumber()+"  "+
								"参数:"+JSONArray.fromObject(list);
						log.setStrackTrace(strackTrace);
						break;
					}
				}
				oaProcessHistoryDao.AddLog(log);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(response.getStatusLine().getStatusCode() == HttpStatus.OK.value()) {
				processMapper.setProcessId(returnData.getString("data"));
				processMapper.setBussinessId(businessKey);
				if (sysProcessMapper == null){
					sysProcessMapperDao.AddSysProcessMapper(processMapper);
				}

				return true;
			}
		}
		return false;
	}
    @Override
    public boolean LaunchedAuditAndFile(String businessKey, String initiator, String bt, String annex, String file, SysProcessMapper processMapper) {
		//获取该流程是否已走过OA审核流程，如果存在则更新OA的流程ID
		HashMap<String, Object> map = new HashMap<>();
		map.put("bussinessId", businessKey);
		map.put("tableMapper", processMapper.getTableMapper());
//		map.put("tableMapper", "T_REPORT_MONTH");//退回只针对报表操作
		map.put("fieldName", processMapper.getFieldName());
		map.put("fieldValue", processMapper.getFieldValue());
		SysProcessMapper sysProcessMapper = sysProcessMapperDao.GetSysProcessMapper(map);
		String processId = "";
		if (sysProcessMapper != null){
			processId = sysProcessMapper.getProcessId();
		}
        //设置请求URI和请求方式
        HttpPost post = new HttpPost(Host + "oa/rs/bpm/startProcess");
        List<NameValuePair> list = new ArrayList<>();
        //设置传输数据
        String dateStr = DateUtil.DateToString(Calendar.getInstance().getTime(), DateUtil.LONG_DATE_FORMAT);
        String fwzh = dateStr.replaceAll("-", "");
        switch(TokenManager.getToken().getOriginCode().toUpperCase()) {
            case "CBL":
                if(annex==null) {
                    list.add(new BasicNameValuePair("processDefinitionKey","companyfawen_v1"));
                    list.add(new BasicNameValuePair("parameters",String.format(SysOAService.COMPANYFAWEN_PARAMETERS, fwzh,bt)));
                }else {
                    list.add(new BasicNameValuePair("processDefinitionKey","companyAsking_v1"));
                    list.add(new BasicNameValuePair("parameters",String.format(SysOAService.COMPANYASKING_PARAMETERS1, TokenManager.getToken().getId(),TokenManager.getToken().getDepartment(),bt,dateStr,annex!=null?annex:"",file!=null?file:"")));
                }
                break;
            default:
                list.add(new BasicNameValuePair("processDefinitionKey","librarycompanyAsking_v1"));
                list.add(new BasicNameValuePair("parameters",String.format(SysOAService.LIBRARYFAWEN_PARAMETERS1,TokenManager.getToken().getId(),TokenManager.getToken().getDepartment(), fwzh,bt,dateStr,annex!=null?annex:"",file!=null?file:"")));

                break;
        }
        System.out.println(annex);
        list.add(new BasicNameValuePair("businessKey",businessKey));
        list.add(new BasicNameValuePair("initiator",initiator));

//		list.add(new BasicNameValuePair("processVersion","0"));
        System.out.println(list.toString());


        UrlEncodedFormEntity entity = null;
        try {
            //设置默认编码为
            entity = new UrlEncodedFormEntity(list,SysOAService.CHARSET_ENCODING);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        post.setEntity(entity);
        HttpResponse response = null;
        Date startTime = Calendar.getInstance().getTime();
        try {
            response = request.execute(post);
        } catch (IOException e) {
            e.printStackTrace();
        }
		post.releaseConnection();
        if(response != null) {
            HttpEntity httpEntity = response.getEntity();
            Date endTime = Calendar.getInstance().getTime();
            JSONObject returnData = null;
            try {
                returnData = JSONObject.fromObject(EntityUtils.toString(httpEntity,"utf-8"));
                SysOAProcessHistory log = new SysOAProcessHistory(startTime, endTime, returnData.toString());
                Throwable ex = new Throwable();
                StackTraceElement[] stackElements = ex.getStackTrace();
                for (StackTraceElement item : stackElements) {
                    if(item.getClassName().indexOf("Controller") != -1) {
                        String strackTrace = "类:"+item.getClassName()+"  "+
                                "方法:"+item.getMethodName()+"  "+
                                "行:"+item.getLineNumber()+"  "+
                                "参数:"+JSONArray.fromObject(list);
                        log.setStrackTrace(strackTrace);
                        break;
                    }
                }
                oaProcessHistoryDao.AddLog(log);
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
			if(response.getStatusLine().getStatusCode() == HttpStatus.OK.value()) {
				processMapper.setProcessId(returnData.getString("data"));
				processMapper.setBussinessId(businessKey);
				if (sysProcessMapper == null){
					sysProcessMapperDao.AddSysProcessMapper(processMapper);
				}

				return true;
			}
        }
        return false;
    }

    @Override
	public boolean LaunchedAudit(String businessKey, String initiator, String bt, String annex,SysProcessMapper processMapper) {
		//获取该流程是否已走过OA审核流程，如果存在则更新OA的流程ID
		HashMap<String, Object> map = new HashMap<>();
		map.put("bussinessId", businessKey);
		map.put("tableMapper", processMapper.getTableMapper());
//		map.put("tableMapper", "T_REPORT_MONTH");//退回只针对报表操作
		map.put("fieldName", processMapper.getFieldName());
		map.put("fieldValue", processMapper.getFieldValue());
		SysProcessMapper sysProcessMapper = sysProcessMapperDao.GetSysProcessMapper(map);
		String processId = "";
		if (sysProcessMapper != null){
			processId = sysProcessMapper.getProcessId();
		}

		//设置请求URI和请求方式
		HttpPost post = new HttpPost(Host + "oa/rs/bpm/startProcess");
		List<NameValuePair> list = new ArrayList<>();
		//设置传输数据
		String dateStr = DateUtil.DateToString(Calendar.getInstance().getTime(), DateUtil.LONG_DATE_FORMAT);
		String fwzh = dateStr.replaceAll("-", "");
		switch(TokenManager.getToken().getOriginCode().toUpperCase()) {
			case "CBL":
//				if(annex==null) {
//					list.add(new BasicNameValuePair("processDefinitionKey","companyfawen_v1"));
//					list.add(new BasicNameValuePair("parameters",String.format(SysOAService.COMPANYFAWEN_PARAMETERS, fwzh,bt)));
//				}else {
					list.add(new BasicNameValuePair("processDefinitionKey","companyAsking_v1"));
					list.add(new BasicNameValuePair("parameters",String.format(SysOAService.COMPANYASKING_PARAMETERS, TokenManager.getToken().getId(),TokenManager.getToken().getDepartment(),bt,dateStr,annex!=null?annex:"")));
//				}
				break;
			default:
				list.add(new BasicNameValuePair("processDefinitionKey","librarycompanyAsking_v1"));
				list.add(new BasicNameValuePair("parameters",String.format(SysOAService.LIBRARYFAWEN_PARAMETERS, TokenManager.getToken().getId(),TokenManager.getToken().getDepartment(),fwzh,bt,dateStr,annex!=null?annex:"")));
				break;
		}
		System.out.println(annex);
		list.add(new BasicNameValuePair("businessKey",businessKey));
		list.add(new BasicNameValuePair("initiator",initiator));
		list.add(new BasicNameValuePair("taskId",processId)); //第一次传空,退回后再审时要传bussinessId

//		list.add(new BasicNameValuePair("processVersion","0"));
		System.out.println(list.toString());


		UrlEncodedFormEntity entity = null;
		try {
			//设置默认编码为
			entity = new UrlEncodedFormEntity(list,SysOAService.CHARSET_ENCODING);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}  
        post.setEntity(entity);  
        HttpResponse response = null;
        Date startTime = Calendar.getInstance().getTime();
        try {
        	response = request.execute(post);
		} catch (IOException e) {
			e.printStackTrace();
		}
		post.releaseConnection();
        if(response != null) {
        	HttpEntity httpEntity = response.getEntity();
        	Date endTime = Calendar.getInstance().getTime();
        	JSONObject returnData = null;
			try {
				returnData = JSONObject.fromObject(EntityUtils.toString(httpEntity,"utf-8"));
				SysOAProcessHistory log = new SysOAProcessHistory(startTime, endTime, returnData.toString());
				Throwable ex = new Throwable();
				StackTraceElement[] stackElements = ex.getStackTrace();
				for (StackTraceElement item : stackElements) {
					if(item.getClassName().indexOf("Controller") != -1) {
						String strackTrace = "类:"+item.getClassName()+"  "+
											"方法:"+item.getMethodName()+"  "+
											"行:"+item.getLineNumber()+"  "+
											"参数:"+JSONArray.fromObject(list);
						log.setStrackTrace(strackTrace);
						break;
					}
				}
				oaProcessHistoryDao.AddLog(log);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	if(response.getStatusLine().getStatusCode() == HttpStatus.OK.value()) {
				processMapper.setProcessId(returnData.getString("data"));
				processMapper.setBussinessId(businessKey);
				if (sysProcessMapper == null){
					sysProcessMapperDao.AddSysProcessMapper(processMapper);
				}

        		return true;
        	}
        }
		return false;
	}

	@Override
	public boolean SendMessage(String userId, String type, String subject, String content, String fromSystem) {
		StringBuilder param = new StringBuilder();
		param.append("userId="+userId+"&");
		param.append("type="+type+"&");
		param.append("subject="+subject+"&");
		param.append("content="+content+"&");
		param.append("fromSystem=production");
		System.out.println(Host + "oa/rs/notification/sendNotice?"+param.toString());

		HttpGet get = new HttpGet(Host + "oa/rs/notification/sendNotice?"+param.toString());
		HttpResponse response = null;

        try {
        	response = request.execute(get);
		}catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		get.releaseConnection();
        if(response != null) {
        	if(response.getStatusLine().getStatusCode() == HttpStatus.OK.value()) {
        		return true;
        	}
        }
		return false;
	}

	@Override
	public int updateStatus(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return sysOADao.updateStatus(map);
	}


}
