<%@ page contentType="application/vnd.ms-excel; charset=utf-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	<%--<BODY class="body_MarginLR10px" style="margin-right:0px;">
		<TABLE width="100%" align="center">
			<tr>
				<td>
					<TABLE width="100%" align="center">
						<tr><td colspan="${fn:length(bzwList[0])+5}" class="title">省储备粮管理有限公司包装物汇总表</td></tr>
						<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
						<tr><td>填报部门：</td><td></td><td></td><td style='mso-number-format:"\@"'>${monthReport.reportMonth}</td><td></td><td></td><td>单位：条</td></tr>
					</TABLE>
				</td>
			</tr>
			<tr>
				<td>
					<TABLE cellSpacing="1" cellPadding="1" border="1" width="100%" align="center" id="content">
						<thead>
							<tr>
								<th rowspan="2">序号</th>
								<th rowspan="2" colspan="3">包装物名称</th>
								<th colspan="${fn:length(bzwList[0])}">单位名称</th>
								<th rowspan="2">公司合计</th>
							</tr>
							<tr>
								<c:forEach items="${bzwList[0]}" var="o">
									<th>${o}</th>
								</c:forEach>
							</tr>
						</thead>
						<tbody>
							<tr class="text-center">
								<td rowspan="4">1</td>
								<td rowspan="4">公司名称</td>
								<td rowspan="2">标新袋</td>
								<td>小计</td>
								<c:forEach items="${bzwList[1]}" var="o">
									<td>${o}</td>
								</c:forEach>
							</tr>
							<tr>
								<td>其中空麻袋</td>
								<c:forEach items="${bzwList[2]}" var="o">
									<td>${o}</td>
								</c:forEach>
							</tr>
							<tr>
								<td rowspan="2">标旧袋</td>
								<td>小计</td>
								<c:forEach items="${bzwList[3]}" var="o">
									<td>${o}</td>
								</c:forEach>
							</tr>
							<tr>
								<td>其中空麻袋</td>
								<c:forEach items="${bzwList[4]}" var="o">
									<td>${o}</td>
								</c:forEach>
							</tr>
							<tr>
								<td>2</td>
								<td colspan="3">总计</td>
								<c:forEach items="${bzwList[5]}" var="o">
									<td>${o}</td>
								</c:forEach>
							</tr>
							<tr>
								<td>3</td>
								<td colspan="3">备注</td>
								<td colspan="${fn:length(bzwList[1])}">${monthReport.remark}</td>
							</tr>
						</tbody>
					</TABLE>
				</td>
			</tr>
			<tr>
				<td>
					<TABLE width="100%" align="center">
						<tr><td colspan="2">单位负责人：</td><td colspan="2">统计负责人：${monthReport.manager}</td><td colspan="2">制表人：${userInfo.name}</td><td>日期：<fmt:formatDate value="${ monthReport.createDate }"  pattern="yyyy年MM月dd日"/></td></tr>
					</TABLE>
				</td>
			</tr>
		</TABLE>
	</BODY>--%>
	<BODY class="body_MarginLR10px" style="margin-right:0px;">
		<TABLE width="100%" align="center">
			<tr>
				<td>
					<TABLE width="100%" align="center">
						<tr><td colspan="${fn:length(reportWarehouses)+3}" class="title">省储备粮管理有限公司包装物汇总表</td></tr>
						<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
						<tr><td>填报部门：</td><td></td><td style='mso-number-format:"\@"'>${monthReport.reportMonth}</td><td></td><td>单位：条</td></tr>
					</TABLE>
				</td>
			</tr>
			<tr>
				<td>
					<TABLE cellSpacing="1" cellPadding="1" border="1" width="100%" align="center" id="content">
						<thead>
							<tr>
								<th rowspan="2" colspan="2">包装物名称</th>
								<th colspan="${fn:length(reportWarehouses)}">单位名称</th>
								<th rowspan="2">公司合计</th>
							</tr>
							<tr>
								<c:forEach items="${reportWarehouses}" var="o">
									<th>${o}</th>
								</c:forEach>
							</tr>
						</thead>
						<tbody>
						<tr class="text-center">
							<td rowspan="5">标新袋</td>
							<td>装粮麻袋</td>
							<c:forEach items="${list1_1}" var="o">
								<td>${o}</td>
							</c:forEach>
						</tr>
							<tr>
								<td>调运麻袋</td>
								<c:forEach items="${list1_2}" var="o">
									<td>${o}</td>
								</c:forEach>
							</tr>
							<tr>
								<td>其他用途</td>
								<c:forEach items="${list1_3}" var="o">
									<td>${o}</td>
								</c:forEach>
							</tr>
							<tr>
								<td>空麻袋</td>
								<c:forEach items="${list1_4}" var="o">
									<td>${o}</td>
								</c:forEach>
							</tr>
							<tr>
								<td>小计</td>
								<c:forEach items="${list1_5}" var="o">
									<td>${o}</td>
								</c:forEach>
							</tr>

							<tr class="text-center">
								<td rowspan="5">标旧袋</td>
								<td>装粮麻袋</td>
								<c:forEach items="${list2_1}" var="o">
									<td>${o}</td>
								</c:forEach>
							</tr>
							<tr>
								<td>调运麻袋</td>
								<c:forEach items="${list2_2}" var="o">
									<td>${o}</td>
								</c:forEach>
							</tr>
							<tr>
								<td>其他用途</td>
								<c:forEach items="${list2_3}" var="o">
									<td>${o}</td>
								</c:forEach>
							</tr>
							<tr>
								<td>空麻袋</td>
								<c:forEach items="${list2_4}" var="o">
									<td>${o}</td>
								</c:forEach>
							</tr>
							<tr>
								<td>小计</td>
								<c:forEach items="${list2_5}" var="o">
									<td>${o}</td>
								</c:forEach>
							</tr>


							<tr class="text-center">
								<td rowspan="5">杂袋</td>
								<td>装粮麻袋</td>
								<c:forEach items="${list3_1}" var="o">
									<td>${o}</td>
								</c:forEach>
							</tr>
							<tr>
								<td>调运麻袋</td>
								<c:forEach items="${list3_2}" var="o">
									<td>${o}</td>
								</c:forEach>
							</tr>
							<tr>
								<td>其他用途</td>
								<c:forEach items="${list3_3}" var="o">
									<td>${o}</td>
								</c:forEach>
							</tr>
							<tr>
								<td>空麻袋</td>
								<c:forEach items="${list3_4}" var="o">
									<td>${o}</td>
								</c:forEach>
							</tr>
							<tr>
								<td>小计</td>
								<c:forEach items="${list3_5}" var="o">
									<td>${o}</td>
								</c:forEach>
							</tr>

						<tr class="text-center">
							<td>废袋</td>
							<td>空麻袋</td>
							<c:forEach items="${list4_1}" var="o">
								<td>${o}</td>
							</c:forEach>
						</tr>

						<tr class="text-center">
							<td colspan="2">总计</td>
							<c:forEach items="${list5_1}" var="o">
								<td>${o}</td>
							</c:forEach>
						</tr>

						</tbody>
					</TABLE>
				</td>
			</tr>
			<tr>
				<td>
					<TABLE width="100%" align="center">
						<tr><td colspan="1">单位负责人：</td><td colspan="1">统计负责人：${monthReport.manager}</td><td colspan="1">制表人：${userInfo.name}</td><td>日期：<fmt:formatDate value="${ monthReport.createDate }"  pattern="yyyy年MM月dd日"/></td></tr>
					</TABLE>
				</td>
			</tr>
		</TABLE>
	</BODY>
</HTML>

