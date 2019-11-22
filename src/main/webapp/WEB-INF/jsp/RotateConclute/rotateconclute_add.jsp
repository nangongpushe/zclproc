<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>
<%-- <c:set var="ctx" value="${pageContext.request.contextPath}" /> --%>

<%@include file="../common/AdminHeader.jsp"%>

<style>

</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>竞标管理</li>
		<li class="active">招标结果管理</li>
	</ol>
</div>


<div class="container-box clearfix" style="padding: 10px">

	<div class="layui-row title">
		<h5>招标结果信息</h5>
	</div>
	
	<form class="layui-form"  lay-filter="form1">

		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label"><span class="red">*</span>招标结果名称:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="inviteName" lay-verify="required"
						autocomplete="off" placeholder="请输入招标结果名称"
						value="${model.inviteName}">
				</div>
			</div>

			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label"><span class="red">*</span>招标结果类别:</label>
				<div class="layui-input-inline">
					<select lay-verify="required" name="inviteType"
						lay-filter="inviteType">
						<option value="招标采购">招标采购</option>
						<option value="竞价销售">竞价销售</option>
						<option value="内部招标">内部招标</option>
						<option value="协议销售">协议销售</option>
					</select>
				</div>
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label"><span class="red">*</span>委托单位:</label>
				<div class="layui-input-inline">
					<input type="text" name="entrustCompany" lay-verify="required"
						autocomplete="off" placeholder="请输入委托单位" class="layui-input"
						value="${model.entrustCompany}">
				</div>
			</div>

			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label"><span class="red">*</span>委托标的:</label>
				<div class="layui-input-inline">
					<input type="text" name="entrustBid" lay-verify="required"
						autocomplete="off" placeholder="请输入委托标的" class="layui-input"
						value="${model.entrustBid}">
				</div>
			</div>
		</div>


		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label"><span class="red">*</span>委托数量:</label>
				<div class="layui-input-inline">
					<input name="entrustNum" autocomplete="off" placeholder="请输入委托数量"
						class="layui-input" lay-verify="required"
						value="${model.entrustNum}">
				</div>
			</div>

			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label"><span class="red">*</span>实施单位:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="exploitingEntity"
						placeholder="请输入实施单位" autocomplete="off" lay-verify="required"
						value="${model.exploitingEntity}">
				</div>
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label">经办人:</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" name="operator" placeholder="请输入经办人"
						autocomplete="off" value="${model.operator}" readonly>
				</div>
			</div>

			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label">经办部门:</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" name="department" placeholder="请输入经办部门"
						autocomplete="off" value="${model.department}"
						readonly>
				</div>
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label">经办时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input form-control" name="handleTime" placeholder="请输入经办时间"
						autocomplete="off"
						value='<fmt:formatDate value="${model.handleTime}" pattern="yyyy-MM-dd" />'
						readonly>
				</div>
			</div>

		</div>


		<div class="layui-form-item layui-form-text">
			<div class="layui-inline layui-col-md5">
				<label class="layui-form-label">备注:</label>
				<div class="layui-input-inline">
					<textarea placeholder="最多2000字符" class="layui-textarea"
						name="remark" maxlength="2000">${model.remark}</textarea>
				</div>
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class=" layui-btn layui-btn-primary layui-btn-small" lay-submit="" lay-filter="save">保存</button>
				<button type="button" class=" layui-btn layui-btn-primary layui-btn-small" id="cancel">取消</button>
			</div>
		</div>
	</form>

</div>

<script>


</script>
<%@include file="../common/AdminFooter.jsp"%>