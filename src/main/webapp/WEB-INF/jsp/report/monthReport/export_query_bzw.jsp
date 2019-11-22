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
						<tr><td colspan="8" class="title">省储备粮管理有限公司包装物库存月报表</td></tr>
						<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>
						<tr><td colspan="3">单位名称：${userInfo.company}</td><td style='mso-number-format:"\@"'>${monthReport.reportMonth}</td><td></td><td></td><td>单位：条</td></tr>
					</TABLE>
				</td>
			</tr>
			<tr>
				<td>
					<TABLE cellSpacing="1" cellPadding="1" border="1" width="100%" align="center" id="content">
						<tr>
							<th class="td_first text-center" rowspan="2">包装物性质</th><th class="td_first text-center" colspan="5">期 末 实 际 库 存</th><th class="td_first text-center" rowspan="2" colspan="2">备注</th>
						</tr>
						<tr>
							<th class="td_first text-center">装粮麻袋</th><th class="td_first text-center">调运麻袋</th><th class="td_first text-center">空 麻 袋</th><th class="td_first text-center">其他用途</th><th class="td_first text-center">小  计</th>
						</tr>
						<tr class="text-center">
							<td>标 新 袋</td><td>${bzwList[0].biaoxin}</td><td>${bzwList[1].biaoxin}</td><td>${bzwList[2].biaoxin}</td><td>${bzwList[3].biaoxin}</td><td>${bzwList[0].biaoxin+bzwList[1].biaoxin+bzwList[2].biaoxin+bzwList[3].biaoxin}</td><td colspan="2"></td>
						</tr>
						<tr class="text-center">
							<td>标 旧 袋</td><td>${bzwList[0].biaojiu}</td><td>${bzwList[1].biaojiu}</td><td>${bzwList[2].biaojiu}</td><td>${bzwList[3].biaojiu}</td><td>${bzwList[0].biaojiu+bzwList[1].biaojiu+bzwList[2].biaojiu+bzwList[3].biaojiu}</td><td colspan="2"></td>
						</tr>
						<tr class="text-center">
							<td>杂 袋</td><td>${bzwList[0].zadai}</td><td>${bzwList[1].zadai}</td><td>${bzwList[2].zadai}</td><td>${bzwList[3].zadai}</td><td>${bzwList[0].zadai+bzwList[1].zadai+bzwList[2].zadai+bzwList[3].zadai}</td><td colspan="2"></td>
						</tr>
						<tr class="text-center">
							<td>废 袋</td><td>${bzwList[0].feidai}</td><td>${bzwList[1].feidai}</td><td>${bzwList[2].feidai}</td><td>${bzwList[3].feidai}</td><td>${bzwList[0].feidai+bzwList[1].feidai+bzwList[2].feidai+bzwList[3].feidai}</td><td colspan="2"></td>
						</tr>
						<tr class="text-center">
							<td>总     计</td><td>${bzwList[0].subtotal}</td><td>${bzwList[1].subtotal}</td><td>${bzwList[2].subtotal}</td><td>${bzwList[3].subtotal}</td><td>${bzwList[0].subtotal+bzwList[1].subtotal+bzwList[2].subtotal+bzwList[3].subtotal}</td><td colspan="2"></td>
						</tr>
						<tr class="text-center">
							<td>备     注</td><td colspan="7"></td>
						</tr>
					</TABLE>
				</td>
			</tr>
			<tr>
				<td>
					<TABLE width="100%" align="center">
						<tr><td colspan="2">单位负责人：</td><td colspan="2">统计负责人：${monthReport.manager}</td><td colspan="2">制表人：${userInfo.name}</td><td colspan="2">日期：<fmt:formatDate value="${ monthReport.createDate }"  pattern="yyyy年MM月dd日"/></td></tr>
					</TABLE>
				</td>
			</tr>
		</TABLE>
	</BODY>
</HTML>

