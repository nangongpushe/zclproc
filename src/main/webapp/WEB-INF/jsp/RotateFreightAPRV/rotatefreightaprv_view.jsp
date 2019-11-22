<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>


<style>
	table#view td{
	width:100px;
	}
</style>

<div class="container clearfix" style="padding: 10px">
	
	<div class="layui-row">
		<div class="layui-col-md3">
			<span>填报人:</span> <span>${model.reporter}</span>
		</div>
		<div class="layui-col-md3">
			<span>填报时间:</span> <span><fmt:formatDate value="${model.reportDate}" pattern="yyyy-MM-dd"/></span>
		</div>

	</div>
	<!-- layui静态表格 -->
	<table class="layui-table" id="view">
		<thead>
				<tr>
					<td>调出单位</td>
					<td>调出库点起运地</td>
					<td>调入单位</td>
					<td>调入库点到达地</td>
					<td>品种</td>
					<td>运距(公里)</td>
					<td>运输方式</td>
					<td>数 量(吨)</td>
					<td>散运(吨)</td>
					<td>包装(吨)</td>
					<%--<td>运费单价(元/吨)</td>--%>
					<td>散运运费单价(元/吨)</td>
					<td>包装运费单价(元/吨)</td>
					<td>散运板前费率(元/吨)</td>
					<td>包装板前费率(元/吨)</td>
					<td>散运入库费率(元/吨)</td>
					<td>包装入库费率(元/吨)</td>

					<td>运费(元)</td>
					<td>其他费用(元)</td>
					<td>板前费(元)</td>
					<td>入库费(元)</td>
					<td>费用合计(元)</td>
					<td>备注</td>
				</tr>


		</thead>
		<tbody>

				<c:forEach items="${model.detailList}" var="item"
					varStatus="status">
				<tr>
					<td>${item.outUnit}</td>
					<td>${item.outStartPlace}</td>
					<td>${item.reportUnit}</td>
					<td>${item.inAimPlace}</td>
					<td>${item.grainType}</td>
					<td>${item.distance}</td>
					<td>${item.shipType}</td>
					<td>${item.quantity}</td>
					<td>${item.bulk}</td>
					<td>${item.packageNum}</td>
					<%--<td>${item.freightUnit}</td>--%>
					<td>${item.bulkFreightUnit}</td>
					<td>${item.packageFreightUnit}</td>
					<td>${item.bulkPreBoardRate}</td>
					<td>${item.packagePreBoardRate}</td>
					<td>${item.bulkInStoreRate}</td>
					<td>${item.packageInStoreRate}</td>

					<td>${item.freight}</td>
					<td>${item.otherFee}</td>
					<td>${item.boardFee}</td>
					<td>${item.warehouseFee}</td>
					<td>${item.totalFee}</td>
					<td>${item.remark}</td>
				</tr>
			</c:forEach>


		</tbody>
	</table>

</div>



<script>
	
</script>
<%-- <%@include file="../common/AdminFooter.jsp"%> --%>