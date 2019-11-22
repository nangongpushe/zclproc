package com.dhc.fastersoft.common;
import javax.servlet.ServletContext;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.web.context.ServletContextAware;

public class InitDataListener implements InitializingBean, ServletContextAware {

	private Logger log = Logger.getLogger(InitDataListener.class);

	public void afterPropertiesSet() throws Exception {
		// 在这个方法里面写 初始化的数据也可以。

	}

	public void setServletContext(ServletContext arg0) {
		//TO DO
	}
}