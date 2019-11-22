<%@page import="com.dhc.fastersoft.common.shrio.token.manager.TokenManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<nav class="navbar navbar-default top-navbar" role="navigation" >
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".sidebar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#" style="color:#fff">
<!-- 				<strong><i class="layui-icon" style="font-size: 30px;">&#xe68e;</i>&nbsp;&nbsp;&nbsp;浙江粮储管理后台</strong> -->
					<img class="logo" alt="Brand" src="${ctx}/images/logo.png">
<!--                     <img class="logo-single" alt="Brand" src="${ctx}/images/logo-single.png"> -->
				</a>
				<div id="sideNav" href="">
					<i class="fa fa-bars icon"></i>
				</div>
			</div>

	<ul class="nav navbar-top-links navbar-right">
		
		<li></li>

		<li class="dropdown"><a class="dropdown-toggle"
			data-toggle="dropdown" href="#" aria-expanded="false"> <% out.print(TokenManager.getNickname());%><i
				class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
		</a>
			<ul class="dropdown-menu dropdown-user">
<!-- 				<li><a href="#" onclick="userInfo();"><i class="fa fa-user fa-fw" ></i> 用户信息</a></li> -->
<!-- 				<li class="divider"></li> -->
				<li><a href="${ctx}/sign/logout.shtml"><i class="fa fa-sign-out fa-fw"></i>退出</a></li>
			</ul></li>

<!-- 		<li class="dropdown"><a class="dropdown-toggle"
			data-toggle="dropdown" href="#" aria-expanded="false">系统切换<i class="fa fa-caret-down"></i>
		</a>
			<ul class="dropdown-menu dropdown-alerts">
				<li><a href="#">
						<div>
							<i class="fa fa-comment fa-fw"></i> New Comment <span
								class="pull-right text-muted small">4 min</span>
						</div>
				</a></li>
				<li class="divider"></li>
				<li><a href="#">
						<div>
							<i class="fa fa-twitter fa-fw"></i> 3 New Followers <span
								class="pull-right text-muted small">12 min</span>
						</div>
				</a></li>

			</ul> 
		</li> -->
		<li class="dropdown dropdown-list">
                    <a aria-expanded="false" aria-haspopup="true" href="#" class="dropdown-toggle" data-toggle="dropdown">
                        系统切换
                        <!-- <img src="/oa/s/home_hourse.png" style="width:25px;height:25px;" class="img-rounded" />
                        <b class="caret"></b> -->
                    </a>
                    <ul class="dropdown-menu animated flipInX">
                        <li>
                            <a href="http://10.10.9.2:82/portal/sso/pageFrontsso?ptype=100"
                               class="list-group-item" target="_blank">
                                <div class="media-box clearfix">
                                    <div class="pull-left">
                                        <em class="fa fa-home fa-2x text-purple" style="color: #7266ba"></em>
                                    </div>
                                    <div class="pull-left"><strong>门户首页</strong></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="http://10.10.9.2:82/emergency/redirect/emergencyweb" class="list-group-item" target="_blank">
                                <div class="media-box clearfix">
                                    <div class="pull-left">
                                        <em class="glyphicon glyphicon-log-in fa-2x " style="color: #f05050"></em>
                                    </div>
                                    <div class="pull-left"><strong>应急指挥</strong></div>
                                </div>
                            </a>
                        </li>
                        <li>
                               <a href="http://10.10.9.2:82/oa/" class="list-group-item" target="_blank">
                                <div class="media-box clearfix">
                                    <div class="pull-left">
                                        <em class="fa fa-envelope fa-2x text-success" style="color: #5d9cec"></em>
                                    </div>
                                    <div class="pull-left"><strong>办公管理</strong></div>
                                </div>
                            </a>
                        </li>                        
                        <li>
                               <a href="http://10.10.9.2:82/oa/redirect/monitorweb" class="list-group-item" target="_blank">
                                <div class="media-box clearfix">
                                    <div class="pull-left">
                                        <em class="fa fa-binoculars fa-2x text-success" style="color: #5d9cec"></em>
                                    </div>
                                    <div class="pull-left"><strong>远程监管</strong></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="http://10.10.9.2:82/safety/redirect/safetyweb" class="list-group-item" target="_blank">
                                <div class="media-box clearfix">
                                    <div class="pull-left">
                                        <em class="fa fa-check-circle fa-2x " style="color: #ff902b"></em>
                                    </div>
                                    <div class="pull-left"> <strong>安全管理</strong></div>
                                </div>
                            </a>
                        </li>


                        <li>
                            <a href="#" class="list-group-item">
                                <div class="media-box clearfix">
                                    <div class="pull-left">
                                        <em class="fa fa-sitemap fa-2x" style="color: #23b7e5"></em>
                                    </div>
                                    <div class="pull-left"><strong>代码识别</strong></div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="http://202.91.248.53:8680/fbrole/main/login.jsp" class="list-group-item" target="_blank">
                                <div class="media-box clearfix">
                                    <div class="pull-left">
                                        <em class="fa fa-pencil-square-o fa-2x text-info" style="color: #23b7e5"></em>
                                    </div>
                                    <div class="pull-left"><strong>订单系统</strong></div>
                                </div>
                            </a>
                        </li>
                    </ul>
                </li>
		

	</ul>
</nav>
<script>
layui.use('layer', function(){

});  
function userInfo(){
 var layer = layui.layer;
 var $ = layui.jquery;
	layer.open({
        type: 1
        ,title: false //不显示标题栏
        ,closeBtn: false
        ,area: '300px;'
        ,shade: 0.8
        ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
        ,btn: ['确认']
        ,btnAlign: 'c'
        ,moveType: 1 //拖拽模式，0或者1
        ,content: '<div style="padding: 50px; line-height: 22px; background-color: #148cb1; color: #fff; font-weight: 300;font-size: 18px;">账号：${sessionScope.user.account}<br>姓名：${sessionScope.user.name}<br>公司：${sessionScope.user.company}<br>部门：${sessionScope.user.department}<br>联系方式：${sessionScope.user.cellPhone}<br>邮箱地址：${sessionScope.user.email}<br></div>'
      });
}
 
</script>