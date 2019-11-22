<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
	<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<style>
	#mainTable + .layui-form .layui-table-body td[data-field="paySerial"]{
		 text-align: left;
	 }
    #mainTable + .layui-form .layui-table-body td[data-field="reportDate"]{
        text-align: center;
    }
	#mainTable + .layui-form .layui-table-body td[data-field="clientName"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="depositAccount"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="payType"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="proceedType"]{
		text-align: left;
	}
	#mainTable + .layui-form .layui-table-body td[data-field="status"]{
		text-align: left;
	}


</style>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>商务处理</li>
		<li class="active">货款支付审批</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
	
	<div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">收款单位:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="clientName" autocomplete="off">
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">账号:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="depositAccount"
						autocomplete="off">
				</div>
			</div>

			<div class="layui-inline">
				<label class="layui-form-label">付款方式:</label>
				<div class="layui-input-inline">
					<select name="payType">
						<option value="">--请选择--</option>
						<c:forEach var="item" items="${payTypes}">
								<option value="${item.value}">${item.value}</option>
						</c:forEach>						
					</select>
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">货款类型:</label>
				<div class="layui-input-inline">
					<select name="proceedType">
						<option value="">--请选择--</option>
						<c:forEach var="item" items="${proceedTypes}">
								<option value="${item.value}">${item.value}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">状态:</label>
				<div class="layui-input-inline">
					<select name="status">
						<option value="">--请选择--</option>
						<option value="待提交">待提交</option>
						<option value="审核中">审核中</option>
						<option value="审核通过">审核通过</option>
						<option value="驳回">驳回</option>
					</select>
				</div>
			</div>
	
			<div class="layui-inline">
				<button class=" layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.queryPageList();}">查询</button>
			</div>
			<div class="layui-inline">
				<input type="button" id="clearBtn" class="layui-btn layui-btn-primary layui-btn-small" value="清空">
				<%--<button class=" layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.queryPageList();}">查询</button>--%>
			</div>
		</div>
	</div>

	<shiro:hasPermission name="RotatePayment:add">
	<button class=" layui-btn layui-btn-primary layui-btn-small" id="add" data-bind="click:function(){$root.add();}">
		<i class="layui-icon">&#xe608;</i> 新增
	</button>
	</shiro:hasPermission>
	<table class="layui-table" id="mainTable" lay-filter="table"></table>

	<script type="text/html" id="barDemo">
		
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>

		{{#  if(d.status =="待提交"|| d.status=="驳回" ){ }}
		<shiro:hasPermission name="RotatePayment:submit">
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="submit">提交</a>
		</shiro:hasPermission>
        {{#  } }}

		 {{# if(d.status=="待提交" || d.status=="驳回"){ }}
<shiro:hasPermission name="RotatePayment:edit">
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">编辑</a>
</shiro:hasPermission>
<shiro:hasPermission name="RotatePayment:remove">
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="remove">删除</a>
</shiro:hasPermission>
		{{#  } }}

		<shiro:hasPermission name="RotatePayment:audit">
			{{# if(d.status=="审核中(业务部经理)" ){ }}
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="audit">审核</a>
			{{#  } }}

		</shiro:hasPermission>


		<shiro:hasPermission name="RotatePayment:audit1">
			{{# if(d.status=="审核中(业务部经理)" ){ }}
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="audit">审核</a>
			{{#  } }}

		</shiro:hasPermission>

		<shiro:hasPermission name="RotatePayment:audit2">

			{{# if(d.status=="审核中(财务部经理)" ){ }}
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="audit">审核</a>
			{{#  } }}
		</shiro:hasPermission>

		<shiro:hasPermission name="RotatePayment:audit3">

			{{# if(d.status=="审核中(分管领导)" ){ }}
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="audit">审核</a>
			{{#  } }}
		</shiro:hasPermission>

		<shiro:hasPermission name="RotatePayment:audit4">

			{{# if(d.status=="审核中(总经理)" ){ }}
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="audit">审核</a>
			{{#  } }}
		</shiro:hasPermission>
		<shiro:hasPermission name="RotatePayment:audit5">

			{{# if(d.status=="审核中(董事长)" ){ }}
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="audit">审核</a>
			{{#  } }}
		</shiro:hasPermission>

	</script>
	
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog">
			<div class="modal-content" >
				<div class="modal-header">
				<h4 class="modal-title">审核</h4>
				</div>
				<div class="modal-body">
					<div class="layui-form" lay-filter="search3" id="search3">
						<div class="layui-form-item">
							<div class="layui-block">
								<label class="layui-form-label">审核操作:</label>
								<div class="layui-input-inline">
									<select  name="audit" lay-filter="audit">
										<option value="">--请选择--</option>
										<option value="审核通过">审核通过</option>
										<option value="驳回">驳回</option>
									</select>
								</div>
							</div>
						</div>					
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.audit()}">确认</button>
					<button type="button" class="layui-btn layui-btn-primary layui-btn-small" data-bind="click:function(){$root.hideModal()}">取消</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
</div>

<script src="${ctx}/js/knockout-3.4.0.js"></script>

<script src="${ctx}/js/app/rotatepayment/main.js"></script>
<script type="text/html" id="reportDateFormat">
	{{Date_format(d.reportDate,true)}}
</script>
<script>


	var viewType="${view_type}"
	var vm = new Main(viewType);
	ko.applyBindings(vm,$(".container-box")[0]);
	vm.initPage();
	
	$("#clearBtn").click(function () {
		$("input[name='clientName']").val("");
		$("input[name='depositAccount']").val("");

		$("select[name='payType'] option:selected").removeAttr("selected");
		$("select[name='payType']").eq(0).attr("selected",true);

        $("select[name='proceedType'] option:selected").removeAttr("selected");
        $("select[name='proceedType']").eq(0).attr("selected",true);

        $("select[name='status'] option:selected").removeAttr("selected");
        $("select[name='status']").eq(0).attr("selected",true);

        layui.form.render();
    });
</script>
<%@include file="../common/AdminFooter.jsp"%>