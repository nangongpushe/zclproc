
<%@ page language="java" contentType="text/html; charset=UTF-8"
     %>


<%@include file="../common/AdminHeader.jsp"%>
<style type="text/css">
.layui-table-view{
 margin-left:0;
}
</style>

<input id="storehouse"  type="hidden" value="${storehouse }" />		

<div class="container-box clearfix" style="padding: 10px">
  
   
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
	var storehouse = $("#storehouse").val();
	storehouse=encodeURI(encodeURI(storehouse));
	//执行渲染
	table.render({
		elem : '#mytable',
		method: 'post', //如果无需自定义HTTP类型，可不加该参数
		url : '${ctx}/StoreExamineAgent/listValidWarehouse.shtml?storehouse='+storehouse,
	
		cols : [[
			{width : 120,align : 'center',toolbar : '#barDemo',width:120,title:'操作'}, 
			{align:'center',field : 'warehouseName',title : '库点名称',width:220},
 		
			/* {align:'center',field : 'enterpriseName',title : '代储企业',width:300},	 */
			{align:'center',field : 'creator',title : '库点负责人',width:200},		
			
			
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
		window.parent.callEnterpriseNameSelect(data);
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
