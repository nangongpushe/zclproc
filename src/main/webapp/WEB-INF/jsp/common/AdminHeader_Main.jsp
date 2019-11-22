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
<title>生产管理系统首页</title>

<link rel="stylesheet" href="${ctx }/plugins/bootstrap-3.3.5-dist/css/bootstrap.min.css"/>

<link rel="stylesheet" href="${ctx }/assets/layui/css/layui.css"/>
<!-- FontAwesome Styles-->
<link href="${ctx}/assets/css/font-awesome.css" rel="stylesheet" />
<link href="${ctx}/assets/css/font-awesome.min.css" rel="stylesheet" />
<%-- <link href="${ctx}/assets/css/font-awesome.min.css" rel="stylesheet" /> --%>
<!-- Custom Styles-->
<link href="${ctx}/assets/css/custom-styles.css" rel="stylesheet" />

<link href="${ctx}/css/index.css" rel="stylesheet" />

<!-- jQuery Js -->
<script src="${ctx}/assets/js/jquery-1.10.2.js"></script>
<!-- Bootstrap Js -->
<script src="${ctx}/assets/js/bootstrap.min.js"></script>
<!-- layui Js -->
<script src="${ctx}/assets/layui/layui.all.js"></script>
<!-- Metis Menu Js -->
<script src="${ctx}/assets/js/jquery.metisMenu.js"></script>
<!-- Custom Js -->
<script src="${ctx}/assets/js/custom-scripts.js"></script>

</head>
<body>
	<div id="wrapper">
	    <!-- 顶部栏 -->
		<%@include file="../common/top_nav.jsp"%>
	
		<!-- 左侧导航栏 -->		
		<%@include file="../common/left_nav.jsp"%>
		
		<!-- 正文 -->
		<div id="page-wrapper" class="embed-responsive" style="overflow-y:auto;">