<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
	<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<style>
	#mainTable + .layui-form .layui-table-body td[data-field="reportUnit"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="grainType"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="totalQuantity"]{
		text-align: right;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="totalBulk"] {
		text-align: right;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="totalPackage"] {
		text-align: right;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="totalFreight"] {
		text-align: right;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="totalFee"] {
		text-align: right;
	}#mainTable + .layui-form .layui-table-body td[data-field="status"] {
		 text-align: left;
	 }
	#mainTable + .layui-form .layui-table-body td[data-field="company"] {
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="reportDate"] {
		text-align: center;
	}
</style>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>运费管理</li>
		<li class="active">运费审批管理</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
	
	<div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">调入单位:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="reportUnit" autocomplete="off">
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">调出单位:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="outUnit"
						autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">品种:</label>
				<div class="layui-input-inline">
					<%--<input class="layui-input" name="grainType"
						   autocomplete="off">--%>
						<select name="grainType" id="grainType">
							<option value="">--全部--</option>
							<c:forEach items="${grainTypes }" var="item">
								<option value="${item.value }">${item.value }</option>
							</c:forEach>
						</select>
				</div>
			</div>
			<%--<div class="layui-inline">
				<label class="layui-form-label">填报单位:</label>
				<div class="layui-input-inline">
					&lt;%&ndash;<input class="layui-input" name="company"
						   autocomplete="off">&ndash;%&gt;
						<select lay-verify="required" class="form-control"  name="company" id="company" lay-search lay-filter="company">
							<option value="">--搜索选择--</option>
							<c:forEach items="${storageWarehouses}" var="storageWarehouse">
								<option value="${storageWarehouse.warehouseShort}" >${storageWarehouse.warehouseShort}</option>
							</c:forEach>
						</select>
				</div>
			</div>--%>
			<div class="layui-inline">
				<label class="layui-form-label">状态:</label>
				<div class="layui-input-inline">
						<select  name="status">
							<option value="">--全部--</option>
							<option value="未提交">未提交</option>
							<option value="OA汇总审核">OA汇总审核</option>

							<option value="未上报">未上报</option>
							<option value="待汇总">待汇总</option>
							<option value="已驳回">已驳回</option>
							<option value="已汇总">已汇总</option>
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
<shiro:hasPermission name="RotateFreightAPRV:add">
	<button class=" layui-btn layui-btn-primary layui-btn-small" id="add" data-bind="click:function(){$root.add();}">
		 新增
	</button>
</shiro:hasPermission>	
	<table class="layui-table" id="mainTable" lay-filter="table"></table>

	<script type="text/html" id="barDemo">
		
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
		 
		{{#  if(d.status =="未提交" || d.status == "已驳回"){ }}
<shiro:hasPermission name="RotateFreightAPRV:edit">
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">编辑</a>
</shiro:hasPermission>
<shiro:hasPermission name="RotateFreightAPRV:submit">
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="submit">提交</a>
</shiro:hasPermission>
<shiro:hasPermission name="RotateFreightAPRV:remove">
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="remove">删除</a>
</shiro:hasPermission>
        {{#  } }}
		{{#  if(d.status =="未上报" ){ }}
<shiro:hasPermission name="RotateFreightAPRV:report">
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="report">上报</a>
</shiro:hasPermission>
		{{#  } }}
		{{#  if(d.status == "待汇总"){ }}
<shiro:hasPermission name="RotateFreightAPRV:gather">
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="gather">汇总</a>
</shiro:hasPermission>
		{{#  } }}
		{{#  if(d.status == "OA汇总审核"||d.status == "待汇总"){ }}
<shiro:hasPermission name="RotateFreightAPRV:reject">
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="reject">驳回</a>
</shiro:hasPermission>
		{{#  } }}
	</script>
</div>

<script src="${ctx}/js/knockout-3.4.0.js"></script>

<script src="${ctx}/js/app/rotatefreightaprv/main.js"></script>
<script type="text/html" id="reportDateFormat">
	{{Date_format(d.reportDate,true)}}
</script>
<script>
	var vm = new Main('${type}');
	ko.applyBindings(vm,$(".container-box")[0]);
	vm.initPage();
</script>
<%@include file="../common/AdminFooter.jsp"%>