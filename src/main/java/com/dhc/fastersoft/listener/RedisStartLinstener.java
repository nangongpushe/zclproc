package com.dhc.fastersoft.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class RedisStartLinstener implements ServletContextListener {


    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        //callCmd("cmd /c start /min D://redis启动脚本.bat");
    }
    private void callCmd(String filePath){
        try{
            Process process = Runtime.getRuntime().exec(filePath);
            process.waitFor();
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
