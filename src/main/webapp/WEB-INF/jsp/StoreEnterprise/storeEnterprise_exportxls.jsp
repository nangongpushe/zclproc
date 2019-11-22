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
								<th>代储企业编号</th>
								<th>企业名称</th>
								<th>企业简称</th>

								<th>统一社会信用代码</th>
								<th>企业经济类型</th>
								<th>登记注册类型</th>

								<th>是否具备中央储备粮代储资格</th>
								<th>法定代表人</th>
								<th>企业地址</th>
								<th>企业电话</th>
								<th>企业传真</th>
								<th>企业电子邮箱</th>
								<th>企业网址</th>
								<th>企业邮政编码</th>
								<th>企业行政区划</th>
								<th>开户银行</th>
								<th>开户账号</th>
								<th>银行信用等级</th>
								<th>固定资产(万)</th>
								<th>注册资本(万)</th>
								<th>资产(万)</th>
								<th>企业从业人数</th>
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
								<TD>${export.enterpriseSerial}</TD>
								<TD>${export.enterpriseName}</TD>
								<TD>${export.shortName}</TD>


								<td style="vnd.ms-excel.numberformat:@">${export.socialCreditCode}</td>
								<TD>${export.economicType}</TD>
								<TD>${export.registType}</TD>

								<TD>${export.seniority}</TD>
								<TD>${export.personIncharge}</TD>
								<TD>${export.address}</TD>
								<TD>${export.telephone}</TD>
								<TD>${export.fax}</TD>
								<TD>${export.email}</TD>
								<TD>${export.website}</TD>
								<TD>${export.postalcode}</TD>
								<TD>${export.province}${export.city}${export.area}</TD>
								<TD>${export.depositBank}</TD>
								<TD style="vnd.ms-excel.numberformat:@">${export.depositAccount}</TD>
								<TD>${export.bankCreditRating}</TD>
								<TD>${export.fixedAssets}</TD>
								<TD>${export.registeredCapital}</TD>
								<TD>${export.assets}</TD>
								<TD>${export.people}</TD>
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