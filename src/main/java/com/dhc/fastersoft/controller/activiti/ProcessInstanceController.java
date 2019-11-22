package com.dhc.fastersoft.controller.activiti;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.activiti.engine.FormService;
import org.activiti.engine.IdentityService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.form.FormProperty;
import org.activiti.engine.identity.User;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Comment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
* @ClassName: ProcessInstanceController
* @Description: 實例操作控制類
* @author zby
* @date 2017年9月28日 
* 
*/

@RequestMapping("/processInstance")
@Controller
public class ProcessInstanceController {
	
	@Autowired
	RuntimeService runtimeService;
	
	@Autowired
	FormService formService;
	
	@Autowired
	TaskService taskService;
	
	@Autowired
	IdentityService identityService;
	
	@Autowired
	RepositoryService repositoryService;
	
	//实例列表
	@RequestMapping("/processInstanceList")
	public String processInstanceList(HttpServletRequest request){
		List<ProcessInstance> processInstances = runtimeService.createProcessInstanceQuery().list();
		request.setAttribute("processInstances", processInstances);
		return "processInstance/processInstance-list";
	}
	
	//开始实例准备信息
	@RequestMapping("/startProcessInstance")
	public String processInstance(HttpServletRequest request,Model model,@RequestParam String deploymentId){
		ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
				.deploymentId(deploymentId).singleResult();
		
		List<FormProperty> formPropertielList = formService.getStartFormData(processDefinition.getId())
												.getFormProperties();
		request.setAttribute("formPropertielList", formPropertielList);
		request.setAttribute("processDefinition", processDefinition);
		return "processInstance/processInstance-start";
	}
	
	//开始实例
	@RequestMapping("/beginProcessInstance")	
	public String startProcessInstance(HttpServletRequest request,Model model,HttpSession session){
		User user = (User) session.getAttribute("user");
		Map<String, Object> variables = new HashMap<String, Object>();
		String processDefinitionId = request.getParameter("processDefinitionId");
		List<FormProperty> formPropertielList = formService.getStartFormData(processDefinitionId)
				.getFormProperties();
		/*		Map<String, String> properties = new HashMap<String, String>();
		for (FormProperty formProperty : formPropertielList) {
			properties.put(formProperty.getId(), request.getParameter(formProperty.getId()));
		}
		formService.submitStartFormData(processDefinitionId, properties);*/	
		for (FormProperty formProperty : formPropertielList) {
			variables.put(formProperty.getId(), request.getParameter(formProperty.getId()));
		}
		identityService.setAuthenticatedUserId(user.getId());
		runtimeService.startProcessInstanceById(processDefinitionId, variables);
		return "redirect:/processInstance/processInstanceList.do";
	}
	
	//删除实例
	@RequestMapping("/deleteProcessInstance")	
	public String deleteProcessInstance(HttpServletRequest request,Model model,HttpSession session,@RequestParam String processInstanceId){
		
		String deleteReason = request.getParameter("deleteReason");
		runtimeService.deleteProcessInstance(processInstanceId, deleteReason);
		return "redirect:/processInstance/processInstanceList.do";
	}
	
	//挂起实例
	@RequestMapping("/suspendProcessInstance")	
	public String suspendProcessInstance(HttpServletRequest request,Model model,HttpSession session,@RequestParam String processInstanceId){
		
		runtimeService.suspendProcessInstanceById(processInstanceId);
		return "redirect:/processInstance/processInstanceList.do";
	}
	
	//激活实例
	@RequestMapping("/activateProcessInstance")	
	public String activateProcessInstance(HttpServletRequest request,Model model,HttpSession session,@RequestParam String processInstanceId){
		
		runtimeService.activateProcessInstanceById(processInstanceId);
		return "redirect:/processInstance/processInstanceList.do";
	}
	
	@RequestMapping("/comment")
	public String comment(HttpServletRequest request,@RequestParam String processInstanceId,HttpServletResponse response){
		List<Comment> comments = taskService.getProcessInstanceComments(processInstanceId);
/*		JSONArray jsonArray = new JSONArray();
		for (Comment comment : comments) {
			jsonArray.add(comment);
		}
		try {
			response.setContentType("text/html;charset=UTF-8");
			response.getWriter().print(jsonArray.toJSONString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		request.setAttribute("comments", comments);
		return "processInstance/comment";
	}
}
