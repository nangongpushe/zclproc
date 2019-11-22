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
<style>
	table#view td{
	width:100px;
	}

</style>

<div class="container clearfix" style="padding: 10px">
	
	<div class="layui-row">
		<div class="layui-col-md3">
			<span>招标结果名称:</span> <span>${model.inviteName}</span>
		</div>
		<div class="layui-col-md3">
			<span>招标结果类别:</span> <span>${model.inviteType}</span>
		</div>
		<div class="layui-col-md3">
			<span>所属标的:</span> <span>${model.bidName}</span>
		</div>
		<div class="layui-col-md3">
			<span>委托单位:</span> <span>${model.entrustCompany}</span>
		</div>
		<div class="layui-col-md3">
			<span>委托标的:</span> <span>${model.entrustBid}</span>
		</div>
		<div class="layui-col-md3">
			<span>委托数量(吨):</span> <span>${model.entrustNum}</span>
		</div>
		<div class="layui-col-md3">
			<span>实施单位:</span> <span>${model.exploitingEntity}</span>
		</div>
		<div class="layui-col-md3">
			<span>数量合计(吨):</span> <span>${model.totalNum}</span>
		</div>
		<div class="layui-col-md3">
			<span>竞得价合计(元/吨):</span> <span>${model.totalCompetitivePrice}</span>
		</div>
		<div class="layui-col-md3">
			<span>标的物总价合计(元):</span> <span>${model.totalBidPrice}</span>
		</div>
		<div class="layui-col-md3">
			<span>占用保证金合计(元):</span> <span>${model.totalBail}</span>
		</div>
		<div class="layui-col-md3">
			<span>经办人:</span> <span>${model.operator}</span>
		</div>
		<div class="layui-col-md3">
			<span>经办部门:</span> <span>${model.department}</span>
		</div>
		<div class="layui-col-md3">
			<span>经办时间:</span> <span> <fmt:formatDate
					value="${model.handleTime}" pattern="yyyy-MM-dd" />
			</span>
		</div>
		<div class="layui-col-md12">
			<span>备注:</span> <span>${model.remark}</span>
		</div>


	</div>
	<!-- layui静态表格 -->
	<table class="layui-table" id="view">
		<thead>
				<tr>
					<td align="center">标段</td>
					<td align="center">竞得单位</td>
					<td align="center">数量(吨)</td>
	
					<td align="center">起始价(元/吨)</td>
					<td align="center">竞得价(元/吨)</td>
	
					<td align="center">标的物总价(元)</td>

					<td align="center">占用保证金(元)</td>
					<td align="center">货款支付免息截止日期</td>
				</tr>


		</thead>
		<tbody>

				<c:forEach items="${model.inviteDetails}" var="item"
					varStatus="status">
					<tr>
						<td align="right">${item.bidSerial}</td>
						<td align="left">${item.competitiveUnit}</td>
						<td align="right">${item.num}</td>
						<td align="right">${item.startingPrice}</td>
						<td align="right">${item.competitivePrice}</td>

						<td align="right">${item.bidPrice}</td>

						<td align="right">${item.bail}</td>
						<td align="right">
							<c:choose>
								<c:when test="${item.loanPaymentEndDate eq null }">
									———
								</c:when>
								<c:otherwise>
									${item.loanPaymentEndDate}
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:forEach>


		</tbody>
	</table>

</div>



<script>
	
</script>
<%-- <%@include file="../common/AdminFooter.jsp"%> --%>