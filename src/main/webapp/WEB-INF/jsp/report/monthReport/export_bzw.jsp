<%@ page contentType="application/vnd.ms-excel; charset=utf-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<HTML>
<head>
<meta http-equiv="Content-Type"
		content="application/ms-excel; charset=utf-8"/>
	<style>
		#content td,th{
			text-align:center;
		}
		.title{
			font-size:42px;
			text-align:center;
		}
	</style>
</head>
	<BODY class="body_MarginLR10px" style="margin-right:0px;">
		<TABLE width="100%" align="center">
			<tr>
				<td>
					<TABLE width="100%" align="center">
						<tr><td colspan="10" class="title">包  装  物  库  存  台  账</td></tr>
						<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
						<tr><td colspan="4">单位名称：${userInfo.company}</td><td style='mso-number-format:"\@"'>${monthReport.reportMonth}</td><td colspan="4"></td><td>单位：条</td></tr>
					</TABLE>
				</td>
			</tr>
			<tr>
				<td>
					<TABLE cellSpacing="1" cellPadding="1" border="1" width="100%" align="center" id="content">
						<thead>
							<tr>
								<th rowspan="2">储存库点名称</th>
								<th rowspan="2">仓号<br>(货位)</th><th rowspan="2">包装物用途</th><th rowspan="2">管理属性</th><th rowspan="2">数量</th><th colspan="4">包装物性质</th><th rowspan="2">备注</th>
							</tr>
							<tr>
								<th>标新</th><th>标旧</th><th>杂袋</th><th>废袋</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${bzwList}" var="o">
								<tr class="text-center">
									<td>${o.reportWarehouse}</td><td>${o.storehouse}</td><td>${o.packageProperty}</td><td>${o.manageProperty}</td><td>${o.subtotal}</td><td>${o.biaoxin}</td><td>${o.biaojiu}</td><td>${o.zadai}</td><td>${o.feidai}</td><td>${o.remark}</td>
								</tr>
							</c:forEach>
						</tbody>
					</TABLE>
				</td>
			</tr>
			<tr>
				<td>
					<TABLE width="100%" align="center">
						<tr><td colspan="3">单位负责人：</td><td colspan="3">统计负责人：${monthReport.manager}</td><td colspan="3">制表人：${userInfo.name}</td><td>日期：<fmt:formatDate value="${ monthReport.createDate }"  pattern="yyyy年MM月dd日"/></td></tr>
					</TABLE>
				</td>
			</tr>
		</TABLE>
	</BODY>
</HTML>

