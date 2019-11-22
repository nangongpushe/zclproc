<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<style>
	#mytable + .layui-form .layui-table-body td[data-field="quotaNo"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="quotaName"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="type"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="grade"]{
		text-align: left;
	}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>质量管理</li>
		<li>质量档案</li>
		<li class="active">等级指标管理</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">

	<div class="layui-form" id="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label ">指标编号:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="quotaNo" id="quotaNo"
						autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label ">指标名称:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="quotaName"
						id="quotaName" autocomplete="off">
				</div>
			</div>
			<%--<div class="layui-inline">
				<label class="layui-form-label ">粮油品类:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="quotaName"
						id="quotaName" autocomplete="off">
				</div>
			</div>--%>
			<div class="layui-inline">
				<label class="layui-form-label ">粮油品类:</label>
				<div class="layui-input-inline">
					<select name="type" id="type">
						<option></option>
						<c:forEach items="${varietyList }" var="item">
							<option value="${item.value }">${item.value }</option>
						</c:forEach>
					</select>
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
		url : '${ctx}/QualityQuota/list.shtml',
		 /* width:1200, */ 
		 method:'post',
		cols : [[
 			{field:'quotaNo',title: '指标编号',width:300,fixed: true,align : 'center'},
			{field : 'quotaName',title : '指标名称',width:300,align : 'center'},
			{field : 'type',title : '粮油品类',width:300,align : 'center'},
			{field : 'grade',title : '等级',width:300,align : 'center'},
			{align : 'center',toolbar : '#barDemo',title: '操作',width:290,fixed: 'right'}, 
			
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
location.href = "${ctx}/QualityQuota/addPage.shtml";
}
table.on('tool(test)', function(obj) {
		var data = obj.data;
		console.log(data);
		if (obj.event === 'detail') {
		
			location.href = "${ctx}/QualityQuota/detailPage.shtml?id="
					+ data.id;
		} else if (obj.event === 'del') {
			layer.confirm('您确认要删除该品类 的等级指标信息', function(index) {
				$.post("${ctx}/QualityQuota/remove.shtml", {
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
			location.href = "${ctx}/QualityQuota/editPage.shtml?id="
					+ data.id;
		}
		
	});
	

	//搜索
	$('#search button').click(function() {
		table.reload("myTableID", {
			method: 'post' //如果无需自定义HTTP类型，可不加该参数
			,where : {
				quotaNo : $('#search #quotaNo').val(),
				quotaName : $('#search #quotaName').val(),
				type : $('#search #type').val(),
			}
		});
	});
</script>
<%@include file="../common/AdminFooter.jsp"%>