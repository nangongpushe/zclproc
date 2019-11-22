<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style>
	#mainTable + .layui-form .layui-table-body td[data-field="dealSerial"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="grainType"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="inviteType"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="dealDate"]{
		text-align: center;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="gather"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="gatherDate"]{
		text-align: center;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="status"]{
		text-align: left;
	}

</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>竞标管理</li>
		<li class="active">成交结果明细管理</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
	
	<div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">粮食品种:</label>
				<div class="layui-input-inline">
					<select name="grainType">
						<option value="">--请选择--</option>
						<c:forEach var="item" items="${grainTypes}">
							<option value="${item.value}">${item.value}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">招标类别:</label>
				<div class="layui-input-inline">
					<select class="layui-input" name="inviteType" lay-filter="inviteType"
						id="inviteType">
						<option value="">--请选择--</option>
						<option value="竞价销售">竞价销售</option>
						<option value="招标采购">招标采购</option>
						<option value="内部招标">内部招标</option>
						<option value="协议销售">协议销售</option>
					</select>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">分发状态:</label>
				<div class="layui-input-inline">
					<select class="layui-input" name="status" lay-filter="status"
							id="status">
						<option value="">--请选择--</option>
						<option value="未分发">未分发</option>
						<option value="已分发">已分发</option>
					</select>
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">竞价交易时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="dealDate" id="dealDate"
						autocomplete="off">
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

	<table class="layui-table" id="mainTable" lay-filter="table" ></table>

	<script type="text/html" id="barDemo">

  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
		{{#  if(d.status !="已分发"){ }}
		<shiro:hasPermission name="RotateConclute:distribute">
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="distribute">分发</a>
		</shiro:hasPermission>
		{{#  } }}
	</script>
	
<!-- 	<table class="layui-table">
		<thead>
				<tr>

					<td>成交明细号</td>
					<td>粮食品种</td>
					<td>招标类别</td>
					<td>竞价交易时间</td>
					<td>汇总人</td>
					<td>汇总时间</td>
					<td>操作</td>
				</tr>
		</thead>
		<tbody data-bind="foreach:list">
			<tr>

				<td data-bind="text:dealSerial"></td>
				<td data-bind="text:grainType"></td>
				<td data-bind="text:inviteType"></td>
				<td data-bind="text:dealDate"></td>
				<td data-bind="text:gather"></td>
				<td data-bind="text:gatherDate"></td>

				<td>
					<a class="layui-btn  layui-btn-primary layui-btn layui-btn-mini" data-bind="click:function(){$root.show($data);}">查看</a>
				</td>

			</tr>
		</tbody>
	</table>
	<div class="layui-row text-center" data-bind="visible:list().length==0">无数据</div>
	<div id="pagination" class="pull-right"></div> -->
</div>


<script src="../js/knockout-3.4.0.js"></script>

<script src="../js/app/rotateconclute/main.js"></script>
<script type="text/html" id="dealDateFormat">
	{{Date_format(d.dealDate,true)}}
</script>
<script type="text/html" id="gatherDateFormat">
	{{Date_format(d.gatherDate,true)}}
</script>
<script>
var type = "${type}";
	var vm = new Main(type);
	ko.applyBindings(vm,$(".container-box")[0]);
	vm.initPage();
</script>
<%@include file="../common/AdminFooter.jsp"%>