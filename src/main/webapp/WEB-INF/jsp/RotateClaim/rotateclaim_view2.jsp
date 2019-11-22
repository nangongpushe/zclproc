<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
					<td style="text-align: center">成交子明细号</td>
					<td style="text-align: center">认领人</td>
					<td style="text-align: center">认领时间</td>
					<td style="text-align: center">认领类型</td>
					<td style="text-align: center">认领金额(元)</td>
				</tr>


		</thead>
		<tbody>

				<c:forEach items="${claimsOfArrive}" var="item"
					varStatus="status">
					<tr>
						<td style="width:150px;text-align: left">${item.dealSerial}</td>
						<td style="width:150px;text-align: left">${item.claimMan}</td>
						<td style="width:150px;text-align: center"><fmt:formatDate value='${item.claimDate}' pattern='yyyy-MM-dd' /></td>
						<td style="width:150px;text-align: left">${item.claimType}</td>
						<td style="width:100px;text-align: right">${item.claimAmount}</td>
					</tr>
				</c:forEach>
				<c:if test="${claimsOfArrive==null || fn:length(claimsOfArrive)==0}">
					<div class="layui-row">暂无数据</div>
				</c:if>

		</tbody>
	</table>

</div>



<script>
	
</script>
<%-- <%@include file="../common/AdminFooter.jsp"%> --%>