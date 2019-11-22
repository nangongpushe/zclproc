<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<div class="container-box clearfix" style="padding: 10px">

	<!-- layui静态表格 -->
	<table class="layui-table">
		<thead>
			<tr>
				<td style="text-align: center">序号</td>
				<td style="text-align: center">轮换类别</td>
				<td style="text-align: center">粮食品种</td>
				<td style="text-align: center">收获年份</td>
				<td style="text-align: center">产地</td>
				<td style="text-align: center">轮换数量(吨)</td>
				<td style="text-align: center">已轮换数量(吨)</td>
				<td style="text-align: center">等级</td>
			</tr>
		</thead>
		<tbody>


			<c:forEach items="${rotatePlanmainDetail}" var="item" varStatus="status">
				<tr>
					<td style="text-align: right">${status.count}</td>
					<td  style="text-align: left">${item.rotateType}</td>
					<td style="text-align: left">${item.foodType}</td>
					<td style="text-align: center">${item.yieldTime}</td>
					<td style="text-align: left">${item.orign}</td>
					<td style="text-align: right">${item.rotateNumber}</td>
					<td style="text-align: right">${item.dealDetailNumber}</td>
					<%--<td style="text-align: left">${item.qualityQuota.grade}</td>--%>
					<td style="text-align: right">${item.grade}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<c:if test="${rotatePlanmainDetail==null||fn:length(rotatePlanmainDetail)==0}">
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