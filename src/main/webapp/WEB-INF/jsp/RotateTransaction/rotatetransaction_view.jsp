<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>

<%-- <%@include file="../common/AdminHeader.jsp"%> --%>


<div class="container clearfix" style="padding: 10px">
	
	<div class="layui-row">
		<div class="layui-col-md4">
			<span>交易明细号:</span> <span>${model.dealSerial}</span>
		</div>
		<div class="layui-col-md4">
			<span>粮食品种:</span> <span>${model.grainType}</span>
		</div>
		<div class="layui-col-md4">
			<span>招标类别:</span> <span>${model.inviteType}</span>
		</div>
		<div class="layui-col-md4">
			<span>单位:</span> <span>${model.unit}</span>
		</div>
		<div class="layui-col-md4">
			<span>数量合计(吨):</span> <span>${model.totalQuantity}</span>
		</div>
		<div class="layui-col-md4">
			<span>成交价格合计(元/吨):</span> <span>${model.dealPriceTotal}</span>
		</div>
		<div class="layui-col-md4">
			<span>成交金额合计(元):</span> <span>${model.dealAmountTotal}</span>
		</div>
		<div class="layui-col-md4">
			<span>汇总部门:</span> <span>${model.gatherUnit}</div>
		<div class="layui-col-md4">
			<span>汇总人:</span> <span>${model.gather}</span>
		</div>
		<div class="layui-col-md4">
			<span>汇总时间:</span> <span>
			<fmt:formatDate
					value="${model.gatherDate}" pattern="yyyy-MM-dd" />
		</span>
		</div>

	</div>
	<!-- layui静态表格 -->
	<table class="layui-table">
		<thead>
				<tr>
					<td  align="center">交易子明细号</td>
					<td align="center">企业</td>
					<td  align="center">接收所属库点</td>
					<td  align="center">仓房编号</td>

					<td  align="center">粮食品种</td>
					<td  align="center">数量(吨)</td>

					<td  align="center">产地</td>

					<td  align="center">收获年份</td>

					<td align="center">包装方式</td>

					<td  align="center">成交价格(元/吨)</td>
					<td  align="center">成交金额(元)</td>

					<td  align="center">交货起始日期</td>
					<td  align="center">交货截止日期</td>
					<td  align="center">成交单位</td>
				</tr>


		</thead>
		<tbody>

			<c:forEach items="${model.detailList}" var="item" varStatus="status">
				<tr>
					<td  align="left">${item.dealSerial}</td>
					<td align="left">${item.enterpriseName}</td>
					<td  align="left">${item.receivePlace}</td>
					<td  align="left">${item.storehouse}</td>
					<td  align="left">${item.grainType}</td>
					<td  align="right">${item.quantity}</td>
					<td  align="left">${item.produceArea}</td>
					<td  align="center">${item.produceYear}</td>
					<td  align="center">${item.storageType}</td>
					<td  align="right">${item.dealPrice}</td>
					<td  align="right">${item.dealAmount}</td>
					<td  align="center">${item.deliveryStart}</td>
					<td  align="center">${item.deliveryEnd}</td>
					<td  align="left">${item.dealUnit}</td>

				</tr>
			</c:forEach>


		</tbody>
	</table>

</div>



<script>
	
</script>
<%-- <%@include file="../common/AdminFooter.jsp"%> --%>