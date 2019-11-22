
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>


<%@include file="../common/AdminHeader.jsp"%>
<style type="text/css">
.layui-table-view{
 margin-left:0;
}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>代储监管</li>
		<li>业务信息</li>
		<li class="active">考评模板表</li>
	</ol>
</div>


<div class="container-box clearfix" style="padding: 10px">
   
   <div class="layui-form" id="search" >
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">模板名称：</label>
				<div class="layui-input-inline">
					<input class="layui-input" autocomplete="off" id="templetName" name="templetName">
				</div>
			</div>
		   <div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small" data-type="reload" id="searchBtn">查询</button>
			</div>	
		</div>	
        
	</div>
   
    <div class="manage">
       
        
        <!-- layui表格 -->
		<table lay-filter="test" id="mytable"></table>
		<script type="text/html" id="barDemo">
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="select">选择</a>
		
		</script>
    </div>
</div>


<script>
	

	var table = layui.table;
	table.render();
	//执行渲染
	table.render({
		elem : '#mytable',
		url : '${ctx}/StoreTemplate/list.shtml',
	
		cols : [[
			{width : 120,align : 'center',toolbar : '#barDemo',width:120}, 
			{align:'center',field : 'templetNo',title : '模板名称编号',width:220},
 			{align:'center',field:'templetName',title: '模板名称',width:200}, 
			{align:'center',field : 'creator',title : '创建人',width:120},	
			{align:'center',field : 'createDate',title : '创建时间',width:200},		
			
			
		]],//设置表头
		request : {
			pageName : 'page', 
			limitName : 'pageSize'
		},
		page:true,//开启分页
		limit:10,
		id:'myTableID',
		done:function(res,curr,count){
		},
	});
	
	//监听工具条

	table.on('tool(test)', function(obj) {
		var data = obj.data;
		console.log(data);
		if (obj.event === 'select') {
		window.parent.callTemplateSelect(data);
		window.parent.$.colorbox.close();
		} 
		
	});
			

/* 	//搜索
	$('#searchBtn').click(function() {
		table.reload("myTableID", {
			method: 'post' //如果无需自定义HTTP类型，可不加该参数
			,where : {
				StoreTemplate : $('#search #StoreTemplate').val()
				
				
			}
		});
	}); */
</script>

<%@include file="../common/AdminFooter.jsp"%>
