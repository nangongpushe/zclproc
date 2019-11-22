<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>uploadfileMessage</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<link rel="stylesheet" type="text/css" href="${ctx }/css/message.css" />
<style type="text/css">
.msg-doc {
	width: 80%;
	position: absolute;
	top: 40%;
	left: 0%;
	margin-left: 120px;
	margin-top: -90px;
	background: #fff;
}
</style>
</head>
<script type="text/javascript">
  	var i = 5; 
	var intervalid; 
	//intervalid = setInterval("setAuto()", 1000); 
	function setAuto() { 
		if (i == 0) { 
			window.location.href="${ctx }${path}";
			clearInterval(intervalid); 
		} 
		document.getElementById("mes").innerHTML = i; 
		i--; 
	} 
  </script>
<body>

	<div class="doc">
		<div class="msg-doc">
			<!-- <div> 
					<p>页面将在 <span id="mes">5</span> 秒钟后返回列表！</p> 
				</div> -->
			<div align="right">
				<a href="${ctx }${path}">关 闭</a>
			</div>
			<div class="msg">

				<table>
					<c:forEach items="${message}" var="msg">
						<tr>
							<td>${msg }</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
