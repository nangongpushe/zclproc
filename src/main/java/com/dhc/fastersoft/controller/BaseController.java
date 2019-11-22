package com.dhc.fastersoft.controller;

import com.dhc.fastersoft.service.system.SysLogService;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;

/**
 * @author Canbol
 * @Description: ${todo}
 * @date 2018/6/30 9:50
 */
public class BaseController {
    @Autowired
    protected HttpServletRequest request;
    @Autowired
    protected SysLogService sysLogService;
}
