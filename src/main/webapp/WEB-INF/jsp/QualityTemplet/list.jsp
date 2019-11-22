<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<style>
	#mytable + .layui-form .layui-table-body td[data-field="templetNo"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="templetName"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="type"]{
		text-align: left;
	}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>质量管理</li>
		<li>质量档案</li>
		<li class="active">粮油模板</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">

	<div class="layui-form" id="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label ">模板编号:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="templetNo" id="templetNo"
						autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label ">模板名称:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="templetName"
						id="templetName" autocomplete="off">
				</div>
			</div>
			
			
			<div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload">查询</button>
			</div>
		</div>
		<div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small" lay-event="add" onclick="add();">新增</button>
			</div>
		</div>
	<!-- layui表格 -->
	<table lay-filter="test" id="mytable"></table>
	<script type="text/html" id="barDemo">
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="edit">编辑</a>
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="del">删除</a>
	</script>

</div>

<script>
	var form=layui.form;
	form.render();
	
	var table = layui.table;
	table.render();
	//执行渲染
	table.render({
		elem : '#mytable',
		url : '${ctx}/QualityTemplet/list.shtml',
		/*  width:1180,  */
		method:'post',
		cols : [[
 			{field:'templetNo',title: '模板编号',width:300,fixed: true,align : 'center'},
			{field : 'templetName',title : '模板名称',width:300,align : 'center'},
			{field : 'type',title : '粮油品类',width:300,sort: true,align : 'center'},
			{width : 160,align : 'center',toolbar : '#barDemo',title: '操作',width:290,fixed: 'right'}, 
			
		]],//设置表头
/* 		request : {
		
			pageName : 'page', 
			limitName : 'pageSize'
		}, */
		page:true,//开启分页
/* 		limit:10, */
		id:'myTableID',
		done:function(res,curr,count){
		},
	});
function add(){
location.href = "${ctx}/QualityTemplet/addPage.shtml";
}
table.on('tool(test)', function(obj) {
		var data = obj.data;
		console.log(data);
		if (obj.event === 'detail') {
		
			location.href = "${ctx}/QualityTemplet/detailPage.shtml?id="
					+ data.id;
		} else if (obj.event === 'del') {
			layer.confirm('您确认要删除该品类的检测项目么?', function(index) {
				$.post("${ctx}/QualityTemplet/remove.shtml", {
					id : data.id
				}, function(result) {
					layer.closeAll(); //疯狂模式，关闭所有层
					layer.open({
					  title: '提示信息'
					  ,content: result.msg
					}); 
						table.reload("myTableID", {
							method: 'post', //如果无需自定义HTTP类型，可不加该参数
							where : {
								templetNo : $('#search #templetNo').val(),
								templetName : $('#search #templetName').val(),
								type : $('#search #type').val(),
							}
						});
				});
			});
		} else if (obj.event === 'edit') {
			location.href = "${ctx}/QualityTemplet/editPage.shtml?id="
					+ data.id;
		}
		
	});
	

	//搜索
	$('#search button').click(function() {
		table.reload("myTableID", {
			method: 'post' //如果无需自定义HTTP类型，可不加该参数
			,where : {
				templetNo : $('#search #templetNo').val(),
				templetName : $('#search #templetName').val(),
				type : $('#search #type').val(),
			}
		});
	});
</script>
<%@include file="../common/AdminFooter.jsp"%>