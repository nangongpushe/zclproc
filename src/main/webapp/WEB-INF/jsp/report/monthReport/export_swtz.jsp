<%@ page contentType="application/vnd.ms-excel; charset=utf-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
	</style>
</head>
	<BODY class="body_MarginLR10px" style="margin-right:0px;">	
		<table width="100%" border="0" cellspacing="0" cellpadding="0" sheetName="4">

		</table>
	</BODY>

	<BODY class="body_MarginLR10px" style="margin-right:0px;">
		<TABLE width="100%" align="center" sheetName="5">
			<tr>
				<td>
					<TABLE width="100%" align="center" sheetName="1">
						<tr><td colspan="17" class="title">地方储备粮油库存实物台账月报表</td></tr>
						<tr></tr>
						<tr><td colspan="8">填报单位：${userInfo.company}</td><td style='mso-number-format:"\@"' colspan="5">储备性质：${reportMain.reserveProperty}</td><td colspan="3" style='mso-number-format:"\@"'>${reportMain.reportMonth}</td><td colspan="2">单位：吨</td></tr>
					</TABLE>
				</td>
			</tr>
			<tr>
				<td>
					<TABLE id="box01" cellSpacing="1" cellPadding="1" border="1" width="100%" align="center" class="table_border01" sheetName="2">
						<tr>
							<td class="td_white" colspan="17">
								<TABLE id="box01" cellSpacing="1" cellPadding="1" border="1" width="100%" align="center" class="table_border01">
									<thead>
										<tr>
											<th rowspan="2" class="td_first text-center" style="width: 200px;height: 56px !important;background-color: #e7f3f7;">储存库点名称</th>
											<th rowspan="2" class="td_first text-center" style="min-width: 147px;height: 56px !important;background-color: #e7f3f7;">仓号<br>(货位)</th>
											<th rowspan="2" class="text-center">品种</th><th rowspan="2" class="text-center">数量</th><th rowspan="2" class="text-center">产地</th><th rowspan="2" class="text-center">收获年份</th><th colspan="9" class="text-center">入库质量情况</th><th colspan="3" class="text-center">储存品质情况</th>
										</tr>
										<tr >
											<th class="text-center">出糙(%)</th><th class="text-center">容重(g/l)</th><th class="text-center">杂质(%)</th><th class="text-center">水分(%)</th><th class="text-center">黄粒米(%)</th><th class="text-center">不完善粒(%)</th><th class="text-center">小麦湿面筋(%)</th><th class="text-center">酸价(KOH)(mg/g)</th><th class="text-center">过氧化值(mmol/kg)</th><th class="text-center">宜存数量</th><th class="text-center">轻度不宜存数量</th><th class="text-center">重度不宜存数量</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${swtzList}" var="swtz">
											<tr class="text-center active">
												<td>${swtz.extendsWarehouse}</td>
												<td>${swtz.storehouse}</td>
												<td>${swtz.variety}</td><td>${swtz.quantity}</td><td>${swtz.origin}</td><td>${swtz.harvestYear}</td><td>${swtz.brown}</td>
												<td>${swtz.unitWeight}</td><td>${swtz.impurity}</td><td>${swtz.dew}</td><td>${swtz.yellowRice}</td><td>${swtz.unsoundGrain}</td>
												<td>${swtz.wetGluten}</td><td>${swtz.koh}</td><td>${swtz.mmol}</td><td>${swtz.advisedDeposit}</td><td>${swtz.slightlyUnsuitable}</td>
												<td>${swtz.severeUnsuitable}</td>
											</tr>
										</c:forEach>
									</tbody>

								</TABLE>
							</td>
						</tr>
					</TABLE>
				</td>
			</tr>
			<tr>
				<td>
					<TABLE width="100%" align="center" sheetName="3">
						<tr><td colspan="9">统计负责人：${reportMain.manager}</td><td colspan="6">填表人：${userInfo.name}</td><td>填报日期：<fmt:formatDate value="${ reportMain.createDate }"  pattern="yyyy年MM月dd日"/></td></tr>
					</TABLE>
				</td>
			</tr>
		</TABLE>
	</BODY>
</HTML>

