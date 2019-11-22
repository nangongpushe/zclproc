<%@ page language="java" contentType="text/html; charset=UTF-8"
%>


<%@include file="../common/AdminHeader.jsp"%>
<style type="text/css">
.layui-table-view{
 margin-left:0;
}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>物资管理</li>
		<li>库存管理</li>
		<li class="active">非易耗品库存</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
	<div class="layui-form" id="search" lay-filter="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label ">物资编码:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="encode" id="encode" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label ">品名:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="commodity" id="commodity" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">类型:</label>
				<div class="layui-input-inline">
					<!-- <div class="layui-inline" style="width: 170px"> -->
					<select class="layui-input" name="type" lay-filter="aihao"
						id="type">
						<option></option>
						<option value="物资">物资</option>
						<option  value="药剂类">药剂类</option>
					
						
						
					</select>
					<!-- </div> -->
				</div>
			</div>
			
			<div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small " id="searchBtn" data-type="reload" >查询</button>
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
	 var form = layui.form;
	form.render();
	var table = layui.table;
	table.render();
	//执行渲染
	table.render({
		elem : '#mytable',
		url : '${ctx}/Durables/list.shtml',
		method:'POST',
        where : {
            commodity : $('#search #commodity').val(),
            type : $('#search #type').val(),
            encode : $('#search #encode').val(),
            shortName : '${shortName}',
        },
		width:840,
		cols : [[
			{width : 140,align : 'center',toolbar : '#barDemo',fixed: true},
 			{align:'center',field:'commodity',title: '品名',width:140},
			{align:'center',field : 'model',title : '规格型号',width:140},
			{align:'center',field : 'encode',title : '物资编码',width:140},
			{align:'center',field : 'type',title : '物资类别',width:140},
			{align:'center',field : 'storageDate',title : '入库时间',width:140,fixed: 'right'},
		

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
		window.parent.callDurablesSelect(data);
		window.parent.$.colorbox.close();
		}
	});
			

		//搜索
	$('#searchBtn').click(function() {
		table.reload("myTableID", {
			method: 'post', //如果无需自定义HTTP类型，可不加该参数
			where : {
				commodity : $('#search #commodity').val(),
				type : $('#search #type').val(),
				encode : $('#search #encode').val(),
                shortName : '${shortName}',
			}
		});
	});
</script>
<%@include file="../common/AdminFooter.jsp"%>
