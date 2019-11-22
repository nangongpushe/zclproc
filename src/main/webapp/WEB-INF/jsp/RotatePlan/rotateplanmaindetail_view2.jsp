<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="container-box clearfix" style="padding: 10px">
	<fieldset class="layui-elem-field layui-field-title text-center"
		style="margin-top: 20px;">
		<legend>${rotatePlan.planName}</legend>
	</fieldset>
		<div class="layui-row">
		<div class="layui-col-md3">
			<span>计划年份:</span> <span data-field="department">${rotatePlan.year}</span>
		</div>
		<div class="layui-col-md3">
			<span>填报部门:</span> <span data-field="colletor">${rotatePlan.department}</span>
		</div>
		<div class="layui-col-md3">
			<span>经办人：</span> <span data-field="modifier">${rotatePlan.colletor}</span>
		</div>
		<div class="layui-col-md3">
			<span>经办时间：</span> <span><fmt:formatDate value="${rotatePlan.colletorDate}" pattern="yyyy-MM-dd" /></span>
		</div>
	</div>
	<!-- layui静态表格 -->
	<table class="layui-table">
		<thead>
			<tr>
				<td>序号</td>
				<td>轮换类别</td>
				<td>粮食品种</td>
				<td>收获年份</td>
				<td>产地</td>
				<td>等级</td>
				<td>轮换数量(吨)</td>
				<td>已轮换数量(吨)</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${rotatePlan.planmainDetail}" var="item" varStatus="status">
				<tr>
					<td style="text-align:right">${status.count}</td>
					<td style="text-align:left">${item.rotateType}</td>
					<td style="text-align:left">${item.foodType}</td>
					<td style="text-align:center">${item.yieldTime}</td>
					<td style="text-align:left">${item.orign}</td>
					<%--<td style="text-align:left">${item.qualityQuota.grade}</td>--%>
					<td style="text-align:right">${item.grade}</td>
					<td style="text-align:right">${item.rotateNumber}</td>
					<%--<td style="text-align:right">${item.detailNumber}</td>--%>
					<td style="text-align:right">${item.dealDetailNumber}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<div style="border: 1px #D8D8D8 solid; margin-top: 10px;">
		<div
				style="background-color: #f8f8f8; height: 40px; line-height: 40px">
			<label style="padding-left: 20px">备注</label>
		</div>
		<div class="opinion_list clearfix" style="margin-left: 20px;">
			<div class="pull-left" style="margin-top:20px;">
				<span>${rotatePlan.description }</span>
			</div>
		</div>
	</div>
	<c:if test="${myFile!=null}">
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
				<div class="pull-left" style="margin-top:20px;">
					<span>${myFile.fileName }</span>
					<a href="../sysFile/download.shtml?fileId=${myFile.id}" style="color: #0000FF; margin-left: 20px">下载</a>
					<c:if test="${suffix =='xls'||suffix =='xlsx'||suffix =='doc'||suffix =='docx'}">
					<a href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${myFile.downloadUrl}','width=1200px;height=800px;')" id="openExcel" style="color: #0000FF; margin-left: 20px">
						预览
					</a>
					</c:if>
					<c:if test="${suffix!='xls'&&suffix!='xlsx'&&suffix!='doc'&&suffix!='docx'}">
					<a href="javascript:openAnnex('${myFile.id}')" id="openFile">
						预览
					</a>
					</c:if>
				</div>
			</div>
		</div>
	</c:if>
	<div class="layui-row text-center">
		<a href="../rotatePlan/exportExcelPlan.shtml?id=${rotatePlan.id}&type=${type}" class="layui-btn layui-btn-small" id="exportExcel">导出</a>
	</div>
</div>