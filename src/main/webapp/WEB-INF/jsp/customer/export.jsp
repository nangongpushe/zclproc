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
								<th>企业名称</th>
								<th>企业统一社会信用代码</th>
								<th>企业注册号</th>
								<th>登记注册类型</th>
								<th>是否具备储备粮代储资格</th>
								<th>法定代表人</th>
								<th>企业电话</th>
								<th>企业联系人</th>
								<th>企业从事人员数</th>
								
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
								<TD style="vnd.ms-excel.numberformat:@">${export.clientName}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.socialCreditCode}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.organizationCode}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.registType}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.extraQualification}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.personIncharge}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.telephone}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.contactor}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.employedNum}</TD>
								
							</TR>
						</c:forEach>
							
					</TABLE>
				</td>
			</tr>
		</table>
	</BODY>
</HTML>