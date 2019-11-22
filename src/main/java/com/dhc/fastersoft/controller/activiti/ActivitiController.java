package com.dhc.fastersoft.controller.activiti;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.bpmn.converter.BpmnXMLConverter;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.editor.language.json.converter.BpmnJsonConverter;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.Model;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dhc.fastersoft.service.ActivitiService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

/**
* @ClassName: ActivitiController
* @Description: 流程查看
* @author zby
* @date 2017年9月28日 
* 
*/

@Controller
@RequestMapping("/activiti")
public class ActivitiController {
	
	protected Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private ActivitiService activitiService;
	
    @Autowired
    private RepositoryService repositoryService;
	
	@RequestMapping("/main")
	public String main(HttpServletRequest request){
		
		return "activiti/main";
	}
	
    /**
     * 根据Model部署流程
     */
    @RequestMapping("/deploy")
    public String deploy(HttpServletRequest request,@RequestParam("modelId") String modelId,@RequestParam("category") String category) {
        try {
            Model modelData = repositoryService.getModel(modelId);
            ObjectNode modelNode = (ObjectNode) new ObjectMapper().readTree(repositoryService.getModelEditorSource(modelData.getId()));
            byte[] bpmnBytes = null;
            BpmnModel model = new BpmnJsonConverter().convertToBpmnModel(modelNode);
            bpmnBytes = new BpmnXMLConverter().convertToXML(model);
            
            String processName = modelData.getName() + ".bpmn20.xml";
            repositoryService.createDeployment()
            		.name(modelData.getName()).category(category)
            		.addString(processName, new String(bpmnBytes)).deploy();            
        } catch (Exception e) {
            logger.error("根据模型部署流程失败：modelId={}", modelId, e);
        }
        return "redirect:/activiti/list.do";
    }
	
	@RequestMapping("/list")
	public String deploymentList(HttpServletRequest request,Model model){
		List<Deployment> deployments = activitiService.queryDeployment();
		request.setAttribute("deployments", deployments);
		return "activiti/deploymentList";
	}
	
	@RequestMapping("/deletedeployment")
	public String startDeployment(HttpServletRequest request,Model model,@RequestParam String deploymentId){
		activitiService.deleteDeployment(deploymentId);
		return "redirect:/activiti/list.do";
	}
	
	
	@RequestMapping("/viewShow")
	public void viewShow(HttpServletRequest request,Model model,@RequestParam String deploymentId,HttpServletResponse response){		
		InputStream imageStream = activitiService.viewShow(deploymentId);
        try {
    		byte[] b = new byte[1024];
            int len;
			while ((len = imageStream.read(b, 0, 1024)) != -1) {
			    response.getOutputStream().write(b, 0, len);
			}				
		} catch (IOException e) {		
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/viewShowHight")
	public void viewShowHight(HttpServletRequest request,HttpServletResponse response,Model model,
			@RequestParam String processDefinitionId,@RequestParam String taskId,@RequestParam String processInstanceId){
		
		InputStream imageStream = activitiService.viewShow(taskId,processDefinitionId,processInstanceId);
        try {
    		byte[] b = new byte[1024];
            int len;
			while ((len = imageStream.read(b, 0, 1024)) != -1) {
			    response.getOutputStream().write(b, 0, len);
}				
		} catch (IOException e) {
			
			e.printStackTrace();
		}
	}
}
