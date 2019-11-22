<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../common/AdminHeader.jsp" %>
<style type="text/css">
#outside {
	width: 94%;
	margin-left: 2%;
	padding: 1%;
	background: #fff;
}

#data-head tr td{
	text-align: center;
}

#data-list tr td[data-field="column3"]{
	text-align: center;
}
#data-list tr td[data-field="column6"]{
	text-align: right;
}
#data-list tr td[data-field="column7"]{
	text-align: right;
}
#data-list tr td[data-field="column10"]{
	text-align: right;
}
#data-list tr td[data-field="column11"]{
	text-align: right;
}

#userInfo{
	padding-bottom:25px;
	padding-top:25px;
}

#userInfo>span{
	display:inline-block;
	width:100%;
	margin:5px 0;
}

</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>商务处理</li>
		<li>合同履约管理</li>
		<li class="active">详情</li>
	</ol>
</div>
<div id="outside">
	<h2 name="scheme-title" style="text-align:center;font-size:2em">浙江省省级储备粮销售${performance.type }完成情况表</h2>
	<div id="userInfo">
		<span style="font-size:1.25em;width:49%">承储单位(盖章)：${performance.deliveryPlace }</span>
		<span style="text-align:right;width:49%">单位：吨</span>
		<table class="layui-table">
			<thead id="data-head">
			<tr>
				<td>标的号</td>
				<td>仓号</td>
				<td>${performance.type eq '出库'?'提货':'交货'}截止时间</td>
				<td>品种</td>
				<td>${performance.type eq '出库'?'提货':'交货'}单位</td>
				<td>合同数量</td>
				<td>按期完成${performance.type eq '出库'?'提货':'交货'}数量</td>
				<td>商务处理情况</td>
				<td>备注</td>
			</tr>
			</thead>
			<tbody id="data-list">
			<tr>
				<td data-field="column1">${performance.bidSerial }</td>
				<td data-field="column2">${performance.storehouse }</td>
				<td data-field="column3">${performance.type eq '出库'?performance.takeEnd:performance.deliveryEnd}</td>
				<td data-field="column4">${performance.grainType }</td>
				<td data-field="column5">${performance.dealUnit }</td>
				<td data-field="column6">${performance.quantity }</td>
				<td data-field="column7">${performance.inPlanQuantity }</td>
				<td data-field="column8">${performance.processDetail }</td>
				<td data-field="column9">${performance.remark }</td>
			</tr>
			<tr>
				<td colspan="4">合计</td>
				<td></td>
				<td data-field="column10">${performance.quantity }</td>
				<td data-field="column11">${performance.inPlanQuantity }</td>
				<td></td>
				<td></td>
			</tr>
			</tbody>
		</table>
		<span style="width:33%;text-align:left;">提货单位(盖章)：</span>
		<span style="width:33%;text-align:center;">买方单位(盖章)：</span>
		<span style="width:33%;text-align:right;">填报日期：<fmt:formatDate value="${performance.handleTime}" pattern="yyyy年MM月dd日"/></span>
		<c:if test="${files ne null }">
		<%--<span>附件：</span>--%>
		<%--<div style="border:1px solid #f2f2f2;padding:10px;">
			<i class="layui-icon">&#xe60a;</i>
			<span>${filename }</span>
			<a href="${ctx }/sysFile/download.shtml?fileId=${performance.annex}">下载</a>
		</div>--%>
			<p>附件：</p>
			<div style="border:1px solid #ccc;padding:10px;">
				<c:forEach items="${files}" var="item">
					<div data="${item.id}" class="buttonArea file-button">
						<div id="afileName" style="display:inline-block;font-size:14px;" >
							<a href="${ctx }/sysFile/download.shtml?fileId=${item.id}" style="margin:0 10px;">${item.fileName}</a>
						</div>
						<c:forEach items="${suffixMap}" var="m">
							<c:if test="${m.key == item.id}">
								<c:choose>
									<c:when test="${m.value == 'xls'|| m.value == 'xlsx'|| m.value== 'doc'|| m.value == 'docx'}">
										<a style="color:yellowgreen" href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${item.downloadUrl}','width=1200px;height=800px;')" id="openExcel">
											预览
										</a>
									</c:when>
									<c:otherwise>
										<a style="color: yellowgreen" href="javascript:openAnnex('${item.id}')" id="openFile">
											预览
										</a>
									</c:otherwise>
								</c:choose>
							</c:if>

						</c:forEach>
					</div>
				</c:forEach>

				<%--<i class="layui-icon">&#xe60a;</i>
				<span>${myFile.fileName }</span>
				<a href="${ctx }/sysFile/download.shtml?fileId=${scheme.annex}">下载</a>
				<a href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${myFile.downloadUrl}','width=1200px;height=800px;')" id="openExcel" style="display: none">
					预览
				</a>
				<a href="javascript:openAnnex('${myFile.id}')" id="openFile" style="display: none">
					预览
				</a>--%>
			</div>
		</c:if>
	</div>
</div>
<div  style="margin-top: 2%;text-align: center;">
	<input class="layui-btn layui-btn-small" type="button" id="backBtn" value="返回"/>
</div>
<script>
	$("#backBtn").click(function () {
		location.href="${ctx }/RotateProcess/Performance.shtml?type=Total"
    });


</script>
<%@ include file="../common/AdminFooter.jsp" %>