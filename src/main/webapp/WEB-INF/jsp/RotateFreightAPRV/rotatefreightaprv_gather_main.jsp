<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
	<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style>
	#mainTable + .layui-form .layui-table-body td[data-field="grainType"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="gatherMan"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="gatherTime"]{
		text-align: center;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="status"] {
		text-align: left;
	}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>运费管理</li>
		<li class="active">运费审批汇总</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
	
	<div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">粮食品种:</label>
				<div class="layui-input-inline">
					<select  name="grainType">
						<option value="">--请选择--</option>
						<c:forEach var="item" items="${grainTypes}">
								<option value="${item.value}">${item.value}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">汇总人:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="gatherMan" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">汇总时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="gatherTime" autocomplete="off" id="gatherTime">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">状态:</label>
				<div class="layui-input-inline">
					<%--<input class="layui-input" name="status" autocomplete="off">--%>
					<select  name="status">
						<option value="">--全部--</option>
						<option value="OA汇总审核">OA汇总审核</option>
						<option value="已驳回">已驳回</option>
						<option value="未上报">未上报</option>
						<option value="待汇总">待汇总</option>
						<option value="已汇总">已汇总</option>
						<%--<c:forEach var="item" items="${grainTypes}">
							<option value="${item.value}">${item.value}</option>
						</c:forEach>--%>
					</select>


				</div>
			</div>
			

			<div class="layui-inline">
				<button class=" layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.queryPageList();}">查询</button>
			</div>
			<div class="layui-inline">
				<button class=" layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.clear();}">清空</button>
			</div>
		</div>
	</div>

	
	<table class="layui-table" id="mainTable" lay-filter="table"></table>

	<script type="text/html" id="barDemo">
		
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
		 
		{{#  if(d.status == "未上报" || d.status=="已驳回"){ }}
<shiro:hasPermission name="RotateFreightAPRVGather:report">
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="report">上报</a>
</shiro:hasPermission>
<shiro:hasPermission name="RotateFreightAPRVGather:remove">
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="remove">删除</a>
</shiro:hasPermission>
		{{#  } }}
{{#  if(d.status == "未上报" || d.status=="OA汇总审核"|| d.status=="待汇总"){ }}
<shiro:hasPermission name="RotateFreightAPRVGather:reject">
	<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="reject">驳回</a>
</shiro:hasPermission>
{{#  } }}
		{{#  if(d.status == "待汇总" ){ }}
		<%--<shiro:hasPermission name="RotateFreightAPRV:gather">--%>
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="gather">汇总</a>
		<%--</shiro:hasPermission>--%>
		{{#  } }}
	</script>
</div>

<script src="${ctx}/js/knockout-3.4.0.js"></script>

<script src="${ctx}/js/app/rotatefreightaprv/gather_main.js"></script>
<script type="text/html" id="gatherTimeFormat">
	{{Date_format(d.gatherTime,true)}}
</script>
<script>
	var vm = new Main("${type}");
	ko.applyBindings(vm,$(".container-box")[0]);
	vm.initPage();
</script>
<%@include file="../common/AdminFooter.jsp"%>