package com.dhc.fastersoft.service;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.identity.Group;
import org.activiti.engine.identity.User;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.task.Task;
import org.springframework.stereotype.Component;

@Component
public interface ActivitiService {
	
	public void createUser(HttpServletRequest request);
	
	/** 
	* @Title: getGroups 
	* @Description: 工作流人员组
	*/ 
	public List<Group> getGroups();
	
	/** 
	* @Title: login 
	* @Description: activiti的人员登录
	*/ 
	public boolean login(HttpServletRequest request);
	
	/** 
	* @Title: getUserInfo 
	* @Description: 工作流人员信息
	*/ 
	public User getUserInfo(HttpServletRequest request);
	
	 /**部署流程定义*/  
	public Deployment createDeploymentProcessDefinition(String name);
	
    /** 
     * 查询部署列表 
     * @return 
     */ 
	public List<Deployment> queryDeployment();
	
    /** 
     * 查询流程定义列表 
     */ 
	public void queryProcessDefinition();
	
    /** 
     * 删除部署信息 
     */  
	public void deleteDeployment(String deploymentId);
	
    /** 
     * 启动流程实例 
     */  
	public void startProcessInstance(String processDefinitionId,Map<String, Object> variables);
	
    /**
     * 查询进行流程实例列表
     * */
	public void processInstanceQuery(String processDefinitionKey);
	
    /**
     * 查询进行流程实例列表(单一)
     * */
	public ProcessDefinition queryProcessDefinitionSingle(String deploymentId);
	
	 /**
     * 结束流程实例
     * */
	public void deleteProcessInstance(String processInstanceId,String reason);
	
	/**查询进行的任务*/
	public List<Task> queryTask();
	
	/**查询当前的个人任务(实际就是查询act_ru_task表)*/  
	public void findTaskByAssignee(String assignee);
	
	 /** 
     * 完成我的任务 
     */  
	public void completeTaskByTaskId(String taskId);
	
	/** 
     * 查询历史活动数据列表 
	 * @return 
     */  
	public List<HistoricActivityInstance> queryHistoricActivityInstance();
	
	  /** 
     * 查询历史任务数据列表 
     */ 
	 public void queryHistoricTaskInstance();
	 
	 /**流程图图片展示 
	  * */
	 public InputStream viewShow(String deploymentId);	 
	 public InputStream viewShow(String taskId,String deploymentId,String processInstanceId);

}
