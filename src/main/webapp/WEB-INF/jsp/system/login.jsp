<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

	<title>浙江粮储管理后台</title>
	<link rel="stylesheet" href="${ctx }/plugins/bootstrap-3.3.5-dist/css/bootstrap.min.css"/>
	<link rel="StyleSheet" type="text/css" href="<%=basePath %>css/signin.css">
	<link rel="StyleSheet" type="text/css" href="<%=basePath %>css/login1.css">
	<link rel="StyleSheet" type="text/css" href="<%=basePath %>css/iconmoon.css">
	<script src="${ctx }/js/jquery.min.js"></script>
	<script src="${ctx }/plugins/bootstrap-3.3.5-dist/js/bootstrap.js"></script>
	<!-- layui Js -->
	<script src="${ctx}/assets/layui/layui.all.js"></script>
	<style type="text/css">
		.video-player {
			background-color: rgba(0, 0, 0, 0);
			min-width: 100%;
			min-height: 100%;
			display: block;
			position: absolute;
			top: 0;
		}

		.video_mask {
			width: 100%;
			height: 100%;
			position: absolute;
			left: 0;
			top: 0;
			z-index: 90;
			background-color: rgba(0, 0, 0, 0.5);
		}
	</style>
</head>

<body>
<div class="container" id="entry">

	<form class="form-signin" action="" id="login">
		<div class="login">
			<h2 class="form-signin-heading">登录系统</h2>

			<div class="item fore1">
				<div class="item-ifo">
					<div class="text-area">
						<div class="i-name ico"><span class="icon-user"></span></div>
						<input type="text" class="text" placeholder="请输入账号" required="" autofocus="" name="account" id="account">
					</div>
					<label id="loginname_succeed" class="blank invisible succeed"></label>
					<label id="loginname_error" class="error" style="display:none;"></label>
				</div>
			</div>

			<div class="item fore2">
				<div class="item-ifo">
					<div class="text-area margin_top_42_1">
						<div class="i-pass ico">
							<span class="icon-password_o"></span>
						</div>
						<input class="text" placeholder="请输入密码" required="" type="password" id="password" name="password">
					</div>
					<label id="loginpwd_succeed" class="blank invisible succeed"></label>
					<label id="loginpwd_error" class="error" style="display: none;"></label>
				</div>
			</div>

			<div class="checkbox">
				<label> <input value="true" name="rememberMe" type="checkbox" id="rememberMe"> 记住我7天
				</label>
			</div>

			<a class="btn btn-lg btn-primary btn-block" id="loginButton">登录</a>
			<%-- <a class="btn btn-lg btn-primary btn-block" href="${ctx }/sign/welcome.shtml">选择其他登录方式</a> --%>

		</div>
	</form>

</div>


</body>
<script>
    jQuery(document).ready(function () {
        //回车事件绑定
        document.onkeydown = function (event) {
            var e = event
                || window.event
                || arguments.callee.caller.arguments[0];
            if (e && e.keyCode == 13) {
                $('#loginButton').click();
            }
        };

        //登录操作
        $('#loginButton').click(function () {

            var account = $('#account').val();
            var password = $('#password').val();

            var data = {
                password: password,
                account: account,
                rememberMe: $("#rememberMe").val
            };

            var loading = layer.load();
            $.ajax({url: "${ctx}/sign/submitLogin.shtml",
                data: data,
                type: "post",
                dataType: "json",
                beforeSend: function () {
                    layer.msg('开始登录,请稍后...');
                },
                success: function (result) {
                    layer.close(loading);
                    if (result && result.status != 200) {
                        layer.msg(result.message);
                        $('#password').val('');
                    } else {
                        layer.msg('登录成功!');
                        setTimeout(function () {
                            //登录返回
                            window.location.href = "${ctx}/Home/Index.shtml";
                        },1000);
                    }
                },
                error: function (e) {
                    layer.close(loading);
                    console.log(e,e.message);
                    layer.msg('登录异常,请联系管理员');
                }
            });
        });
    });

    if (window != top) {
        top.location.href = location.href;
    }
</script>
  
  
  