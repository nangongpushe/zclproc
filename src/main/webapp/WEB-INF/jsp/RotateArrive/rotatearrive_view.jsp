<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />


<div class="container clearfix" style="padding: 10px">
	<div class="layui-row title">
		<h5>货款到账单信息</h5>
	</div>
	<div class="layui-row">
		<div class="layui-col-md3">
			<span>付款人:</span> <span>${model.payer}</span>
		</div>
		<div class="layui-col-md3">
			<span>付款单位:</span> <span>${model.payUnit}</span>
		</div>
		<div class="layui-col-md3">
			<span>收款日期:</span> <span><fmt:formatDate value="${model.arriveDate}" pattern="yyyy-MM-dd HH:mm"/></span>
		</div>
		<div class="layui-col-md3">
			<span>来款金额(元):</span> <span> <fmt:formatNumber value="${model.arriveAmount}" type="number" groupingUsed="false"/></span>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-md12">
			<span>备注:</span> <span>${model.remark}</span>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-md3">
			<span>填报人:</span> <span>${model.reporter}</span>
		</div>
		<div class="layui-col-md3">
			<span>填报时间:</span> <span><fmt:formatDate value="${model.reportDate}" pattern="yyyy-MM-dd HH:mm"/></span>
		</div>
		<div class="layui-col-md3">
			<span>填报部门:</span> <span>${model.reportDept}</span>
		</div>
	</div>
	<c:if test="${myFile!=null}">
		<div style="border: 1px #D8D8D8 solid; margin-top: 10px;">
			<div
				style="background-color: #f8f8f8; height: 40px; line-height: 40px">
				<label style="padding-left: 20px">附件</label>
			</div>
			<div class="opinion_list clearfix" style="margin-left: 20px;">
				<div class="pull-left"
					style="width: 43px; height: 43px; background-color: #f6f7f7; margin-top: 10px">
					<i class="layui-icon 21cake_list"
						style="font-size: 40px; color: #1E9FFF;"></i>
				</div>
				<div class="pull-left" style="margin-top:20px;">
					<span>${myFile.fileName }</span>
					<div style="display:inline-block;font-size:20px;" id="openExce">
						<a href="javascript:POBrowser.openWindow('${ctx }/sysFile/openExcel.shtml?fileUrl=${myFile.downloadUrl}','width=1200px;height=800px;')" id="openExcel" style="display: none">
							预览
						</a>
						<a href="javascript:openAnnex('${model.groupId}')" id="openFile" style="display: none">
							预览
						</a>
					</div>
					<a href="../sysFile/download.shtml?fileId=${myFile.id}" style="color: #0000FF; margin-left: 20px">下载</a>
				</div>
			</div>
		</div>
	</c:if>

<%-- 	<c:if test="${audit!=null }">
		<div class="layui-row title">
			<h5>财务经理审核</h5>
		</div>
		<div class="layui-row">
			<div class="layui-col-md12">
				<span>审核意见:</span> <span>${audit.advice}</span>
			</div>
			<c:if test="${audit.advice == '不同意' }">
				<div class="layui-col-md12">
					<span>原因:</span> <span>${audit.reason}</span>
				</div>
			</c:if>
		</div>
	</c:if>
	
	<c:if test="${audit_two!=null }">
		<div class="layui-row title">
			<h5>财务总监审核</h5>
		</div>
		<div class="layui-row">
			<div class="layui-col-md12">
				<span>审核意见:</span> <span>${audit_two.advice}</span>
			</div>
			<c:if test="${audit.advice == '不同意' }">
				<div class="layui-col-md12">
					<span>原因:</span> <span>${audit_two.reason}</span>
				</div>
			</c:if>
		</div>
	</c:if> --%>
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

