<%@ page contentType="application/vnd.ms-excel; charset=utf-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<HTML>
<head>
<meta http-equiv="Content-Type"
		content="application/ms-excel; charset=utf-8"/>
	<style type="text/css">
		#outside {
		width: 94%;
		margin-left: 2%;
		padding: 1%;
		background: #fff;
		}

		#userInfo{
		/* margin-left:10%; */
		padding:10px 0;
		}

		#userInfo>span{
		display: inline-block;
		width: 25%;
		margin: 2px 0;
		}

		#data-view table{
		width:100%;
		text-align: center;
		}

		#data-view thead{
		background:#aaa;
		}

		#data-view td{
		padding:10px 5px;
		}

		#data-view tbody tr:hover{
		background:#eee;
		}

		table td{
		border: 1px solid #e2e2e2;
		}

	</style>
</head>
	<BODY class="body_MarginLR10px" style="margin-right:0px;">
		<div id="outside">
			<c:choose>
				<c:when test="${true }">
					<div>
						<h1 style="text-align:center;font-size:2em;">浙江省省级储备粮油</h1>
						<h3 style="text-align:center;font-size:1.5em">${notice.noticeType }通知书</h3>
						<h3 style="text-align:center;font-size:1.5em">${notice.noticeSerial }<!-- ${notice.year }〕${RN}号 --></h3>
						<p style="font-size:1.25em">${notice.storeEnterprise.enterpriseName }：</p>
						<c:choose>
							<c:when test="${notice.noticeType eq '入库' or notice.noticeType eq '出库'}">
								<span style="font-size:1.25em">
									&nbsp;&nbsp;&nbsp;&nbsp;依据${notice.documentNumber }，安排你单位下列省级储备粮（油）${notice.noticeType}，请严格按省定品种、数量、收获年份和承储库点等要求，抓紧做好各项${notice.noticeType}工作。${notice.noticeType }完成时间截止
									<fmt:formatDate value="${notice.storageDate }" pattern="yyyy年MM月dd日"/>。其他有关事项按上述文件精神办理。对拒不执行${notice.noticeType}计划的，将按《浙江省地方储备粮管理办法》严肃查处。
								</span>
							</c:when>
							<c:otherwise>
								<span style="font-size:1.25em">
									&nbsp;&nbsp;&nbsp;&nbsp;依据${notice.documentNumber }，安排你单位下列省级储备粮（油）调拔给${notice.noticeDetail[0].immigrationUnit }，请严格按省定品种、数量、质量和承储库点等要求，抓紧做好各项调拔工作。完成时间截止<fmt:formatDate value="${notice.storageDate }" pattern="yyyy年MM月dd日"/>。
									调拔粮（油）的质量必须达到国标中等以上，如有质量问题，必须由你单位承担全部责任，其他有关事项按上述文件精神办理。
								</span>
							</c:otherwise>
						</c:choose>
					</div>
					<c:choose>
						<c:when test="${notice.noticeType eq '入库' or notice.noticeType eq '出库'}">
							<div style="text-align:right">单位：成本，元/吨；数量，吨</div>
						</c:when>
						<c:otherwise>
							<div style="text-align:right">单位：吨 </div>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<h4 name="scheme-title" style="text-align:center;font-size:1.5em">${notice.noticeSerial }</h4>
					<div id="userInfo">
						<span name="scheme-year">轮换类型：${notice.noticeType }</span>
						<span>轮换方式：&nbsp;${notice.rotateType }</span>
						<br/>
						<span>经办时间：&nbsp;<fmt:formatDate value="${notice.createTime }" pattern="yyyy年MM月dd日"/></span>
						<span>经办人：&nbsp;${notice.creater }</span>
						<br/>
						<span>文号：&nbsp;${notice.documentNumber }</span>
						<span>${notice.noticeType }截止时间：&nbsp;<fmt:formatDate value="${notice.storageDate }" pattern="yyyy年MM月dd日"/></span>
					</div>
				</c:otherwise>
			</c:choose>
			<div id="data-view">
				<table class="layui-table" style="margin: 10px 0;">
					<thead>
						<tr style="background:#aaa;">
							<td align="center">品种</td>
							<c:choose>
								<c:when test="${notice.noticeType eq '移库'}">
									<td align="center">移出单位</td>
									<td align="center">移入单位</td>
								</c:when>
								<c:otherwise>
									<td align="center">成本</td>
									<td align="center">直管属性</td>
									<td align="center">收获年份</td>
									<c:if test="${notice.noticeType eq '入库'}">
										<td>企业</td>
									</c:if>
									<td align="center">仓房编号</td>
								</c:otherwise>
							</c:choose>
							<td align="center">储存库点</td>
							<td align="center">计划数</td>
							<td align="center">实际数</td>
						</tr>
					</thead>
					<tbody>
						<c:if test="${notice.noticeType eq '入库' or notice.noticeType eq '出库'}">
							<tr>
								<td align="center">合计</td>
								<td align="center" style='vnd.ms-excel.numberformat:0.00'><fmt:formatNumber value="${totalCost }"  pattern="#.##" maxFractionDigits="2"/></td>
								<td align="center">———</td>
								<td align="center">———</td>
								<c:if test="${notice.noticeType eq '入库'}">
									<td>———</td>
								</c:if>
								<td align="center">———</td>
								<td align="center">———</td>
								<td align="center">${planCount }</td>
								<td align="center">${realCount }</td>
							</tr>
						</c:if>
						<c:forEach items="${notice.noticeDetail }" var="item">
							<tr>
								<td align="center">${item.variety }</td>
								<c:choose>
									<c:when test="${notice.noticeType eq '移库'}">
										<td align="center">${item.removalUnit }</td>
										<td align="center">${item.immigrationUnit }</td>
									</c:when>
									<c:otherwise>
										<td align="center" style='vnd.ms-excel.numberformat:0.00'><fmt:formatNumber value="${item.cost=='0'?'':item.cost }"  pattern="#.##" maxFractionDigits="2"/></td>
										<td align="center">${item.pipeAttribute }</td>
										<td align="center">${item.harvestYear }</td>
										<c:if test="${notice.noticeType eq '入库'}">
											<td align="center">${item.enterpriseName}</td>
										</c:if>
										<td align="center">${item.storehouse }</td>
									</c:otherwise>
								</c:choose>
								<td align="center">${item.warehouse.warehouseShort }</td>
								<td align="center">${item.planNumber }</td>
								<td align="center">${item.actualNumber }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<c:if test="${true }">
				<div style="font-size:1.25em;margin:30px 0;text-align:center;">
					<span>签发单位负责人：___<span style="border-bottom:1px solid #000">${notice.sender }</span>___</span>
					<span style="margin-left:10%;">审核：___<span style="border-bottom:1px solid #000">${notice.audit }</span>___</span>
					<span style="margin-left:10%;">经办人：___<span style="border-bottom:1px solid #000">${notice.creater }</span>___</span>

					<%--<c:if test="${notice.noticeType eq '出库'}">--%>
						<%--<div style="margin-left:60%;position: absolute;"><img src="${ctx}/images/chuku.png" alt="需要盖章" style="opacity:0.6;z-index: -1"></div>--%>
					<%--</c:if>--%>
					<%--<c:if test="${notice.noticeType eq '入库'}">--%>
						<%--<div style="text-align:right;margin-top:70px;z-index: 1"><img src="${path}/images/ruku.png" alt="需要盖章" style="opacity:0.6;z-index: -1"></div>--%>
					<%--</c:if>--%>
					<%--<c:if test="${notice.noticeType eq '移库'}">--%>
						<%--<div style="margin-left:60%;position: absolute;"><img src="${ctx}/images/yiku.png" alt="需要盖章" style="opacity:0.6;z-index: -1"></div>--%>
					<%--</c:if>--%>

					<div style="text-align:right;margin-top:70px;z-index: 1">签发时间（盖章）：<fmt:formatDate value="${notice.completeDate}" pattern=" yyyy 年 MM 月 dd 日"/></div>
				</div>
			</c:if>
			<div id="otherpart" style="padding-bottom:20px;">
				<c:if test="${filename ne null }">
					<p>附件：</p>
					<div style="border:1px solid #ccc;padding:10px;">
						<i class="layui-icon">&#xe60a;</i>
						<span>${filename }</span>
						<a href="${ctx }/sysFile/download.shtml?fileId=${notice.annex}">下载</a>
					</div>
				</c:if>
				<span style="display:block;margin-top:5px;">备注：</span>
				<div>${notice.remark }</div>
			</div>
		</div>
	</BODY>
</HTML>

