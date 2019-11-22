<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>

<%-- <%@include file="../common/AdminHeader.jsp"%> --%>

<style>
	table tr td{
	/*width:150px;*/
	}
	h3{
	font-size: 18px;
    font-weight: bold;
	}
</style>
<div class="container clearfix" style="padding: 10px" id="printDiv">
	<div class="layui-row">
		<div class="layui-col-md4">
			<span>库点:</span> <span>${model.warehouse}</span>
		</div>
		<div class="layui-col-md4">
			<span>仓号:</span> <span>${model.encode}</span>
		</div>
		<div class="layui-col-md4">
			<span>熏蒸记录编号:</span> <span>${model.fumigate}</span>
		</div>
		<div class="layui-col-md4">
			<span>粮堆平均浓度(ppm):</span> <span>${model.average}</span>
		</div>
		<div class="layui-col-md4">
			<span>检测人:</span> <span>${model.inspector},${model.inspectors}</span>
		</div>

		<div class="layui-col-md4">
			<span>检测时间:</span> <span><fmt:formatDate
					value="${model.inspecteTime}" pattern="yyyy-MM-dd" /></span>
		</div>
		<div class="layui-col-md4">
			<span>检测仪器:</span> <span>${model.testDevice},${model.testDevice}</span>
		</div>
		<div class="layui-col-md12">
			<span>备注:</span> <span>${model.remark}</span>
		</div>


	</div>
	<!-- layui静态表格 -->
	<table class="layui-table">
		<thead>
			<tr>
				<td style="text-align: center">粮堆检测点</td>
				<td style="text-align: center">磷化氢浓度(ppm)</td>
			</tr>
		</thead>
		<tbody>

			<c:forEach items="${model.pointList}" var="item" varStatus="status">
				<tr>
					<td style="text-align: left">${item.point}</td>
					<td style="text-align: right">${item.value}</td>
				</tr>
			</c:forEach>


		</tbody>
	</table>

</div>

<script>

</script>
<%-- <%@include file="../common/AdminFooter.jsp"%> --%>