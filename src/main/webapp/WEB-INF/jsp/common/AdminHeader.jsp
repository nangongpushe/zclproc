<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html>
<head>
<meta charset="UTF-8">
<title>生产管理系统首页</title>

<link rel="stylesheet" href="${ctx }/plugins/bootstrap-3.3.5-dist/css/bootstrap.min.css"/>

<link rel="stylesheet" href="${ctx }/plugins/jQueryValidationEngine-2.6.2/validationEngine.jquery.css">
<link rel="StyleSheet" href="${ctx }/plugins/colorbox/colorbox.css"/>
<link rel="StyleSheet" href="${ctx }/plugins/jQueryDropdown/jquery.dropdown.min.css"/>
<link rel="stylesheet" href="${ctx }/plugins/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">

<!-- FontAwesome Styles-->
<link href="${ctx}/assets/css/font-awesome.css" rel="stylesheet" />
<link href="${ctx}/assets/css/font-awesome.min.css" rel="stylesheet" />
<!-- Morris Chart Styles-->
<link href="${ctx}/assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />

<link rel="stylesheet" href="${ctx }/css/commons.css"/>
<link rel="stylesheet" href="${ctx }/assets/layui/css/layui.css"/>
<!-- Custom Styles-->
<link href="${ctx}/assets/css/custom-styles.css" rel="stylesheet" />

 <link href="${ctx}/css/index.css" rel="stylesheet" />

	<!-- jQuery Js -->
	<script src="${ctx}/assets/js/jquery-1.10.2.js"></script>
<!-- JS Scripts-->
<!-- layui Js -->
<script src="${ctx}/assets/layui/layui.all.js"></script>

<!-- Bootstrap Js -->
<script src="${ctx}/assets/js/bootstrap.min.js"></script>

<!-- Jquery form Js -->
<script src="${ctx}/assets/js/jquery.form.js"></script>
<script src="${ctx }/plugins/colorbox/jquery.colorbox.js"></script>
<!-- commons Js -->
<script src="${ctx}/js/commons.js"></script>

<script src="${ctx}/js/laytool.js"></script>
<script src="${ctx}/js/dateformat.js"></script>
<script src="${ctx}/js/app/DateFormat.js"></script>

<script src="${ctx }/plugins/jQueryValidationEngine-2.6.2/jquery.validationEngine.js"></script>
<script src="${ctx }/plugins/jQueryValidationEngine-2.6.2/jquery.validationEngine-zh_CN.js"></script>


<%-- <script src="${ctx }/plugins/colorbox/jquery.colorbox.js"></script> --%>

<script src="${ctx }/js/cities.data.js"></script>
<!-- <script type="text/javascript" src="https://janking.github.io/dropdown/mock.js"></script> -->
<script src="${ctx }/plugins/jQueryDropdown/jquery.dropdown.min.js"></script>

<script type="text/javascript" src="${ctx }/plugins/zTree_v3/js/jquery.ztree.core.js"></script>
<script type="text/javascript" src="${ctx }/plugins/zTree_v3/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript" src="${ctx }/plugins/zTree_v3/js/jquery.ztree.exedit.js"></script>

<script type="text/javascript" src="${ctx }/js/jquery.tablesorter.min.js"></script>
<script type="text/javascript" src="${ctx }/js/jquery.tablesorter.widgets.min.js"></script>


<script src="${ctx}/js/jquery.nicescroll.min.js"></script>

<!-- 局部打印插件 -->
<script src="${ctx}/js/jquery.PrintArea.js"></script>
<!--PageOffice.js-->
<script type="text/javascript" src="${ctx}/pageoffice.js" id="po_js_main"></script>
</head>
<body  style="background-color:#fff;overflow:auto!important;">

<script>
	pagesize = 10;
</script>		
		<!-- 正文 -->
		<div id="page-wrapper" style="margin:0;top:0;min-height: 100%;">