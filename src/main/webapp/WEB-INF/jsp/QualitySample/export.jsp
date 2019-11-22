<%@ page contentType="application/vnd.ms-excel; charset=utf-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<HTML>
<head>
<meta http-equiv="Content-Type"
		content="application/ms-excel; charset=utf-8">
</head>
	<BODY class="body_MarginLR10px" style="margin-right:0px;">	
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td colspan="12"  style="text-align:center" >样品信息导出信息</td>
		</tr>
			<tr>
				<td class="td_white" colspan="20">
					<TABLE id="box01" cellSpacing="1" cellPadding="1" border="1" width="100%" align="center" class="table_border01">
						<thead>
							<tr>
								<th>样品编号</th>
								<th>样品来源</th>
								<th>仓/罐号</th>
								<th>粮食品种</th>
								<th>收获年份</th>
								<th>产地</th>
								<th>扦样日期</th>
								<th>扦样人</th>
								<th>检验人</th>
								<th>检验时间</th>
								<th>样品状态</th>
								<th>数量</th>
							</tr>
						</thead>
						
						<c:if test="${empty exportList}">
							<tr  class="td_bg01">
						 		<td colspan="10" align="center" height="30">
						 			<span><font color="red">对不起,没有您所查找的信息!</font></span>
						 		</td>
						 	</tr>
						</c:if>
						<c:forEach items="${exportList}" var="export">
							<TR align="center">
								<TD style="vnd.ms-excel.numberformat:@">${export.sampleNo}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.sampleSouce}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.storehouse}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.variety}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.harvestYear}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.origin}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.samplingDate}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.samplingPeople}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.executor}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.testDate}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.testStatus}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.quantity}</TD>
							</TR>
						</c:forEach>
							
					</TABLE>
				</td>
			</tr>
		</table>
	</BODY>
</HTML>