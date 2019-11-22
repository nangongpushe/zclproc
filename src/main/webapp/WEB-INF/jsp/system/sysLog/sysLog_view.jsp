<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../../common/AdminHeader.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<style>
	#LAY_table_user + .layui-form .layui-table-body td[data-field="clientIp"]{
		text-align: left;
	}
	#LAY_table_user + .layui-form .layui-table-body td[data-field="userName"]{
		text-align: left;
	}
	#LAY_table_user + .layui-form .layui-table-body td[data-field="account"]{
		text-align: left;
	}
	#LAY_table_user + .layui-form .layui-table-body td[data-field="description"]{
		text-align: left;
	}
	#LAY_table_user + .layui-form .layui-table-body td[data-field="createTime"]{
		text-align: center;
	}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>系统管理</li>
		<li class="active">系统日志</li>
	</ol>
</div>
<div class="container-box clearfix" style="padding: 10px">
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;"></fieldset>
		
		<div class="demoTable">
			IP地址：
			<div class="layui-inline">
				<input class="layui-input" name="clientIp" id="clientIp" autocomplete="off">
			</div>
			用户名称：
			<div class="layui-inline">
				<input class="layui-input" name="userName" id="userName" autocomplete="off">
			</div>
			操作：
			<div class="layui-inline">
				<input class="layui-input" name="description" id="description" autocomplete="off">
			</div>
			开始时间：
			<div class="layui-inline">
				<input class="layui-input" name="startTime" id="startTime" autocomplete="off">
			</div>
			结束时间：
			<div class="layui-inline">
				<input class="layui-input" name="endTime" id="endTime" autocomplete="off">
			</div>
            <div class="layui-inline" style="float:right">
			<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload">搜索</button>
            </div>
		</div>
    <div class="layui-inline">
	    <table class="layui-hide" id="LAY_table_user" lay-filter="demoEvent"></table>
    </div>

	</div>

<script>

layui.use(['form', 'layedit', 'laydate','table'],function(){
var laydate = layui.laydate;
var table =layui.table;
	laydate.render({
		 elem: '#startTime'
	})
	laydate.render({
		 elem: '#endTime'
	})
//render初始化参数
table.render({elem:'#LAY_table_user'
	,url:'${ctx}/sysLog/list.shtml'
	,method:'POST'
	,cols:[[
		/* ,{field:'logId',title:'ID',width:200,sort:true} */
		{field:'clientIp',title:'IP地址',width:300,align:'center'}
		,{field:'userName',title:'用户名称',width:300,align:'center'}
		,{field:'account',title:'用户账号',width:300,align:'center'}
		,{field:'description',title:'操作',width:300,align:'center'}
		,{field:'createTime',title:'操作时间',width:400,sort: true,align:'center'}
		]]
	,id:'logTable'
	,page:true
	,even: true //开启隔行背景
	,height:490
	});
	
	var $ =layui.$,
	active ={reload:function(){
	var clientIp =$('#clientIp');
	var userName = $('#userName');
	var description = $('#description');
	var startTime = $('#startTime');
	var endTime = $('#endTime');
	table.reload('logTable',{
		where:{ //设定异步数据接口的额外参数
			key:{
					clientIp:clientIp.val(),
					userName:userName.val(),
                	description:description.val(),
					startTime:startTime.val(),
					endTime:endTime.val()
				}		
			}	
	});
	}
	};
	
	$('.demoTable .layui-btn').on('click',function(){
			var type =$(this).data('type');
			active[type] ?active[type].call(this) :'';
		});
	
	});




</script>
<script type="text/html" id="barDemo">
  <a class="layui-btn layui-btn layui-btn-mini" lay-event="detail">查看</a>
  <a class="layui-btn layui-btn layui-btn-mini" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn layui-btn-mini" lay-event="del">删除</a>
</script>
<%@ include file="../../common/AdminFooter.jsp" %>