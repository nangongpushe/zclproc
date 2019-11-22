<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>

<%-- <%@include file="../common/AdminHeader.jsp"%> --%>

<style>
	table tr td{
	width:150px;
	}
</style>
<div class="container clearfix" style="padding: 10px">
	<fieldset class="layui-elem-field layui-field-title text-center"
		style="margin-top: 20px;">
		<legend>${noticeType}进度表</legend>
	</fieldset>
<%-- 	<div class="layui-row">
		<div class="layui-col-md4">
			<span>经办人:</span> <span>${model.operator}</span>
		</div>
		<div class="layui-col-md4">
			<span>经办部门:</span> <span>${model.department}</span>
		</div>
		<div class="layui-col-md4">
			<span>填报时间:</span> <span>${model.reportTimeStr}</span>
		</div>
		<div class="layui-col-md4">
			<span>填报单位:</span> <span>
					${model.reportUnit}
			</span>
		</div>
		<div class="layui-col-md4">
			<span>单位:</span> <span>${model.unit}</span>
		</div>
		<div class="layui-col-md4">
			<span>类型:</span> <span>${model.noticeType}</span>
		</div>
		<div class="layui-col-md4">
			<span>所属出入库通知书:</span> <span>${model.noticeSerial}</span>
		</div>
	</div> --%>
	<!-- layui静态表格 -->
	<table class="layui-table">
		<thead>
				<tr>
					<td align="center">仓房编号</td>
					<td align="center">粮食品种</td>
					<c:if test="${noticeType =='出库' }">
					<td align="center">提货单位</td>
					</c:if>
					<td align="center">合同数量(吨)</td>
					<td align="center">上期累计(吨)</td>
					<td align="center">本期(吨)</td>
					<td align="center">累计(吨)</td>
					<td align="center">完成率(%)</td>
					<td align="center">备注</td>
				</tr>


		</thead>
		<tbody>

			<c:forEach items="${detailList}" var="item" varStatus="status">
				<tr>
					
						<td align="left">${item.storehouse}</td>
						<td align="left">${item.grainType}</td>
					
					<c:if test="${noticeType =='出库' }">
						<td align="left">${item.deliveryUnit}</td>
					</c:if>
					
					<td align="right">${item.quantity}</td>
					<td align="right">${item.priorPeriod}</td>

					<td align="right">${item.currentPeriod}</td>
					
						<td align="right">${item.total}</td>

					<td align="right">${item.compleRate}</td>
					<td align="left" style="word-wrap:break-word;word-break:break-all;">${item.remark}</td>

				</tr>
			</c:forEach>


		</tbody>
	</table>

</div>



<script>
	
</script>
<%-- <%@include file="../common/AdminFooter.jsp"%> --%>