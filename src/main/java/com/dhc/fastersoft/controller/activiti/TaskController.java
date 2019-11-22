package com.dhc.fastersoft.controller.activiti;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.activiti.engine.FormService;
import org.activiti.engine.HistoryService;
import org.activiti.engine.IdentityService;
import org.activiti.engine.TaskService;
import org.activiti.engine.form.FormProperty;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.identity.Group;
import org.activiti.engine.identity.User;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
* @ClassName: TaskController
* @Description: 任務控制類
* @author zby
* @date 2017年9月28日 
* 
*/

@RequestMapping("/task")
@Controller
public class TaskController {
	
	@Autowired
	TaskService taskService;
	
	@Autowired
	HistoryService historyService;
	
	@Autowired
	FormService formService;
	
	@Autowired
	IdentityService identityService;
	
	@RequestMapping("/queryTask")
	public String queryTask(HttpServletRequest request,Model model,HttpSession session){
		Group group = (Group) session.getAttribute("group");		
		List<Task> tasks =  taskService.createTaskQuery().list();
		
		List<User> users = identityService.createUserQuery().list();	
		request.setAttribute("task", tasks);
		request.setAttribute("users", users);
		return "task/task-list";
	}

	@RequestMapping("/myGroupTask")
	public String myTask(HttpServletRequest request,HttpSession session){
		Group group = (Group) session.getAttribute("group");
		User user = (User) session.getAttribute("user");
		List<Task> tasks= taskService.createTaskQuery().taskCandidateGroup(group.getId()).list();
		List<User> users = identityService.createUserQuery().list();	
		/*List<Task> tasks = taskService.createTaskQuery().taskCandidateUser(user.getId()).list();*/
		request.setAttribute("tasks", tasks);	
		request.setAttribute("users", users);
		return "task/task-group";
	}
	
	@RequestMapping("/historicTaskList")
	public String historicTaskList(HttpServletRequest request,Model model,HttpSession session){	
		List<HistoricTaskInstance> historicTaskInstances =  historyService.createHistoricTaskInstanceQuery()
				.orderByHistoricActivityInstanceId().asc().orderByTaskCreateTime().desc().list();	
		request.setAttribute("historicTaskInstances", historicTaskInstances);
		
		return "task/task-historicList";
	}
	
	@RequestMapping("/startCompleteTask")
	public String startCompleteTask(HttpServletRequest request,Model model,
			@RequestParam String taskId,@RequestParam String processInstanceId){
		List<FormProperty> formPropertielList = formService.getTaskFormData(taskId)
				.getFormProperties();
		request.setAttribute("formPropertielList", formPropertielList);
		request.setAttribute("taskId", taskId);
		request.setAttribute("processInstanceId", processInstanceId);
		return "task/startCompleteTask";
	}
	
	@RequestMapping("/completeTask")
	public String completeTask(HttpServletRequest request,Model model,HttpSession session,
			@RequestParam String taskId,@RequestParam String processInstanceId,@RequestParam String message){
		Map<String, Object> variables = new HashMap<String, Object>();
		List<FormProperty> formPropertielList = formService.getTaskFormData(taskId)
				.getFormProperties();
		for (FormProperty formProperty : formPropertielList) {
			variables.put(formProperty.getId(), request.getParameter(formProperty.getId()));
		}	
		//做留言处理
		taskService.addComment(taskId, processInstanceId, message);
		taskService.complete(taskId, variables);
		return "task/task-list";
	}
	
	@RequestMapping("/allotTask")
	public String allotTask(HttpServletRequest request,@RequestParam String taskId,@RequestParam String userId){
		/*taskService.setOwner(taskId, userId);*/
		taskService.claim(taskId, userId);
		return "redirect:/task/queryTask.do";
	}
	
	@RequestMapping("/myOwnerTask")
	public String myOwnerTask(HttpServletRequest request,HttpSession session){
		User user = (User) session.getAttribute("user");
		List<Task> tasks = taskService.createTaskQuery().taskAssignee(user.getId()).list();
		request.setAttribute("tasks", tasks);
		return "task/myOwnerTask";
	}
}
