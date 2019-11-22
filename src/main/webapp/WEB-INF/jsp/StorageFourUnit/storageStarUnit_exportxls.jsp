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
							
								<th>粮库名称</th>
								<th>通讯地址</th>
								<th>粮库主任</th>
								<th>电子信箱</th>
								<th>邮编</th>
								<th>电话</th>
								<th>传真</th>
								<th>职工总人数(人)</th>
								<th>有职业资格证书人员(人)</th>
								<th>大专（含）以上学历(人)</th>
								<th>中级（含）以上职称(人)</th>
								<th>粮油保管员(人)</th>
								<th>粮油质量检验员(人)</th>
								<th>粮仓机械员(人)</th>
								<th>中央控制室操作员(人)</th>
								<th>电工(人)</th>
								<th>安全生产管理员(人)</th>
								<th>原"四化"状态</th>
								<th>现"四化"状态</th>
								<th>申请企业名称</th>
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
								<TD>${export.warehouse}</TD>
								<TD>${export.postalAddress}</TD>
								<TD>${export.director}</TD>
								<TD>${export.email}</TD>
								<TD>${export.zip}</TD>
								<TD>${export.telphone}</TD>
								<TD>${export.fax}</TD>
								<TD>${export.entireStaff}</TD>
								<TD>${export.nvq}</TD>
								<TD>${export.juniorCollege}</TD>
								<TD>${export.mediumGrade}</TD>
								<TD>${export.keeper}</TD>
								<TD>${export.monitor}</TD>
								<TD>${export.mechanic}</TD>
								<TD>${export.controlOperator}</TD>
								<TD>${export.electrician}</TD>
								<TD>${export.safety}</TD>
								<TD>${export.oldLevel}</TD>
								<TD>${export.applyLevel}</TD>
								<TD>${export.enterprise}</TD>
								<TD>${export.creator}</TD>
								<TD>${export.createDate}</TD>
								
								
							</TR>
						</c:forEach>
							
					</TABLE>
				</td>
			</tr>
		</table>
	</BODY>
</HTML>