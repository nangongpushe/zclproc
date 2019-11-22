<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<style>
	table#view td{
	width:100px;
	}
</style>

<div class="container clearfix" style="padding: 10px">
	
	<div class="layui-row">
		<div class="layui-col-md3">
			<span>收款单位:</span> <span>${model.clientName}</span>
		</div>
		<div class="layui-col-md3">
			<span>开户行:</span> <span>${model.depositBank}</span>
		</div>
		<div class="layui-col-md3">
			<span>账号:</span> <span>${model.depositAccount}</span>
		</div>
		<div class="layui-col-md3">
			<span>付款方式:</span> <span>${model.payType}</span>
		</div>
		<div class="layui-col-md3">
			<span>货款类型:</span> <span>${model.proceedType}</span>
		</div>
		<div class="layui-col-md3">
			<span>经办人:</span> <span>${model.operator}</span>
		</div>
		<div class="layui-col-md3">
			<span>填报时间:</span> <span><fmt:formatDate value="${model.reportDate}" pattern="yyyy-MM-dd"/></span>
		</div>
		<div class="layui-col-md3">
			<c:if test="${model.groupId==null or model.groupId=='' }">
				<span>附件:</span> <span>暂无文件</span>
			</c:if>
			<c:if test="${model.groupId ne null and model.groupId ne '' }">
				<span>附件:${filename.fileName}</span> <span>
				 <div style="display:inline-block;font-size:20px;" id="openExce">
                        <a href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${filename.downloadUrl}','width=1200px;height=800px;')" id="openExcel" style="display: none">
                            预览
                        </a>
                        <a href="javascript:openAnnex('${model.groupId}')" id="openFile" style="display: none">
                            预览
                        </a>
                    </div>
				<a href="../sysFile/download.shtml?fileId=${model.groupId}" style="color: #0000FF; margin-left: 20px">点击下载</a></span>
			</c:if>
		</div>
	</div>
	<!-- layui静态表格 -->
	<table class="layui-table" id="view">
		<thead>
				<tr>
					<td style="text-align: center">方案名称</td>
					<td style="text-align: center">标的号</td>
					<td style="text-align: center">品种</td>
					<td style="text-align: center">数量(吨)</td>
					<td style="text-align: center">单价(元/吨)</td>
					<td style="text-align: center">金额(元)</td>
				</tr>
		</thead>
		<tbody>

				<c:forEach items="${model.detailList}" var="item"
					varStatus="status">
					<tr>
						<td style="text-align: left">${item.schemeName}</td>
						<td style="text-align: left">${item.bidSerial}</td>
						<td style="text-align: left">${item.grainType}</td>
						<td style="text-align: right">${item.quantity}</td>
						<td style="text-align: right">${item.price}</td>

						<td style="text-align: right">${item.amount}</td>

					
					</tr>
				</c:forEach>


		</tbody>
	</table>

</div>



<script>
    if ("${model.groupId}" != "") {
        if('${suffix}' == 'xls'||'${suffix}' == 'xlsx'||'${suffix}'== 'doc'||'${suffix}' == 'docx'){
            $("#openExcel").css("display", "");
        }else{
            $("#openFile").css("display", "");
        }
    }
</script>
<%-- <%@include file="../common/AdminFooter.jsp"%> --%>