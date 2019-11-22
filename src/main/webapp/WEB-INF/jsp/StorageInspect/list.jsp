<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/AdminHeader.jsp"%>
<link rel="stylesheet" href="${ctx}/css/combo.select.css">
<style>
	#mytable + .layui-form .layui-table-body td[data-field="year"]{
		text-align: center;
	}
	#mytable + .layui-form .layui-table-body td[data-field="reportUnit"]{
		text-align: left;
	}
	#mytable + .layui-form .layui-table-body td[data-field="inspectStart"]{
		text-align: center;
	}
	#mytable + .layui-form .layui-table-body td[data-field="inspectEnd"]{
		text-align: center;
	}
	#mytable + .layui-form .layui-table-body td[data-field="inspectFunds"]{
		text-align: right;
	}
	#mytable + .layui-form .layui-table-body td[data-field="inspector"]{
		text-align: left;
	}
</style>
<div class="row clear-m">
	<ol class="breadcrumb">
		<li>仓储管理</li>
		<li class="active">全国查库</li>
	</ol>
</div>

<div class="container-box clearfix" style="padding: 10px">

	<div class="layui-form" id="search">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label ">填报单位:</label>
				<div class="layui-input-inline">
					<select   name="reportUnit" id="reportUnit" lay-search >
                    		<option value="">--请选择--</option>
		                 <c:forEach items="${distinctList}" var="distinctList">  
		        			<option value="${distinctList.warehouseShort}">${distinctList.warehouseShort}</option>
		   				 </c:forEach>
   					</select>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label ">检查负责人:</label>
				<div class="layui-input-inline">
					<select   name="inspector" id="inspector" lay-search >
                    		<option value="">--请选择--</option>
		                 <c:forEach items="${listSysUser}" var="listSysUser">  
		        			<option value="${listSysUser.id}">${listSysUser.name}【${listSysUser.position}】</option>
		   				 </c:forEach>
   					</select>
				</div>
			</div>
			<div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small"  id="reload" data-type="reload">查询</button>
			</div>
		</div>
	
		<div class="layui-inline">
				<button class="layui-btn layui-btn-primary layui-btn-small"  onclick="add();">新增</button>
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
		url : '${ctx}/StorageInspect/list.shtml',
		 /* width:1100, */ 
		cols : [[
 			{field:'year',title: '年度',width:150,fixed: true,align:'center'},
 			{field:'reportUnit',title: '填报单位',width:150,align:'center'},
 			{field:'inspectStart',title: '检查开始日期',width:150,align:'center'},
 			{field:'inspectEnd',title: '检查结束日期',width:150,align:'center'},
 			{field:'inspectFunds',title: '检查经费(万元)',width:150,align:'center'},
 			{field:'inspector',title: '检查负责人',width:150,align:'center'	},
			{width : 160,align : 'center',toolbar : '#barDemo',title: '操作',width:290,fixed: 'right'}, 
			
		]],//设置表头
		page:true,//开启分页
/* 		limit:10, */
		id:'myTableID',
		done:function(res,curr,count){
		/* $('#inspector').comboSelect(); */
		},
	});
function add(){
location.href = "${ctx}/StorageInspect/addPage.shtml";
}
table.on('tool(test)', function(obj) {
		var data = obj.data;
		console.log(data);
		if (obj.event === 'detail') {
		
			location.href = "${ctx}/StorageInspect/detailPage.shtml?id="
					+ data.id;
		} else if (obj.event === 'del') {
			layer.confirm('确认要删除吗？', function(index) {
				$.post("${ctx}/StorageInspect/remove.shtml", {
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
								reportUnit : $('#search #reportUnit').val(),
								inspector : $('#search #inspector').val(),
							}
						});
				});
			});
		} else if (obj.event === 'edit') {
			location.href = "${ctx}/StorageInspect/editPage.shtml?id="
					+ data.id;
		}
		
	});
	

	//搜索
	$('#reload').click(function() {
		table.reload("myTableID", {
			method: 'post' //如果无需自定义HTTP类型，可不加该参数
			,where : {
				reportUnit : $('#search #reportUnit').val(),
				inspector : $('#search #inspector').val(),
			}
		});
	});
	 $("select#reportUnit").each(function(i,n){
       var options = "";
       $(n).find("option").each(function(j,m){
           if(options.indexOf($(m)[0].outerHTML) == -1)
           {
               options += $(m)[0].outerHTML;
           }
       });
       $(n).html(options);
   });
</script>

<script src="${ctx}/js/select/jquery.combo.select.js"></script>