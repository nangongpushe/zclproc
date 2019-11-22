<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>浙江粮储生产管理系统</title>

<link rel="stylesheet" href="${ctx }/plugins/bootstrap-3.3.5-dist/css/bootstrap.min.css"/>
<link rel="stylesheet" href="${ctx }/plugins/jQueryValidationEngine-2.6.2/validationEngine.jquery.css">
<link rel="StyleSheet" href="${ctx }/plugins/colorbox/colorbox.css"/>
<link rel="StyleSheet" href="${ctx }/plugins/jQueryDropdown/jquery.dropdown.min.css"/>
<link rel="stylesheet" href="${ctx }/plugins/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">

<!-- FontAwesome Styles-->
<link href="${ctx}/assets/css/font-awesome.css" rel="stylesheet" />
<!-- Morris Chart Styles-->
<link href="${ctx}/assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />
<!-- Custom Styles-->
<link href="${ctx}/assets/css/custom-styles.css" rel="stylesheet" />

<link rel="stylesheet" href="${ctx}/assets/js/Lightweight-Chart/cssCharts.css">

<link rel="stylesheet" href="${ctx }/css/commons.css"/>

<link rel="stylesheet" href="${ctx }/assets/layui/css/layui.css"/>
<link rel="stylesheet" href="${ctx }/css/basis_info.css"/>
<!-- Custom Styles-->
<link href="${ctx}/assets/css/custom-styles2.css" rel="stylesheet" />


<!-- JS Scripts-->
<!-- layui Js -->
<script src="${ctx}/assets/layui/layui.all.js"></script>

<!-- layDate Js -->
<script src="${ctx }/plugins/laydate/laydate.js"></script>

<!-- laypage Js -->
<script src="${ctx }/plugins/laypage/laypage.js"></script>


<!-- jQuery Js -->
<script src="${ctx}/assets/js/jquery-1.10.2.js"></script>


<!-- Bootstrap Js -->
<script src="${ctx}/assets/js/bootstrap.min.js"></script>

<!-- Metis Menu Js -->
<script src="${ctx}/assets/js/jquery.metisMenu.js"></script>
<!-- Morris Chart Js -->
<script src="${ctx}/assets/js/morris/raphael-2.1.0.min.js"></script>
<script src="${ctx}/assets/js/morris/morris.js"></script>

<!-- Jquery form Js -->
<script src="${ctx}/assets/js/jquery.form.js"></script>

<script src="${ctx}/assets/js/easypiechart.js"></script>
<script src="${ctx}/assets/js/easypiechart-data.js"></script>

<script src="${ctx}/assets/js/Lightweight-Chart/jquery.chart.js"></script>
<!-- Custom Js -->
<script src="${ctx}/assets/js/custom-scripts.js"></script>
<!-- mydate Js -->
<script src="${ctx}/assets/js/Date.js"></script>

<!-- commons Js -->
<script src="${ctx}/js/commons.js"></script>

<script src="${ctx}/js/laytool.js"></script>
<script src="${ctx}/js/dateformat.js"></script>



<script src="${ctx }/plugins/jQueryValidationEngine-2.6.2/jquery.validationEngine.js"></script>
<script src="${ctx }/plugins/jQueryValidationEngine-2.6.2/jquery.validationEngine-zh_CN.js"></script>

<script src="${ctx }/plugins/colorbox/jquery.colorbox.js"></script>


<script src="${ctx }/js/cities.data.js"></script>
<!-- <script type="text/javascript" src="https://janking.github.io/dropdown/mock.js"></script> -->
<script src="${ctx }/plugins/jQueryDropdown/jquery.dropdown.min.js"></script>

<script src="${ctx}/js/app/DateFormat.js"></script>



	<%-- <script type="text/javascript" src="${ctx }/plugins/zTree_v3/js/jquery-1.4.4.min.js"></script> --%>
	<script type="text/javascript" src="${ctx }/plugins/zTree_v3/js/jquery.ztree.core.js"></script>
	<script type="text/javascript" src="${ctx }/plugins/zTree_v3/js/jquery.ztree.excheck.js"></script>
	<script type="text/javascript" src="${ctx }/plugins/zTree_v3/js/jquery.ztree.exedit.js"></script>
<!-- Chart Js -->
<%-- <script type="text/javascript" src="${ctx}/assets/js/chart.min.js"></script>
<script type="text/javascript" src="${ctx}/assets/js/chartjs.js"></script> --%>

</head>
<body>
	<div id="wrapper">
	    <!-- 顶部栏 -->
		<%@include file="../common/top_nav.jsp"%>
	
		<!-- 左侧导航栏 -->		
		<%@include file="../common/left_nav.jsp"%>
		
		<!-- 正文 -->
		<div id="page-wrapper">