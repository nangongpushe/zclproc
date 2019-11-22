<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<div class="container clearfix" style="padding: 10px">
	
	<!-- layui静态表格 -->
	<table class="layui-table">
		<thead>
				<tr>
					<td style="text-align: center">审核人</td>
					<td style="text-align: center">审核意见</td>
					<td style="text-align: center">原因</td>
					<td style="text-align: center">审核时间</td>
				</tr>


		</thead>
		<tbody>

			<c:forEach items="${auditList}" var="item" varStatus="status">
				<tr>

					<td style="width:180px;text-align: left">${item.auditorName}</td>
					<td style="width:180px;text-align: left">${item.advice}</td>

					<td style="width:180px;text-align: left">${item.reason}</td>

					<td style="width:180px;text-align: center"><fmt:formatDate value="${item.auditDate}" pattern="yyyy-MM-dd hh:mm:ss" /></td>

				</tr>
			</c:forEach>


		</tbody>
	</table>
</div>
