package com.dhc.fastersoft.service.impl;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.activiti.bpmn.model.BpmnModel;
import org.activiti.engine.IdentityService;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngines;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricActivityInstance;
import org.activiti.engine.history.HistoricActivityInstanceQuery;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.history.HistoricTaskInstanceQuery;
import org.activiti.engine.identity.Group;
import org.activiti.engine.identity.User;
import org.activiti.engine.impl.cfg.ProcessEngineConfigurationImpl;
import org.activiti.engine.impl.context.Context;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.DeploymentBuilder;
import org.activiti.engine.repository.DeploymentQuery;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.runtime.ProcessInstanceQuery;
import org.activiti.engine.task.Task;
import org.activiti.image.ProcessDiagramGenerator;
import org.springframework.stereotype.Service;

import com.dhc.fastersoft.service.ActivitiService;

@Service("activitiService")
public class ActivitiServiceImpl implements ActivitiService{
	
	ProcessEngine processEngine=ProcessEngines.getDefaultProcessEngine();
	
	public void createUser(HttpServletRequest request){
		IdentityService identityService = processEngine.getProcessEngineConfiguration().getIdentityService();
		User user = identityService.newUser(request.getParameter("userName"));
		user.setPassword(request.getParameter("password"));
		user.setEmail(request.getParameter("email"));
		user.setFirstName(request.getParameter("firstName"));
		user.setLastName(request.getParameter("lastName"));	
		String groupId = request.getParameter("groupId");
		identityService.setUserInfo(user.getId(), "groupId", groupId);
		identityService.saveUser(user);
		identityService.createMembership(user.getId(),groupId);
	
	}
	
	public List<Group> getGroups(){
		List<Group> list = processEngine.getIdentityService().createGroupQuery().list();
		return list;
	}
	
	public void createGroup(HttpServletRequest request){
		Group group = processEngine.getIdentityService().newGroup(request.getParameter("groupId"));
		group.setName(request.getParameter("groupName"));
		group.setType(request.getParameter("type"));
		processEngine.getIdentityService().saveGroup(group);
	}
	
	public boolean login(HttpServletRequest request){
		IdentityService inIdentityService = processEngine.getProcessEngineConfiguration().getIdentityService();
		
		Boolean check = inIdentityService.checkPassword(request.getParameter("userName"), request.getParameter("password"));
		return check;
	}
	
	public User getUserInfo(HttpServletRequest request){
		IdentityService inIdentityService = processEngine.getProcessEngineConfiguration().getIdentityService();
		User user = inIdentityService.createUserQuery().userId(request.getParameter("userName")).singleResult();		
		return user;
	}
	
	public Deployment createDeploymentProcessDefinition(String name) {
		//与流程定义和部署对象相关的Service  
        RepositoryService repositoryService=processEngine.getRepositoryService();  
          
        DeploymentBuilder deploymentBuilder=repositoryService.createDeployment();//创建一个部署对象  
        deploymentBuilder.name(name);//添加部署的名称  
          
        Deployment deployment=deploymentBuilder.deploy();//完成部署  
          
        //打印我们的流程信息  
        System.out.println("流程Id:"+deployment.getId());  
        System.out.println("流程Name:"+deployment.getName());
		return deployment;  
		
	}

	public List<Deployment> queryDeployment() {
		 // 部署查询对象，查询表act_re_deployment  
        DeploymentQuery query = processEngine.getRepositoryService()  
                .createDeploymentQuery();  
        List<Deployment> list = query.list(); 
        if("".equals(list)||list.size()==0){
        	System.out.println("没有部署列表");
        }else{
            for (Deployment deployment : list) {  
                System.out.println("正在进行的流程Id:"+deployment.getId());  
                System.out.println("正在进行的流程Name:"+deployment.getName()); 
            }  
        }
        
		return list;
	}
	
	public ProcessDefinition queryProcessDefinitionSingle(String deploymentId) {
		  // 流程定义查询对象，查询表act_re_procdef  
	        ProcessDefinitionQuery processDefinition = processEngine.getRepositoryService()  
	                .createProcessDefinitionQuery()
	                .orderByProcessDefinitionVersion().desc().deploymentId(deploymentId);  
	        List<ProcessDefinition> list = processDefinition.list();
	        if("".equals(list)||list.size()==0){
	        	System.out.println("没有流程定义列表");
	        	}else{
		        for (ProcessDefinition pd : list) {  
		            System.out.println("*** 流程定义ID:" + pd.getId() +"*** 流程定义name:"+pd.getName() + 
		            		"*** 所属的部署ID:" +pd.getDeploymentId());  
	        }  
	        }
	        return list.get(0);
			
		}

	public void queryProcessDefinition() {
	  // 流程定义查询对象，查询表act_re_procdef  
        ProcessDefinitionQuery query = processEngine.getRepositoryService()  
                .createProcessDefinitionQuery();  
        List<ProcessDefinition> list = query.list(); 
        if("".equals(list)||list.size()==0){
        	System.out.println("没有流程定义列表");
        	}else{
	        for (ProcessDefinition pd : list) {  
	            System.out.println("*** 流程定义ID:" + pd.getId() +"*** 流程定义name:"+pd.getName() + 
	            		"*** 所属的部署ID:" +pd.getDeploymentId());  
        }  
        }
		
	}

	public void deleteDeployment(String deploymentId) {
		  processEngine.getRepositoryService().deleteDeployment(deploymentId,//级联删除,通过删除部署信息达到删除流程定义的目的,删除流程定义使用相同方法
	                true);  
		System.out.println("删除的部署ID是："+deploymentId);
	}

	/*开始流程实例*/
	public void startProcessInstance(String processDefinitionId,Map<String, Object> variables) {
		 ProcessInstance pi = processEngine.getRuntimeService()// 于正在执行的流程实例和执行对象相关的Service  
	                .startProcessInstanceById(processDefinitionId,variables);// 使用流程定义的key启动流程实例，key对应hellworld.bpmn文件中id的属性值，使用key值启动，默认是按照最新版本的流程定义启动  
		 
		 System.out.println("流程实例ID:" + pi.getId());
	        System.out.println("流程定义ID:" + pi.getProcessDefinitionId()); 
	}

	public void processInstanceQuery(String processDefinitionKey) {
		 //流程实例查询对象，查询act_ru_execution表  
        ProcessInstanceQuery query = processEngine.getRuntimeService().createProcessInstanceQuery();  
        query.processDefinitionKey(processDefinitionKey);  
        query.orderByProcessInstanceId().desc();  
        query.listPage(0, 10);//分页  
        List<ProcessInstance> list = query.list();  
        for (ProcessInstance pi : list) {  
            System.out.println("正执行的事例ID："+pi.getId() + "*** 所属的流程：" + pi.getProcessDefinitionId() +"*** 开始的ActivityId:"+pi.getActivityId());  
        }  
		
	}

	public void deleteProcessInstance(String processInstanceId,String reason) {
		processEngine.getRuntimeService().deleteProcessInstance(processInstanceId , reason); 
		System.out.println("结束的流程ID是："+processInstanceId);
		System.out.println("结束的原因是："+reason);
	}
	
	public List<Task> queryTask() {
		
		List<Task> tasks =  processEngine.getTaskService().createTaskQuery().list();
    	for (Task task:tasks) {
    		System.out.println("执行ID:"+task.getId());  
    	
    	}
    	return tasks;
		
	}

	public void findTaskByAssignee(String assignee) {
		//获取事务Service  
        TaskService taskService=processEngine.getTaskService();  
        List<Task> taskList=taskService.createTaskQuery()//创建任务查询对象  
                   .taskAssignee(assignee)//指定个人任务查询，指定办理人  
                   .list();//获取该办理人下的事务列表  
          
        if(taskList!=null&&taskList.size()>0){  
            for(Task task:taskList){  
                System.out.println("任务ID："+task.getId());  
                System.out.println("任务名称："+task.getName());  
                System.out.println("任务的创建时间："+task.getCreateTime());  
                System.out.println("任务办理人："+task.getAssignee());  
                System.out.println("流程实例ID："+task.getProcessInstanceId());  
                System.out.println("执行对象ID："+task.getExecutionId());  
                System.out.println("流程定义ID："+task.getProcessDefinitionId());  
                System.out.println("#############################################");  
            }  
        }  
		
	}

	public void completeTaskByTaskId(String taskId) {
        processEngine.getTaskService()//与正在执行的认为管理相关的Service  
                .complete(taskId); 
        
/*        processEngine.getIdentityService().setAuthenticatedUserId(userId);
        processEngine.getTaskService().addComment(taskId, processInstanceId, message);*/
        System.out.println("完成任务:任务ID:"+taskId);  
		
	}

	public List<HistoricActivityInstance> queryHistoricActivityInstance() {
		   HistoricActivityInstanceQuery query = processEngine.getHistoryService()  
	                .createHistoricActivityInstanceQuery();  
	        // 按照流程实例排序  
	        query.orderByProcessInstanceId().desc();  
	        query.orderByHistoricActivityInstanceEndTime().asc();  
	        List<HistoricActivityInstance> list = query.list();  
	        for (HistoricActivityInstance hi : list) {  
	            System.out.println("ActivityId："+hi.getActivityId()+"*** Assignee:"+hi.getAssignee() + "*** ActivityName" + hi.getActivityName()  
	                    + "*** ActivityType：" + hi.getActivityType()+"*** ExecutionId:"+hi.getExecutionId()+"*** StartTime"+hi.getStartTime()
	                    + "*** EndTime"+hi.getEndTime());  
	        }  
		return list;
	}

	public void queryHistoricTaskInstance() {
		 HistoricTaskInstanceQuery query = processEngine.getHistoryService()  
	                .createHistoricTaskInstanceQuery();  
	        query.orderByProcessInstanceId().asc();  //根据ProcessInstanceId升序
	        query.orderByHistoricTaskInstanceEndTime().desc();  //结束时间降序
	        
	        List<HistoricTaskInstance> list = query.list();  
	        for (HistoricTaskInstance hi : list) {  
	            System.out.println("执行ID：" + hi.getId()+"*** 关键人KEY："+hi.getAssignee() + "*** 执行事件:" + hi.getName() + "*** 开始时间："  
	                    + hi.getStartTime()+"*** 结束时间："+ hi.getEndTime() + "*** ExecutionId:"+hi.getExecutionId() 
	                    + "*** 结束原因："+hi.getDeleteReason()+"*** 所属实例："+hi.getProcessInstanceId());  
	        }  		
	}
	
           

	public InputStream viewShow(String deploymentId) {
		 ProcessDefinitionQuery processDefinition = processEngine.getRepositoryService()  
	                .createProcessDefinitionQuery().deploymentId(deploymentId);  //根据部署ID查询
		 ProcessDiagramGenerator diagramGenerator = processEngine.getProcessEngineConfiguration().getProcessDiagramGenerator();
		 BpmnModel bpmnModel = processEngine.getRepositoryService().getBpmnModel(processDefinition.list().get(0).getId());
		 InputStream imageStream = diagramGenerator.generateDiagram(bpmnModel,"png","宋体","宋体",null,null, 1.0);
		 return imageStream;
	}	
	
	public InputStream viewShow(String taskId,String processDefinitionId,String processInstanceId) {
		 Context.setProcessEngineConfiguration((ProcessEngineConfigurationImpl) processEngine.getProcessEngineConfiguration());
		 //创建画图实例
		 ProcessDiagramGenerator diagramGenerator = processEngine.getProcessEngineConfiguration().getProcessDiagramGenerator();
		 //查询画图的实体
		 ProcessDefinitionEntity definitionEntity = (ProcessDefinitionEntity)processEngine.getRepositoryService() 
	        		.getProcessDefinition(processDefinitionId);
		 //查询流程图的图片
		 BpmnModel bpmnModel = processEngine.getRepositoryService().getBpmnModel(processDefinitionId);
		 //查询所有节点
		 List<HistoricActivityInstance> highLightedActivitList =   processEngine.getHistoryService()
				 .createHistoricActivityInstanceQuery().processInstanceId(processInstanceId).list();		 
		 //高亮环节id集合
        List<String> highLightedActivitis = new ArrayList<String>();
        //高亮线路id集合
        List<String> highLightedFlows = getHighLightedFlows(definitionEntity,highLightedActivitList);
        //节点和task组装
        for(HistoricActivityInstance tempActivity : highLightedActivitList){
            String activityId = tempActivity.getActivityId();
            highLightedActivitis.add(activityId);
        }
		 
        //中文乱码，设置字体就好了
        InputStream imageStream = diagramGenerator.generateDiagram(bpmnModel, "png", highLightedActivitis,highLightedFlows,"宋体","宋体",null,null, 1.0);
		 return imageStream;
	}
	
	 /**
     * 获取需要高亮的线
     * @param processDefinitionEntity
     * @param historicActivityInstances
     * @return
     */
    private List<String> getHighLightedFlows(
            ProcessDefinitionEntity processDefinitionEntity,
            List<HistoricActivityInstance> historicActivityInstances) {
        List<String> highFlows = new ArrayList<String>();// 用以保存高亮的线flowId
        for (int i = 0; i < historicActivityInstances.size() - 1; i++) {// 对历史流程节点进行遍历
            ActivityImpl activityImpl = processDefinitionEntity
                    .findActivity(historicActivityInstances.get(i)
                            .getActivityId());// 得到节点定义的详细信息
            List<ActivityImpl> sameStartTimeNodes = new ArrayList<ActivityImpl>();// 用以保存后需开始时间相同的节点
            ActivityImpl sameActivityImpl1 = processDefinitionEntity
                    .findActivity(historicActivityInstances.get(i + 1)
                            .getActivityId());
            // 将后面第一个节点放在时间相同节点的集合里
            sameStartTimeNodes.add(sameActivityImpl1);
            for (int j = i + 1; j < historicActivityInstances.size() - 1; j++) {
                HistoricActivityInstance activityImpl1 = historicActivityInstances
                        .get(j);// 后续第一个节点
                HistoricActivityInstance activityImpl2 = historicActivityInstances
                        .get(j + 1);// 后续第二个节点
                if (activityImpl1.getStartTime().equals(
                        activityImpl2.getStartTime())) {
                    // 如果第一个节点和第二个节点开始时间相同保存
                    ActivityImpl sameActivityImpl2 = processDefinitionEntity
                            .findActivity(activityImpl2.getActivityId());
                    sameStartTimeNodes.add(sameActivityImpl2);
                } else {
                    // 有不相同跳出循环
                    break;
                }
            }
            List<PvmTransition> pvmTransitions = activityImpl
                    .getOutgoingTransitions();// 取出节点的所有出去的线
            for (PvmTransition pvmTransition : pvmTransitions) {
                // 对所有的线进行遍历
                ActivityImpl pvmActivityImpl = (ActivityImpl) pvmTransition
                        .getDestination();
                // 如果取出的线的目标节点存在时间相同的节点里，保存该线的id，进行高亮显示
                if (sameStartTimeNodes.contains(pvmActivityImpl)) {
                    highFlows.add(pvmTransition.getId());
                }
            }
        }
        return highFlows;
    }

}
