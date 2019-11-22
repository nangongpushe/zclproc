<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="cf" uri="com.dhc.fastersoft.utils.JsonUtil" %>

<%@include file="../common/AdminHeader.jsp"%>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>货款管理</li>
		<li class="active">
			货款到账单审核
		</li>
	</ol>
</div>

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
			<span>来款金额(元):</span> <span> <fmt:formatNumber value="${model.arriveAmount}" type="number" groupingUsed="false"/> </span>
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
					<a href="../sysFile/download.shtml?fileId=${myFile.id}" style="color: #0000FF; margin-left: 20px">下载</a>
				</div>
			</div>
		</div>
	</c:if>

	<c:if test="${model.status == '审核中(财务经理)' }">
		<div class="layui-row title">
			<h5>财务经理审核</h5>
		</div>
		<form class="layui-form" lay-filter="form1">
			<div class="layui-form-item">
				<label class="layui-form-label"><span class="red">*</span>审核意见:</label>
				<div class="layui-input-inline">
					<select name="status" lay-filter="status">
						<option value="">--请选择--</option>
						<%--<option value="审核中(财务总监)">同意</option>
						<option value="已驳回">不同意</option>--%>
						<option value="已通过">同意</option>
						<option value="已驳回">不同意</option>
					</select>
				</div>
			</div>
			<div class="layui-form-item" style="display:none;" id="reasonDiv">
				<label class="layui-form-label"><span class="red">*</span>原因:</label>
				<div class="layui-input-block">
					<textarea placeholder="最多500字符" class="layui-textarea"
						name="auditReason" maxlength="500"></textarea>
				</div>
			</div>
			<div class="layui-row text-center">
				<div class="layui-col-md12" id="operation">
					<button type="button" lay-submit class="layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.audit();}">确定</button>
					<button type="button" class="layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.cancel();}">取消</button>
				</div>
			</div>
		</form>
	</c:if>
	<c:if	test="${model.status == '审核中(财务总监)' }">
		<div class="layui-row title">
			<h5>财务经理审核</h5>
		</div>
		<div class="layui-row">
			<div class="layui-col-md12">
				<span>审核意见:</span> <span>${audit.advice}</span>
			</div>
		</div>
<!-- 		<div class="layui-row"> -->
<!-- 			<div class="layui-col-md12"> -->
<!-- 				<span>可看部门:</span> <span></span> -->
<!-- 			</div> -->
<!-- 		</div> -->
		<div class="layui-row title">
			<h5>财务总监审核</h5>
		</div>
		<form class="layui-form" lay-filter="form1">
			<div class="layui-form-item">
				<label class="layui-form-label"><span class="red">*</span>审核意见:</label>
				<div class="layui-input-inline">
					<select name="status" lay-filter="status">
						<option value="">--请选择--</option>
						<option value="已通过">同意</option>
						<option value="已驳回">不同意</option>
					</select>
				</div>
			</div>
			<div class="layui-form-item" style="display:none;" id="reasonDiv">
				<label class="layui-form-label"><span class="red">*</span>原因:</label>
				<div class="layui-input-block">
					<textarea placeholder="最多500字符" class="layui-textarea"
						name="auditReason" maxlength="500"></textarea>
				</div>
			</div>
			<div class="layui-row text-center">
				<div class="layui-col-md12" id="operation">
					<button type="button" lay-submit class="layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.audit();}">确定</button>
					<button type="button" class="layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.cancel();}">取消</button>
				</div>
			</div>
		</form>
	</c:if>
</div>


<script src="${ctx}/js/knockout-3.4.0.js"></script>

<script src="${ctx}/js/app/rotatearrive/audit.js"></script>
<script>
var status = "${model.status}";
var auditStep =1;
if(status == '审核中(财务经理)')
	auditStep =1;
else if(status == '审核中(财务总监)')
	auditStep=2;
var vm = new Audit("${model.id}",auditStep);
ko.applyBindings(vm,$(".container-box")[0]);
vm.initPage();
</script>
<%@include file="../common/AdminFooter.jsp"%>