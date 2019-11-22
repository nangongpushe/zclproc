<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<style>
	#myTable1 + .layui-form .layui-table-body td[data-field="planName"]{
		text-align: left;
	}
	#myTable1 + .layui-form .layui-table-body td[data-field="stockOut"]{
		text-align: right;
	}
	#myTable1 + .layui-form .layui-table-body td[data-field="stockIn"]{
		text-align: right;
	}
	#myTable1 + .layui-form .layui-table-body td[data-field="state"]{
		text-align: left;
	}

</style>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>轮换计划详情</li>
		<li class="active">计划清单</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">

	<div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
<!-- 			<div class="layui-inline">
				<label class="layui-form-label ">计划名称:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="planName"
						autocomplete="off">
				</div>
			</div> -->
			<div class="layui-inline">
				<label class="layui-form-label ">年份:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="year" id="year" autocomplete="off">
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label layui-col-md2">分发时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="completeDate" autocomplete="off">
				</div>
			</div>

			<div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small " data-bind="click:function(){$root.clearAll();}">清空</button>
			</div>

			<div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small " data-bind="click:function(){$root.reloadTable();}">查询</button>
			</div>

		</div>
	</div>
	
	
 	<table class="layui-table" lay-filter="table1" id="myTable1"></table>
	<script type="text/html" id="barDemo">

		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="view">查看</a>
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="remove">删除</a>
  	</script> 
  	
<!-- 	<table class="layui-table">
		<thead>
				<tr>

					<td class="col-md-1">计划名称</td>
					<td class="col-md-1">文号</td>
					<td class="col-md-1">年份</td>
					<td class="col-md-1">出库总数</td>
					<td class="col-md-1">入库总数</td>
					<td class="col-md-1">创建人</td>
					<td class="col-md-1">创建时间</td>
					<td class="col-md-1">状态</td>
					<td class="col-md-2">操作</td>
				</tr>
		</thead>
		<tbody data-bind="foreach:list">
			<tr>

				<td data-bind="text:planName"></td>
				<td data-bind="text:documentNumber"></td>
				<td data-bind="text:year"></td>
				<td>
					<a href="javascript:void(0);" class="layui-table-link" data-bind="text:stockOut,click:function(){$root.show($data,'轮出')}"></a>
				</td>
				<td>
					<a href="javascript:void(0);" class="layui-table-link" data-bind="text:stockIn,click:function(){$root.show($data,'轮入')}"></a>
				</td>
				<td data-bind="text:colletor"></td>
				<td data-bind="text:colletorDate"></td>
				<td data-bind="text:state"></td>

				<td>
					<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" data-bind="click:function(){$root.show($data);}">查看</a>
					ko if:state == "未提交"
					<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" data-bind="click:function(){$root.submit($data,'OA流程','提交');}" data-state="OA流程">提交</a>
					/ko
					ko if:state() == "未提交" ||state() == "OA流程"
					<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" data-bind="click:function(){$root.edit($data);}">修改</a>
					/ko
					ko if:state() == "OA流程"
					<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" data-bind="click:function(){$root.submit($data,'审核通过','通过审核');}" data-state="审核">通过</a>
					/ko
					ko if:state() == "审核通过"
					<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" data-bind="click:function(){$root.submit($data,'已分发','分发');}">分发</a>
					/ko
				</td>

			</tr>
		</tbody>
	</table>
	<div class="layui-row text-center" data-bind="visible:list().length==0">无数据</div>
	<div id="pagination" class="pull-right"></div> -->
</div>

<script src="${ctx}/js/knockout-3.4.0.js"></script>
<script src="${ctx}/js/app/rotateplan/main2.js"></script>
<script type="text/html" id=completeDateFormat>
	{{Date_format(d.completeDate,true)}}
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