<%@page import="com.dhc.fastersoft.common.shrio.token.manager.TokenManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ include file="../common/AdminHeader.jsp" %>
<link rel="StyleSheet" href="${ctx }/css/original-layui.css"/>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="row clear-m">
	<ol class="breadcrumb">
		<li class="active">欢迎&nbsp;&nbsp;<%=TokenManager.getNickname() %> &nbsp;&nbsp;登录本系统</li>
	</ol>
</div>
<div class="container-box clearfix" style="padding: 10px">
<div class="layui-carousel" id="homeCarousel">
  <div carousel-item="">
    <div style="text-align: center; line-height:400px;background-color: #006666;font-size:60px;color:#fff"><%=TokenManager.getNickname() %>&nbsp;&nbsp;欢迎登录</div>
  </div>
</div>
</div>


<script>
layui.use('carousel', function(){
  var carousel = layui.carousel;
  //建造实例
  carousel.render({
    elem: '#homeCarousel'
    ,width: '100%' //设置容器宽度
    ,height:'450px'
    ,arrow: 'always' //始终显示箭头
    //,anim: 'updown' //切换动画方式
  });
});

 	

</script>


<%@ include file="../common/AdminFooter.jsp" %>