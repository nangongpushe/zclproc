<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>

<%-- <%@include file="../common/AdminHeader.jsp"%> --%>

<!-- <div class="row clear-m"> -->
<!-- 	<ol class="breadcrumb"> -->
<!-- 		<li>轮换业务</li> -->
<!-- 		<li>竞标管理</li> -->
<!-- 		<li class="active">标的物明细</li> -->
<!-- 	</ol> -->
<!-- </div> -->

<div class="container clearfix" style="padding: 10px">
	
	<!-- layui静态表格 -->
	<table class="layui-table">
		<thead>
				<tr>
					<td>成交子明细号</td>
					<td>认领人</td>
					<td>认领时间</td>
					<td>认领类型</td>
					<td>认领金额(元)</td>
				</tr>


		</thead>
		<tbody>

				<c:forEach items="${claimsOfArrive}" var="item"
					varStatus="status">
					<tr>
						<td>${item.dealSerial}</td>
						<td>${item.claimMan}</td>
						<td>${item.claimDate}</td>
						<td>${item.claimType}</td>
						<td>${item.claimAmount}</td>
					</tr>
				</c:forEach>


		</tbody>
	</table>

</div>



<script>
	
</script>
<%-- <%@include file="../common/AdminFooter.jsp"%> --%>