<%--
  Created by IntelliJ IDEA.
  User: dazer
  Date: 2017/8/27
  Time: 下午3:22
  To change this template use File | Settings | File Templates.
  pageOffice 简单在线编辑功能，只提供编辑保存功能
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%--<%@include file="/taglibs.jsp" %>
<%@include file="/common/s.jsp" %>
<%@ page language="java"
         import="com.mossle.api.store.StoreConnector,com.mossle.api.store.StoreDTO,com.mossle.api.tenant.TenantHolder"
         pageEncoding="utf-8" %>
<%@ page import="com.mossle.security.util.SpringSecurityUtils" %>--%>
<%@ page import="com.dhc.fastersoft.service.system.SysFileService" %>
<%@ page import="com.zhuozhengsoft.pageoffice.OpenModeType" %>
<%@ page import="com.zhuozhengsoft.pageoffice.PageOfficeCtrl" %>
<%@ page import="org.apache.commons.lang3.BooleanUtils" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="com.dhc.fastersoft.utils.PropFileReader" %>
<%--<%!
    private SysFileController sys;
    private TenantHolder tenantHolder;
%>--%>
<%
    //******************************卓正PageOffice组件的使用*******************************
    //设置PageOffice服务器组件
    PageOfficeCtrl poCtrl1 = null;
    try {
        /*String storemodel = request.getParameter("model");*/
        String storeKey = request.getParameter("fileUrl");
        String isCanEditor = "false";//是否能够编辑
        String isWord = "";//是否word
        if (StringUtils.isBlank(isWord) && StringUtils.isNotBlank(storeKey)) {
            isWord = storeKey.toLowerCase().contains(".doc") + "";
        }
        poCtrl1 = new PageOfficeCtrl(request);
        poCtrl1.setServerPage(request.getContextPath() + "/poserver.zz"); //此行必须
        //设置保存的action
        /*poCtrl1.setSaveFilePage(request.getContextPath() + "/commonFileSave.do?model=" + storemodel + "&key=" + storeKey);

        /*if (this.storeConnector == null) {
            this.storeConnector = ApplicationContextHelper.getBean(StoreConnector.class);
        }
        if (this.tenantHolder == null) {
            this.tenantHolder = ApplicationContextHelper.getBean(TenantHolder.class);
        }*/
        PropFileReader propFileReader = new PropFileReader();
        String realPath = propFileReader.getPorpertyValue("filePaths.properties","update_url");
        String path = realPath + "/" + storeKey;
        System.out.println(path);
        /*String path = request.getContextPath() + "/" + storeKey;*/
        //隐藏Office工具条
        poCtrl1.setOfficeToolbars(true);
        //隐藏自定义工具栏
        poCtrl1.setCustomToolbar(true);
        //设置页面的显示标题
        poCtrl1.setCaption(storeKey);
        OpenModeType openModeType = null;
        if (BooleanUtils.toBoolean(isWord)) {
            if (BooleanUtils.toBoolean(isCanEditor)) {
                openModeType = OpenModeType.docAdmin;
            } else {
                openModeType = OpenModeType.docReadOnly;
            }
        } else {
            if (BooleanUtils.toBoolean(isCanEditor)) {
                openModeType = OpenModeType.xlsNormalEdit;
            } else {
                openModeType = OpenModeType.xlsReadOnly;
            }
        }
        //禁用按钮
        poCtrl1.setJsFunction_AfterDocumentOpened("AfterDocumentOpened");   //禁用按钮
        //打开文件
        String username = "超管";
        poCtrl1.webOpen(path, openModeType, username);
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("taohong_error_msg", "文件不存在！");
    }


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
    <title>编辑文档</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <%--<link href="css/pageoffice_csstg.css" rel="stylesheet" type="text/css"/>--%>
    <!-- PageOffice.js文件一定要引用 -->
    <!--PageOffice.js和jquery.min.js文件一定要引用-->
    <%--<script type="text/javascript" src="${ctx}/pageoffice.js" id="po_js_main"></script>--%>
    <script src="${ctx}/assets/js/jquery-1.10.2.js"></script>
    <script type="text/javascript">

        function load() {
            <c:if test="${not empty taohong_error_msg}">
            window.alert("${taohong_error_msg} || '未读取到文件！'");
            </c:if>
        }

        function AfterDocumentOpened() {
            document.getElementById("PageOfficeCtrl1").SetEnableFileCommand(3, false); // 禁止保存
            document.getElementById("PageOfficeCtrl1").SetEnableFileCommand(4, true); // 禁止另存
            document.getElementById("PageOfficeCtrl1").SetEnableFileCommand(5, true); //禁止打印
            document.getElementById("PageOfficeCtrl1").SetEnableFileCommand(6, false); // 禁止页面设置
        }
    </script>
</head>
<body onload="load()">
<div style=" width:auto; height:700px;">
    <%=poCtrl1.getHtmlCode("PageOfficeCtrl1")%>
</div>
</body>
</html>
