<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>


<%@include file="../common/AdminHeader.jsp"%>
<style>
	#mytable + .layui-form .layui-table-body td[data-field="templetNo"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="templetName"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="creator"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="createDate"]{
		text-align: center;
	}
</style>
<style type="text/css">

.layui-inline{
	width: 45% ;
}
.layui-form-item .layui-form-label{
    width: 30% ;
    max-width:120px;
}

.layui-form-item .layui-input-inline{
  width: 65% ;
}
.layui-form-item {
    margin-bottom: 1px;
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
          <p class="btn-box" style="padding-top:0px;margin-left:10px;">
            <button type="button" class="layui-btn layui-btn-primary layui-btn-small "  onclick="window.location.href='${ctx }/StoreTemplate/add.shtml?'">新增</button>
        </p>
        
        <!-- layui表格 -->
		<table lay-filter="test" id="mytable"></table>
		<script type="text/html" id="barDemo">
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
  		<a class="layui-btn layui-btn layui-btn-mini" lay-event="edit">编辑</a>
  		<a class="layui-btn layui-btn-danger layui-btn layui-btn-mini" lay-event="del">删除</a>
		
		</script>
    </div>



<script>
	

	var table = layui.table;
	table.render();
	var width=($('.container-box').innerWidth()-35)/5;
	//执行渲染
	table.render({
		elem : '#mytable',
		url : '${ctx}/StoreTemplate/list.shtml',
		method:'POST',
		cols : [[
			{align:'center',field : 'templetNo',title : '模板名称编号',width:width,fixed: true},
 			{align:'center',field:'templetName',title: '模板名称',width:width},
			{align:'center',field : 'creator',title : '创建人',width:width},
			{align:'center',field : 'createDate',title : '创建时间',width:width},		
			{align:'center',field : 'right',align : 'center',toolbar : '#barDemo',title: '操作',width:width}, 
			
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
		if (obj.event === 'detail') {
			
			location.href = "${ctx}/StoreTemplate/view.shtml?id="
					+ data.id+"&templateId="+data.templetNo;
		} else if (obj.event === 'del') {
			layer.confirm('确定删除吗？', function(index) {
				$.post("${ctx}/StoreTemplate/remove.shtml", {
					id : data.id
				}, function(result) {
					layer.closeAll(); //疯狂模式，关闭所有层
					layer.msg("删除成功",{icon:1}, function(){
						table.reload("myTableID", {
								method: 'post', //如果无需自定义HTTP类型，可不加该参数
								where : {
									templetName : $('#templetName').val()
									
								}
							});
					})
						
				});
			});
		} else if (obj.event === 'edit') {
			
			location.href = "${ctx}/StoreTemplate/edit.shtml?id="
					+ data.id+"&templateId="+data.templetNo;
		}
		
	});
			

	//搜索
	$('#searchBtn').click(function() {
		table.reload("myTableID", {
			method: 'post' //如果无需自定义HTTP类型，可不加该参数
			,where : {
				templetName : $('#templetName').val()
				
				
			}
		});
	});
</script>
<%@include file="../common/AdminFooter.jsp"%>
