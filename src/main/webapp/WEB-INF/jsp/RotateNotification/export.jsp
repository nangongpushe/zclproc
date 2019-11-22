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
			<td colspan="12"  style="text-align:center" >提货单汇总导出信息</td>
		</tr>
			<tr>
				<td class="td_white" colspan="20">
					<TABLE id="box01" cellSpacing="1" cellPadding="1" border="1" width="100%" align="center" class="table_border01">
						<thead>
							<tr>
								<th colspan="3">库点名称</th>
								<th colspan="3">粮食品种</th>
								<th colspan="3">年份</th>
								<th colspan="3">数量</th>
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
								<TD style="vnd.ms-excel.numberformat:@" colspan="3">${export.wareHouseShort}</TD>
								<TD style="vnd.ms-excel.numberformat:@" colspan="3">${export.variety}</TD>
								<TD style="vnd.ms-excel.numberformat:@" colspan="3">${export.wareHouseYear}</TD>
								<TD style="vnd.ms-excel.numberformat:@" colspan="3">${export.shipment}</TD>
							</TR>
						</c:forEach>
							
					</TABLE>
				</td>
			</tr>
		</table>
	</BODY>
</HTML>