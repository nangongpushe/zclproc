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
						<tr><td colspan="20" class="title">${reportName}</td></tr>
						<tr><td>编制单位：${userInfo.company}</td><td colspan="9"></td><td style='mso-number-format:"\@"'>${reportMonth}</td><td colspan="8"></td><td>计量单位：吨</td></tr>
					</TABLE>
				</td>
			</tr>
			<tr>
				<td>
					<TABLE id="box01" cellSpacing="1" cellPadding="1" border="1" width="100%" align="center" class="table_border01">
						<tr>
							<td class="td_white" colspan="20">
								<TABLE id="box01" cellSpacing="1" cellPadding="1" border="1" width="100%" align="center" class="table_border01">
									<thead>
										<tr >
											<th rowspan="2">品种指标</th>
											<th colspan="32" style="font-weight: bold;">${reportName}分省合计</th>
										</tr>
										<tr>
											<th>小计</th><th>${fix}北京</th><th>${fix}天津</th><th>${fix}河北 </th><th>${fix}山西</th><th>${fix}内蒙古</th>
											<th>${fix}辽宁</th><th>${fix}吉林</th><th>${fix}黑龙江</th><th>${fix}上海</th><th>${fix}江苏</th><th>${fix}浙江</th><th>${fix}安徽</th>
											<th>${fix}福建</th><th>${fix}江西</th><th>${fix}山东</th><th>${fix}河南</th><th>${fix}湖北</th><th>${fix}湖南</th><th>${fix}广东</th>
											<th>${fix}广西</th><th>${fix}海南</th><th>${fix}重庆</th><th>${fix}四川</th><th>${fix}贵州</th><th>${fix}云南</th><th>${fix}西藏</th>
											<th>${fix}陕西</th><th>${fix}甘肃</th><th>${fix}青海</th><th>${fix}宁夏</th><th>${fix}新疆</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${xwswList}" var="xwsw">
											<tr class="text-center active">
												<td class="${fn:replace(fn:split(xwsw.cssClass,"-")[0], " thick", "")}" <c:if test="${fn:contains(fn:split(xwsw.cssClass,'-')[0],'thick')}">style="font-weight: bold;"</c:if>>${xwsw.grainType}</td>
												<td>${xwsw.subtotal}</td><td>${xwsw.beijing}</td><td>${xwsw.tianjin}</td><td>${xwsw.hebei}</td><td>${xwsw.shanxi}</td>
												<td>${xwsw.neimenggu}</td><td>${xwsw.liaoning}</td><td>${xwsw.jinli}</td><td>${xwsw.heilongjian}</td><td>${xwsw.shanghai}</td>
												<td>${xwsw.jiangsu}</td><td>${xwsw.zhejiang}</td><td>${xwsw.anhui}</td><td>${xwsw.fujian}</td><td>${xwsw.jiangxi}</td><td>${xwsw.shandong}</td>
												<td>${xwsw.henan}</td><td>${xwsw.hubei}</td><td>${xwsw.hunan}</td><td>${xwsw.guangdong}</td><td>${xwsw.guangxi}</td>
												<td>${xwsw.hainan}</td><td>${xwsw.chongqing}</td><td>${xwsw.sichuan}</td><td>${xwsw.guizhou}</td><td>${xwsw.yunnan}</td>
												<td>${xwsw.xizang}</td><td>${xwsw.shanXi}</td><td>${xwsw.gansu}</td><td>${xwsw.qinghai}</td><td>${xwsw.ningxia}</td>
												<td>${xwsw.xinjiang}</td>
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
						<tr><td></td><td>统计负责人：${reportMain.manager}</td><td colspan="6"></td><td colspan="6">填表人：${userInfo.name}</td><td colspan="3"></td><td>填报日期：<fmt:formatDate value="${ reportMain.createDate }"  pattern="yyyy年MM月dd日"/></td></tr>
					</TABLE>
				</td>
			</tr>
		</TABLE>
	</BODY>
</HTML>

