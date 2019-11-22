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
			<td colspan="12"  style="text-align:center" >样品管理导出信息</td>
		</tr>
			<tr>
				<td class="td_white" colspan="20">
					<TABLE id="box01" cellSpacing="1" cellPadding="1" border="1" width="100%" align="center" class="table_border01">
						<thead>
			  
							<tr>
								<th>任务编号</th>
								<th>任务名称</th>
								<th>库点名称</th>
								<th>样品编号</th>
								<th>检验类型</th>
								<th>优先级</th>
								<th>执行人</th>
								<th>计划检验时间</th>
								<th>实际检验时间</th>
								<th>任务状态</th>
								<th>创建人</th>
								<th>创建时间</th>
								
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
								<TD style="vnd.ms-excel.numberformat:@">${export.taskSerial}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.taskName}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.wearhouse}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.sampleNo}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.inspectionType}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.taskPriority}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.taskExecutor}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.plannedInspectionTime}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.actualInspectionTime}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.taskStatus}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.creator}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.createDate}</TD>
							</TR>
						</c:forEach>
							
					</TABLE>
				</td>
			</tr>
		</table>
	</BODY>
</HTML>