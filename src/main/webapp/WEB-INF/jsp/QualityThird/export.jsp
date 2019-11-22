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
			<td colspan="10"  style="text-align:center" >第三方质检记录导出信息</td>
		</tr>
			<tr>
				<td class="td_white" colspan="20">
					<TABLE id="box01" cellSpacing="1" cellPadding="1" border="1" width="100%" align="center" class="table_border01">
						<thead>
							<tr>
								<th>样品编号</th>
								<th>样品名称</th>
								<th>受检单位</th>
								<th>承检单位</th>
								<th>检验日期</th>
								<th>抽样基数(吨)</th>
								<th>抽样地点</th>
								<th>粮食产地</th>
								<th>入库时间</th>
								<th>储存方式</th>
								<c:forEach items="${testItes }" var="testItems">
									<th>${testItems.key}</th>
								</c:forEach>
								<th>质量指标判定</th>
								<th>存储品质指标判定</th>
							</tr>
						</thead>
						
						<c:if test="${empty exportList}">
							<tr  class="td_bg01">
						 		<td colspan="9" align="center" height="30">
						 			<span><font color="red">对不起,没有您所查找的信息!</font></span>
						 		</td>
						 	</tr>
						</c:if>
						
						<c:forEach items="${exportList}" var="export" varStatus="status">
							<TR align="center">
								<TD style="vnd.ms-excel.numberformat:@">${export.sampleNo}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.variety}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.reportUnit}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.acceptedUnit}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.testDate}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.quantity}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.storeEncode}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.origin}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.storeDate}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.storeType}</TD>
								<c:forEach items="${testItes }" var="testItems">
									<TD style="vnd.ms-excel.numberformat:@">${testItems.value[status.index]}</TD>
								</c:forEach>
								<TD style="vnd.ms-excel.numberformat:@">${export.remark}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.storeJudge}</TD>
							</TR>
						</c:forEach>
							
					</TABLE>
				</td>
			</tr>
		</table>
	</BODY>
</HTML>