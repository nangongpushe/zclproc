<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<style>

	#myTable + .layui-form .layui-table-body td[data-field="bidSerial"]{
		text-align: left;
	}
	#myTable + .layui-form .layui-table-body td[data-field="company"]{
		text-align: left;
	}
	#myTable + .layui-form .layui-table-body td[data-field="dealDate"]{
		text-align: center;
	}
	#myTable + .layui-form .layui-table-body td[data-field="dealType"]{
		text-align: left;
	}
	#myTable + .layui-form .layui-table-body td[data-field="refundAmount"]{
		text-align: right;
	}
	#myTable + .layui-form .layui-table-body td[data-field="operator"]{
		text-align: left;
	}
	#myTable + .layui-form .layui-table-body td[data-field="department"]{
		text-align: left;
	}
	#myTable + .layui-form .layui-table-body td[data-field="handleTime"]{
		text-align: center;
	}


</style>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>竞标管理</li>
		<li class="active">保证金退还</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px" id="rotatearrive_main">
	
	<div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">单位:</label>
				<div class="layui-input-inline">
					<select name="company" lay-search>
						<option value=""></option>
						<c:forEach items="${customers}" var="custom">
							<option value="${custom.clientName}">${custom.clientName}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">交易时间:</label>
				<div class="layui-input-inline">
					<input type="text" name="dealDate"
						autocomplete="off" placeholder="请输入交易日期" class="layui-input">
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">编号:</label>
				<div class="layui-input-inline">
					<input type="text" name="serial"
						autocomplete="off" placeholder="请输入编号" class="layui-input">
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">交易方式:</label>
				<div class="layui-input-inline">
					<select name="dealType">
						<option value="">--请选择--</option>
						<option value="招标采购">招标采购</option>
						<%--<option value="订单采购">订单采购</option>--%>
						<%--<option value="进口粮采购">进口粮采购</option>--%>
						<option value="竞价销售">竞价销售</option>
						<option value="内部招标">内部招标</option>
						<option value="协议销售">协议销售</option>
					</select>
				</div>
			</div>
			
<!-- 			<div class="layui-inline">
				<label class="layui-form-label">交易金额:</label>
				<div class="layui-input-inline">
					<input type="text" name="dealAmount"
						autocomplete="off" placeholder="请输入交易金额" class="layui-input">
				</div>
			</div> -->
			
			<div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.reloadTable();}">查询</button>
			</div>

			<div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.clear();}">清空</button>
			</div>
		</div>
	</div>


	<button class=" layui-btn layui-btn-primary layui-btn-small" id="add" data-bind="click:function(){$root.add();}">
		<i class="layui-icon">&#xe608;</i> 新增
	</button>
	
	<table class="layui-table" lay-filter="table" id="myTable"></table>
	<script type="text/html" id="barDemo">

			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="view">查看</a>

			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit" >编辑</a>

			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="remove" >删除</a>


		
  	</script>
</div>


<script src="${ctx}/js/knockout-3.4.0.js"></script>

<script src="${ctx}/js/app/rotaterefund/main.js"></script>
<script type="text/html" id="dealDateFormat">
	{{Date_format(d.dealDate,true)}}
</script>
<script type="text/html" id="handleTimeFormat">
	{{Date_format(d.handleTime,true)}}
</script>
<script>

	var vm = new Main();
	ko.applyBindings(vm,$(".container-box")[0]);
	vm.initPage();
</script>
<%@include file="../common/AdminFooter.jsp"%>