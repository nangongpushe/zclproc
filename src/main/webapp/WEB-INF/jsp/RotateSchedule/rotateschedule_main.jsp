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
	#mainTable + .layui-form .layui-table-body td[data-field="reportTimeStr"]{
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
	#mainTable + .layui-form .layui-table-body td[data-field="status"]{
		text-align: left;
	}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>轮换业务</li>
		<li>执行进度</li>
		<li class="active">进度上报</li>
	</ol>
</div>

<div id="isKu" class="container-box clearfix" style="padding: 10px">
	<script>
        var type = "${type}";
        if(type=='ProviceUnit'){
            $("#isKu").css("display",'none');
            alert("对不起，您没有该权限！");
        }

	</script>
	
	<div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right">填报时间:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="reportTime" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="text-align:right">状态:</label>
				<div class="layui-input-inline">
					<select class="layui-input" name="status" lay-filter="status">
						<option></option>
						<option value="待提交">待提交</option>
						<option value="审核中">审核中</option>
						<option value="已通过">已通过</option>
						<option value="未通过">未通过</option>
					</select>
				</div>
			</div>
            <div class="layui-inline">
                <label class="layui-form-label" style="text-align:right">填报单位:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" name="reportUnit" autocomplete="off">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label" style="text-align:right">经办部门:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" name="department" autocomplete="off">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label" style="text-align:right">轮换类型:</label>
                <div class="layui-input-inline">
                    <select name="noticeType" lay-filter="noticeType">
                        <option value="">--全部--</option>
                        <option value="出库">出库</option>
                        <option value="入库">入库</option>
                    </select>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label" style="text-align:right">所属通知书编号:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" name="noticeSerial" autocomplete="off">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label" style="text-align:right">经办人:</label>
                <div class="layui-input-inline">
                    <input class="layui-input" name="operator" autocomplete="off">
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

	<shiro:hasPermission name="RotateSchedule:add">
		<button class=" layui-btn layui-btn-primary layui-btn-small" id="add" data-bind="click:function(){$root.add();}">
			<i class="layui-icon">&#xe608;</i> 新增
		</button>
	</shiro:hasPermission>

	<table class="layui-table" id="mainTable" lay-filter="table"></table>

	<script type="text/html" id="barDemo">
		<shiro:hasPermission name="RotateSchedule:view">
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
		</shiro:hasPermission>
		{{#  if(d.status =="待提交" ){ }}
		<shiro:hasPermission name="RotateSchedule:submit">
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="submit">提交</a>
		</shiro:hasPermission>
		{{#  } }}
		{{#  if(d.status =="待提交" || d.status == "未通过"){ }}
		<shiro:hasPermission name="RotateSchedule:edit">
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">修改</a>
		</shiro:hasPermission>
		<shiro:hasPermission name="RotateSchedule:remove">
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="remove">删除</a>
		</shiro:hasPermission>
		{{#  } }}
		{{#  if(d.status =="审核中" ){ }}
		<shiro:hasPermission name="RotateSchedule:submit">
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="report">通过</a>
		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="reject">驳回</a>
		</shiro:hasPermission>
		{{#  } }}

	</script>
	
</div>


<script src="../js/knockout-3.4.0.js"></script>

<script src="../js/app/rotateschedule/main.js"></script>
<script>
var type = "${type}";

var vm = new Main(type);
	ko.applyBindings(vm,$(".container-box")[0]);
	vm.initPage();
</script>
<%@include file="../common/AdminFooter.jsp"%>