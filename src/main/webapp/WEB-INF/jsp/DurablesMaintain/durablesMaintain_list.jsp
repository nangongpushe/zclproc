<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<style type="text/css">

	#mytable + .layui-form .layui-table-body td[data-field="encode"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="commodity"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="type"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="maintainMan"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="maintainContent"]{
		text-align: left;
	}

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
		<li>物资管理</li>
		<li class="active">维修管理</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">
    
    <div class="layui-form" id="search" >
      
		<div class="layui-form-item">
		
			 
			<div class="layui-inline">
				<label class="layui-form-label ">品名:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="commodity" id="commodity" autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label ">物资编号:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="encode" id="encode" autocomplete="off">
				</div>
			</div>
			<div style="width:20px;" class="layui-inline">
					<button class="layui-btn layui-btn-primary layui-btn-small" id="searchBtn"  >查询</button>
				</div>
			<div class="layui-inline">
				<label class="layui-form-label">保养日期起:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="timeStart" id="timeStart"
						autocomplete="off">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label layui-col-md2">保养日期止:</label>
				<div class="layui-input-inline">
					<input class="layui-input" name="timeEnd" id="timeEnd"
						autocomplete="off">
				</div>
			</div>
			
			   
				 
			
		</div>
	</div>
  	
   
    <div class="manage">
         <p class="btn-box" style="padding-top:0px;margin-left:10px;">
        	<a class="layui-btn layui-btn-primary layui-btn-small " onclick="window.location.href='${ctx }/DurablesMaintain/add.shtml?'" >新增</a>
             <a type="button" class="layui-btn layui-btn-primary layui-btn-small " onclick="exportxls();">导出</a>
        </p>
        
        <!-- layui表格 -->
		<table lay-filter="test" id="mytable"></table>
		<script type="text/html" id="barDemo">
  		<a class="layui-btn layui-btn-primary layui-btn layui-btn-mini" lay-event="detail">查看</a>
  		<a class="layui-btn layui-btn layui-btn-mini" lay-event="edit">编辑</a>
  		<a class="layui-btn layui-btn-danger layui-btn layui-btn-mini" lay-event="del">删除</a>
		
		</script>
    </div>
</div>

<script>

		function exportxls(){
		window.location.href = "${ctx }/DurablesMaintain/exportxls.shtml?commodity="+$('#search #commodity').val()+
						"&encode=" + $('#search #encode').val()+
						"&timeEnd=" + $('#search #timeEnd').val()+
						"&timeStart=" + $('#search #timeStart').val();
		
		
	}
	
	layui.use('laydate', function(){
	  var laydate = layui.laydate;
	  laydate.render({ 
		  elem: '#timeStart'
		  ,format: 'yyyy-MM-dd' //可任意组合
		});
		laydate.render({ 
		  elem: '#timeEnd'
		  ,format: 'yyyy-MM-dd' //可任意组合
		});
	});
	
	var table = layui.table;
	table.render();
	//执行渲染
	table.render({
		elem : '#mytable',
		url : '${ctx}/DurablesMaintain/list.shtml',
		method:'POST',
		cols : [[
 			{align:'center',field:'encode',title: '物资编码',width:200,fixed: true}, 
			
			{align:'center',field : 'commodity',title : '品名',width:200}, 
			{align:'center',field : 'type',title : '类别',width:200},
			{align:'center',field : 'maintainDate',title : '维修日期',width:200},
			{align:'center',field : 'maintainMan',title : '维修保养人员',width:200},
			{align:'center',field : 'maintainContent',title : '维修内容',width:350},			
			{fixed : 'right',align : 'center',toolbar : '#barDemo',title: '操作',width:250}, 
			
			
		]],//设置表头
		
		page:true,//开启分页
	
		id:'myTableID',
		done:function(res,curr,count){
		},
	});
	
	//监听工具条

	table.on('tool(test)', function(obj) {
		var data = obj.data;
		console.log(data);
		if (obj.event === 'detail') {
		
			location.href = "${ctx}/DurablesMaintain/view.shtml?id="
					+ data.id;
		} else if (obj.event === 'del') {
			layer.confirm('确定删除吗？', function(index) {
				$.post("${ctx}/DurablesMaintain/remove.shtml", {
					id : data.id
				}, function(result) {
					layer.closeAll(); //疯狂模式，关闭所有层
					layer.msg("删除成功",{icon:1}, function(){
							table.reload("myTableID", {
							method: 'post', //如果无需自定义HTTP类型，可不加该参数
							where : {
								commodity : $('#search #commodity').val(),
								type : $('#search #type').val(),
								encode : $('#search #encode').val(),
								timeEnd : $('#search #timeEnd').val(),
								timeStart : $('#search #timeStart').val()
								
								
								
							}
						});
					
					})
						
				});
			});
		} else if (obj.event === 'edit') {
			location.href = "${ctx}/DurablesMaintain/edit.shtml?id="
					+ data.id;
		}
		
	});
			

	//搜索
	$('#searchBtn').click(function() {
	
	var timeStart=$("#timeStart").val();
	var timeEnd=$("#timeEnd").val();
	if (timeStart > timeEnd) {
			layer.msg("保养日期起不能大于保养日期止", {
				icon : 0
			});
			return false;
		} 
		table.reload("myTableID", {
			method: 'post', //如果无需自定义HTTP类型，可不加该参数
			where : {
				commodity : $('#search #commodity').val(),
				type : $('#search #type').val(),
				encode : $('#search #encode').val(),
				timeEnd : $('#search #timeEnd').val(),
				timeStart : $('#search #timeStart').val()
				
			}
		});
	});
</script>
<%@include file="../common/AdminFooter.jsp"%>
