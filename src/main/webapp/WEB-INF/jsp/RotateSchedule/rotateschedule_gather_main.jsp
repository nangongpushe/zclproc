<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../common/AdminHeader.jsp"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style>
	#mainTable1 + .layui-form .layui-table-body td[data-field="grainType"]{
		text-align: left;
	}
	#mainTable1 + .layui-form .layui-table-body td[data-field="schemeBatch"]{
		text-align: right;
	}
	#mainTable1 + .layui-form .layui-table-body td[data-field="quantity"]{
		text-align: right;
	}
	#mainTable1 + .layui-form .layui-table-body td[data-field="priorPeriod"]{
		text-align: right;
	}
	#mainTable1 + .layui-form .layui-table-body td[data-field="currentPeriod"]{
		text-align: right;
	}
	#mainTable1 + .layui-form .layui-table-body td[data-field="total"]{
		text-align: right;
	}
	#mainTable1 + .layui-form .layui-table-body td[data-field="compleRate"]{
		text-align: right;
	}
	#mainTable1 + .layui-form .layui-table-body td[data-field="modifyTimeStr"]{
		text-align: center;
	}
</style>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>执行进度</li>
		<li class="active">进度汇总</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">

	<div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">批次:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="schemeBatch" autocomplete="off">
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">品种:</label>
				<div class="layui-input-inline">
					<select class="layui-input" name="grainType" lay-filter="aihao"
						id="grainType">
						<option value=''>请选择</option>
						<c:forEach var="item" items="${grainTypes}">
							<option value="${item.value}">${item.value}</option>
						</c:forEach>
					</select>
				</div>
				
			</div>
			
			<!-- <div class="layui-inline">
				<label class="layui-form-label">截至时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="endTime" autocomplete="off">
				</div>
			</div> -->
			
			
			<div class="layui-inline">
				<button class=" layui-btn layui-btn-primary layui-btn-small" data-type="reload" data-bind="click:function(){$root.reloadTable();}">查询</button>
			</div>
			<div class="layui-inline">
				<button class=" layui-btn layui-btn-primary layui-btn-small" data-type="reload" data-bind="click:function(){$root.clear();}">清空</button>
			</div>
		</div>
	</div>

	<div class="layui-tab" lay-filter="test">
		<ul class="layui-tab-title">
			<li class="layui-this" data-type="入库">入库</li>
			<li data-type="出库">出库</li>
		</ul>

		<table class="layui-table" id="mainTable1" lay-filter="table1"></table>

		<script type="text/html" id="barDemo1">
			<shiro:hasPermission name="RotateSchedule_Gather:view">
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="view">查看</a>
			</shiro:hasPermission>
		</script>

	</div>

</div>


<script src="../js/knockout-3.4.0.js"></script>

<script src="../js/app/rotateschedule/gather_main.js"></script>
<script>
	var vm = new Main();
	ko.applyBindings(vm,$(".container-box")[0]);
	vm.initPage();
</script>
<%@include file="../common/AdminFooter.jsp"%>