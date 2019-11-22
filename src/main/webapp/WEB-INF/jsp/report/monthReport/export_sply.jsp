<%@ page contentType="application/vnd.ms-excel; charset=utf-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
		.list_1 {
		padding-left: 30px
		}

		.list_2 {
		padding-left: 60px
		}

		.list_3 {
		padding-left: 45px
		}

		.list_4 {
		padding-left: 60px
		}

		.list_5 {
		padding-left: 75px
		}

		.thick {
		font-weight: bold;
		}
	</style>
</head>
	<BODY class="body_MarginLR10px" style="margin-right:0px;">	
		<TABLE width="100%" align="center">
			<tr>
				<td>
					<TABLE width="100%" align="center">
						<tr><td colspan="25" class="title">商品粮油收支平衡月报表</td></tr>
						<tr><td colspan="24"></td>
							<td>
								表    号：浙粮 03 表<br/>
								制定机关：浙江省粮食局<br/>
								批准机关：浙江省统计局<br/>
								批准文号：<br/>
								有效期至：
							</td></tr>
						<tr><td colspan="10">填报单位：${userInfo.company}</td><td style='mso-number-format:"\@"'>${reportMonth}</td><td colspan="13"></td><td>单位：吨</td></tr>
					</TABLE>
				</td>
			</tr>
			<tr>
				<td>
					<TABLE id="box01" cellSpacing="1" cellPadding="1" border="1" width="100%" align="center" class="table_border01">
						<tr class="text-center">
							<th rowspan="3">品种指标</th>
							<th rowspan="3" >期初库存</th><th colspan="12">收入合计</th><th colspan="9">支出合计</th><th colspan="2" >期末库存</th>
						</tr>
						<tr>
							<th rowspan="2">小计</th><th colspan="3">从生产者购进</th><th colspan="5">从企业购进</th><th rowspan="2" >进口</th><th rowspan="2" >储备粮油转入</th><th rowspan="2" >其他收入</th>
							<th rowspan="2">小计</th><th colspan="5">销售</th><th rowspan="2">出口</th><th rowspan="2">转作储备粮油</th><th rowspan="2" >其他支出</th><th rowspan="2" >小计</th><th rowspan="2" >省外储存</th>
						</tr>
						<tr >
							<th>小计</th><th>其中：省外</th><th>省内订单收购</th><th>小计</th><th>其中：省外</th><th>省内县外</th><th>县内</th><th>从国有粮食企业购进</th>
							<th>小计</th><th>其中：省外</th><th>省内县外</th><th>县内</th><th>对国有粮食企业销售</th>
						</tr>
						<tbody>
							<c:forEach items="${splyList}" var="sply">
								<tr class="text-center active">
									<td class="${fn:replace(fn:split(sply.cssClass,"-")[0], " thick", "")}" <c:if test="${fn:contains(fn:split(sply.cssClass,'-')[0],'thick')}">style="font-weight: bold;"</c:if>>${sply.grainType}</td>
									<td>${sply.preStock}</td><td>${sply.totalIncomeSubtotal}</td><td>${sply.productorInSubtotal}</td><td>${sply.productorInSw}</td>
									<td>${sply.productorInSn}</td><td>${sply.enterpriseInSubtotal}</td><td>${sply.enterpriseInSw}</td><td>${sply.enterpriseInSnxw}</td>
									<td>${sply.enterpriseInXn}</td><td>${sply.enterpriseInGy}</td><td>${sply.importedIn}</td><td>${sply.reserveIn}</td>
									<td>${sply.otherIncome}</td><td>${sply.otherExpendSubtotal}</td>
									<td>${sply.saleSubtotal}</td><td>${sply.saleSw}</td><td>${sply.saleSnxw}</td><td>${sply.saleXn}</td><td>${sply.saleGy}</td>
									<td>${sply.exportOut}</td><td>${sply.transferReserveOil}</td>
									<td>${sply.otherExpend}</td>
									<td>${sply.inventorySubtotal}</td><td>${sply.inventorySwStore}</td>
								</tr>
							</c:forEach>
						</tbody>

					</TABLE>
				</td>
			</tr>
			<tr>
				<td>
					<TABLE width="100%" align="center">
						<tr><td></td><td>统计负责人：${reportMain.manager}</td><td colspan="6"></td><td colspan="6">填表人：${userInfo.name}</td><td colspan="3"></td><td>填报日期：<fmt:formatDate value="${ reportMain.createDate }"  pattern="yyyy年MM月dd日"/></td></tr>
						<tr><td>填表说明：</td><td colspan="9">
							1、统计范围：各类粮油企业。<br/>
							2、列平衡关系：01+02-15=32；02=03+06+11+12+13+14；06=07+08+09；15=16+21+22+23+24+31；16=17+18+19；24=25+26。<br/>
							3、受其他企业或个体工商户委托收购和委托储存的粮食在报表的备注栏中单独反映，不计入本企业的粮食收支平衡表。
						</td></tr>
					</TABLE>
				</td>
			</tr>
		</TABLE>
	</BODY>
</HTML>

