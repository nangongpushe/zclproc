<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
	<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style>
	#mainTable + .layui-form .layui-table-body td[data-field="inviteSerial"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="inviteName"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="inviteType"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="operator"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="handleTime"]{
		text-align: center;
	}
</style>


<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>竞标管理</li>
		<li class="active">招标结果管理</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
	
	<div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">招标结果名称:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="inviteName" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">招标结果类别:</label>
				<div class="layui-input-inline">
					<select class="layui-input" name="inviteType" lay-filter="inviteType"
						id="inviteType">
						<option></option>
						<option>竞价销售</option>
						<option>招标采购</option>
						<option>内部招标</option>
						<option>协议销售</option>
					</select>
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">创建时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="handleTime" id="handleTime"
						autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<button class=" layui-btn layui-btn-primary layui-btn-small" data-type="reload" id="searchBtn">查询</button>
			</div>
			<div class="layui-inline">
				<button class=" layui-btn layui-btn-primary layui-btn-small" data-type="reload" id="clear">清空</button>
			</div>
		</div>
	</div>

	<shiro:hasPermission name="RotateInvite:add">
	<button class=" layui-btn layui-btn-primary layui-btn-small" id="add">
		<i class="layui-icon">&#xe608;</i> 新增
	</button>
	</shiro:hasPermission>
	<table class="layui-table" id="mainTable" lay-filter="table"></table>

	<script type="text/html" id="barDemo">
		<shiro:hasPermission name="RotateInvite:view">
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
		</shiro:hasPermission>

		{{#  if(d.isGather =="0" ){ }}
		<shiro:hasPermission name="RotateInvite:edit">
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">编辑</a>
		</shiro:hasPermission>
		<shiro:hasPermission name="RotateInvite:submit">
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="submit">提交</a>
		</shiro:hasPermission>
		{{#  } }}
	</script>
	
<!-- 	<table class="layui-table">
		<thead>
				<tr>
					<td>招标结果编号</td>
					<td>招标结果名称</td>
					<td>招标结果类别</td>
					<td>创建人</td>
					<td>时间</td>
					<td>操作</td>
				</tr>
		</thead>
		<tbody data-bind="foreach:list">
			<tr>
				<td data-bind="text:id"></td>
				<td data-bind="text:inviteName"></td>
				<td data-bind="text:inviteType"></td>
				<td data-bind="text:operator"></td>
				<td data-bind="text:handleTime"></td>
				<td>
					<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" data-bind="click:function(){$root.show($data);}">查看</a>
					<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" data-bind="click:function(){$root.edit($data);}">编辑</a>

				</td>
			</tr>
		</tbody>
	</table>
	<div class="layui-row text-center" data-bind="visible:list().length==0">无数据</div>
	<div id="pagination" class="pull-right"></div> -->
</div>

<script src="${ctx}/js/knockout-3.4.0.js"></script>

<script src="${ctx}/js/app/rotateinvite/main.js"></script>
<script type="text/html" id="handleTimeFormat">
	{{Date_format(d.handleTime,true)}}
</script>
<script>

	var vm = new Main();
	ko.applyBindings(vm,$(".container-box")[0]);
	vm.initPage();
</script>
<%@include file="../common/AdminFooter.jsp"%>