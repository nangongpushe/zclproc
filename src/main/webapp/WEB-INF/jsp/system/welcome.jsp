<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>


  <head>
  
    <title>浙江粮储管理后台</title>
    <link rel="stylesheet" href="${ctx }/plugins/bootstrap-3.3.5-dist/css/bootstrap.min.css"/>
    <script src="${ctx }/js/jquery.min.js"></script>
    <script src="${ctx }/plugins/bootstrap-3.3.5-dist/js/bootstrap.js"></script>

  </head>
  <style type="text/css">
    body {
      padding-top: 40px;
      padding-bottom: 40px;
    }
  </style>
<body>
    <div class="container">

        <!-- <div class="video_mask"></div> -->
        <h1 style="text-align:center">请选择登录方式!</h1>
          
    	<div class="row">
    	  <div class="col-md-6">
            <div class="jumbotron" style="margin: 5%">
    		    <div class="container">
    		        <h1>本系统登录</h1>
    		        <p><a class="btn btn-primary btn-lg" role="button" href="${ctx}/sign/login.shtml">
    		        	 登录</a>
    		        </p>
    		    </div>
    		</div>
          </div>

    	  <div class="col-md-6">
             <div class="jumbotron" style="margin: 5%">
                <div class="container" >
                    <h1>单点登录</h1>
                    <p><a href="${ctx }/sign/caslogin.shtml" class="btn btn-primary btn-lg" role="button">
                         	登录</a>
                    </p>
                </div>
            </div>

        </div>
        </div>
    </div>

</body>

<script>
	if(window != top){
		top.location.href = location.href; 
	} 
</script>
    