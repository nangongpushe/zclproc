package com.dhc.fastersoft.test;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.ProcessEngineConfiguration;
import org.junit.Test;

public class CreateTable {
	
	/** 
	 * 使用配置文件来创建数据库中的表 
	 */  
	@Test  
    public void createTable_2(){  
        //流程引擎ProcessEngine对象，所有操作都离不开引擎对象  
        ProcessEngineConfiguration processEngineConfiguration =   
                ProcessEngineConfiguration.createProcessEngineConfigurationFromResource("activiti.cfg.xml");  
        //获取工作流的核心对象，ProcessEngine对象  
        ProcessEngine processEngine=processEngineConfiguration.buildProcessEngine();  
        System.out.println("processEngine:"+processEngine+"Create Success!!");  
        
    }  
	
}
