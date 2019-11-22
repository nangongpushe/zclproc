<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../common/AdminHeader.jsp"%>
<style>
	#resultTable + .layui-form .layui-table-body td[data-field="superviseSerial"]{
		text-align: left;
	}
	#resultTable + .layui-form .layui-table-body td[data-field="superviseYear"]{
		text-align: center;
	}
	#resultTable + .layui-form .layui-table-body td[data-field="superviseName"]{
		text-align: left;
	}
	#resultTable + .layui-form .layui-table-body td[data-field="creator"]{
		text-align: left;
	}
	#resultTable + .layui-form .layui-table-body td[data-field="createDateFmt"]{
		text-align: center;
	}
</style>

<div class="row clear-m">
	<ol class="breadcrumb">
		<li>代储监管</li>
		<li>分片监管</li>
	</ol>
</div>
<div class="container-box clearfix" style="padding: 10px">
	<div id="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">计划编号：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" name="superviseSerial" id="superviseSerial">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">计划年份：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" name="superviseYear" id="superviseYear">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">制定时间：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" name="createDate" id="createDate">
				</div>
			</div>
			<div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload" id="searchBtn">查询</button>
			</div>
		</div>
	</div>
	
	<div class="manage">
		<br>
		<shiro:hasPermission name="StoreSupervise:add">
			<button type="button" class="layui-btn layui-btn-primary layui-btn-small" onclick="window.location.href='${ctx }/StoreSupervise/addPage.shtml'">新增</button>
        	</shiro:hasPermission>
        <table lay-filter="operation" id="resultTable"></table>
        <script type="text/html" id="bar">
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
			<shiro:hasPermission name="StoreSupervise:edit">
  			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">编辑</a>
			</shiro:hasPermission>		
			<shiro:hasPermission name="StoreSupervise:del">  			
			<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="del">删除</a>
			</shiro:hasPermission>
		</script>
    </div>
</div>

<script>
layui.use(['table', 'laydate'], function(){
	var table = layui.table,
	laydate = layui.laydate;
	laydate.render({
		elem:"#createDate",
		type:"date",
		format:"yyyy-MM-dd"
	});
	laydate.render({
		elem:"#superviseYear",
		type:"year"
	});
	table.render({
		elem : '#resultTable',
		url : '${ctx}/StoreSupervise/list.shtml',
		method : "POST",
		cols : [[
 			{field : 'superviseSerial',title : '计划编号',width:400, align : 'center'},
			{field : 'superviseYear',title : '计划年份 ',width:200, align : 'center'},
			{field : 'superviseName',title : '计划名称',width:400, align : 'center'},
			{field : 'creator',title : '制定人',width:200, align : 'center'},
			{field : 'createDateFmt',title : '制定时间',width:200, align : 'center'},
			{ title : '操作', width : 200, align : 'center', toolbar : '#bar'},
		]],//设置表头
		request : {
			pageName : 'page', 
			limitName : 'pageSize'
		},
		page:true,//开启分页
		limit:10,
		id:'resultTableId',
		done:function(res,curr,count){
		},
	});
	
	//监听工具条
	table.on('tool(operation)', function(obj) {
		var data = obj.data;
		//console.log(data);
		if (obj.event === 'detail') {
			window.location.href = '${ctx }/StoreSupervise/view.shtml?id=' + data.id;
			//view(data);
		} else if (obj.event === 'del') {
			layer.confirm('确认删除吗？', function(index) {
				$.post("${ctx}/StoreSupervise/remove.shtml", {
					id : data.id
				}, function(result) {
					if (result.success) {
						obj.del();
						layer.msg(result.msg,{time:1000,icon:1});
						//layer.msg(result.msg,{icon:2});
					} else {
						layer.msg(result.msg,{icon:2});
					}
					
				});
			});
		} else if (obj.event === 'edit') {
			location.href = "${ctx}/StoreSupervise/editPage.shtml?id="
					+ data.id;
		};
	});
	
	//搜索
	$('#searchBtn').click(function() {
		table.reload("resultTableId", {
			where : {
				superviseSerial : $('#search #superviseSerial').val(),
				superviseYear : $('#search #superviseYear').val(),
				createDate : $('#search #createDate').val()
			}
		});
	});
	
});



function view(data) {
	var url = "${ctx }/StoreSupervise/view.shtml";
	$.post(url, {id:data.id}, function(str) {
		layer.open({
			type : 1,
			title:"计划详情",
			content : str,
			area:['auto','800px']
		});
	});
};

</script>