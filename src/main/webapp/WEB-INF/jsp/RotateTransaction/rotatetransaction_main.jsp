<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style>
/*	#mainTable + .layui-form .layui-table-box th{
		text-align: center;
	}*/
	#mainTable + .layui-form .layui-table-body td[data-field="dealSerial"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="grainType"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="inviteType"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="gather"]{
		 text-align: left;
	 }
	#mainTable + .layui-form .layui-table-body td[data-field="gatherDateStr"]{
		text-align: center;
	}
</style>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>竞标管理</li>
		<li class="active">交易明细</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
	
	<div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">粮食品种:</label>
				<div class="layui-input-inline">

					<select name="grainType" id="grainType">
						<option value="">--请选择--</option>
						<c:forEach var="item" items="${grainTypes}">
							<option value="${item.value}">${item.value}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">采购类别:</label>
				<div class="layui-input-inline">
					<select class="layui-input" name="inviteType" lay-filter="inviteType"
						id="inviteType">
						<option></option>
						<option>订单采购</option>
						<option>进口粮采购</option>
					</select>
				</div>
			</div>
			

			<div class="layui-inline">
				<button class=" layui-btn layui-btn-primary layui-btn-small" data-type="reload" data-bind="click:function(){$root.queryPageList();}">查询</button>
			</div>
			<div class="layui-inline">
				<button class=" layui-btn layui-btn-primary layui-btn-small" id="clear" data-bind="click:function(){$root.clear();}">清空</button>
			</div>
		</div>
	</div>
	<shiro:hasPermission name="RotateTransaction:add">
	<button class=" layui-btn layui-btn-primary layui-btn-small" id="add" data-bind="click:function(){$root.add();}">
		<i class="layui-icon">&#xe608;</i> 新增
	</button>
	</shiro:hasPermission>
	<table class="layui-table" id="mainTable" lay-filter="table"></table>

	<script type="text/html" id="barDemo">
		<shiro:hasPermission name="RotateTransaction:view">
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
		</shiro:hasPermission>
	</script>

</div>


<script src="../js/knockout-3.4.0.js"></script>

<script src="../js/app/rotatetransaction/main.js"></script>
<script>
var type = "${type}";
var vm = new Main(type);
	ko.applyBindings(vm,$(".container-box")[0]);
	vm.initPage();

/*$('#clear').click(function(){
    $('#search [name="grainType"]').val("");
    $('#search [name="inviteType"]').val("");
});*/

</script>
<%@include file="../common/AdminFooter.jsp"%>