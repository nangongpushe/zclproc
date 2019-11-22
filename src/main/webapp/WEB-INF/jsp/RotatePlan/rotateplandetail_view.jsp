<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- <%@include file="../common/AdminHeader.jsp"%> --%>

<!-- <div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>轮换计划</li>
		<li class="active">计划清单</li>
	</ol>
</div> -->

<div class="container-box clearfix" style="padding: 10px">

	<!-- layui静态表格 -->
	<table class="layui-table">
		<thead>
			<tr>
				<td>序号</td>
				<td>轮换类别</td>
				<td>所属库点</td>
				<c:if test="${rotateType=='轮出'}">				
				<td>所属仓号</td>
				</c:if>
				<td>粮食品种</td>
				<td>收获年份</td>
				<td>产地</td>
				<c:if test="${rotateType=='轮入'}">
					<td>仓号</td>
				</c:if>
				<td>轮换数量(吨)</td>
				<td>存储方式</td>
				<c:if test="${rotateType=='轮入'}">
					<td>等级</td>
					<td>质量详情</td>
				</c:if>
				

				<td>出糙(%)</td>
				<td>容重(g/L)</td>
				<td>杂质(%)</td>
				<td>水分(%)</td>
				<td>黄米粒(%)</td>
				<td>不完善粒(%)</td>
				<td>小麦湿面筋(%)</td>
				<td>酸价(KOH)(mg/g)</td>
				<td>过氧化值(mmol/kg)</td>
			</tr>
		</thead>
		<tbody>


			<c:forEach items="${rotatePlanDetail}" var="item" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td>${item.rotateType}</td>
					<td>${item.libraryName}</td>
					<c:if test="${rotateType=='轮出'}">				
					<td>${item.barnNumber}</td>
					</c:if>
					<td>${item.foodType}</td>
					<td>${item.yieldTime}</td>
					<td>${item.orign}</td>
					<c:if test="${rotateType=='轮入'}">
						<td>${item.barnNumber}</td>
					</c:if>
					<td>${item.rotateNumber}</td>
					<td>${item.storeType}</td>
					<c:choose>
						<c:when test="${rotateType=='轮出'}">
							<td>${item.swtz.brown!=null&&item.swtz.brown!=''?item.swtz.brown:'--'}</td>
							<td>${item.swtz.unitWeight!=null&&item.swtz.unitWeight!=''?item.swtz.unitWeight:'--'}</td>
							<td>${item.swtz.impurity!=null&&item.swtz.impurity!=''?item.swtz.impurity:'--'}</td>
							<td>${item.swtz.dew!=null&&item.swtz.dew!=''?item.swtz.dew:''}</td>
							<td>${item.swtz.yellowRice!=null&&item.swtz.yellowRice!=''?item.swtz.yellowRice:'--'}</td>
							<td>${item.swtz.unsoundGrain!=null&&item.swtz.unsoundGrain!=''?item.swtz.unsoundGrain:'--'}</td>
							<td>${item.swtz.wetGluten!=null&&item.swtz.wetGluten!=''?item.swtz.wetGluten:'--'}</td>
							<td>${item.swtz.koh!=null&&item.swtz.koh!=''?item.swtz.koh:'--'}</td>
							<td>${item.swtz.mmol!=null&&item.swtz.mmol!=''?item.swtz.mmol:'--'}</td>
						</c:when>
						<c:otherwise>
							<td>${item.quality}</td>
							<td>${item.qualityDetail}</td>
							<td>${item.quotaItemMap["出糙"]!=null&&item.quotaItemMap["出糙"]!=''?item.quotaItemMap["出糙"]:"--"}</td>
							<td>${item.quotaItemMap["容重"]!=null&&item.quotaItemMap["容重"]!=''?item.quotaItemMap["容重"]:"--"}</td>
							<td>${item.quotaItemMap["杂质"]!=null&&item.quotaItemMap["杂质"]!=''?item.quotaItemMap["杂质"]:"--"}</td>
							<td>${item.quotaItemMap["水分"]!=null&&item.quotaItemMap["水分"]!=''?tem.quotaItemMap["水分"]:"--"}</td>
							<td>${item.quotaItemMap["黄米粒"]!=null&&item.quotaItemMap["黄米粒"]!=''?item.quotaItemMap["黄米粒"]:"--"}</td>
							<td>${item.quotaItemMap["不完善粒"]!=null&&item.quotaItemMap["不完善粒"]!=''?item.quotaItemMap["不完善粒"]:"--"}</td>
							<td>${item.quotaItemMap["小麦湿面筋"]!=null&&item.quotaItemMap["小麦湿面筋"]!=''?item.quotaItemMap["小麦湿面筋"]:"--"}</td>
							<td>${item.quotaItemMap["酸价"]!=null&&item.quotaItemMap["酸价"]!=''?item.quotaItemMap["酸价"]:"--"}</td>
							<td>${item.quotaItemMap["过氧化值"]!=null&&item.quotaItemMap["过氧化值"]!=''?item.quotaItemMap["过氧化值"]:"--"}</td>
						</c:otherwise>
					</c:choose>

				</tr>
			</c:forEach>


		</tbody>
	</table>

	<c:if test="${rotatePlanDetail==null||fn:length(rotatePlanDetail)==0}">
		<div class="layui-row text-center">无数据</div>
	</c:if>

	<c:if test="${rotatePlan.attachment}!=null">
		<div style="border: 1px #D8D8D8 solid; margin-top: 10px;">
			<div
				style="background-color: #f8f8f8; height: 40px; line-height: 40px">
				<label style="padding-left: 20px">附件</label>
			</div>
			<div class="opinion_list clearfix" style="margin-left: 20px;">
				<div class="pull-left"
					style="width: 43px; height: 43px; background-color: #f6f7f7; margin-top: 10px">
					<i class="layui-icon 21cake_list"
						style="font-size: 40px; color: #1E9FFF;"></i>
				</div>
				<div class="pull-left">
					<p>2017年省级储备粮轮换计划意见.docx</p>
					<p>
						<a style="color: #0000FF">预览</a><a
							style="color: #0000FF; margin-left: 20px">下载</a>
					</p>
				</div>
			</div>
		</div>
	</c:if>

</div>



<script>
	
</script>
<%-- <%@include file="../common/AdminFooter.jsp"%> --%>