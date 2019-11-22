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
				<td class="td_white" colspan="20">
					<TABLE id="box01" cellSpacing="1" cellPadding="1" border="1" width="100%" align="center" class="table_border01">
						<thead>
			 
							<tr>
								<th>物资编码</th>
								<th>品名</th>
								<th>类别</th>
								<th>维修日期</th>
								<th>维修保养人员</th>
								<th>维修内容</th>
								
								<th>备注</th>
								
							</tr>
						</thead>
						
						<c:if test="${empty exportList}">
							<tr  class="td_bg01">
						 		<td colspan="9" align="center" height="30">
						 			<span><font color="red">对不起,没有您所查找的信息!</font></span>
						 		</td>
						 	</tr>
						</c:if>
						
						<c:forEach items="${exportList}" var="export">
							<TR align="center">
								<TD>${export.encode}</TD>
								<TD>${export.commodity}</TD>
								<TD>${export.type}</TD>
								<TD>${export.maintainDate}</TD>
								<TD>${export.maintainMan}</TD>
								<TD>${export.maintainContent}</TD>
								<TD>${export.remark}</TD>
								
							</TR>
						</c:forEach>
							
					</TABLE>
				</td>
			</tr>
		</table>
	</BODY>
</HTML>