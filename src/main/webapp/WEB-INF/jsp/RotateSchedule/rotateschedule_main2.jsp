<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style>
	#mainTable + .layui-form .layui-table-body td[data-field="operator"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="department"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="reportTime"]{
		text-align: center;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="reportUnit"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="noticeType"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="noticeSerial"]{
		text-align: left;
	}
</style>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>执行进度</li>
		<li class="active">进度查询</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
	
	<div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">填报时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="reportTime" autocomplete="off">
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">填报单位:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="reportUnit" autocomplete="off">
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">类型:</label>
				<div class="layui-input-inline">
					<select class="layui-input" name="noticeType" lay-filter="aihao"
						id="noticeType">
						<option value=''>请选择</option>
						<option value="出库">出库</option>
						<option value="入库">入库</option>
					</select>
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">通知书编号:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="noticeSerial" autocomplete="off">
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">经办人:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="operator" autocomplete="off">
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">经办部门:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="department" autocomplete="off">
				</div>
			</div>
			
			<div class="layui-inline">
				<button class=" layui-btn layui-btn-primary layui-btn-small" data-type="reload" data-bind="click:function(){$root.queryPageList();}">查询</button>
			</div>
			<div class="layui-inline">
				<button class=" layui-btn layui-btn-primary layui-btn-small" data-type="reload" data-bind="click:function(){$root.clear();}">清空</button>
			</div>
		</div>
	</div>

	
	<table class="layui-table" id="mainTable" lay-filter="table"></table>

	<script type="text/html" id="barDemo">
		<shiro:hasPermission name="RotateSchedule_Company:view">
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
		</shiro:hasPermission>
	</script>
	
</div>


<script src="../js/knockout-3.4.0.js"></script>

<script src="../js/app/rotateschedule/main2.js"></script>
<script type="text/html" id="reportTimeFormat">
	{{Date_format(d.reportTime,true)}}
</script>
<script>
var type = "${type}";
var vm = new Main(type);
	ko.applyBindings(vm,$(".container-box")[0]);
	vm.initPage();
</script>
<%@include file="../common/AdminFooter.jsp"%>