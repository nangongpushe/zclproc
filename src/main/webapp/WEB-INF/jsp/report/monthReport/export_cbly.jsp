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
						<tr><td colspan="34" class="title">储备粮油收支平衡月报表</td></tr>
						<tr><td colspan="30"></td>
							<td colspan="2">
								表    号：浙粮 03 表<br/>
								制定机关：浙江省粮食局<br/>
								批准机关：浙江省统计局<br/>
								批准文号：<br/>
								有效期至：
						</td></tr>
						<tr><td colspan="10">填报单位：${userInfo.company}</td></td><td style='mso-number-format:"\@"'>${reportMonth}</td><td colspan="19"></td><td>单位：吨</td></tr>
					</TABLE>
				</td>
			</tr>
			<tr>
				<td>
					<TABLE id="box01" cellSpacing="1" cellPadding="1" border="1" width="100%" align="center" class="table_border01">
						<thead>
							<tr>
								<th rowspan="3">品种指标</th>
								<th rowspan="3">期初库存</th><th colspan="11">收入合计</th><th colspan="9">支出合计</th><th colspan="11">期末库存</th><th rowspan="3">动态储备</th>
							</tr>

							<tr>
								<th rowspan="2">小计</th><th colspan="2">从生产者购进</th><th colspan="2">从企业购进</th><th colspan="2">商品粮油转入</th><th rowspan="2">进口</th><th colspan="3">其他收入</th>
								<th rowspan="2">小计</th><th colspan="2">销售</th><th colspan="2">转作商品粮油</th><th rowspan="2">出口</th><th colspan="3">其他支出</th><th rowspan="2">小计</th><th colspan="8">按收获年份划分</th><th rowspan="2">小包装</th><th rowspan="2">省外储存</th>
							</tr>
							<tr>
								<th>小计</th><th>省外</th><th>小计</th><th>省外</th><th>小计</th><th>轮换收入</th>
								<th>小计</th><th>省内调入</th><th>加工成品收回</th><th>小计</th><th>省外</th><th>小计</th><th>轮换支出</th><th>小计</th><th>省内调出</th><th>加工原料付出</th><th>小计</th><th class="year1">${thisYear-6}年及以前</th><th class="year2">${thisYear-5}年</th><th class="year3">${thisYear-4}年</th>
								<th class="year4">${thisYear-3}年</th><th class="year5">${thisYear-2}年</th><th class="year">${thisYear-1}年</th><th class="year5">${thisYear}年</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${cblyList}" var="cbly">
								<tr class="text-center active">
									<td class="${fn:replace(fn:split(cbly.cssClass,"-")[0], " thick", "")}" <c:if test="${fn:contains(fn:split(cbly.cssClass,'-')[0],'thick')}">style="font-weight: bold;"</c:if>>${cbly.grainType}</td>
									<td>${cbly.preStock}</td><td>${cbly.totalIncomeSubtotal}</td><td>${cbly.productorInSubtotal}</td><td>${cbly.productorIn}</td><td>${cbly.enterpriseInSubtotal}</td><td>${cbly.enterpriseIn}</td><td>${cbly.changeInSubtotal}</td><td>${cbly.changeIn}</td><td>${cbly.importedIn}</td><td>${cbly.otherIncomeSubtotal}</td>
									<td>${cbly.provinceIn}</td><td>${cbly.recoveryIn}</td><td>${cbly.totalExpendSubtotal}</td><td>${cbly.otherProvinceOutSubtotal}</td><td>${cbly.otherProvinceOut}</td><td>${cbly.changeOutSubtotal}</td><td>${cbly.changeOut}</td><td>${cbly.exportOut}</td><td>${cbly.otherExpendSubtotal}</td><td>${cbly.provinceOut}</td>
									<td>${cbly.materialOut}</td><td>${cbly.inventorySubtotal}</td><td>${cbly.yearSubtotal}</td><td>${cbly.year6Stock}</td><td>${cbly.year5Stock}</td><td>${cbly.year4Stock}</td><td>${cbly.year3Stock}</td><td>${cbly.year2Stock}</td><td>${cbly.year1Stock}</td><td>${cbly.year0Stock}</td><td>${cbly.smallPackageStock}</td>
									<td>${cbly.otherProvinceStock}</td><td>${cbly.dynamicsStock}</td>
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
						<tr><td>填表说明：</td><td colspan="9">1、小包装粮指袋或箱中的净重量在25公斤及以下粮食；小包装油指每桶5.5升以下的食用油。<br/>
							2、列平衡关系：01+02-13=21；02=03+05+07+09+10+11+12；13=14+17+18+19+20；21=24+25+26+27+28+29。</td></tr>
					</TABLE>
				</td>
			</tr>
		</TABLE>
	</BODY>
</HTML>

