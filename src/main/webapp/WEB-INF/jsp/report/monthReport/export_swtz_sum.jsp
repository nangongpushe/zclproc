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
		font-size:18px;
		text-align:center;
		}
	</style>
</head>
	<BODY class="body_MarginLR10px" style="margin-right:0px;">
		<TABLE width="100%" align="center">
			<tr>
				<td>
					<TABLE width="100%" align="center">
						<tr><td colspan="10" class="title">地方储备粮油库存实物台账月报表汇总</td></tr>
						<tr></tr>
						<tr><td colspan="4">填报单位：${userInfo.company}</td><td style='mso-number-format:"\@"' colspan="4">${reportMonth}</td><td colspan="2">单位：吨</td></tr>
					</TABLE>
				</td>
			</tr>
			<tr>
				<td>
					<TABLE id="box01" cellSpacing="1" cellPadding="1" border="1" width="100%" align="center" class="table_border01">
						<tr>
							<td class="td_white" colspan="10">
								<TABLE id="box01" cellSpacing="1" cellPadding="1" border="1" width="100%" align="center" class="table_border01">
									<thead>
										<tr>
											<th rowspan="2" class="td_first text-center" style="width: 200px;height: 56px !important;background-color: #e7f3f7;">储存库点名称</th>
											<th rowspan="2" class="text-center">品种</th><th rowspan="2" class="text-center">数量</th><th rowspan="2" class="text-center">产地</th><th rowspan="2" class="text-center">收获年份</th><th colspan="3" class="text-center">储存品质情况</th><th class="text-center" colspan="2">存储方式</th>
										</tr>
										<tr >
											<th class="text-center">宜存数量</th><th class="text-center">轻度不宜存数量</th><th class="text-center">重度不宜存数量</th><th class="text-center">包装</th><th class="text-center">散装</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${swtzList}" var="swtz">
											<tr class="text-center active">
												<td>${swtz.extendsWarehouse}</td>
												<td>${swtz.variety}</td><td>${swtz.quantity}</td><td>${swtz.origin}</td><td>${swtz.harvestYear}</td><td>${swtz.advisedDeposit}</td><td>${swtz.slightlyUnsuitable}</td>
												<td>${swtz.severeUnsuitable}</td><td>${swtz.packing}</td><td>${swtz.bulk}</td>
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
					<TABLE width="100%" align="center">
						<tr><td colspan="4">统计负责人：${reportMain.manager}</td><td colspan="3">填表人：${userInfo.name}</td><td>填报日期：<fmt:formatDate value="${ reportMain.createDate }"  pattern="yyyy年MM月dd日"/></td></tr>
					</TABLE>
				</td>
			</tr>
		</TABLE>
	</BODY>
</HTML>

