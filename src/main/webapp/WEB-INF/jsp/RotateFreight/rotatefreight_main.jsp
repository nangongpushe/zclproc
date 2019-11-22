<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
	<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style>
	#mainTable + .layui-form .layui-table-body td[data-field="freightName"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="inviteUnit"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="inviteTime"]{
		text-align: center;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="status"] {
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="operator"] {
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="operatorTime"] {
		text-align: center;
	}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>运费管理</li>
		<c:if test="${view_type=='invite' }">
			<li class="active">运费成交结果</li>
		</c:if>
		<c:if test="${view_type!='invite' }">
			<li class="active">运费采购方案</li>
		</c:if>
		
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
	
	<div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">运费方案名称:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="freightName" autocomplete="off">
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">招标开始时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="inviteTime"
						autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">招标单位:</label>
				<div class="layui-input-inline">
						<%--<select lay-verify="required" class="form-control"  name="inviteUnit" id="inviteUnit" lay-search lay-filter="inviteUnit">
							<option value="">--搜索选择--</option>
							<c:forEach items="${customers}" var="customer">
								<option value="${customer.clientName}" >${customer.clientName}</option>
							</c:forEach>
						</select>--%>
					<input class="layui-input" name="inviteUnit" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">经办人:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="operator"
						   autocomplete="off">
				</div>
			</div>
			<c:if test="${view_type ne 'invite'}">
			<div class="layui-inline">
				<label class="layui-form-label">状态:</label>
				<div class="layui-input-inline">
					<select name="status">
						<option value="">--请选择--</option>
						<option value="待提交">待提交</option>
						<option value="审核中">审核中</option>
						<option value="审核通过">审核通过</option>
						<option value="已驳回">已驳回</option>
					</select>
				</div>
			</div>
			</c:if>
			<div class="layui-inline">
				<button class=" layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.queryPageList();}">查询</button>
			</div>
			<div class="layui-inline">
				<button class=" layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.clear();}">清空</button>
			</div>
		</div>
	</div>

	<c:if test="${view_type ne 'invite'}">
	<shiro:hasPermission name="RotateFreight:add">
	<button class=" layui-btn layui-btn-primary layui-btn-small" id="add" data-bind="click:function(){$root.add();}">
		<i class="layui-icon">&#xe608;</i> 新增
	</button>
	</shiro:hasPermission>
	</c:if>
	
	
	<table class="layui-table" id="mainTable" lay-filter="table"></table>
	

	<script type="text/html" id="barDemo">
		
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
		 
		{{#  if(d.status =="待提交" || d.status=="已驳回"){ }}
<shiro:hasPermission name="RotateFreight:edit">
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">编辑</a>
</shiro:hasPermission>
<shiro:hasPermission name="RotateFreight:submit">
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="submit">提交</a>
</shiro:hasPermission>
        {{#  } }}
		{{#  if(d.status =="审核中" ){ }}
<shiro:hasPermission name="RotateFreight:audit">
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="audit">审核</a>
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="reject">驳回</a>
</shiro:hasPermission>
		{{#  } }} 
		{{#  if(d.status =="审核通过" ){ }}
		<c:if test="${view_type=='invite'}">
<shiro:hasPermission name="RotateFreight:invite_edit">
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="invite_edit">招标结果录入</a>
</shiro:hasPermission>
		</c:if>
		{{#  } }}
	</script>
</div>

<script src="${ctx}/js/knockout-3.4.0.js"></script>

<script src="${ctx}/js/app/rotatefreight/main.js"></script>
<script type="text/html" id="inviteTimeFormat">
	{{Date_format(d.inviteTime,true)}}
</script>
<script type="text/html" id="inviteEndTimeFormat">
	{{Date_format(d.inviteEndTime,true)}}
</script>
<script type="text/html" id="operatorTimeFormat">
	{{Date_format(d.operatorTime,true)}}
</script>
<script>
	var viewType="${view_type}"
	var vm = new Main(viewType);
	ko.applyBindings(vm,$(".container-box")[0]);
	vm.initPage();
</script>
<%@include file="../common/AdminFooter.jsp"%>