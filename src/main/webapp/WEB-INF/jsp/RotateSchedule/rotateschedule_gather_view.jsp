<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- <%@include file="../common/AdminHeader.jsp"%> --%>

<style>
	table tr td{
	width:150px;
	}
</style>
<div class="container clearfix" style="padding: 10px">
	<fieldset class="layui-elem-field layui-field-title text-center"
		style="margin-top: 20px;">
		<legend>${rotateType}进度表</legend>
	</fieldset>
	<!-- layui静态表格 -->
	<table class="layui-table">
		<thead>
				<tr>
					<td align="center">批次</td>
					<td align="center">标号</td>

					<c:if test="${rotateType =='出库' }">
					<td align="center">出库单位</td>
					<td align="center">仓号</td>
					<td align="center">粮食品种</td>
					<td align="center">计划数(吨)</td>
					<td align="center">成交单位</td>
					<td align="center">拍卖时间</td>
					</c:if>
					<c:if test="${rotateType =='入库' }">
					<td align="center">单位</td>
					<td align="center">仓号</td>
					<td align="center">粮食品种</td>
					<td align="center">交货时间起</td>
					<td align="center">交货时间止</td>
					<td align="center">计划数(吨)</td>
					<td align="center">交货单位</td>
					</c:if>
					<td align="center">上期(吨)</td>
					<td align="center">本期(吨)</td>
					<td align="center">累计(吨)</td>
					<td align="center">完成率(%)</td>
				</tr>


		</thead>
		<tbody>

			<c:forEach items="${detailList}" var="item" varStatus="status">
				<tr>	
					<c:if test="${status.index==0 }">
						<td rowspan="${length}" align="right">${schemeBatch}</td>
					</c:if>
						<td align="right">${item.bidSerial}</td>
					
					<c:if test="${rotateType =='出库' }">
						<td align="left">${item.reportUnit}</td>
						<td align="left">${item.storehouse}</td>
						<td align="left">${item.grainType}</td>
						<td align="right">${item.quantity}</td>
						<td align="left">${item.dealUnit}</td>
						<td align="center">${item.dealDate}</td>
					</c:if>
					<c:if test="${rotateType =='入库' }">
						<td align="left">${item.reportUnit}</td>
						<td align="left">${item.storehouse}</td>
						<td align="left">${item.grainType}</td>
						<td align="center">${item.deliveryStart}</td>
						<td align="center">${item.deliveryEnd}</td>
						<td align="right">${item.quantity}</td>
						<td align="left">${item.dealUnit}</td>
					</c:if>

					<td align="right">${item.priorPeriod}</td>

					<td align="right">${item.currentPeriod}</td>
					
					<td align="right">${item.total}</td>

					<td align="right">${item.compleRate}</td>


				</tr>
			</c:forEach>
			<c:if test="${detailList==null || fn:length(detailList)==0}">
					<div class="layui-row">暂无数据</div>
			</c:if>

		</tbody>
	</table>

</div>



<script>
	
</script>
<%-- <%@include file="../common/AdminFooter.jsp"%> --%>