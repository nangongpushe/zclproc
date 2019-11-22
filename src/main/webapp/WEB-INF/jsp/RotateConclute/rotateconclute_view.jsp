<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>

<%-- <%@include file="../common/AdminHeader.jsp"%> --%>


<div class="container clearfix" style="padding: 10px">
	
	<div class="layui-row">
		<div class="layui-col-md4">
			<span>成交明细号:</span> <span>${model.dealSerial}</span>
		</div>
		<div class="layui-col-md4">
			<span>粮食品种:</span> <span>${model.grainType}</span>
		</div>
		<div class="layui-col-md4">
			<span>招标类别:</span> <span>${model.inviteType}</span>
		</div>
		<div class="layui-col-md4">
			<span>竞价交易时间:</span> <span>
						<fmt:formatDate
					value="${model.dealDate}" pattern="yyyy-MM-dd" />
			</span>
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
		<div class="layui-col-md4">
			<span>备注:</span> <span>${model.remark}</span>
		</div>


	</div>
	<!-- layui静态表格 -->
	<table class="layui-table">
		<thead>
				<tr>
				<td align="center">成交子明细号</td>
				<td align="center">标段</td>
				<c:if test="${model.inviteType =='招标采购' }">
					<td align="center">企业</td>
					<td align="center">接收所属库点</td>
				</c:if>
				<c:if test="${model.inviteType !='招标采购' }">
					<td align="center">交货所属库点</td>
				</c:if>
					<td align="center">仓房编号</td>
					<td align="center">粮食品种</td>
					<td align="center">数量(吨)</td>

					<td align="center">产地</td>
				<c:if test="${model.inviteType =='招标采购' }">
					<td align="center">收获年份</td>
				</c:if>
				<c:if test="${model.inviteType !='招标采购' }">
					<td align="center">入库年度</td>
					<td align="center">储存方式</td>
				</c:if>

					<td align="center">成交价格(元/吨)</td>

					<td align="center">成交金额(元)</td>
				<c:if test="${model.inviteType !='招标采购' }">
					<td align="center">提货截止时间</td>
				</c:if>
				<c:if test="${model.inviteType =='招标采购' }">
					<td align="center">交货起始日期</td>
					<td align="center">交货截止日期</td>
					<td align="center">货款支付免息截止日期</td>
				</c:if>

					<td align="center">成交单位</td>
				</tr>


		</thead>
		<tbody>
			<c:forEach items="${model.detailList}" var="item" varStatus="status">
				<tr>
					<td align="left">${item.dealSerial}</td>
					<td align="left">${item.bidSerial}</td>
					<c:if test="${model.inviteType =='招标采购' }">
						<td align="left">${item.enterpriseName}</td>
						<td align="left">${item.receivePlace}</td>
					</c:if>
					<c:if test="${model.inviteType !='招标采购' }">
						<td align="left">${item.deliveryPlace}</td>
					</c:if>
					<td align="left">${item.storehouse}</td>
					<td align="left">${item.grainType}</td>
					<td align="right">${item.quantity}</td>

					<td align="left">${item.produceArea}</td>
					<c:if test="${model.inviteType =='招标采购' }">
						<td align="center">${item.produceYear}</td>
					</c:if>					
					<c:if test="${model.inviteType !='招标采购' }">
						<td align="center">${item.warehoueYear}</td>
						<td align="left">${item.storageType}</td>
					</c:if>

					<td align="right">${item.dealPrice}</td>

					<td align="right">${item.dealAmount}</td>
					<c:if test="${model.inviteType !='招标采购' }">
						<td align="center">${item.takeEnd}</td>
					</c:if>
					<c:if test="${model.inviteType =='招标采购' }">
						<td align="center">${item.deliveryStart}</td>
						<td align="center">${item.deliveryEnd}</td>
						<td align="center">
                            <c:choose>
                                <c:when test="${item.loanPaymentEndDate eq null }">
                                    ———
                                </c:when>
                                <c:otherwise>
                                    ${item.loanPaymentEndDate}
                                </c:otherwise>
                            </c:choose>
                        </td>
					</c:if>	
					
					<td align="left" onclick="showClientInfo('${item.dealUnit}')">${item.dealUnit}</td>

				</tr>
			</c:forEach>


		</tbody>
	</table>
	<div class="layui-row text-center">
		<a href="../rotateConclute/exportExcel.shtml?id=${model.id}&type=${type}" class="layui-btn layui-btn-small" id="exportExcel">导出</a>
		<a type="button" class="layui-btn layui-btn-small" onclick="layer.closeAll();">关闭</a>
	</div>
	
</div>



<script>
    function showClientInfo(clientName) {
        var url = "../CustomerInformation/clientInfo.shtml?";
        $.post(url, {clientName:clientName}, function(str) {
            layer.open({
                closeBtn:1,
                type : 1,
                content : str,
                area:['800px','400px']
            });
        });
    }
</script>
<%-- <%@include file="../common/AdminFooter.jsp"%> --%>