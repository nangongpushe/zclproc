<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<style>
	#myTable1 + .layui-form .layui-table-body td[data-field="planName"]{
		text-align: left;
	}
	#myTable1 + .layui-form .layui-table-body td[data-field="planType"]{
		text-align: left;
	}
	#myTable1 + .layui-form .layui-table-body td[data-field="year"]{
		text-align: center;
	}
	#myTable1 + .layui-form .layui-table-body td[data-field="foodType"]{
		text-align: left;
	}
	#myTable1 + .layui-form .layui-table-body td[data-field="stockOut"]{
		text-align: right;
	}
	#myTable1 + .layui-form .layui-table-body td[data-field="stockIn"]{
		text-align: right;
	}
	#myTable1 + .layui-form .layui-table-body td[data-field="colletor"]{
		text-align: left;
	}
	#myTable1 + .layui-form .layui-table-body td[data-field="colletorDate"]{
		text-align: center;
	}
	#myTable1 + .layui-form .layui-table-body td[data-field="state"]{
		text-align: left;
	}
</style>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>轮换计划</li>
		<li class="active">计划申报</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">

	<div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label ">年份:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="year" id="year" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">创建人:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="colletor" id="colletor"
						autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label layui-col-md2">创建时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="colletorDate" id="colletorDate"
						autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">状态:</label>
				<div class="layui-input-inline">
					<!-- <div class="layui-inline" style="width: 170px"> -->
					<select class="layui-input" name="state" lay-filter="aihao"
						id="state">
						<option></option>
						<option value="未提交">未提交</option>
						<option value="OA流程">OA流程</option>
						<option value="审核通过">审核通过</option>
					</select>
					<!-- </div> -->
				</div>
			</div>
			<div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small " data-bind="click:function(){$root.reloadTable();}">查询</button>
				<button class="layui-btn layui-btn-primary layui-btn-small " data-bind="click:function(){$root.delSearch();}">清空</button>
			</div>
		</div>
	</div>
	
	<shiro:hasPermission name="RotatePlan:add">
	<button class=" layui-btn layui-btn-primary layui-btn-small" id="add" data-bind="click:function(){$root.add();}">
		<i class="layui-icon">&#xe608;</i> 新增
	</button>
	</shiro:hasPermission>
 	<table class="layui-table" lay-filter="table1" id="myTable1"></table>
	<script type="text/html" id="barDemo">
		{{#  if(d.state =="未提交" ){ }}
		<shiro:hasPermission name="RotatePlan:submit">
  		<a class="layui-btn layui-btn layui-btn-mini" lay-event="submit">提交</a>
		</shiro:hasPermission>
  		 {{#  } }}
  		 {{#  if(d.state =="未提交" ||d.state == "OA流程"){ }}
		<shiro:hasPermission name="RotatePlan:edit">
  		<a class="layui-btn layui-btn layui-btn-mini" lay-event="edit">修改</a>
		</shiro:hasPermission>
  		{{#  } }}
		<%--{{#  if(d.state =="未提交"){ }}--%>
		<shiro:hasPermission name="RotatePlan:edit">
			<a class="layui-btn layui-btn layui-btn-mini" lay-event="remove">删除</a>
		</shiro:hasPermission>
		<%--{{#  } }}--%>
  		{{#  if(d.state == "OA流程" || d.state == "待审核"){ }}
		<shiro:hasPermission name="RotatePlan:pass">
  		<a class="layui-btn layui-btn layui-btn-mini" lay-event="pass">同意</a>
		</shiro:hasPermission>
  		{{#  } }}
  		{{#  if(d.state =="审核通过"){ }}
		<shiro:hasPermission name="RotatePlan:distribute">
		<a class="layui-btn layui-btn layui-btn-mini" lay-event="distribute">查看</a>
		</shiro:hasPermission>
		{{#  } }}
		<shiro:hasPermission name="RotatePlan:export">
		<a href="../rotatePlan/exportExcelPlan.shtml?id={{d.id}}" class="layui-btn layui-btn layui-btn-mini" id="exportExcel">导出</a>
		</shiro:hasPermission>
  	</script> 
  	
</div>

<script src="${ctx}/js/knockout-3.4.0.js"></script>
<script src="${ctx}/js/app/rotateplan/declare.js"></script>
<script type="text/html" id="colletorDateFormat">
	{{Date_format(d.colletorDate,true)}}
</script>
<script type="text/html" id="stockOut">
  <a href="javascript:void(0);" data-id="{{d.id}}" class="layui-table-link" data-type="轮出">{{d.stockOut}}</a>
</script>
<script type="text/html" id="stockIn">
  <a href="javascript:void(0);" data-id="{{d.id}}" class="layui-table-link" data-type="轮入">{{d.stockIn}}</a>
</script>
<script>
	var type = "${type}";
	var vm = new Main(type);
	ko.applyBindings(vm,$(".container-box")[0]);
	vm.initPage();
</script>
<%@include file="../common/AdminFooter.jsp"%>