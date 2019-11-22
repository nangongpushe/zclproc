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
				<label class="layui-form-label ">粮油种类:</label>
				<div class="layui-input-inline">
					<select name="type" id="type" class="layui-select">
						<option value=""></option>
						<c:forEach items="${type}" var="type">
							<option value="${type.value}">${type.value}</option>
						</c:forEach>
					</select>
				</div>
			</div>

			<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload">查询</button>

		</div>
		</div>
	<!-- layui表格 -->
	<table lay-filter="test" id="mytable"></table>
	<script type="text/html" id="barDemo">
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="select">选择</a>
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
		url : '${ctx}/QualityTemplet/listChoice.shtml',
		cols : [[
			{width : 160,align : 'center',toolbar : '#barDemo',title: '操作'},
 			{field:'templetNo',title: '模板编号',width:300,align : 'center'},
			{field : 'templetName',title : '模板名称',width:300,align : 'center'},
			{field : 'type',title : '粮油品类',width:300,align : 'center'},
			
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

		
	//监听工具条

	table.on('tool(test)', function(obj) {
		var data = obj.data;
		console.log(data);
		if (obj.event === 'select') {
			$.ajax({
				type:"get",
				data:{tempid:data.id},
				url:"${ctx}/QualityTemplet/itemDetailList.shtml",
				success:function(res){
					window.parent.selectToData(res);
					window.parent.$.colorbox.close();
				}
			});
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