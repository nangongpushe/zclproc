package com.dhc.fastersoft.service.system;

import com.dhc.fastersoft.entity.system.SysProcessMapper;

import java.util.HashMap;

public interface SysOAService{
	
	//Host作为OA系统的常量
	String CHARSET_ENCODING = "UTF-8";
	
	public static String COMPANYFAWEN_PARAMETERS = "{\"companyfawen_fwzh\":\"%s\",\"companyfawen_bt\":\"%s\",\"userpicker_zsr\":\"主送-储备粮公司\",\"userpicker_csr\":\"\",\"dictionary_gwlx\":\"请示\",\"companyfawen_mmdj\":\"绝密\"}";
	
	public static String LIBRARYFAWEN_PARAMETERS = "{\"user\": \"%s\",\"department\": \"%s\",\"companyfawen_fwzh\":\"%s\",\"companyfawen_bt\":\"%s\",\"userpicker_zsr\":\"主送-储备粮公司\",\"userpicker_csr\":\"\",\"dictionary_gwlx\":\"请示\",\"companyfawen_mmdj\":\"绝密\",\"departmentpicker_1\":\"所属库部门\",\"officeeditor_bjgw\":\"编辑公文\",\"datepicker_1\":\"%s\",\"officeeditor_excel\": \"%s\"}";
	
	public static String COMPANYASKING_PARAMETERS = "{\"user\": \"%s\",\"department\": \"%s\",\"dictionary_gwlx\": \"请示\",\"companyfawen_bt\": \"%s\",\"userpicker_zsr\": \"主送-储备粮公司\",\"userpicker_csr\": \"\",\"companyfawen_mmdj\": \"绝密\",\"datepicker_1\": \"%s\",\"officeeditor_excel\": \"%s\",\"radio_lcd\":\"否\"}";

	public static String LIBRARYFAWEN_PARAMETERS1 = "{\"user\": \"%s\",\"department\": \"%s\",\"companyfawen_fwzh\":\"%s\",\"companyfawen_bt\":\"%s\",\"userpicker_zsr\":\"主送-储备粮公司\",\"userpicker_csr\":\"\",\"dictionary_gwlx\":\"请示\",\"companyfawen_mmdj\":\"绝密\",\"departmentpicker_1\":\"所属库部门\",\"officeeditor_bjgw\":\"编辑公文\",\"datepicker_1\":\"%s\",\"officeeditor_excel\": \"%s\",\"companyfawen_wj_mores\": \"%s\"}";

	public static String COMPANYASKING_PARAMETERS1 = "{\"user\": \"%s\",\"department\": \"%s\",\"dictionary_gwlx\": \"请示\",\"companyfawen_bt\": \"%s\",\"userpicker_zsr\": \"主送-储备粮公司\",\"userpicker_csr\": \"\",\"companyfawen_mmdj\": \"绝密\",\"datepicker_1\": \"%s\",\"officeeditor_excel\": \"%s\",\"companyfawen_wj_mores\": \"%s\",\"radio_lcd\":\"否\"}";
	/*发文请示*/
	public static String COMPANYFAWEN_PARAMETERS2 = "{\"companyfawen_fwzh\":\"%s\",\"companyfawen_bt\":\"%s\",\"userpicker_zsr\":\"主送-储备粮公司\",\"userpicker_csr\":\"\",\"dictionary_gwlx\":\"请示\",\"companyfawen_mmdj\":\"绝密\",\"officeeditor_excel\":\"%s\"}";
	/**
	 * OA发起流程
	 * @param businessKey 业务主键
	 * @param initiator 发起人,发起人id
	 * @param bt 发文标题
	 * @param processMapper 流程实例映射对象
	 * @return 执行成功与否
	 */
	boolean LaunchedAudit(String businessKey,String initiator,String bt,String annex,SysProcessMapper processMapper);


	/**
	 * OA发起流程
	 * @param businessKey 业务主键
	 * @param initiator 发起人,发起人id
	 * @param bt 发文标题
	 * @param processMapper 流程实例映射对象
	 * @return 执行成功与否
	 */
	boolean LaunchedAuditAndFile(String businessKey,String initiator,String bt,String annex,String file,SysProcessMapper processMapper);
	/**
	 * OA发起流程
	 * @param businessKey 业务主键
	 * @param initiator 发起人,发起人id
	 * @param bt 发文标题
	 * @param processMapper 流程实例映射对象
	 * @return 执行成功与否
	 */
	boolean LaunchedAuditAndFileAndParam(String parameterType,String businessKey,String initiator,String bt,String annex,String file,SysProcessMapper processMapper);
	/**
	 * OA发送站内信
	 * @param userId 用户id
	 * @param type 站内信类型(取值:msg、email)
	 * @param subject 站内信主题
	 * @param content 站内信内容
	 * @param fromSystem 表示来自哪个系统的消息(必传，可以为空串)
	 * @return 执行成功与否
	 */
	boolean SendMessage(String userId,String type,String subject,String content,String fromSystem); 
	
	/**
	 * OA更新状态
	 * @param map
	 * @return
	 */
	int updateStatus(HashMap<String, String> map);
}
