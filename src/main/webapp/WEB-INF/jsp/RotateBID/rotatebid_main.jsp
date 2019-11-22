<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


	<%@include file="../common/AdminHeader.jsp"%>
	<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style>
	#mainTable + .layui-form .layui-table-body td[data-field="bidType"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="bidName"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="tenderee"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="saler"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="foodType"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="total"]{
		text-align: right;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="creator"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="createDate"]{
		text-align: center;
	}


</style>

	<div class="row clear-m">
		<ol class="breadcrumb">
			<li>轮换业务</li>
			<li>竞标管理</li>
			<li class="active">标的物明细</li>
		</ol>
	</div>



<div class="container-box clearfix" style="padding: 10px" id="rotatebid_main">
	
	<div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">标的物类别:</label>
				<div class="layui-input-inline">
					<select class="layui-input" name="bidType" lay-filter="aihao"
						id="state">
						<option value="">--请选择--</option>
						<option value="竞价销售">竞价销售</option>
						<option value="招标采购">招标采购</option>
						<option value="内部招标">内部招标</option>
						<option value="协议销售">协议销售</option>
					</select>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">招标人:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="tenderee"
						autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">卖出人:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="saler"
						autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">粮食品种:</label>
				<div class="layui-input-inline">

					<select name="foodType">
						<option value="">--请选择--</option>
						<c:forEach var="item" items="${grainTypes}">
							<option value="${item.value}">${item.value}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">经办时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="createDate" id="createDate"
						autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<button class=" layui-btn layui-btn-primary layui-btn-small " data-type="reload" id="searchBtn">查询</button>
			</div>
			<div class="layui-inline">
				<button class=" layui-btn layui-btn-primary layui-btn-small " data-type="reload" id="clear">清空</button>
			</div>
		</div>
	</div>

	<shiro:hasPermission name="RotateBID:add">
	<button class=" layui-btn layui-btn-primary layui-btn-small " id="add">
		<i class="layui-icon">&#xe608;</i> 新增
	</button>
	</shiro:hasPermission>
	
	<table class="layui-table" id="mainTable" lay-filter="table"></table>

	<script type="text/html" id="barDemo">
		<shiro:hasPermission name="RotateBID:view">
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
		</shiro:hasPermission>
		<shiro:hasPermission name="RotateBID:edit">
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">编辑</a>
		</shiro:hasPermission>
	</script>
	
	
<!-- 	<table class="layui-table">
		<thead>
				<tr>

					<td>标的物类别</td>
					<td>招标人/卖出人</td>
					<td>粮食品种</td>
					<td>数量合计（吨）</td>
					<td>经办人</td>
					<td>经办时间</td>
					<td>操作</td>
				</tr>
		</thead>
		<tbody data-bind="foreach:list">
			<tr>

				<td data-bind="text:bidType"></td>
				ko if:bidType=="招标采购"
				<td data-bind="text:tenderee"></td>
				/ko
				ko if:bidType!="招标采购"
				<td data-bind="text:saler"></td>
				/ko
				<td data-bind="text:foodType"></td>
				<td data-bind="text:total"></td>
				<td data-bind="text:creator"></td>
				<td data-bind="text:createDate"></td>

				<td>
					<a class="layui-btn  layui-btn-primary layui-btn layui-btn-mini" data-bind="click:function(){$root.show($data);}">查看</a>
					<a class="layui-btn  layui-btn-primary layui-btn layui-btn-mini" data-bind="click:function(){$root.edit($data);}">编辑</a>

				</td>

			</tr>
		</tbody>
	</table>
	<div class="layui-row text-center" data-bind="visible:list().length==0">无数据</div>
	<div id="pagination" class="pull-right"></div> -->
</div>


<script src="../js/knockout-3.4.0.js"></script>


<script src="../js/app/rotatebid/main.js"></script>
<script type="text/html" id="createDateFormat">
	{{Date_format(d.createDate,true)}}
</script>
<script>

	var vm = new Main();
	ko.applyBindings(vm,$(".container-box")[0]);
	vm.initPage();
</script>

<%@include file="../common/AdminFooter.jsp"%>
